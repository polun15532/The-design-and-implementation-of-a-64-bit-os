/***************************************************
*		版权声明
*
*	本操作系统名为：MINE
*	该操作系统未经授权不得以盈利或非盈利为目的进行开发，
*	只允许个人学习以及公开交流使用
*
*	代码最终所有权及解释权归田宇所有；
*
*	本模块作者：	田宇
*	EMail:		345538255@qq.com
*
*
***************************************************/

#include "memory.h"
#include "printk.h"
#include "lib.h"
#include "errno.h"

struct Global_Memory_Descriptor memory_management_struct = {{0},0};

struct Slab_cache kmalloc_cache_size[16] = {
    {1 << 5 , 0, 0, NULL, NULL, NULL, NULL},
    {1 << 6 , 0, 0, NULL, NULL, NULL, NULL},
    {1 << 7 , 0, 0, NULL, NULL, NULL, NULL},
    {1 << 8 , 0, 0, NULL, NULL, NULL, NULL},
    {1 << 9 , 0, 0, NULL, NULL, NULL, NULL},
    {1 << 10, 0, 0, NULL, NULL, NULL, NULL}, //1KB
    {1 << 11, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 12, 0, 0, NULL, NULL, NULL, NULL}, //4KB
    {1 << 13, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 14, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 15, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 16, 0, 0, NULL, NULL, NULL, NULL}, //64KB
    {1 << 17, 0, 0, NULL, NULL, NULL, NULL}, //128KB
    {1 << 18, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 19, 0, 0, NULL, NULL, NULL, NULL},
    {1 << 20, 0, 0, NULL, NULL, NULL, NULL}, //1MB
};


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

    if (!page->reference_count) {
        page->attribute &= PG_PTable_Maped;
    }
    return 1;
}

unsigned long get_page_attribute(struct Page *page)
{
    if (page == NULL) {
        color_printk(RED, BLACK, "get_page_attribute() ERROR: page == NULL\n");
        return 0;
    }
    return page->attribute;
}

unsigned long set_page_attribute(struct Page *page, unsigned long flags)
{
    if (page == NULL) {
        color_printk(RED, BLACK, "set_page_attribute() ERROR: page == NULL\n");
        return 0;
    }
    page->attribute = flags;
    return 1;
}

