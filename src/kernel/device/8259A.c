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


#include "interrupt.h"
#include "lib.h"
#include "printk.h"
#include "memory.h"
#include "gate.h"
#include "8259A.h"

void init_8259A()
{
    int i;
    // 32 - 55對應0x20-0x0x37。
    for (i = 32;i < 56; ++i) {
        set_intr_gate(i, 2, interrupt[i - 32]);
        // i表示是第i號idt描述符，2表示使用tss的ist2，interrupt[i - 32]為處理函式的地址。
    }

    color_printk(RED, BLACK, "8259A init \n");
    //8259A-master	ICW1-4
    io_out8(0x20, 0x11); // 0x11表示啟用ICW4 (BIT4為ICW，BIT0為啟用ICW4)
    io_out8(0x21, 0x20); // 表示中斷向量從0x20開始(BIT0-BIT2必須為0)
    io_out8(0x21, 0x04); // 表示IRQ2聯集從8259A晶片
    io_out8(0x21, 0x01); // 表示AEOI模式會自動復位ISR，不須透過CPU發出EOI指令。

    //8259A-slave	ICW1-4
    io_out8(0xa0, 0x11);
    io_out8(0xa1, 0x28);
    io_out8(0xa1, 0x02); // 表示銜接到IRQ2的引腳
    io_out8(0xa1, 0x01);

    //8259A-M/S	OCW1
    io_out8(0x21,0xfd); // 把IRQ1以外的中段屏蔽
    io_out8(0xa1,0xff);
    sti();
}

void do_IRQ(unsigned long regs, unsigned long nr)	//regs:rsp,nr
{
    unsigned char x;
    color_printk(RED, BLACK, "do_IRQ:%#08x\t", nr);
    x = io_in8(0x60);
    color_printk(RED, BLACK, "key code:%#08x\n", x);
    io_out8(0x20, 0x20);
}
