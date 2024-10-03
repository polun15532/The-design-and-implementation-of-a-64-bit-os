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

#include "trap.h"
#include "gate.h"
#include "task.h"
#include "SMP.h"
#include "lib.h"
#include "printk.h"

int lookup_kallsyms(unsigned long address, int level)
{
    int index = 0;
    int level_index = 0;
    char *string = (char*) &kallsyms_names;
    for (index = 0; index < kallsyms_syms_num; index++) {
        if(address > kallsyms_addresses[index] && address <= kallsyms_addresses[index + 1])
            break;  
    }

    if (index < kallsyms_syms_num) {
        for(level_index = 0; level_index < level; level_index++)
            color_printk(RED, BLACK, "  ");
        color_printk(RED, BLACK, "+---> ");

        color_printk(RED,
                     BLACK,
                     "address:%#018lx \t(+) %04d function:%s\n",
                     address,
                     address - kallsyms_addresses[index],
                     &string[kallsyms_index[index]]);
        return 0;
    }
    return 1;    
}


void backtrace(struct pt_regs *regs)
{
    unsigned long *rbp = (unsigned long*)regs->rbp;
    unsigned long ret_address = regs->rip;
    int i = 0;
    color_printk(RED, BLACK, "====================== Kernel Stack Backtrace ======================\n");

    for (i = 0; i < 10; i++) {
        if (lookup_kallsyms(ret_address, i))
            break;

        if((unsigned long)rbp < regs->rsp || (unsigned long)rbp > current->thread->rsp0)
            break;
        ret_address = *(rbp+1);
        rbp = (unsigned long*)*rbp;
    }
}

void display_regs(struct pt_regs *regs)
{
    // 打印各暫存器的信息。

    color_printk(RED,
                 BLACK,
                 "CS:%#010x,SS:%#010x\nDS:%#010x,ES:%#010x\nRFLAGS:%#018lx\n",
                 regs->cs,
                 regs->ss,
                 regs->ds,
                 regs->es,
                 regs->rflags);

    color_printk(RED,
                 BLACK,
                 "RAX:%#018lx,RBX:%#018lx,RCX:%#018lx,RDX:%#018lx\nRSP:%#018lx,RBP:%#018lx,RIP:%#018lx\nRSI:%#018lx,RDI:%#018lx\n",
                 regs->rax,
                 regs->rbx,
                 regs->rcx,
                 regs->rdx,
                 regs->rsp,
                 regs->rbp,
                 regs->rip,
                 regs->rsi,
                 regs->rdi);

    color_printk(RED,
                 BLACK,
                 "R8 :%#018lx,R9 :%#018lx\nR10:%#018lx,R11:%#018lx\nR12:%#018lx,R13:%#018lx\nR14:%#018lx,R15:%#018lx\n",
                 regs->r8,
                 regs->r9,
                 regs->r10,
                 regs->r11,
                 regs->r12,
                 regs->r13,
                 regs->r14,
                 regs->r15);

    backtrace(regs);
}


void do_divide_error(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_divide_error(0),ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_debug(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_debug(1), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_nmi(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_nmi(2), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}


void do_int3(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_int3(3), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_overflow(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_overflow(4), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_bounds(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_bounds(5), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_undefined_opcode(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_undefined_opcode(6), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_dev_not_available(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_dev_not_available(7), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_double_fault(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_double_fault(8), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_coprocessor_segment_overrun(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_coprocessor_segment_overrun(9), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    display_regs(regs);
    while (1)
        hlt();
}

void do_invalid_TSS(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_invalid_TSS(10), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());

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

    display_regs(regs);
    while (1)
        hlt();
}

void do_segment_not_present(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_segment_not_present(11), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());

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

    display_regs(regs);
    while (1)
        hlt();
}

void do_stack_segment_fault(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_stack_segment_fault(12), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());

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

    display_regs(regs);
    while (1)
        hlt();
}

void do_general_protection(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_general_protection(13), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());

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

    display_regs(regs);
    while (1)
        hlt();
}

void do_page_fault(struct pt_regs *regs, unsigned long error_code)
{

    unsigned long cr2 = 0;
    __asm__	__volatile__("movq	%%cr2,	%0":"=r"(cr2)::"memory"); // 將cr2暫存器的值放入變數cr2中

    color_printk(RED, BLACK, "do_page_fault(14), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());

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

    color_printk(RED, BLACK, "\nCR2:%#018lx\n", cr2);

    display_regs(regs);
    while (1)
        hlt();
}

void do_x87_FPU_error(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_x87_FPU_error(16), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    
    display_regs(regs);
    while (1)
        hlt();
}

void do_alignment_check(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_alignment_check(17), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    
    display_regs(regs);
    while (1)
        hlt();
}

void do_machine_check(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_machine_check(18), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    while (1)
        hlt();
}

void do_SIMD_exception(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_SIMD_exception(19), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    
    display_regs(regs);
    while (1)
        hlt();
}

void do_virtualization_exception(struct pt_regs *regs, unsigned long error_code)
{
    color_printk(RED, BLACK, "do_virtualization_exception(20), ERROR_CODE:%#018lx,CPU:%#018lx\n", error_code, SMP_cpu_id());
    
    display_regs(regs);
    while (1)
        hlt();
}

void sys_vector_init()
{
    set_trap_gate(0, 0, divide_error);
    set_trap_gate(1, 0, debug);
    set_intr_gate(2, 0, nmi);
    set_system_gate(3, 0, int3);
    set_system_gate(4, 0, overflow);
    set_system_gate(5, 0, bounds);
    set_trap_gate(6, 0, undefined_opcode);
    set_trap_gate(7, 0, dev_not_available);
    set_trap_gate(8, 0, double_fault);
    set_trap_gate(9, 0, coprocessor_segment_overrun);
    set_trap_gate(10, 0, invalid_TSS);
    set_trap_gate(11, 0, segment_not_present);
    set_trap_gate(12, 0, stack_segment_fault);
    set_trap_gate(13, 0, general_protection);
    set_trap_gate(14, 0, page_fault);
    //15 Intel reserved. Do not use.
    set_trap_gate(16, 0, x87_FPU_error);
    set_trap_gate(17, 0, alignment_check);
    set_trap_gate(18, 0, machine_check);
    set_trap_gate(19, 0, SIMD_exception);
    set_trap_gate(20, 0, virtualization_exception);
}