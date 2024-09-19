#include "trap.h"
#include "gate.h"
#include "task.h"
#include "SMP.h"
#include "lib.h"

void sys_vector_init()
{
    set_trap_gate(0, 1, divide_error);
    set_trap_gate(1, 1, debug);
    set_intr_gate(2, 1, nmi);
    set_system_gate(3, 1, int3);
    set_system_gate(4, 1, overflow);
    set_system_gate(5, 1, bounds);
    set_trap_gate(6, 1, undefined_opcode);
    set_trap_gate(7, 1, dev_not_available);
    set_trap_gate(8, 1, double_fault);
    set_trap_gate(9, 1, coprocessor_segment_overrun);
    set_trap_gate(10, 1, invalid_TSS);
    set_trap_gate(11, 1, segment_not_present);
    set_trap_gate(12, 1, stack_segment_fault);
    set_trap_gate(13, 1, general_protection);
    set_trap_gate(14, 1, page_fault);
    //15 Intel reserved. Do not use.
    set_trap_gate(16, 1, x87_FPU_error);
    set_trap_gate(17, 1, alignment_check);
    set_trap_gate(18, 1, machine_check);
    set_trap_gate(19, 1, SIMD_exception);
    set_trap_gate(20, 1, virtualization_exception);

    //set_system_gate(SYSTEM_CALL_VECTOR,7,system_call);
}

void do_divide_error(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_divide_error(0),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_debug(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_debug(1),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_nmi(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_nmi(2),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}


void do_int3(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_int3(3),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_overflow(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_overflow(4),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_bounds(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_bounds(5),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_undefined_opcode(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_undefined_opcode(6),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_dev_not_available(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_dev_not_available(7),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_double_fault(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_double_fault(8),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_coprocessor_segment_overrun(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_coprocessor_segment_overrun(9),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_invalid_TSS(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_invalid_TSS(10),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());

    if (error_code& 0x01)
        color_printk(RED, BLACK, "The exception occurred during delivery of an event external to the program,such as an interrupt or an earlier exception.\n"); //檢查BIT0查看錯誤是否在外部事件或是更早的異常中觸發。

    if (error_code& 0x02)
        color_printk(RED, BLACK, "Refers to a gate descriptor in the IDT;\n"); // 是否為IDT
    else
        color_printk(RED, BLACK, "Refers to a descriptor in the GDT or the current LDT;\n");

    if ((error_code& 0x02) == 0)
        if (error_code& 0x04) // 檢查是否為LDT
            color_printk(RED, BLACK, "Refers to a segment or gate descriptor in the LDT;\n");
        else
            color_printk(RED, BLACK, "Refers to a descriptor in the current GDT;\n");

    color_printk(RED, BLACK, "Segment Selector Index:%#010x\n", error_code& 0xfff8);

    while(1)
        hlt();
}

void do_segment_not_present(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_segment_not_present(11),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());

    if (error_code& 0x01)
        color_printk(RED, BLACK, "The exception occurred during delivery of an event external to the program,such as an interrupt or an earlier exception.\n");

    if (error_code& 0x02)
        color_printk(RED, BLACK, "Refers to a gate descriptor in the IDT;\n");
    else
        color_printk(RED, BLACK, "Refers to a descriptor in the GDT or the current LDT;\n");

    if ((error_code& 0x02) == 0)
        if (error_code& 0x04)
            color_printk(RED, BLACK, "Refers to a segment or gate descriptor in the LDT;\n");
        else
            color_printk(RED, BLACK, "Refers to a descriptor in the current GDT;\n");

    color_printk(RED, BLACK, "Segment Selector Index:%#010x\n", error_code& 0xfff8);

    while(1)
        hlt();
}

void do_stack_segment_fault(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_stack_segment_fault(12),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());

    if (error_code& 0x01)
        color_printk(RED, BLACK, "The exception occurred during delivery of an event external to the program,such as an interrupt or an earlier exception.\n");

    if (error_code& 0x02)
        color_printk(RED, BLACK, "Refers to a gate descriptor in the IDT;\n");
    else
        color_printk(RED, BLACK, "Refers to a descriptor in the GDT or the current LDT;\n");

    if ((error_code& 0x02) == 0)
        if (error_code& 0x04)
            color_printk(RED, BLACK, "Refers to a segment or gate descriptor in the LDT;\n");
        else
            color_printk(RED, BLACK, "Refers to a descriptor in the current GDT;\n");

    color_printk(RED, BLACK, "Segment Selector Index:%#010x\n", error_code& 0xfff8);

    while(1)
        hlt();
}

void do_general_protection(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_general_protection(13),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());

    if (error_code& 0x01)
        color_printk(RED, BLACK, "The exception occurred during delivery of an event external to the program,such as an interrupt or an earlier exception.\n");

    if (error_code& 0x02)
        color_printk(RED, BLACK, "Refers to a gate descriptor in the IDT;\n");
    else
        color_printk(RED, BLACK, "Refers to a descriptor in the GDT or the current LDT;\n");

    if ((error_code& 0x02) == 0)
        if (error_code& 0x04)
            color_printk(RED, BLACK, "Refers to a segment or gate descriptor in the LDT;\n");
        else
            color_printk(RED, BLACK, "Refers to a descriptor in the current GDT;\n");

    color_printk(RED, BLACK, "Segment Selector Index:%#010x\n", error_code& 0xfff8);

    while(1)
        hlt();
}

void do_page_fault(struct pt_regs *regs, unsigned long error_code)
{
    unsigned long cr2 = 0;
    __asm__	__volatile__("movq	%%cr2,	%0":"=r"(cr2)::"memory"); // 將cr2暫存器的值放入變數cr2中

    color_printk(RED, BLACK, "do_page_fault(14),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());

    if (!(error_code& 0x01))
        color_printk(RED, BLACK, "Page Not-Present,\t"); // 這個頁是否存在。

    if (error_code& 0x02)
        color_printk(RED, BLACK, "Write Cause Fault,\t"); // 寫入時觸發
    else
        color_printk(RED, BLACK, "Read Cause Fault,\t"); // 讀取時觸發

    if (error_code& 0x04)
        color_printk(RED, BLACK, "Fault in user(3)\t");
    else
        color_printk(RED, BLACK, "Fault in supervisor(0,1,2)\t");

    if (error_code& 0x08)
        color_printk(RED, BLACK, ",Reserved Bit Cause Fault\t"); // 頁表項的保留位引發異常

    if (error_code& 0x10)
        color_printk(RED, BLACK, ",Instruction fetch Cause Fault"); // 取得指令時是否觸發異常

    color_printk(RED, BLACK, "\n");
    color_printk(RED, BLACK, "CR2:%#018lx\n", cr2);

    while(1)
        hlt();
}

void do_x87_FPU_error(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_x87_FPU_error(16),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_alignment_check(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_alignment_check(17),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_machine_check(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_machine_check(18),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_SIMD_exception(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_SIMD_exception(19),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}

void do_virtualization_exception(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_virtualization_exception(20),ERROR_CODE:%#018lx,RSP:%#018lx,RIP:%#018lx,CPU:%#018lx\n", error_code, regs->rsp, regs->rip, SMP_cpu_id());
    while(1)
        hlt();
}