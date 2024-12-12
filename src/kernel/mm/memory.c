#include "memory.h"
#include "printk.h"
#include "lib.h"
#include "errno.h"

struct Global_Memory_Descriptor memory_management_struct;

unsigned long page_init(struct Page *page, unsigned long flags)
{
    page->attribute |= flags;
    
    if (!page->reference_count || (page->attribute & PG_Shared)) {
        page->reference_count++;
        page->zone_struct->total_pages_link++;
    }	
    return 1;
}

unsigned long page_clean(struct Page *page)
{
    page->reference_count--;
    page->zone_struct->total_pages_link--;

    if (!page->reference_count) page->attribute &= PG_PTable_Maped;
    
    return 1;
}

unsigned long get_page_attribute(struct Page *page)
{
    if (!page) {
        color_printk(RED, BLACK, "get_page_attribute() ERROR: page == NULL\n");
        return 0;
    }
    return page->attribute;
}

unsigned long set_page_attribute(struct Page *page, unsigned long flags)
{
    if (!page) {
        color_printk(RED, BLACK, "set_page_attribute() ERROR: page == NULL\n");
        return 0;
    }
    page->attribute = flags;
    return 1;
}

static inline void parse_e820_map()
{
    struct E820 *p = (struct E820 *)0xffff800000007e00; // int 15h, ax = e820h 的返回結構體放在 0x7e00的位置

    for (int i = 0; i < E820_MAX_ENTRY; i++, p++) {
        if (p->type > 4 || p->length == 0 || p->type < 1)
            break;
        memory_management_struct.e820[i] = *p;
        memory_management_struct.e820_length = i;
    }
}

static inline void calculate_memory_resource()
{
    for (int i = 0; i < memory_management_struct.e820_length; i++) {
        if (memory_management_struct.e820[i].type != RAM_TYPE) continue;
        unsigned long start = PAGE_2M_ALIGN(memory_management_struct.e820[i].address);
        unsigned long end = (memory_management_struct.e820[i].address + memory_management_struct.e820[i].length) & PAGE_2M_MASK;
    }
}

