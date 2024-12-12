#ifndef __MEMORY_H__
#define __MEMORY_H__

#include "lib.h"

// 在64位元架構下一個頁表項佔8byte，因此一個頁表有4KB / 8byte = 512項
#define PTRS_PER_PAGE	512

#define	TASK_SIZE   ((unsigned long)0x00007fffffffffff)
#define PAGE_OFFSET	((unsigned long)0xffff800000000000) // kernel的起始線性地址，這是經過映射的結果對應物理地址的0。

/* 虛擬的地址只有使用48位元，高的16位是保留位。假使設定一個頁的大喜為4KB。最低的12位元就是offset。
 * 剩餘36位元將分成4等分，分別配給4級頁表，每個頁表有9位元，下面的巨集就是在說明這個關係。
 */
#define PAGE_GDT_SHIFT  39
#define PAGE_1G_SHIFT   30  // 第2級頁表一個項是2^30 = 1GB
#define PAGE_2M_SHIFT   21  // 第3級頁表一個項是2^21 = 2MB
#define PAGE_4K_SHIFT   12  // 第4級頁表一個項是2^12 = 4KB

#define PAGE_2M_SIZE    (1UL << PAGE_2M_SHIFT)
#define PAGE_4K_SIZE    (1UL << PAGE_4K_SHIFT)

#define PAGE_2M_MASK    (~ (PAGE_2M_SIZE - 1)) //忽略小於2MB的數字
#define PAGE_4K_MASK    (~ (PAGE_4K_SIZE - 1)) //忽略小於4KB的數字

#define PAGE_2M_ALIGN(addr) (((unsigned long)(addr) + PAGE_2M_SIZE - 1) & PAGE_2M_MASK) // 讓地址對齊2MB邊界
#define PAGE_4K_ALIGN(addr) (((unsigned long)(addr) + PAGE_4K_SIZE - 1) & PAGE_4K_MASK) // 讓地址對齊4KB邊界

// 下面兩個函式用於虛擬地址與物理地址之間的映射，但是這個映射關係只有前48MB(定義在head.S中)。
#define Virt_To_Phy(addr)   ((unsigned long)(addr) - PAGE_OFFSET)
#define Phy_To_Virt(addr)   ((unsigned long *)((unsigned long)(addr) + PAGE_OFFSET))

#define Virt_To_2M_Page(kaddr)  (memory_management_struct.pages_struct + (Virt_To_Phy(kaddr) >> PAGE_2M_SHIFT))
#define Phy_to_2M_Page(kaddr)   (memory_management_struct.pages_struct + ((unsigned long)(kaddr) >> PAGE_2M_SHIFT))

////page table attribute

//  bit 63  Execution Disable:
#define PAGE_XD     (1UL << 63)
//  bit 12  Page Attribute Table
#define	PAGE_PAT    (1UL << 12)
//  bit 8   Global Page:1,global;0,part
#define	PAGE_Global (1UL << 8)
//  bit 7   Page Size:1,big page;0,small page;
#define	PAGE_PS	    (1UL << 7)
//  bit 6   Dirty:1,dirty;0,clean;
#define	PAGE_Dirty  (1UL << 6)
//  bit 5   Accessed:1,visited;0,unvisited;
#define	PAGE_Accessed   (1UL << 5)
//  bit 4   Page Level Cache Disable
#define PAGE_PCD    (1UL << 4)
//  bit 3   Page Level Write Through
#define PAGE_PWT    (1UL << 3)
//  bit 2   User Supervisor:1,user and supervisor;0,supervisor;
#define	PAGE_U_S    (1UL << 2)
//  bit 1   Read Write:1,read and write;0,read;
#define	PAGE_R_W    (1UL << 1)
//  bit 0   Present:1,present;0,no present;
#define	PAGE_Present    (1UL << 0)
//1,0
#define PAGE_KERNEL_GDT     (PAGE_R_W | PAGE_Present)
//1,0
#define PAGE_KERNEL_Dir     (PAGE_R_W | PAGE_Present)
//7,1,0
#define PAGE_KERNEL_Page    (PAGE_PS  | PAGE_R_W | PAGE_Present)
//1,0
#define PAGE_USER_GDT       (PAGE_U_S | PAGE_R_W | PAGE_Present)
//2,1,0
#define PAGE_USER_Dir       (PAGE_U_S | PAGE_R_W | PAGE_Present)
//7,2,1,0
#define	PAGE_USER_Page      (PAGE_PS  | PAGE_U_S | PAGE_R_W | PAGE_Present)

