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

#include "HPET.h"
#include "lib.h"
#include "memory.h"
#include "printk.h"
#include "APIC.h"
#include "time.h"
#include "timer.h"
#include "softirq.h"
#include "task.h"
#include "schedule.h"
#include "SMP.h"

extern struct time time;

hw_int_controller HPET_int_controller = {
    .enable = IOAPIC_enable,
    .disable = IOAPIC_disable,
    .install = IOAPIC_install,
    .uninstall = IOAPIC_uninstall,
    .ack = IOAPIC_edge_ack
};

void HPET_handler(unsigned long nr, unsigned long parameter, struct pt_regs *regs)
{
    struct timer_list *timer = NULL;
    struct INT_CMD_REG icr_entry;
    jiffies++;
/*
    memset(&icr_entry, 0, sizeof(struct INT_CMD_REG));
    icr_entry.vector = 0xc8;
    icr_entry.dest_shorthand = ICR_ALL_EXCLUDE_Self; // 傳遞給所有處理器，但不包含自己。
    icr_entry.trigger = APIC_ICR_IOAPIC_Edge;
    icr_entry.dest_mode = ICR_IOAPIC_DELV_PHYSICAL;
    icr_entry.deliver_mode = APIC_ICR_IOAPIC_Fixed;
    wrmsr(0x830, *(unsigned long *)&icr_entry);
*/
    timer = container_of(list_next(&timer_list_head.list), struct timer_list, list);
    if (timer->expire_jiffies <= jiffies)
        set_softirq_status(TIMER_SIRQ);

    switch (current->priority) {
        case 0:
        case 1:
            task_schedule[SMP_cpu_id()].CPU_exec_task_jiffies--;
            current->vrun_time++;
            break;
        case 2:
        default:
            task_schedule[SMP_cpu_id()].CPU_exec_task_jiffies -= 2;
            current->vrun_time += 2;
            break;
    }
    if (task_schedule[SMP_cpu_id()].CPU_exec_task_jiffies <= 0)
        current->flags |= NEED_SCHEDULE;
}

void HPET_init()
{
    unsigned int x;
    unsigned int *p;
    unsigned char *HPET_addr = (unsigned char*)Phy_To_Virt(0xfed00000); // HPET暫存器組的地址映射從這裡開始。
    struct IO_APIC_RET_entry entry;
    // color_printk(RED, BLACK, "HPET - GCAP_ID:<%#018lx>\n", *(unsigned long *)HPET_addr);
/*    
    get_cmos_time(&time);
    color_printk(RED, BLACK, "year%0x,month:%x,day:%x,hour:%x,mintue:%x,second:%x\n",
                 time.year,time.month,time.day,time.hour,time.minute,time.second);
*/
    //init I/O APIC IRQ2 => HPET Timer 0
    entry.vector = 34;
    entry.deliver_mode = APIC_ICR_IOAPIC_Fixed;
    entry.dest_mode = ICR_IOAPIC_DELV_PHYSICAL;
    entry.deliver_status = APIC_ICR_IOAPIC_Idle;
    entry.polarity = APIC_IOAPIC_POLARITY_HIGH;
    entry.irr = APIC_IOAPIC_IRR_RESET;
    entry.trigger = APIC_ICR_IOAPIC_Edge;
    entry.mask = APIC_ICR_IOAPIC_Masked;
    entry.reserved = 0;
    entry.destination.physical.reserved1 = 0;
    entry.destination.physical.phy_dest = 0;
    entry.destination.physical.reserved2 = 0;
    
    register_irq(34, &entry, &HPET_handler, NULL, &HPET_int_controller, "HPET");

    // get RCBA address
    io_out32(0xcf8, 0x8000f8f0);
    x = io_in32(0xcfc);
    x &= 0xffffc000;

    if (x > 0xfec00000 && x < 0xfee00000) {
        p = (unsigned int *)Phy_To_Virt(x + 0x3404UL); // 3034h是HPTC在晶片組的位移。
        *p = 0x80; // 開啟HPET暫存器的地址映射，低2位用來決定開啟地址映射的範圍。
        io_mfence(); // 內存屏障。
    }
    // bochs虛擬機中HPET愈設開啟註冊RTE暫存器與IDT即可執行，下面這些程式碼都不需要配置。
    // *(unsigned long*)(HPET_addr + 0x10) = 3; // 配置GEN_CONF，啟用中斷並讓8259A或I/O APIC接收來自定時器0與定時器1的中斷請求。
    // io_mfence();

    // edge triggered & periodic   

    *(unsigned long*)(HPET_addr + 0x100) = 0x004c; // 啟用定時器0的中斷並設置為周期性模式。
    io_mfence();

    *(unsigned long*)(HPET_addr + 0x108) = 14318179; // 設定定時器0的定時值14318179而每次定時器調動時間約為69.84ns，因此約1s產生一次中斷。
    io_mfence();

    *(unsigned long*)(HPET_addr + 0xf0) = 0; // 設定主計數器的值為0。
    io_mfence();
}