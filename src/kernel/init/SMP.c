#include "SMP.h"
#include "cpu.h"
#include "printk.h"
#include "lib.h"
#include "gate.h"
#include "interrupt.h"
#include "task.h"
#include "schedule.h"
#include "spinlock.h"

int global_i = 0;
spinlock_t SMP_lock;

void IPI_0x200(unsigned long nr, unsigned long parameter, struct pt_regs *regs)
{
    struct task_struct *current_tsk = current;
    int cpu_id = current_tsk->cpu_id;
    switch(current_tsk->priority) {
        case 0:
        case 1:
            task_schedule[cpu_id].CPU_exec_task_jiffies--;
            current_tsk->vrun_time++;
            break;
        case 2:
        default:
            task_schedule[cpu_id].CPU_exec_task_jiffies -= 2;
            current_tsk->vrun_time += 2;
            break;
    }

    if (task_schedule[cpu_id].CPU_exec_task_jiffies <= 0) current_tsk->flags |= NEED_SCHEDULE;
}

void SMP_init()
{
    int i;
    unsigned int a, b, c, d;
    for (i = 0; ; i++) {
        get_cpuid(0xb, i, &a, &b, &c, &d);
        if ((c >> 8 & 0xff) == 0)
            break;
        color_printk(WHITE, BLACK, "local APIC ID Package_../Core_2/SMT_1,type(%x) Width:%#010x,num of logical processor(%x)\n", c >> 8 & 0xff, a & 0x1f, b & 0xff);
    }
    color_printk(WHITE, BLACK, "x2APIC ID level:%#010x\tx2APIC ID the current logical processor:%#010x\n", c & 0xff, d);
    color_printk(WHITE, BLACK, "SMP copy byte:%#010x\n", (unsigned long)&_APU_boot_end - (unsigned long)&_APU_boot_start);
    
    memcpy(_APU_boot_start, (unsigned char *)0xffff800000020000, (unsigned long)&_APU_boot_end - (unsigned long)&_APU_boot_start);
    spin_init(&SMP_lock);

    for (i = 200; i < 210; i++) {
        set_intr_gate(i, 2, SMP_interrupt[i - 200]);
    }
    memset(SMP_IPI_desc, 0, sizeof(irq_desc_t) * 10);
    register_IPI(200, NULL, &IPI_0x200, NULL, NULL, "IPI_0x200");
}

void Start_SMP()
{

    unsigned int x, y;
    color_printk(RED, YELLOW, "APU starting......\n");

    // 以下程式碼來自APIC.c的Local_APIC_init初使化函式。

    __asm__ __volatile__( "movq $0x1b, %%rcx \n\t"
                        "rdmsr             \n\t"
                        "bts $10,   %%rax  \n\t"
                        "bts $11,   %%rax  \n\t"
                        "wrmsr             \n\t"
                        "mov $0x1b, %%rcx  \n\t"
                        "rdmsr             \n\t"
                        :"=a"(x), "=d"(y)
                        :
                        :"memory");

    if (x & 0xc00) color_printk(WHITE, BLACK, "xAPIC & x2APIC enabled\n");

    __asm__ __volatile__( "movq $0x80f, %%rcx \n\t"
                          "rdmsr              \n\t"
                          "bts  $8,  %%rax    \n\t"
                          "wrmsr              \n\t"
                          "mov $0x80f, %%rcx  \n\t"
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");
    if(x & 0x100) color_printk(WHITE, BLACK, "SVR[8] enabled\n");
    // get local APIC ID
    __asm__ __volatile__( "movq $0x802, %%rcx \n\t"
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");

    color_printk(RED, YELLOW, "x2APIC ID:%#010x\n", x);

    
    struct task_struct *current_tsk = current;
    *current_tsk = (struct task_struct) {
        .state = TASK_RUNNING,
        .flags = PF_KTHREAD,
        .mm = &init_mm,
        .addr_limit = 0xffff800000000000,
        .priority = 2,
        .vrun_time = 0,
        .thread = (struct thread_struct*)(current + 1)
    };

    list_init(&current_tsk->list);

    *current_tsk->thread = (struct thread_struct) {
        .rsp0 = _stack_start,
        .rsp = _stack_start,
        .fs = KERNEL_DS,
        .gs = KERNEL_DS,
    };

    init_task[current_tsk->cpu_id] = current_tsk;

    load_TR(10 + global_i * 2);

    spin_unlock(&SMP_lock);

    current_tsk->preempt_count = 0;  // 歸零

    while (1) hlt();
}