static inline void init_bitmaps()
{
    unsigned long TotalMem = memory_management_struct.e820[memory_management_struct.e820_length].address +
                             memory_management_struct.e820[memory_management_struct.e820_length].length;

    memory_management_struct.bits_map = (unsigned long*)((memory_management_struct.start_brk + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.bits_size = TotalMem >> PAGE_2M_SHIFT;
    memory_management_struct.bits_length = (((unsigned long)(TotalMem >> PAGE_2M_SHIFT) + sizeof(long) * 8 - 1) / 8) & ( ~ (sizeof(long) - 1));
    memset(memory_management_struct.bits_map, 0xff, memory_management_struct.bits_length); //init bits map memory
}

static inline void calculate_free_pages()
{
    memory_management_struct.pages_struct = (struct Page*)(((unsigned long)memory_management_struct.bits_map
                                            + memory_management_struct.bits_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.pages_size = memory_management_struct.bits_size;

    memory_management_struct.pages_length = ((memory_management_struct.pages_size) * sizeof(struct Page) +
                                            sizeof(long) - 1) & (~sizeof(long) - 1);
    memset(memory_management_struct.pages_struct, 0, memory_management_struct.pages_length); //init pages memory

}

static inline void init_zones_and_pages()
{
    memory_management_struct.zones_struct = (struct Zone*)(((unsigned long)memory_management_struct.pages_struct
                                            + memory_management_struct.pages_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.zones_size = 0;
    memory_management_struct.zones_length = (5 * sizeof(struct Zone) + sizeof(long) - 1) & (~(sizeof(long) - 1));
    memset(memory_management_struct.zones_struct, 0, memory_management_struct.zones_length); //init zones memory


    for (int i = 0; i < memory_management_struct.e820_length; i++) {
        unsigned long start, end;
        struct Zone *z;
        struct Page *p;
        unsigned long *b;

        if (memory_management_struct.e820[i].type != RAM_TYPE) continue; // 非OS可用內存就跳過
        
        start = PAGE_2M_ALIGN(memory_management_struct.e820[i].address); // 內存頁先對2MB對齊
        end = (memory_management_struct.e820[i].address + memory_management_struct.e820[i].length) & PAGE_2M_MASK;
        
        if (end <= start) continue; // 代表這一塊內存無法劃分出一塊大小為2MB並且與2MB對齊的頁，故跳過。

        // zone init
        z = memory_management_struct.zones_struct + memory_management_struct.zones_size; // 相當於zones_struct[zones_size] 
        memory_management_struct.zones_size++;

        *z = (struct Zone) {
            .pages_group = (struct Page*)(memory_management_struct.pages_struct + (start >> PAGE_2M_SHIFT)),
            .pages_length = (end - start) >> PAGE_2M_SHIFT,
            .zone_start_address = start,
            .zone_end_address = end,
            .zone_length = end - start,
            .page_free_count = (end - start) >> PAGE_2M_SHIFT,
            .GMD_struct = &memory_management_struct,
        };

        //page init
        p = z->pages_group;

        for (int j = 0; j < z->pages_length; j++, p++) {

            *p = (struct Page) {
                .zone_struct = z,
                .PHY_address = start + PAGE_2M_SIZE * j,
            };

            unsigned long page_offset = p->PHY_address >> PAGE_2M_SHIFT;
            *(memory_management_struct.bits_map + (page_offset >> 6)) ^= 1UL << page_offset % 64;
            /* 在bit_map一個位元就代表一個頁。
             * (p->PHY_address >> PAGE_2M_SHIFT) >> 6用於索引此物理頁對應bits_map哪一項。
             * 右移6位則是因為bits_map的每一個元素是64位元。
             * 1ul << (p->PHY_address >> PAGE_2M_SHIFT) % 64 則用於計算需要標記的是哪一個位元。
             * 利用^=把這個位元清0，來表示這一個頁可以被使用。
             */
        }
    }

    //init address 0 to page struct 0; because the memory_management_struct.e820[0].type != 1
    *memory_management_struct.pages_struct = (struct Page) {
        .zone_struct = memory_management_struct.zones_struct,
        .reference_count = 1,
    };

    set_page_attribute(memory_management_struct.pages_struct,PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
    memory_management_struct.zones_length = (memory_management_struct.zones_size * sizeof(struct Zone) + sizeof(long) - 1) & ( ~ (sizeof(long) - 1));
    
    ZONE_DMA_INDEX = 0;
    ZONE_NORMAL_INDEX = 0;
    ZONE_UNMAPED_INDEX = 0;

    for (int i = 0; i < memory_management_struct.zones_size; i++) {
        struct Zone *z = memory_management_struct.zones_struct + i;
        if (z->zone_start_address >= 0x100000000 && !ZONE_UNMAPED_INDEX)
            ZONE_UNMAPED_INDEX = i;
    }

    memory_management_struct.end_of_struct = (unsigned long) ((unsigned long) memory_management_struct.zones_struct 
                                             + memory_management_struct.zones_length + sizeof(long) * 32) & (~(sizeof(long) - 1));
}

static inline void mark_kernel_pages()
{

    unsigned long i = Virt_To_Phy(memory_management_struct.end_of_struct) >> PAGE_2M_SHIFT; /* 這理用於計算從地址0到內存管理結構結尾佔據多少頁 */

    for (unsigned long j = 1; j <= i; j++) {
        struct Page *tmp_page =  memory_management_struct.pages_struct + j;
        unsigned long page_offset = tmp_page->PHY_address >> PAGE_2M_SHIFT;
        page_init(tmp_page, PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
        *(memory_management_struct.bits_map + (page_offset >> 6)) |= 1UL << page_offset % 64;
        tmp_page->zone_struct->page_using_count++;
        tmp_page->zone_struct->page_free_count--;
    }

    flush_tlb();
}

void init_memory()
{
    parse_e820_map();
    calculate_memory_resource();
    init_bitmaps(); // bits map construction init
    calculate_free_pages(); // pages construction init
    init_zones_and_pages(); // zones construction init
    mark_kernel_pages();
}

/*
 * number: number < 64
 * zone_select: zone select from dma, mapped in pagetable, unmapped in pagetable
 * page_flags: struct Page flages
 */

struct Page *alloc_pages(int zone_select, int number, unsigned long page_flags)
{
    int i;
    unsigned long page = 0;
    unsigned long attribute = 0;
    int zone_start = 0;
    int zone_end = 0;

    if (number >= 64 || number <= 0) {
        color_printk(RED, BLACK, "alloc_pages() ERROR: number is invalid\n");
        return NULL;
    }

    switch (zone_select) {
        case ZONE_DMA:
            zone_start = 0;
            zone_end = ZONE_DMA_INDEX;
            attribute = PG_PTable_Maped;
            break;
        case ZONE_NORMAL:
            zone_start = ZONE_DMA_INDEX;
            zone_end = ZONE_NORMAL_INDEX;
            attribute = PG_PTable_Maped;
            break;
        case ZONE_UNMAPED:
            zone_start = ZONE_UNMAPED_INDEX;
            zone_end = memory_management_struct.zones_size - 1;
            attribute = 0;
            break;
        default:
            color_printk(RED,BLACK,"alloc_pages() ERROR: zone_select index is invalid\n");
            return NULL;
            break;
    }

    // number為需申請的頁數，遍歷所有的zone，找到一個zone可分配number頁數的內存。
    for(i = zone_start; i <= zone_end; i++) {
        struct Zone *z;
        unsigned long j;
        unsigned long start, end;
        unsigned long tmp;

        if ((memory_management_struct.zones_struct + i)->page_free_count < number)
            continue; // 頁不足的zone就跳過

        z = memory_management_struct.zones_struct + i;
        start = z->zone_start_address >> PAGE_2M_SHIFT;
        end = z->zone_end_address >> PAGE_2M_SHIFT;

        tmp = 64 - start % 64; // 因為在bit_map中每一項都代表64個page，考慮對齊問題引入參數tmp
        // start + tmp 為 64的倍數，因此for迴圈只有在第一次循環時j可能不對齊，其餘都是64倍數
        for(j = start; j <= end; j += j % 64 ? tmp : 64) {

            unsigned long *p = memory_management_struct.bits_map + (j >> 6); // bits_map一項表示64個頁。
            unsigned long shift = j % 64; // 找到j於bits_map對應項中的位元。
            unsigned long k = 0;
            unsigned long num = (1UL << number) - 1;

            for(k = shift; k < 64; k++) {
                /**
                 * (*p >> k) | (*(p + 1) << (64 - k)用於取得連續的64個page。
                 * 假設運算的結果不是0則代表找不到連續的可用物理頁，取!即可幫助判斷是否存在連續可用的頁。
                 * 由於當前可申請頁的最大數量為63，所以不需考慮64個頁的特例。
                 */
                if (!((k ? ((*p >> k) | (*(p + 1) << (64 - k))) : *p) & (num))) {
                    unsigned long l;
                    page = j + k - shift;
                    for(l = 0; l < number; l++){
                        struct Page *pageptr = memory_management_struct.pages_struct + page + l;
                        unsigned long page_offset = pageptr->PHY_address >> PAGE_2M_SHIFT;
                        *(memory_management_struct.bits_map + (page_offset >> 6)) |= 1UL << page_offset % 64;
                        z->page_using_count++;
                        z->page_free_count--;
                        pageptr->attribute = attribute;
                    }
                    goto find_free_pages;
                }
            }
        }
    }
    color_printk(RED, BLACK, "alloc_pages() ERROR: no page can alloc\n");
    return NULL;

find_free_pages:

    return (struct Page*)(memory_management_struct.pages_struct + page);
}

/**
 * page: free page start from this pointer
 * number: number < 64
 */

void free_pages(struct Page *page, int number)
{	
    int i = 0;
    
    if (page == NULL) {
        color_printk(RED, BLACK, "free_pages() ERROR: page is invalid\n");
        return;
    }	

    if (number >= 64 || number <= 0) {
        color_printk(RED, BLACK, "free_pages() ERROR: number is invalid\n");
        return;	
    }
    
    for(i = 0; i < number; i++, page++) {
        unsigned long page_offset = page->PHY_address >> PAGE_2M_SHIFT;
        *(memory_management_struct.bits_map + (page_offset >> 6)) &= ~(1UL << page_offset % 64);
        page->zone_struct->page_using_count--;
        page->zone_struct->page_free_count++;
        page->attribute = 0;
    }
}

void pagetable_init()
{
    unsigned long i, j;
    unsigned long *tmp = NULL;

    unsigned long base_addr = (unsigned long)Get_gdt() & (~0xfffUL);

    tmp = (unsigned long*)((unsigned long)Phy_To_Virt(base_addr) + 8 * 256);
    // Get_gdt() & (~0xfffUL)用於將CR3暫存器的低12位標誌位屏蔽以取得一級頁表的基地址，8 * 256代表將tmp定位到第256項。
    // color_printk(YELLOW, BLACK, "1:%#018lx,%#018lx\t\t\n", (unsigned long)tmp, *tmp);

    tmp = Phy_To_Virt(*tmp & (~0xfffUL)); // 目前設定的三級頁表可用Phy_To_Virt映射，此操作用於找出下一級頁表的虛擬地址。
    // color_printk(YELLOW, BLACK, "2:%#018lx,%#018lx\t\t\n", (unsigned long)tmp, *tmp);

    tmp = Phy_To_Virt(*tmp & (~0xfffUL));
    // color_printk(YELLOW, BLACK, "3:%#018lx,%#018lx\t\t\n", (unsigned long)tmp, *tmp);

    for (i = 0; i < memory_management_struct.zones_size; i++) {
        struct Zone *z = memory_management_struct.zones_struct + i;
        struct Page *p = z->pages_group;

        if (ZONE_UNMAPED_INDEX && i == ZONE_UNMAPED_INDEX)
            break;

        for (j = 0; j < z->pages_length; j++, p++) {
            tmp = (unsigned long*)((unsigned long)Phy_To_Virt(base_addr) + (((unsigned long)Phy_To_Virt(p->PHY_address) >> PAGE_GDT_SHIFT) & 0x1ff) * 8);
            // Phy_To_Virt(p->PHY_address) >> PAGE_GDT_SHIFT) & 0x1ff) * 8 用於計算頁表中的索引位置。(目前頁表都放在可使用Phy_To_Virt線性映射的區域)。
            
            if (*tmp == 0) {
                // 如果*tmp=0代表尚未建立映射關係，此時使用kmalloc取得4KB空間，這4KB空間是tmp所指向的下一級頁表。
                unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0); // 目前kmalloc使用的空間也在Phy_To_Virt線性映射的區域。
                set_mpl4t(tmp, mk_mpl4t(Virt_To_Phy(virtual), PAGE_KERNEL_GDT));
                // mk_mpl4t用於組合物理地址與頁表的屬性，巨集set_mpl4t則將其寫入*tmp中。
            }

            tmp = (unsigned long*)((unsigned long)Phy_To_Virt(*tmp & (~0xfffUL)) + (((unsigned long)Phy_To_Virt(p->PHY_address) >> PAGE_1G_SHIFT) & 0x1ff) * 8);
            // 將tmp轉換到2級頁表的目標項次

            if (*tmp == 0) {
                unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0);
                set_pdpt(tmp, mk_pdpt(Virt_To_Phy(virtual), PAGE_KERNEL_Dir));
                // set_pdpt定義與set_mpl4t相同，mk_pdpt與mk_mpl4t相同，僅僅用於區分目前處理的是幾級頁表的項次。
            }

            tmp = (unsigned long*)((unsigned long)Phy_To_Virt(*tmp & (~0xfffUL)) + (((unsigned long)Phy_To_Virt(p->PHY_address) >> PAGE_2M_SHIFT) & 0x1ff) * 8);
            // 將tmp轉換到3級頁表的目標項次(x86-64支援2MB的大頁目前的系統頁分配會以2MB為單位)。
            set_pdt(tmp, mk_pdt(p->PHY_address,PAGE_KERNEL_Page));
            // if (j % 50 == 0)
            //    color_printk(GREEN, BLACK, "@:%#018lx,%#018lx\t\n", (unsigned long)tmp, *tmp);
        }
    }
    flush_tlb(); // 刷新TLB，使映射生效。
}

unsigned long do_brk(unsigned long addr, unsigned long len)
{
    unsigned long *tmp = NULL;
    unsigned long *virtual = NULL;
    struct Page *p = NULL;
    unsigned long i = 0;
    for (i = addr; i < addr + len; i += PAGE_2M_SIZE) {
        tmp = Phy_To_Virt((unsigned long*)((unsigned long)current->mm->pgd & (~0xfffUL)) +
                         ((i >> PAGE_GDT_SHIFT) & 0x1ff));
        if (*tmp == NULL) {
            virtual = kmalloc(PAGE_4K_SIZE, 0);
            memset(virtual, 0, PAGE_4K_SIZE);
            set_mpl4t(tmp, mk_mpl4t(Virt_To_Phy(virtual), PAGE_USER_GDT));
        }

        tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) + ((i >> PAGE_1G_SHIFT) & 0x1ff));
        if (*tmp == NULL) {
            virtual = kmalloc(PAGE_4K_SIZE, 0);
            memset(virtual, 0, PAGE_4K_SIZE);
            set_pdpt(tmp, mk_pdpt(Virt_To_Phy(virtual), PAGE_USER_Dir));
        }

        tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) + ((i >> PAGE_2M_SHIFT) & 0x1ff));
        if (*tmp == NULL) {
            p = alloc_pages(ZONE_NORMAL, 1, PG_PTable_Maped);
            if (p == NULL)
                return -ENOMEM;
            set_pdt(tmp, mk_pdt(p->PHY_address, PAGE_USER_Page));
        }        
    }

    current->mm->end_brk = i;
    flush_tlb(); // 刷新快取

    return i;
}