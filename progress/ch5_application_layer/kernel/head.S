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
#include "linkage.h"

.section .text

ENTRY(_start)

    mov	$0x10,  %ax
    mov	%ax,    %ds
    mov	%ax,    %es
    mov	%ax,    %fs
    mov	%ax,    %ss
    mov	$0x7E00,    %esp

//=======   load GDTR

    lgdt    GDT_POINTER(%rip)	// RIP-Relative尋址 操作數如果是32為原則可以在rip為中心找±2GB

//=======   load    IDTR

    lidt    IDT_POINTER(%rip)

    mov	$0x10,  %ax
    mov	%ax,    %ds
    mov	%ax,    %es
    mov	%ax,    %fs
    mov	%ax,    %gs
    mov	%ax,%ss

    movq    $0x7E00,    %rsp

//=======   load    cr3

    movq    $0x101000,  %rax
    movq    %rax,       %cr3
    movq    switch_seg(%rip),   %rax
    pushq   $0x08
    pushq   %rax
    lretq   // GAS編譯器不支援ljmp/lcall所以用lretq (使用lretq必須自己手動push cs與rip到stack)

//=======   64-bit mode code

switch_seg:
    .quad   entry64

entry64:
    movq    $0x10,  %rax
    movq    %rax,   %ds
    movq    %rax,   %es
    movq    %rax,   %gs
    movq    %rax,   %ss
    movq	_stack_start(%rip), %rsp /* rsp address */

setup_IDT:
    leaq    ignore_int(%rip),   %rdx
    movq    $(0x08 << 16),  %rax // 段選擇子的位置從bit8開始
    movw	%dx,	%ax	         // dx暫存器中放置ignore_int的地址，這裡低16位是offset
    movq    $(0x8E00 << 32),    %rcx // 0x8E00用來描述IDT的類型和特權級別	
    addq    %rcx,   %rax             // 這裡用or或是add都可
    movl    %edx,   %ecx
    shrl    $16,    %ecx             // 右移16位取ignore_int剩餘的地址
    shlq    $48,    %rcx             // 左移48位讓剩餘16位的地址對上Offset的位置，該位置從bit48開始
    addq    %rcx,   %rax
    shrq    $32,    %rdx             // 將剩餘的32位元地址取出
    leaq    IDT_Table(%rip),    %rdi // 把IDT_Table的地址放入rdi
    mov	$256,   %rcx
rp_sidt:
    movq    %rax,   (%rdi)           // rax為IDT的前8byte
    movq    %rdx,   8(%rdi)          // 這裡放置IDT的後4byte，剩餘4byte為保留位不管他
    addq    $0x10,  %rdi
    dec	%rcx                         // 重複填滿256個IDT描述符
    jne rp_sidt

setup_TSS64:
    leaq	TSS64_Table(%rip),	%rdx
    xorq    %rax,   %rax
    xorq    %rcx,   %rcx
    movq    $0x89,  %rax
    shlq    $40,    %rax
    movl    %edx,   %ecx
    shrl    $24,    %ecx
    shlq    $56,    %rcx
    addq    %rcx,   %rax
    xorq    %rcx,   %rcx
    movl    %edx,   %ecx
    andl    $0xffffff,  %ecx
    shlq    $16,    %rcx
    addq    %rcx,   %rax
    addq    $103,   %rax
    leaq    GDT_Table(%rip),    %rdi
    movq    %rax,   80(%rdi)    // 這裡設80而非72是因為對齊
    shrq    $32,    %rdx        // 取TSS描述符地址高32位
    movq    %rdx,   88(%rdi)

    movq    go_to_kernel(%rip), %rax        /* movq address */
    pushq   $0x08
    pushq   %rax
    lretq

go_to_kernel:
    .quad   Start_Kernel


//=======   ignore_int

ignore_int:
    cld
    pushq   %rax
    pushq   %rbx
    pushq   %rcx
    pushq   %rdx
    pushq   %rbp
    pushq   %rdi
    pushq   %rsi

    pushq   %r8
    pushq   %r9
    pushq   %r10
    pushq   %r11
    pushq   %r12
    pushq   %r13
    pushq   %r14
    pushq   %r15

    movq    %es,    %rax
    pushq   %rax
    movq    %ds,    %rax
    pushq   %rax

    movq    $0x10,  %rax // 第二個GDT描述符
    movq    %rax,   %ds
    movq    %rax,   %es

    leaq	int_msg(%rip),	%rax        /* leaq get address */
    pushq	%rax
    movq    %rax,   %rdx
    movq    $0x00000000,    %rsi
    movq    $0x00ff0000,    %rdi
    movq    $0, %rax
    callq   color_printk
    addq    $0x8,   %rsp