typedef struct {unsigned long pml4t;} pml4t_t;
#define	mk_mpl4t(addr, attr) ((unsigned long)(addr) | (unsigned long)(attr))
#define set_mpl4t(mpl4tptr, mpl4tval)(*(mpl4tptr) = (mpl4tval))

typedef struct {unsigned long pdpt;} pdpt_t;
#define mk_pdpt(addr, attr)  ((unsigned long)(addr) | (unsigned long)(attr))
#define set_pdpt(pdptptr, pdptval)   (*(pdptptr) = (pdptval))


typedef struct {unsigned long pdt;} pdt_t;
#define mk_pdt(addr,attr)   ((unsigned long)(addr) | (unsigned long)(attr))
#define set_pdt(pdtptr, pdtval)      (*(pdtptr) = (pdtval))


typedef struct {unsigned long pt;} pt_t;
#define mk_pt(addr, attr)    ((unsigned long)(addr) | (unsigned long)(attr))
#define set_pt(ptptr, ptval)     (*(ptptr) = (ptval))

// 這個數據是在BIOS模式下使用BIOS中斷int 15 AX=E820取得的記憶體資料
struct E820 {
    unsigned long address;    
    unsigned long length;
    unsigned int type;
}__attribute__((packed));

// 這是因為結構體以8 byte為單位對齊，所以要增加屬性packed，保證結構體是緊湊的。
#define E820_MAX_ENTRY  32
#define RAM_TYPE        1
struct Global_Memory_Descriptor{
    struct E820     e820[E820_MAX_ENTRY];
    unsigned long   e820_length;
    unsigned long   *bits_map; // 物理地址空間頁映射位圖
    unsigned long   bits_size; // 物理地址空間的頁數量
    unsigned long   bits_length; // 物理地址空間頁映射位圖長度

    struct Page     *pages_struct;
    unsigned long   pages_size;
    unsigned long   pages_length;

    struct Zone     *zones_struct;
    unsigned long   zones_size;
    unsigned long   zones_length;

    unsigned long   start_code, end_code, end_data, end_rodata, start_brk;
    unsigned long   end_of_struct;
};

//alloc_pages zone_select

#define ZONE_DMA    (1 << 0)
#define ZONE_NORMAL (1 << 1)
#define ZONE_UNMAPED    (1 << 2)

//struct page attribute (alloc_pages flags)
//	mapped=1 or un-mapped=0 
#define PG_PTable_Maped (1 << 0)

//	init-code=1 or normal-code/data=0
#define PG_Kernel_Init  (1 << 1)

//	device=1 or memory=0
#define PG_Device   (1 << 2)

//	kernel=1 or user=0
#define PG_Kernel   (1 << 3)

//	shared=1 or single-use=0 
#define PG_Shared   (1 << 4)

struct Page {
    struct Zone     *zone_struct;   // 本頁所屬區域結構體
    unsigned long   PHY_address;    // 頁的物理地址
    unsigned long   attribute;      // 頁的屬性
    unsigned long   reference_count;// 該頁的引用次數
    unsigned long   age;            // 該頁的建立時間
};

//// each zone index