void init_memory()
{
    int i,j;
    unsigned long TotalMem = 0 ;
    struct E820 *p = NULL;	
    
    // color_printk(RED,BLACK,"Display Physics Address MAP,Type(1:RAM,2:ROM or Reserved,3:ACPI Reclaim Memory,4:ACPI NVS Memory,Others:Undefine)\n");
    p = (struct E820 *)0xffff800000007e00;

    for (i = 0; i < 32; i++) {
        // color_printk(ORANGE,BLACK, "Address:%#018lx\tLength:%#018lx\tType:%#010x\n", p->address, p->length, p->type);
        unsigned long tmp = 0;
        if (p->type == 1)
            TotalMem +=  p->length;

        memory_management_struct.e820[i].address = p->address;
        memory_management_struct.e820[i].length	 = p->length;
        memory_management_struct.e820[i].type	 = p->type;
        memory_management_struct.e820_length     = i;

        p++;
        if (p->type > 4 || p->length == 0 || p->type < 1)
            break;
    }

    // color_printk(ORANGE, BLACK, "OS Can Used Total RAM:%#018lx\n", TotalMem);

    TotalMem = 0; // 考慮頁表對齊重新計算記憶體資源。

    for (i = 0; i <= memory_management_struct.e820_length; i++) {
        unsigned long start, end;
        if (memory_management_struct.e820[i].type != 1)
            continue;
        start = PAGE_2M_ALIGN(memory_management_struct.e820[i].address);
        end   = (memory_management_struct.e820[i].address + memory_management_struct.e820[i].length) & PAGE_2M_MASK;
        if (end <= start)
            continue;
        TotalMem += (end - start) >> PAGE_2M_SHIFT;
    }

    // color_printk(ORANGE, BLACK, "OS Can Used Total 2M PAGEs:%#010x=%010d\n", TotalMem, TotalMem);
    TotalMem = memory_management_struct.e820[memory_management_struct.e820_length].address
               + memory_management_struct.e820[memory_management_struct.e820_length].length; // 這是總地址空間，包括RAM、ROM、內存空洞等。
           
    // bits map construction init
    memory_management_struct.bits_map = (unsigned long*) ((memory_management_struct.start_brk + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.bits_size = TotalMem >> PAGE_2M_SHIFT;
    memory_management_struct.bits_length = (((unsigned long)(TotalMem >> PAGE_2M_SHIFT) + sizeof(long) * 8 - 1) / 8) & ( ~ (sizeof(long) - 1));
    memset(memory_management_struct.bits_map, 0xff, memory_management_struct.bits_length); //init bits map memory

    //pages construction init
    memory_management_struct.pages_struct = (struct Page*)(((unsigned long)memory_management_struct.bits_map
                                            + memory_management_struct.bits_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.pages_size = TotalMem >> PAGE_2M_SHIFT;
    memory_management_struct.pages_length = ((TotalMem >> PAGE_2M_SHIFT) * sizeof(struct Page) + sizeof(long) - 1) & (~sizeof(long) - 1);
    memset(memory_management_struct.pages_struct, 0, memory_management_struct.pages_length); //init pages memory

    //zones construction init
    memory_management_struct.zones_struct = (struct Zone*)(((unsigned long)memory_management_struct.pages_struct
                                            + memory_management_struct.pages_length + PAGE_4K_SIZE - 1) & PAGE_4K_MASK);
    memory_management_struct.zones_size = 0;
    memory_management_struct.zones_length = (5 * sizeof(struct Zone) + sizeof(long) - 1) & (~(sizeof(long) - 1));
    memset(memory_management_struct.zones_struct, 0, memory_management_struct.zones_length); //init zones memory

    for (i = 0; i < memory_management_struct.e820_length; i++) {
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
        // zone init
        z = memory_management_struct.zones_struct + memory_management_struct.zones_size; // 相當於zones_struct[zones_size] 
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
        for (j = 0; j < z->pages_length; j++, p++) {
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

    //init address 0 to page struct 0; because the memory_management_struct.e820[0].type != 1
    
    memory_management_struct.pages_struct->zone_struct = memory_management_struct.zones_struct;

    memory_management_struct.pages_struct->PHY_address = 0UL;
    set_page_attribute(memory_management_struct.pages_struct,PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
    memory_management_struct.pages_struct->reference_count = 1;
    memory_management_struct.pages_struct->age = 0;

    memory_management_struct.zones_length = (memory_management_struct.zones_size * sizeof(struct Zone) + sizeof(long) - 1) & ( ~ (sizeof(long) - 1));
    /*
    color_printk(ORANGE, BLACK, "bits_map:%#018lx,bits_size:%#018lx,bits_length:%#018lx\n",
                 memory_management_struct.bits_map, memory_management_struct.bits_size, memory_management_struct.bits_length);
    color_printk(ORANGE, BLACK, "pages_struct:%#018lx,pages_size:%#018lx,pages_length:%#018lx\n",
                 memory_management_struct.pages_struct, memory_management_struct.pages_size, memory_management_struct.pages_length);
    color_printk(ORANGE, BLACK, "zone_struct:%#018lx,zones_size:%#018lx,zones_length:%#018lx\n",
                 memory_management_struct.zones_struct, memory_management_struct.zones_size, memory_management_struct.zones_length);
    */
    ZONE_DMA_INDEX = 0;
    ZONE_NORMAL_INDEX = 0;
    ZONE_UNMAPED_INDEX = 0;

    for (i = 0; i < memory_management_struct.zones_size; i++) {
        struct Zone *z = memory_management_struct.zones_struct + i;
        // color_printk(ORANGE, BLACK, "zone_start_address:%#018lx,zone_end_address:%#018lx,zone_length:%#018lx,pages_group:%#018lx,pages_length:%#018lx\n",
        //            z->zone_start_address, z->zone_end_address, z->zone_length, z->pages_group, z->pages_length);
        if (z->zone_start_address >= 0x100000000 && !ZONE_UNMAPED_INDEX)
            ZONE_UNMAPED_INDEX = i;
    }

    // color_printk(ORANGE, BLACK, "ZONE_DMA_INDEX:%d\tZONE_NORMAL_INDEX:%d\tZONE_UNMAPED_INDEX:%d\n", ZONE_DMA_INDEX,ZONE_NORMAL_INDEX, ZONE_UNMAPED_INDEX);
    memory_management_struct.end_of_struct = (unsigned long) ((unsigned long) memory_management_struct.zones_struct 
                                             + memory_management_struct.zones_length + sizeof(long) * 32) & (~(sizeof(long) - 1));

    // color_printk(ORANGE,BLACK, "start_code:%#018lx,end_code:%#018lx,end_data:%#018lx,start_brk:%#018lx,end_of_struct:%#018lx\n",
    //             memory_management_struct.start_code, memory_management_struct.end_code, memory_management_struct.end_data, memory_management_struct.start_brk, memory_management_struct.end_of_struct);

    i = Virt_To_Phy(memory_management_struct.end_of_struct) >> PAGE_2M_SHIFT; /* 這理用於計算從地址0到內存管理結構結尾佔據多少頁 */

    for (j = 1; j <= i; j++) {
        struct Page * tmp_page =  memory_management_struct.pages_struct + j;
        page_init(tmp_page, PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
        *(memory_management_struct.bits_map + ((tmp_page->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (tmp_page->PHY_address >> PAGE_2M_SHIFT) % 64;
        tmp_page->zone_struct->page_using_count++;
        tmp_page->zone_struct->page_free_count--;
    }

    /*
    color_printk(INDIGO, BLACK, "CR3\t:%#018lx\n", Get_gdt());
    color_printk(INDIGO, BLACK, "*CR3\t:%#018lx\n", *Phy_To_Virt(Get_gdt()) & (~0xff));
    color_printk(PURPLE, BLACK, "**CR3\t:%#018lx\n", *Phy_To_Virt(*Phy_To_Virt(Get_gdt()) & (~0xff)) & (~0xff));
    
    color_printk(ORANGE, 
                 BLACK,
                 "1.memory_management_struct.bits_map:%#018lx\tzone_struct->page_using_count:%d\tzone_struct->page_free_count:%d\n",
                 *memory_management_struct.bits_map,
                 memory_management_struct.zones_struct->page_using_count,
                 memory_management_struct.zones_struct->page_free_count);
    */

    flush_tlb();
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

                        *(memory_management_struct.bits_map + ((pageptr->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (pageptr->PHY_address >> PAGE_2M_SHIFT) % 64;
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
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) &= ~(1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64);
        page->zone_struct->page_using_count--;
        page->zone_struct->page_free_count++;
        page->attribute = 0;
    }
}

void *kmalloc(unsigned long size, unsigned long gfp_flags)
{
    int i, j;
    struct Slab *slab = NULL;
    if (size > (1 << 20)) {
        /* 假設申請大小超過1MB，將因找不到合適大小的內存塊而無法申請 */
        color_printk(RED, BLACK, "kmalloc() ERROR: kmalloc size too long:%08d\n", size);
        return NULL;        
    }

    for (i = 0; i < 16 && kmalloc_cache_size[i].size < size; i++); // i<16可以省略，因為i>16的情況必須是申請內存塊大於1MB，但不可能出現。

    slab = kmalloc_cache_size[i].cache_pool;

    if (kmalloc_cache_size[i].total_free) {
        // 內存塊尚未使用完畢的狀況。
        do {
            // 走訪cache_pool中所有的slab，直到找到空閒內存塊。
            if (slab->free_count == 0)
                slab = container_of(list_next(&slab->list), struct Slab, list);
            else
                break;
        } while (slab != kmalloc_cache_size[i].cache_pool);
    } else {
        // 內存池已滿的狀況。
        slab = kmalloc_create(kmalloc_cache_size[i].size); // 建立新的slab並分配2MB頁空間。

        if (slab == NULL) {
            color_printk(YELLOW, BLACK, "kmalloc()->kmalloc_create()=>slab == NULL\n");
            return NULL;            
        }

        kmalloc_cache_size[i].total_free += slab->color_count;
        color_printk(YELLOW, BLACK, "kmalloc()->kmalloc_create()<=size:%#010x\n", kmalloc_cache_size[i].size);
        list_add_to_before(&kmalloc_cache_size[i].cache_pool->list, &slab->list); // 把新的slab加入list尾端。       
    }

    
    for (j = 0; j < slab->color_count; j++) {

        if (*(slab->color_map + (j >> 6)) == 0xffffffffffffffffUL) {
            // 從起始地址以64個內存塊為單位開始掃描，如果掃描到的數字其64位元接為1，表示此64內存塊接被占用，則改掃描下一個位置。
            j += 63;
            continue;
        }
        if ((*(slab->color_map + (j >> 6)) & (1UL << (j % 64))) == 0) {
            *(slab->color_map + (j >> 6)) |= 1UL << (j % 64);
            slab->using_count++;
            slab->free_count--;

            kmalloc_cache_size[i].total_free--;
            kmalloc_cache_size[i].total_using++;
            return (void *)((char *)slab->Vaddress + kmalloc_cache_size[i].size * j);
        }
    }

    color_printk(RED, BLACK, "kmalloc() ERROR: no memory can alloc\n");
    return NULL;
}

struct Slab *kmalloc_create(unsigned long size)
{
    int i;
    struct Slab *slab = NULL;
    struct Page *page = NULL;
    unsigned long *vaddress = NULL;
    long structsize = 0;

    page = alloc_pages(ZONE_NORMAL, 1, 0);

    if (page == NULL) {
        color_printk(RED, BLACK, "kmalloc_create()->alloc_pages()=>page == NULL\n");
        return NULL;
    }

    page_init(page, PG_Kernel);

    switch (size) {
        case 32:
        case 64:
        case 128:
        case 256:
        case 512:

            vaddress = Phy_To_Virt(page->PHY_address);
            structsize = sizeof(struct Slab) + PAGE_2M_SIZE / size / 8;

            slab = (struct Slab*)((unsigned char*)vaddress + PAGE_2M_SHIFT - structsize); // 申請頁的最尾端用來放置struct Slab與color_map數組。
            slab->color_map = (unsigned long*)((unsigned char*)slab + sizeof(struct Slab));
            
            slab->free_count = (PAGE_2M_SIZE - structsize) / size;
            slab->using_count = 0;
            slab->color_count = slab->free_count;
            slab->page = page;
            list_init(&slab->list);

            slab->color_length = (slab->color_count + sizeof(unsigned long) * 8 - 1 >> 6) << 3;
            memset(slab->color_map, 0xff, slab->color_length);
            
            for (i = 0; i < slab->color_count; i++) {
                *(slab->color_map + (i >> 6)) ^= 1UL << i % 64;
            }
            break;
        
        // kmalloc slab and map,not in 2M page anymore
        case 1024:
        case 2048:
        case 4096: // 4KB
        case 8192:
        // color_map is a very short buffer.
        case 16384:
        case 32768:
        case 65536:
        case 131072: // 128KB
        case 262144:
        case 524288:
        case 1048576: // 1MB
        // 由於size太大，把slab與struct Slab放置在頁的末尾，會浪費太多空間，不如轉用kmalloc分配。
            slab = (struct Slab*)kmalloc(sizeof(struct Slab), 0);
            slab->free_count = PAGE_2M_SIZE / size;
            slab->using_count = 0;
            slab->color_count = slab->free_count;
            slab->color_length = (slab->color_count + sizeof(unsigned long) * 8 - 1 >> 6) << 3;
            slab->color_map = (unsigned long*)kmalloc(slab->color_length, 0);
            memset(slab->color_map, 0xff, slab->color_length);

            slab->Vaddress = Phy_To_Virt(page->PHY_address);
            slab->page = page;
            list_init(&slab->list);
            for (i = 0; i < slab->color_count; i++) {
                *(slab->color_map + (i >> 6)) ^= 1UL << i % 64;
            }
            
            break;
        default:
            color_printk(RED, BLACK, "kmalloc_create() ERROR: wrong size:%08d\n", size);
            free_pages(page, 1);
            return NULL;
    }
    return slab;
}

unsigned long kfree(void *address)
{
    int i, index;
    struct Slab *slab = NULL;
    void *page_base_address = (void*)((unsigned long)address & PAGE_2M_MASK); // 取得該內存塊所在的頁的基地址。

    for (i = 0; i < 16; i++) {
        slab = kmalloc_cache_size[i].cache_pool;
        if (slab->Vaddress != page_base_address) {
            slab = container_of(list_next(&slab->list), struct Slab, list);
            for (; slab != kmalloc_cache_size[i].cache_pool && (slab->Vaddress != page_base_address); slab = container_of(list_next(&slab->list), struct Slab, list));
        }

        if (slab->Vaddress != page_base_address)
            continue;

        index = (address - slab->Vaddress) / kmalloc_cache_size[i].size;
        slab->free_count++;
        slab->using_count--;
        kmalloc_cache_size[i].total_free++;
        kmalloc_cache_size[i].total_using--;

        if (slab->using_count == 0 && kmalloc_cache_size[i].total_free >= slab->color_count * 3 / 2
            && kmalloc_cache_size[i].cache_pool != slab) {
            switch(kmalloc_cache_size[i].size) {
                // slab + struct Slab 放置在頁末尾的狀況。
                case 32:
                case 64:
                case 128:
                case 256:
                case 512:
                    list_del(&slab->list);
                    kmalloc_cache_size[i].total_free -= slab->color_count;
                    page_clean(slab->page);
                    free_pages(slab->page, 1);
                    break;
                default:
                    list_del(&slab->list);
                    kmalloc_cache_size[i].total_free -= slab->color_count;
                    kfree(slab->color_map);
                    page_clean(slab->page);
                    free_pages(slab->page, 1);
                    kfree(slab);
                    break;
            }
        }
        return 1;    
    }
    color_printk(RED, BLACK, "kfree() ERROR: can`t free memory\n");
    return 0;   
}

struct Slab_cache *slab_create(unsigned long size, void *(*constructor)(void *Vaddress, unsigned long arg) 
                              , void *(*destructor)(void *Vaddress, unsigned long arg), unsigned long arg)
{
    struct Slab_cache *slab_cache = NULL;
    slab_cache = (struct Slab_cache*)kmalloc(sizeof(struct Slab_cache), 0);
    if (slab_cache == NULL) {
        color_printk(RED, BLACK, "slab_create()->kmalloc()=>slab_cache == NULL\n");
        return NULL;
    }
    memset(slab_cache, 0, sizeof(struct Slab_cache));

    slab_cache->size = SIZEOF_LONG_ALIGN(size);
    slab_cache->total_using = 0;
    slab_cache->total_free = 0;
    slab_cache->cache_pool = (struct Slab*)kmalloc(sizeof(struct Slab), 0);
    if (slab_cache->cache_pool == NULL) {
        color_printk(RED, BLACK, "slab_create()->kmalloc()=>slab_cache->cache_pool == NULL\n");
        kfree(slab_cache);
        return NULL;
    }
    memset(slab_cache->cache_pool, 0, sizeof(struct Slab_cache));
    slab_cache->cache_dma_pool = NULL;
    slab_cache->constructor = constructor;
    slab_cache->destructor = destructor;
    list_init(&slab_cache->cache_pool->list);

    slab_cache->cache_pool->page = alloc_pages(ZONE_NORMAL, 1, 0); // 給cache_pool分配大小為2MB的頁

    if (slab_cache->cache_pool->page == NULL) {
        color_printk(RED, BLACK, "slab_create()->alloc_pages()=>slab_cache->cache_pool->page == NULL\n");
        kfree(slab_cache->cache_pool);
        kfree(slab_cache);
        return NULL;        
    }

    page_init(slab_cache->cache_pool->page, PG_Kernel); // 設置物理頁的屬性

    slab_cache->cache_pool->using_count = 0;
    slab_cache->cache_pool->free_count = PAGE_2M_SIZE / slab_cache->size; // 當前頁可使用的內存塊數量
    slab_cache->total_free = slab_cache->cache_pool->free_count; // 所有快取池的可用內存塊數量
    slab_cache->cache_pool->Vaddress = Phy_To_Virt(slab_cache->cache_pool->page->PHY_address);
    slab_cache->cache_pool->color_count = slab_cache->cache_pool->free_count;
    slab_cache->cache_pool->color_length = ((slab_cache->cache_pool->color_count + sizeof(unsigned long) * 8 - 1) >> 6) << 3;
    /** 
     * 上面的color_length用於計算需要多少空間才可以表示color_map。
     * sizeof(unsigned long) * 8 - 1用於讓color_map上對齊。
     * >>6是因為unsigned long有64位元，<<3則是因為unsigned long佔據8byte。
     */
    slab_cache->cache_pool->color_map = (unsigned long*)kmalloc(slab_cache->cache_pool->color_length, 0);

    if (slab_cache->cache_pool->color_map == NULL) {
        color_printk(RED, BLACK, "slab_create()->kmalloc()=>slab_cache->cache_pool->color_map == NULL\n");
        free_pages(slab_cache->cache_pool->page, 1);
        kfree(slab_cache->cache_pool);
        kfree(slab_cache);
        return NULL;        
    }

    memset(slab_cache->cache_pool->color_map, 0, slab_cache->cache_pool->color_length);
    return slab_cache;
}

unsigned long slab_destory(struct Slab_cache *slab_cache)
{
    struct Slab *slab_p = slab_cache->cache_pool;
    struct Slab *tmp_slab = NULL;
    if (slab_cache->total_using) { // 有正在使用的內存塊不能回收。
        color_printk(RED, BLACK, "slab_cache->total_using != 0\n");
        return 0;
    }

    while (!list_is_empty(&slab_p->list)) {
        // 逐個刪除list元素直到元素為空。
        tmp_slab = slab_p;
        slab_p = container_of(list_next(&slab_p->list), struct Slab, list);
        list_del(&tmp_slab->list);
        kfree(tmp_slab->color_map);
        page_clean(tmp_slab->page);
        kfree(tmp_slab);
    }

    kfree(slab_p->color_map);
    page_clean(slab_p->page);
    free_pages(slab_p->page, 1);
    kfree(slab_p);
    kfree(slab_cache);
    return 1;
}

void *slab_malloc(struct Slab_cache *slab_cache, unsigned long arg)
{
    struct Slab *slab_p = slab_cache->cache_pool;
    struct Slab *tmp_slab = NULL;
    int j = 0;

    // 這一段程式碼用於在slab_cache內存池中查找上未使用的內存塊並返回此內存塊。
    if (slab_cache->total_free == 0) {
        // 所有的內存塊被使用完畢，需分配新的頁以填充內存塊。
        tmp_slab = (struct Slab*)kmalloc(sizeof(struct Slab), 0);
        if (tmp_slab == NULL) {
            color_printk(RED, BLACK, "slab_malloc()->kmalloc()=>tmp_slab == NULL\n");
            return NULL;          
        }

        memset(tmp_slab, 0, sizeof(struct Slab));
        list_init(&tmp_slab->list);

        tmp_slab->page = alloc_pages(ZONE_NORMAL, 1, 0); // 分配新的頁
        if (tmp_slab->page = NULL) {
            color_printk(RED, BLACK, "slab_malloc()->alloc_pages()=>tmp_slab->page == NULL\n");
            kfree(tmp_slab);
            return NULL;            
        }
        page_init(tmp_slab->page, PG_Kernel); // 設定頁的屬性。

        tmp_slab->using_count = 0;
        tmp_slab->free_count = PAGE_2M_SIZE / slab_cache->size;
        tmp_slab->Vaddress = Phy_To_Virt(tmp_slab->page->PHY_address);
        
        tmp_slab->color_count = tmp_slab->free_count;
        tmp_slab->color_length = (tmp_slab->color_count + sizeof(unsigned long) * 8 - 1 >> 6) << 3;
        tmp_slab->color_map = (unsigned long*)kmalloc(tmp_slab->color_length, 0);

        if (tmp_slab->color_map == NULL) {
            color_printk(RED, BLACK, "slab_malloc()->kmalloc()=>tmp_slab->color_map == NULL\n");
            free_pages(tmp_slab->page, 1);
            kfree(tmp_slab);
            return NULL;            
        }
        memset(tmp_slab->color_map, 0, tmp_slab->color_length); // 將color_map代表的內存塊設為閒置狀態。
        list_add_to_behind(&slab_cache->cache_pool->list, &tmp_slab->list); // 將tmp_slab插入cache_pool中統一管理。
        slab_cache->total_free += tmp_slab->color_count; // 更新slab_cache可用內存塊數量。

        for (j = 0; j < tmp_slab->color_count; j++) {
            // 遍歷所有的內存塊，直至找到第1個閒置的內存塊。由於tmp_slab分配的是新的頁所以只會遍歷到j=0的內存塊而已。
            if ( (*(tmp_slab->color_map + (j >> 6)) & (1UL << (j % 64))) == 0) {
                *(tmp_slab->color_map + (j >> 6)) |= 1UL << (j % 64);

                tmp_slab->using_count++;
                tmp_slab->free_count--;

                slab_cache->total_using++;
                slab_cache->total_free--;
                
                if (slab_cache->constructor) {
                    return slab_cache->constructor((char *)tmp_slab->Vaddress + slab_cache->size * j, arg);
                } else { // 沒有slab建構函式的情況。
                    return (void *)((char*)tmp_slab->Vaddress + slab_cache->size * j);
                }		
            }
        }           
    } else {
        // 這裡是cache_pool中有閒置未使用的內存塊的情況。
        do { // 把cache_pool中所有的slab都掃過一次，直到找到空閒的內存塊。
            if (slab_p->free_count == 0) { // 當前slab沒有足夠空間，換找下一個。
                slab_p = container_of(list_next(&slab_p->list), struct Slab, list);
                continue;
            }

            for (j = 0; j < slab_p->color_count; j++) {
                if (*(slab_p->color_map + (j >> 6)) == 0xffffffffffffffffUL) { // 檢查color_map的第j >> 6項是否存在閒置內存塊。
                    j += 63;
                    continue;
                }
            }

            if ((*(slab_p->color_map + (j >> 6)) & (1UL << (j % 64))) == 0) {
                // slab_p所管理的第j個內存塊閒置。
                *(slab_p->color_map + (j >> 6)) |= 1UL << (j % 64);
                slab_p->using_count++;
                slab_p->free_count--;

                slab_cache->total_using++;
                slab_cache->total_free--;

                if (slab_cache->constructor) {
                    return slab_cache->constructor((char*)slab_p->Vaddress + slab_cache->size * j,arg);
                } else {
                    return (void*)((char*)slab_p->Vaddress + slab_cache->size * j);
                }
            }
        } while (slab_p != slab_cache->cache_pool);
    }

    color_printk(RED, BLACK, "slab_malloc() ERROR: can`t alloc\n");

    if (tmp_slab) {
        list_del(&tmp_slab->list);
        kfree(tmp_slab->color_map);
        page_clean(tmp_slab->page);
        free_pages(tmp_slab->page, 1);
        kfree(tmp_slab);        
    }
    return NULL;
}

unsigned long slab_free(struct Slab_cache *slab_cache, void *address, unsigned long arg)
{
    struct Slab *slab_p = slab_cache->cache_pool;
    int index = 0;
    do { // 走訪cache_pool的所有元素，直到找到紀錄著待釋放內存塊的slab。
        if (slab_p->Vaddress <= address && address < slab_p->Vaddress + PAGE_2M_SIZE) {
            index = (address - slab_p->Vaddress) / slab_cache->size; // 檢索釋放內存塊對應的color_map的哪個bit。
            *(slab_p->color_map + (index >> 6)) ^= 1UL << index % 64;
            slab_p->free_count++;
            slab_p->using_count--;

            slab_cache->total_free++;
            slab_cache->total_using--;

            if (slab_cache->destructor) { // 如果存在內存對象的解構函式
                slab_cache->destructor((char*)slab_p->Vaddress + slab_cache->size * index, arg);
            }

            if ((slab_p->using_count == 0) && (slab_cache->total_free >= slab_p->color_count * 3 / 2)) {
                // 判斷目前的slab是否要回收，如果剩餘內存塊數量大於1.5 slab所具有的數量，則回收當前的slab。
                list_del(&slab_p->list);
                slab_cache->total_free -= slab_p->color_count;
                kfree(slab_p->color_map);
                page_clean(slab_p->page);
                free_pages(slab_p->page, 1);
                kfree(slab_p);
            }
            return 1;
        } else {
            slab_p = container_of(list_next(&slab_p->list),struct Slab,list);
            continue;
            // 如果用for (; slab_p != slab_cache->cache_pool; slab_p = container_of(list_next(slab_p->list),struct Slab,list)) 可以少一層嵌套。
        }
    } while (slab_p != slab_cache->cache_pool);

    color_printk(RED, BLACK, "slab_free() ERROR: address not in slab\n");
    return 0;
}

// 初始化16個固定大小slab_cache內存池，內存池的尺寸分布為32byte-1MB，並各自分配2MB的頁空間，函是kmalloc、kfree的內存將從這申請與釋放
unsigned long slab_init()
{
    struct Page *page = NULL;
    unsigned long *virtual = NULL; // get a free page and set to empty page table and return the virtual address
    unsigned long i, j;
    unsigned long tmp_address = memory_management_struct.end_of_struct;
    
    // 為16個Slab_cache分配Slab
    for (i = 0; i < 16; i++) {
        // memory_management_struct.end_of_struct是一個線性變動地址，它代表了目前可用區域的起始線性地址，他會在後續的程式碼中一直被更動。
        kmalloc_cache_size[i].cache_pool = (struct Slab*)memory_management_struct.end_of_struct; // 定義結構體struct Slab的地址。
        memory_management_struct.end_of_struct += sizeof(struct Slab) + sizeof(long) * 10;
        // 這裡預保留sizeof(long) * 10的空間是為了防止訪問越界造成錯誤。
        list_init(&kmalloc_cache_size[i].cache_pool->list); // 初始化list。

        // 填入struct Slab的一些常數包括內存塊使用數量與閒置數量，有多少內存塊與表示所有內存塊狀態的數組。
        kmalloc_cache_size[i].cache_pool->using_count = 0;
        kmalloc_cache_size[i].cache_pool->free_count = PAGE_2M_SIZE / kmalloc_cache_size[i].size; // 內存塊數量

        kmalloc_cache_size[i].cache_pool->color_length = ((PAGE_2M_SIZE / kmalloc_cache_size->size) + sizeof(unsigned long) * 8 - 1 >> 6) << 3; 
        kmalloc_cache_size[i].cache_pool->color_count = kmalloc_cache_size[i].cache_pool->free_count;
        kmalloc_cache_size[i].cache_pool->color_map = (unsigned long*)memory_management_struct.end_of_struct; // 表示所有內存塊狀態。
        
        memory_management_struct.end_of_struct += (unsigned long)(kmalloc_cache_size[i].cache_pool->color_length + sizeof(long) * 10) & (~ (sizeof(long) - 1));

        memset(kmalloc_cache_size[i].cache_pool->color_map,0xff,kmalloc_cache_size[i].cache_pool->color_length); // 把所有狀態內存塊設為1。
        for (j = 0; j < kmalloc_cache_size[i].cache_pool->color_count; j++) {
            // 存在的內存塊設為0，表示閒置可以使用。
            *(kmalloc_cache_size[i].cache_pool->color_map + (j >> 6)) ^= 1UL << j % 64; // >> 6是因為color_map一項為64位元。
        }
        kmalloc_cache_size[i].total_free = kmalloc_cache_size[i].cache_pool->color_count;
        kmalloc_cache_size[i].total_using = 0;
    }
    
    // init page for kernel code and memory management struct
    i = Virt_To_Phy(memory_management_struct.end_of_struct) >> PAGE_2M_SHIFT;
    for (j = PAGE_2M_ALIGN(Virt_To_Phy(tmp_address)) >> PAGE_2M_SHIFT; j <= i; j++) {
        // PAGE_2M_ALIGN將以地址的上邊界對齊。j <= i的比較可以標示出那些已經使用而尚未記錄的頁。
        page = (struct Page*)(memory_management_struct.end_of_struct + j);
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64;
        page->zone_struct->page_using_count++;
        page->zone_struct->page_free_count--;
        page_init(page, PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
    }
/*
    color_printk(ORANGE ,BLACK, "2.memory_management_struct.bits_map:%#018lx\tzone_struct->page_using_count:%d\tzone_struct->page_free_count:%d\n"
                , *memory_management_struct.bits_map, memory_management_struct.zones_struct->page_using_count, memory_management_struct.zones_struct->page_free_count);
*/
    for (i = 0; i < 16; i++) {
        // 連續分配16個頁給內存池。
        virtual = (unsigned long*)((memory_management_struct.end_of_struct + PAGE_2M_SIZE * i + PAGE_2M_SIZE - 1) & PAGE_2M_MASK);
        // 上對齊確保分配給變數virtual的必定為新的頁。
        page = Virt_To_2M_Page(virtual); // 根據線性地址virtual轉換成相對於pages_struct的地址。
        *(memory_management_struct.bits_map + ((page->PHY_address >> PAGE_2M_SHIFT) >> 6)) |= 1UL << (page->PHY_address >> PAGE_2M_SHIFT) % 64;
        page->zone_struct->page_using_count++;
        page->zone_struct->page_free_count--;

        // 初始化頁的狀態。
        page_init(page, PG_PTable_Maped | PG_Kernel_Init | PG_Kernel);
        kmalloc_cache_size[i].cache_pool->page = page;
        kmalloc_cache_size[i].cache_pool->Vaddress = virtual;
    }
    /*
    color_printk(ORANGE, BLACK,"3.memory_management_struct.bits_map:%#018lx\tzone_struct->page_using_count:%d\tzone_struct->page_free_count:%d\n",
                 *memory_management_struct.bits_map, memory_management_struct.zones_struct->page_using_count, memory_management_struct.zones_struct->page_free_count);
    color_printk(ORANGE, BLACK,"start_code:%#018lx,end_code:%#018lx,end_data:%#018lx,start_brk:%#018lx,end_of_struct:%#018lx\n"
                , memory_management_struct.start_code, memory_management_struct.end_code, memory_management_struct.end_data
                , memory_management_struct.start_brk, memory_management_struct.end_of_struct);
    */
    return 1;
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