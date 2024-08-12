#include "memory.h"
#include "lib.h"

void init_memory()
{
    int i,j;
    unsigned long TotalMem = 0 ;
    struct E820 *p = NULL;	
    
    color_printk(BLUE,BLACK,"Display Physics Address MAP,Type(1:RAM,2:ROM or Reserved,3:ACPI Reclaim Memory,4:ACPI NVS Memory,Others:Undefine)\n");
    p = (struct E820 *)0xffff800000007e00;

    for (i = 0; i < 32; ++i) {
        color_printk(ORANGE,BLACK, "Address:%#018lx\tLength:%#018lx\tType:%#010x\n", p->address, p->length, p->type);
        unsigned long tmp = 0;
        if(p->type == 1)
            TotalMem +=  p->length;

        memory_management_struct.e820[i].address += p->address;
        memory_management_struct.e820[i].length	 += p->length;
        memory_management_struct.e820[i].type	 = p->type;
        memory_management_struct.e820_length     = i;

        p++;
        if(p->type > 4 || p->length == 0 || p->type < 1)
            break;		
    }

    color_printk(ORANGE, BLACK, "OS Can Used Total RAM:%#018lx\n", TotalMem);

    TotalMem = 0; // 考慮頁表對齊重新計算記憶體資源。

    for (i = 0; i <= memory_management_struct.e820_length; ++i) {
        unsigned long start, end;
        if (memory_management_struct.e820[i].type != 1)
            continue;
        start = PAGE_2M_ALIGN(memory_management_struct.e820[i].address);
        end   = (memory_management_struct.e820[i].address + memory_management_struct.e820[i].length) & PAGE_2M_MASK;
        if (end <= start)
            continue;
        TotalMem += (end - start) >> PAGE_2M_SHIFT;
    }

    color_printk(ORANGE, BLACK, "OS Can Used Total 2M PAGEs:%#010x=%010d\n", TotalMem, TotalMem);
    TotalMem = memory_management_struct.e820[memory_management_struct.e820_length].address
               + memory_management_struct.e820[memory_management_struct.e820_length].length; // 這是總地址空間，包括RAM、ROM、內存空洞等。
           
    // bits map construction init
    memory_management_struct.bits_map = (unsigned long*) ((memory_management_struct.end_brk + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.bits_size = TotalMem >> PAGE_2M_SHIFT;
    memory_management_struct.bits_length = (((unsigned long)(TotalMem >> PAGE_2M_SHIFT)
                                            + sizeof(long) * 8 - 1) / 8) & ( ~ (sizeof(long) - 1));
    memset(memory_management_struct.bits_map, 0xff, memory_management_struct.bits_length);

    //pages construction init

    // pages construction init
    memory_management_struct.pages_struct = (struct Page*)(((unsigned long)memory_management_struct.bits_map
                                            + memory_management_struct.bits_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.pages_size = TotalMem >> PAGE_2M_SHIFT;
    memory_management_struct.pages_length = ((TotalMem >> PAGE_2M_SHIFT) * sizeof(struct Page) + sizeof(long) - 1)
                                            & (~sizeof(long) - 1);
    memset(memory_management_struct.pages_struct, 0, memory_management_struct.pages_length); //init pages memory

    //zones construction init
    memory_management_struct.zone_struct = (struct Zone*)(((unsigned long)memory_management_struct.pages_struct
                                            + memory_management_struct.pages_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.zones_size = 0;
    memory_management_struct.zones_length = (5 * sizeof(struct Zone) + sizeof(long) - 1) & (~(sizeof(long) - 1));
    memset(memory_management_struct.zone_struct, 0, memory_management_struct.zones_length); //init zones memory

    for (i = 0; i < memory_management_struct.e820_length; ++i) {
        unsigned long start, end;
        struct Zone *z;
        struct Page *p;
        unsigned long *b;

        if (memory_management_struct.e820[i].type != 1)
            continue; // 非OS可用內存就跳過
        start = PAGE_2M_ALIGN(memory_management_struct.e820[i].address); // 內存頁先對2MB對齊
        end = (memory_management_struct.e820[i].address + memory_management_struct.e820[i].length) & PAGE_2M_MASK;
        if (end <= start)
            continue; // 代表這一塊內存無法劃分出一塊大小為2MB並且與2MB對齊的頁，故跳過。
        // 這裡相當於依照BIOS系統呼叫int 15h AX=E820h的返回結果，如果這塊內存符合條件，就把它放到一個新的zone。
        // zone init
        z = memory_management_struct.zone_struct + memory_management_struct.zones_size; // 相當於zone_struct[zones_size] 
        memory_management_struct.zones_size++;

        z->zone_start_address = start;
        z->zone_end_address = end;
        z->zone_length = end - start;

        z->page_using_count = 0;
        z->page_free_count = (end - start) >> PAGE_2M_SHIFT;
        
        z->total_pages_link = 0;

        z->attribute = 0;
        z->GMD_struct = &memory_management_struct;

        z->pages_length = (end - start) >> PAGE_2M_SHIFT;
        z->pages_group = (struct Page*)(memory_management_struct.pages_struct + (start >> PAGE_2M_SHIFT));

        //page init
        p = z->pages_group;
        for (j = 0; j < z->pages_length; ++j, ++p) {
            p->zone_struct = z;
            p->PHY_address = start + PAGE_2M_SIZE * j;
            p->attribute = 0;

            p->reference_count = 0;
            p->age = 0;

            *(memory_management_struct.bits_map + ((p->PHY_address >> PAGE_2M_SHIFT) >> 6)) ^= 1UL << (p->PHY_address >> PAGE_2M_SHIFT) % 64;
            /* 在bit_map一個位元就代表一個頁。
             * (p->PHY_address >> PAGE_2M_SHIFT) >> 6用於索引此物理頁對應bits_map哪一項。
             * 右移6位則是因為bits_map的每一個元素是64位元。
             * 1ul << (p->PHY_address >> PAGE_2M_SHIFT) % 64 則用於計算需要標記的是哪一個位元。
             * 利用^=把這個位元清0，來表示這一個頁可以被使用。
             */
        }
    }

    /////////////init address 0 to page struct 0; because the memory_management_struct.e820[0].type != 1
    
    memory_management_struct.pages_struct->zone_struct = memory_management_struct.zone_struct;

    memory_management_struct.pages_struct->PHY_address = 0UL;
    memory_management_struct.pages_struct->attribute = 0;
    memory_management_struct.pages_struct->reference_count = 0;
    memory_management_struct.pages_struct->age = 0;

    /////////////
    memory_management_struct.zones_length = (memory_management_struct.zones_size * sizeof(struct Zone) + sizeof(long) - 1) & ( ~ (sizeof(long) - 1));
    color_printk(ORANGE, BLACK, "bits_map:%#018lx,bits_size:%#018lx,bits_length:%#018lx\n",
                 memory_management_struct.bits_map, memory_management_struct.bits_size, memory_management_struct.bits_length);
    color_printk(ORANGE, BLACK, "pages_struct:%#018lx,pages_size:%#018lx,pages_length:%#018lx\n",
                 memory_management_struct.pages_struct, memory_management_struct.pages_size, memory_management_struct.pages_length);
    color_printk(ORANGE, BLACK, "zone_struct:%#018lx,zones_size:%#018lx,zones_length:%#018lx\n",
                 memory_management_struct.zone_struct, memory_management_struct.zones_size, memory_management_struct.zones_length);

    ZONE_DMA_INDEX = 0; //need rewrite in the future
    ZONE_NORMAL_INDEX = 0; //need rewrite in the future

    for (i = 0; i < memory_management_struct.zones_size; ++i) { //need rewrite in the future
        struct Zone *z = memory_management_struct.zone_struct + i;
        color_printk(ORANGE, BLACK, "zone_start_address:%#018lx,zone_end_address:%#018lx,zone_length:%#018lx,pages_group:%#018lx,pages_length:%#018lx\n",
                    z->zone_start_address, z->zone_end_address, z->zone_length, z->pages_group, z->pages_length);
        if (z->zone_start_address == 0x100000000)
            ZONE_UNMAPED_INDEX = i;
    }
    memory_management_struct.end_of_struct = (unsigned long) ((unsigned long) memory_management_struct.zone_struct 
                                             + memory_management_struct.zones_length + sizeof(long) * 32) & (~(sizeof(long) - 1));

    color_printk(ORANGE,BLACK, "start_code:%#018lx,end_code:%#018lx,end_data:%#018lx,end_brk:%#018lx,end_of_struct:%#018lx\n",
                 memory_management_struct.start_code, memory_management_struct.end_code, memory_management_struct.end_data, memory_management_struct.end_brk, memory_management_struct.end_of_struct);

    i = Virt_To_Phy(memory_management_struct.end_of_struct) >> PAGE_2M_SHIFT;/* 這裡用於計算內存頁管理結構佔據多少頁 */

    for (j = 0; j <= i; ++j) {
        page_init(memory_management_struct.pages_struct + j,PG_PTable_Maped | PG_Kernel_Init | PG_Active | PG_Kernel);
    }

    Global_CR3 = Get_gdt();
    color_printk(INDIGO,BLACK, "Global_CR3\t:%#018lx\n", Global_CR3);
    color_printk(INDIGO,BLACK, "*Global_CR3\t:%#018lx\n", *Phy_To_Virt(Global_CR3) & (~0xff));
    color_printk(PURPLE,BLACK, "**Global_CR3\t:%#018lx\n", *Phy_To_Virt(*Phy_To_Virt(Global_CR3) & (~0xff)) & (~0xff));

    flush_tlb();
}

/*
    number: number < 64
    zone_select: zone select from dma, mapped in  pagetable, unmapped in pagetable
    page_flags: struct Page flages

*/

struct Page *alloc_pages(int zone_select,int number,unsigned long page_flags)
{
    int i;
    unsigned long page = 0;
    int zone_start = 0;
    int zone_end = 0;

    switch(zone_select) {
        case ZONE_DMA:
            zone_start = 0;
            zone_end = ZONE_DMA_INDEX;
            break;
        case ZONE_NORMAL:
            zone_start = ZONE_DMA_INDEX;
            zone_end = ZONE_NORMAL_INDEX;
            break;
        case ZONE_UNMAPED:
            zone_start = ZONE_UNMAPED_INDEX;
            zone_end = memory_management_struct.zones_size - 1;
            break;
        default:
            color_printk(RED,BLACK,"alloc_pages error zone_select index\n");
            return NULL;
            break;
    }

    // number為需申請的頁數，遍歷所有的zone，找到一個zone可分配number頁數的內存。
    for(i = zone_start; i <= zone_end; ++i) {
        struct Zone *z;
        unsigned long j;
        unsigned long start, end, length;
        unsigned long tmp;

        if((memory_management_struct.zone_struct + i)->page_free_count < number)
            continue; // 頁不足的zone就跳過

        z = memory_management_struct.zone_struct + i;
        start = z->zone_start_address >> PAGE_2M_SHIFT;
        end = z->zone_end_address >> PAGE_2M_SHIFT;
        length = z->zone_length >> PAGE_2M_SHIFT;

        tmp = 64 - start % 64; // 因為在bit_map中每一項都代表64個page，考慮對齊問題引入參數tmp
        // start + tmp 為 64的倍數，因此for迴圈只有在第一次循環時j可能不對齊，其餘都是64倍數
        for(j = start; j <= end; j += j % 64 ? tmp : 64) {
            unsigned long * p = memory_management_struct.bits_map + (j >> 6); // bits_map一項表示64個頁。
            unsigned long shift = j % 64; // 找到j於bits_map對應項中的位元。
            unsigned long k;
            for(k = shift; k < 64 - shift; ++k) {
                /* (*p >> k) | (*(p + 1) << (64 - k)用於取得連續的64個page。
                 * 三元表達式用於避免溢出，用了一個number == 64的特例，並建立掩碼。 
                 * 假設做與運算的結果不是0則代表找不到連續的可用物理頁，取!即可幫助判斷。
                 */
                if( !(((*p >> k) | (*(p + 1) << (64 - k))) & (number == 64 ? 0xffffffffffffffffUL : (1UL << number) - 1))) {
                    // 找到可用的頁並分配空間
                    unsigned long l;
                    page = j + k - 1; // 定位pages_struct中所代表的物理頁
                    for(l = 0; l < number; ++l) {
                        struct Page *x = memory_management_struct.pages_struct + page + l;
                        page_init(x,page_flags); // 初始化
                    }
                    goto find_free_pages;
                }
            }
        }
    }

    return NULL;

find_free_pages:

    return (struct Page*)(memory_management_struct.pages_struct + page);
}

unsigned long page_init(struct Page *page, unsigned long flags)
{
    if (!page->attribute) {
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64;
        page->attribute = flags;
        page->reference_count++;
        page->zone_struct->page_using_count++;
        page->zone_struct->page_free_count--;
        page->zone_struct->total_pages_link++;
    } else if ((page->attribute & PG_Referenced) || (page->attribute & PG_K_Share_To_U)
                || (flags & PG_Referenced) || (flags & PG_K_Share_To_U)) {
        page->attribute |= flags;
        page->reference_count++;
        page->zone_struct->total_pages_link++;
    } else {
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64;
        page->attribute |= flags;
    }
    return 0;
}

unsigned long page_clean(struct Page *page) {
    if(!page->attribute) {
        page->attribute = 0;
    } else if((page->attribute & PG_Referenced) || (page->attribute & PG_K_Share_To_U)) {		
        page->reference_count--;
        page->zone_struct->total_pages_link--;
        if(!page->reference_count) {
            page->attribute = 0;
            page->zone_struct->page_using_count--;
            page->zone_struct->page_free_count++;
        }
    } else {
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) &= ~(1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64);

        page->attribute = 0;
        page->reference_count = 0;
        page->zone_struct->page_using_count--;
        page->zone_struct->page_free_count++;
        page->zone_struct->total_pages_link--;
    }
    return 0;
}