Loop:
    jmp	Loop	

    popq    %rax
    movq    %rax,   %ds
    popq    %rax
    movq    %rax,   %es

    popq    %r15
    popq    %r14
    popq    %r13
    popq    %r12
    popq    %r11
    popq    %r10
    popq    %r9
    popq    %r8

    popq    %rsi
    popq    %rdi
    popq    %rbp
    popq    %rdx
    popq    %rcx
    popq    %rbx
    popq    %rax
    iretq

int_msg:
    .asciz  "Unknown interrupt or fault at RIP\n"

ENTRY(_stack_start)
    .quad   init_task_union + 32768

//=======   init page
.align 8    // 一個page table entry的長度為 8 byte

.org    0x1000  // 用.org固定一級頁表的起始位置
                // loader.asm把kernel文件放在0x100000後，所以page放置的位置是物理內存的0x101000
__PML4E:
// cr3指向標籤__PML4E的地址，地址為0x101000
    .quad   0x102007    // 0x102007，page table是以4KB對齊，指向的2級頁物理地址為0x102000，0x7則為屬性
    .fill   255,8,0     // 其餘255個條目尚未使用先補0
    .quad   0x102007    // 這裡重複是因為希望讓映射兩段虛擬地址到相同的物理內存，虛擬地址0xffff800000000000 與 0x0是相同的page 
    .fill   255,8,0

.org    0x2000

__PDPTE:
    
    .quad   0x103007    /* 0x103003 */
    .fill   511,8,0

.org    0x3000

__PDE:

    .quad   0x000087
    .quad   0x200087
    .quad   0x400087
    .quad   0x600087
    .quad   0x800087        /* 0x800083 */
    .quad   0xe0000087      /*0x a00000*/
    .quad   0xe0200087
    .quad   0xe0400087
    .quad   0xe0600087      /*0x1000000*/
    .quad   0xe0800087
    .quad   0xe0a00087
    .quad   0xe0c00087
    .quad   0xe0e00087
    .fill   499,8,0

// GDT_Table

.section    .data

.global     GDT_Table

GDT_Table:
    .quad   0x0000000000000000          /*0	NULL descriptor               	00*/
    .quad   0x0020980000000000          /*1	KERNEL  Code    64-bit  Segment	08*/
    .quad   0x0000920000000000          /*2	KERNEL  Data    64-bit  Segment	10*/
    .quad   0x0000000000000000          /*3	USER    Code    32-bit  Segment 18*/
    .quad   0x0000000000000000          /*4	USER    Data    32-bit  Segment 20*/
    .quad   0x0020f80000000000          /*5	USER    Code    64-bit  Segment	28*/
    .quad   0x0000f20000000000          /*6	USER    Data    64-bit  Segment	30*/
    .quad   0x00cf9a000000ffff          /*7	KERNEL  Code    32-bit  Segment	38*/
    .quad   0x00cf92000000ffff          /*8	KERNEL  Data    32-bit  Segment	40*/
    .fill   10,8,0                      /*10 ~ 11 TSS (jmp one segment <9>) in long-mode 128-bit 50*/
GDT_END:

GDT_POINTER:
GDT_LIMIT:  .word   GDT_END - GDT_Table - 1
GDT_BASE:   .quad   GDT_Table

//=======   IDT_Table

.globl  IDT_Table

IDT_Table:
    .fill     512,8,0
IDT_END:

IDT_POINTER:
IDT_LIMIT:  .word   IDT_END - IDT_Table - 1
IDT_BASE:   .quad   IDT_Table

//=======   TSS64_Table

.globl  TSS64_Table

TSS64_Table:
    .fill    13,8,0
TSS64_END:


TSS64_POINTER:
TSS64_LIMIT:    .word   TSS64_END - TSS64_Table - 1
TSS64_BASE:     .quad   TSS64_Table