int ZONE_DMA_INDEX  = 0;
int ZONE_NORMAL_INDEX   = 0;    //low 1GB RAM ,was mapped in pagetable
int ZONE_UNMAPED_INDEX  = 0;    //above 1GB RAM,unmapped in pagetable

#define MAX_NR_ZONES    10  //max zone

struct Zone {
    struct Page     *pages_group; // 結構體數組指針
    unsigned long   pages_length; // page數量
    unsigned long   zone_start_address; // 本區域的起始頁對齊地址
    unsigned long   zone_end_address; // 本區域的結束頁對齊地址
    unsigned long   zone_length; // 頁對齊後的地址長度
    unsigned long   attribute;  // 本區域的屬性

    struct Global_Memory_Descriptor *GMD_struct; // 指向全局結構體

    unsigned long   page_using_count; // 已使用的物理內存頁數量
    unsigned long   page_free_count; // 空閒的物理內存頁數量
    unsigned long   total_pages_link; // 本區域物理頁被引用的次數

};

extern struct Global_Memory_Descriptor memory_management_struct;

struct Slab {
    struct List list;
    struct Page *page;
    unsigned long using_count;
    unsigned long free_count;
    void *Vaddress;
    unsigned long color_length;
    unsigned long color_count;
    unsigned long *color_map;
};

struct Slab_cache {
    unsigned long size;
    unsigned long total_using;
    unsigned long total_free;
    struct Slab *cache_pool;
    struct Slab *cache_dma_pool;
    void *(*constructor)(void *Vaddress, unsigned long arg);
    void *(*destructor)(void *Vaddress, unsigned long arg);
};

extern struct Slab_cache kmalloc_cache_size[16];

#define SIZEOF_LONG_ALIGN(size) ((size + sizeof(long) - 1) & ~(sizeof(long) - 1))
#define SIZEOF_INT_ALIGN(size) ((size + sizeof(int) - 1) & ~(sizeof(int) - 1))

#define	flush_tlb_one(addr) \
    __asm__ __volatile__    ("invlpg    (%0)    \n\t"::"r"(addr):"memory")
// 無效化指定地址的 TLB

#define flush_tlb()                         \
do {                                        \
    unsigned long	tmpreg;                 \
    __asm__ __volatile__    (               \
                "movq   %%cr3,  %0  \n\t"   \
                "movq   %0, %%cr3   \n\t"   \
                :"=r"(tmpreg)               \
                :                           \
                :"memory"                   \
                );                          \
}while(0)
// 每次修改 cr3 將強制刷新 TLB

static inline unsigned long *Get_gdt()
{
    unsigned long * tmp;
    __asm__ __volatile__    (
                    "movq   %%cr3,	%0	\n\t"
                    :"=r"(tmp)
                    :
                    :"memory"
                );
    // 把cr3的值放入操作數0也就是tmp中。
    return tmp;
}


unsigned long page_init(struct Page *page,unsigned long flags);
unsigned long page_clean(struct Page *page);

unsigned long get_page_attribute(struct Page *page);
unsigned long set_page_attribute(struct Page *page, unsigned long flags);

void init_memory();

struct Page *alloc_pages(int zone_select,int number,unsigned long page_flags);
void free_pages(struct Page * page,int number);

void *kmalloc(unsigned long size,unsigned long flags);
unsigned long kfree(void *address);

struct Slab *kmalloc_create(unsigned long size);

struct Slab_cache *slab_create(unsigned long size, void *(*constructor)(void *Vaddress,unsigned long arg), void *(*destructor)(void *Vaddress, unsigned long arg), unsigned long arg);
unsigned long slab_destroy(struct Slab_cache *slab_cache);

void *slab_malloc(struct Slab_cache *slab_cache, unsigned long arg);

unsigned long slab_free(struct Slab_cache *slab_cache,void *address, unsigned long arg);
unsigned long slab_init();
void pagetable_init();
unsigned long do_brk(unsigned long addr, unsigned long len);

#endif
