#include "printk.h"
#include "gate.h"
#include "trap.h"
#include "memory.h"
#include "task.h"
#include "cpu.h"
#include "APIC.h"
#include "keyboard.h"
#include "mouse.h"
#include "disk.h"
#include "SMP.h"
#include "spinlock.h"
#include "HPET.h"
#include "timer.h"
#include "softirq.h"
#include "schedule.h"

void Start_Kernel(void)
{
    struct ICR_REG_entry icr_entry = {0};
    unsigned char *ptr = NULL;

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
    set_tss64((unsigned int*)&init_tss[0], _stack_start, _stack_start, _stack_start, 
             0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00,
             0xffff800000007c00, 0xffff800000007c00, 0xffff800000007c00,
             0xffff800000007c00);
    sys_vector_init();

    init_cpu();

    memory_management_struct.start_code = (unsigned long)& _text;
    memory_management_struct.end_code   = (unsigned long)& _etext;
    memory_management_struct.end_data   = (unsigned long)& _edata;
    memory_management_struct.end_rodata = (unsigned long)& _erodata;
    memory_management_struct.start_brk  = (unsigned long)& _end;

    color_printk(RED, BLACK, "memory init \n");
    init_memory();

    color_printk(RED, BLACK,"slab init \n"); 
    slab_init();

    ptr = (unsigned char*)kmalloc(STACK_SIZE, 0) + STACK_SIZE;
    ((struct task_struct*)(ptr - STACK_SIZE))->cpu_id = 0;

    init_tss[0].ist1 = (unsigned long)ptr;
    init_tss[0].ist2 = (unsigned long)ptr;
    init_tss[0].ist3 = (unsigned long)ptr;
    init_tss[0].ist4 = (unsigned long)ptr;
    init_tss[0].ist5 = (unsigned long)ptr;
    init_tss[0].ist6 = (unsigned long)ptr;
    init_tss[0].ist7 = (unsigned long)ptr;

    color_printk(RED, BLACK, "frame buffer init \n");
    frame_buffer_init();

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

    color_printk(RED, BLACK, "disk init \n");
    disk_init();

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
    
    for (global_i = 0; global_i < 0;) {
        spin_lock(&SMP_lock);
        global_i++;
        ptr = (unsigned char*)kmalloc(STACK_SIZE, 0); // AP處理器的stack


        ((struct task_struct *)ptr)->cpu_id = global_i; // 處理器ID
        _stack_start = (unsigned long)ptr + STACK_SIZE;
        memset(&init_tss[global_i], 0, sizeof(struct tss_struct));
        color_printk(RED, BLACK, "CPUid test %d init \n", ((struct task_struct *)(_stack_start-32768))->cpu_id);
        init_tss[global_i].rsp0 = _stack_start;
        init_tss[global_i].rsp1 = _stack_start;
        init_tss[global_i].rsp2 = _stack_start;

        ptr = (unsigned char*)kmalloc(STACK_SIZE, 0) + STACK_SIZE; // AP處理器異常中斷的stack
        ((struct task_struct*)(ptr - STACK_SIZE))->cpu_id = global_i;

        init_tss[global_i].ist1 = (unsigned long)ptr;
        init_tss[global_i].ist2 = (unsigned long)ptr;
        init_tss[global_i].ist3 = (unsigned long)ptr;
        init_tss[global_i].ist4 = (unsigned long)ptr;
        init_tss[global_i].ist5 = (unsigned long)ptr;
        init_tss[global_i].ist6 = (unsigned long)ptr;
        init_tss[global_i].ist7 = (unsigned long)ptr;

        set_tss_descriptor(10 + global_i * 2, &init_tss[global_i]);

        icr_entry.vector = 0x20; // 在Start-up IPI模式下用於指定AP處理器的程式執行地址。
        icr_entry.deliver_mode = ICR_Start_up;
        icr_entry.dest_shorthand = ICR_No_Shorthand; // 當速記值為0時才會從dest_field檢索目標處理器。
        icr_entry.dest_field.x2APIC = global_i;
        wrmsr(0x830, *(unsigned long *)&icr_entry); // Start-up IPI
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

    task_init();
    sti();

    while (1) {
        if(p_kb->count)
            analysis_keycode();
        if(p_mouse->count)
            analysis_mousecode();
    }
}
