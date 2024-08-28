#include "lib.h"
#include "printk.h"
#include "gate.h"
#include "trap.h"
#include "memory.h"
#include "task.h"
#include "interrupt.h"

#if APIC
#include "APIC.h"
#else
#include "8259A.h"
#endif

extern char _text;
extern char _etext;
extern char _edata;
extern char _end;

struct Global_Memory_Descriptor memory_management_struct = {{0},0};

void Start_Kernel(void)
{
    int *addr = (int *)0xffff800003000000;
    int i;

    struct Page *page = NULL;
    void *tmp = NULL;
    struct Slab *slab = NULL;

    Pos.XResolution = 1440;
    Pos.YResolution = 900;

    Pos.XPosition = 0;
    Pos.YPosition = 0;

    Pos.XCharSize = 8;	// 字符寬為8像素點
    Pos.YCharSize = 16; // 字符寬為16像素點

    Pos.FB_addr = (int *)0xffff800003000000; // frame buffer的地址
    Pos.FB_length = (Pos.XResolution * Pos.YResolution * 4 + PAGE_4K_SIZE - 1) & PAGE_4K_MASK; //每個像素點需要32位元表示

    load_TR(10);
    set_tss64(0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00);
    sys_vector_init();

    init_cpu();

    memory_management_struct.start_code = (unsigned long)&_text;
    memory_management_struct.end_code   = (unsigned long)&_etext;
    memory_management_struct.end_data   = (unsigned long)&_edata;
    memory_management_struct.end_brk    = (unsigned long)&_end;

    color_printk(RED,BLACK, "memory init \n");
    init_memory();

    color_printk(RED,BLACK,"slab init \n"); 
    slab_init();

    color_printk(RED, BLACK, "frame buffer init \n");
    frame_buffer_init();
    color_printk(WHITE, BLACK,"frame_buffer_init() is OK \n");

    color_printk(RED, BLACK, "pagetable init \n");	
    pagetable_init();

    color_printk(RED,BLACK, "interrupt init \n");

    #if APIC
        APIC_IOAPIC_init();
    #else
        init_8259A();
    #endif

    //color_printk(RED,BLACK,"task_init \n");
    //task_init();

    while(1);
}
