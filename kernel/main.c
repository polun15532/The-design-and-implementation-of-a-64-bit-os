#include "lib.h"
#include "printk.h"
#include "gate.h"
#include "trap.h"
#include "memory.h"
#include "task.h"
#include "cpu.h"
#include "APIC.h"
#include "spinlock.h"
#include "HPET.h"
#include "timer.h"
#include "softirq.h"
#include "keyboard.h"
#include "mouse.h"
#include "disk.h"
#include "SMP.h"
#include "schedule.h"

struct Global_Memory_Descriptor memory_management_struct = {{0},0};

int golbal_i = 0;

extern struct block_device_operation IDE_device_operation;
extern spinlock_t SMP_lock;

void Start_Kernel(void)
{

    unsigned int *tss = NULL;
    struct ICR_REG_entry icr_entry = {0};

    Pos.XResolution = 1440;
    Pos.YResolution = 900;
    Pos.XPosition = 0;
    Pos.YPosition = 0;
    Pos.XCharSize = 8;	// 字符寬為8像素點
    Pos.YCharSize = 16; // 字符寬為16像素點

    Pos.FB_addr = (int *)0xffff800003000000; // frame buffer的地址
    Pos.FB_length = (Pos.XResolution * Pos.YResolution * 4 + PAGE_4K_SIZE - 1) & PAGE_4K_MASK; //每個像素點需要32位元表示

    spin_init(&Pos.printk_lock);
    load_TR(10);
    set_tss64(TSS64_Table, _stack_start, _stack_start, _stack_start, 
             0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00,
             0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00,
             0xffff800000007c00);
    sys_vector_init();

    init_cpu();

    memory_management_struct.start_code = (unsigned long)&_text;
    memory_management_struct.end_code   = (unsigned long)&_etext;
    memory_management_struct.end_data   = (unsigned long)&_edata;
    memory_management_struct.end_brk    = (unsigned long)&_end;

    color_printk(RED, BLACK, "memory init \n");
    init_memory();

    color_printk(RED, BLACK,"slab init \n"); 
    slab_init();

    color_printk(RED, BLACK, "frame buffer init \n");
    frame_buffer_init();
    // color_printk(WHITE, BLACK,"frame_buffer_init() is OK \n");

    color_printk(RED, BLACK, "pagetable init \n");	
    pagetable_init();

    color_printk(RED, BLACK, "interrupt init \n");
    APIC_IOAPIC_init();

    color_printk(RED, BLACK,"schedule init \n");
    schedule_init();  
    
    color_printk(RED, BLACK,"Soft IRQ init \n");
    softirq_init();

    color_printk(RED, BLACK, "keyboard init \n");
    keyboard_init();
    
    color_printk(RED, BLACK, "mouse init \n");
    mouse_init();

    SMP_init();

    icr_entry.vector = 0;
    icr_entry.deliver_mode = APIC_ICR_IOAPIC_INIT;
    icr_entry.dest_mode = ICR_IOAPIC_DELV_PHYSICAL;
    icr_entry.deliver_state = 0;
    icr_entry.reserved1 = 0;
    icr_entry.level = ICR_LEVEL_DE_ASSERT; // 這裡切換成de-assert的INIT投遞模式
    icr_entry.trigger = APIC_ICR_IOAPIC_Edge;
    icr_entry.reserved2 = 0;
    icr_entry.dest_shorthand = ICR_ALL_EXCLUDE_Self;
    icr_entry.reserved3 = 0;
    icr_entry.dest_field.x2APIC = 0;
    wrmsr(0x830, *(unsigned long *)&icr_entry);	//INIT IPI
    // 0x830為ICR暫存器的MSR地址。

    for (golbal_i = 0; golbal_i < 3;) {
        spin_lock(&SMP_lock);
        golbal_i++;
        _stack_start = (unsigned long)kmalloc(STACK_SIZE, 0) + STACK_SIZE; // 為每個AP配給32KB的stack空間
        tss = kmalloc(128, 0);
        set_tss_descriptor(10 + golbal_i * 2, tss);
        set_tss64(tss, _stack_start, _stack_start, _stack_start, _stack_start,
            _stack_start, _stack_start, _stack_start, _stack_start, _stack_start,
            _stack_start);
        icr_entry.vector = 0x20; // 在Start-up IPI模式下用於指定AP處理器的程式執行地址。
        icr_entry.deliver_mode = ICR_Start_up;
        icr_entry.dest_shorthand = ICR_No_Shorthand; // 當速記值為0時才會從dest_field檢索目標處理器。
        icr_entry.dest_field.x2APIC = golbal_i;
        wrmsr(0x830, *(unsigned long *)&icr_entry);
        wrmsr(0x830, *(unsigned long *)&icr_entry);
    }

    icr_entry.vector = 0xc8; // 定義中斷向量號。
    icr_entry.dest_field.x2APIC = 1; // 設定目標處理器為1。
    icr_entry.deliver_mode = APIC_ICR_IOAPIC_Fixed;
    wrmsr(0x830, *(unsigned long *)&icr_entry);
    icr_entry.vector = 0xc9;
    wrmsr(0x830, *(unsigned long *)&icr_entry);

    color_printk(RED, BLACK,"Timer init \n");
    timer_init();

    color_printk(RED, BLACK,"HPET init \n");
    HPET_init();

    color_printk(RED, BLACK,"task init \n");
    sti();

    task_init();
    
    while (1) {
        
        if(p_kb->count)
            analysis_keycode();
        if(p_mouse->count)
            analysis_mousecode();
        
    }
}
