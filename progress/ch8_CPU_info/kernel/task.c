#include "task.h"
#include "printk.h"
#include "linkage.h"

extern void ret_system_call(void);
extern void system_call(void);

void __switch_to(struct task_struct *prev, struct task_struct *next);
unsigned long init(unsigned long arg);

void user_level_function()
{
    long ret = 0;
    char string[]="Hello World!\n";
    __asm__ __volatile__ (
                    "leaq   sysexit_return_address(%%rip),  %%rdx   \n\t"
                    "movq   %%rsp,  %%rcx       \n\t"
                    "sysenter                   \n\t"
                    "sysexit_return_address:    \n\t"
                    :"=a"(ret):"0"(1),"D"(string):"memory");
    while(1);
}

unsigned long do_execve(struct pt_regs *regs)
{
    regs->rdx = 0x800000; //RIP
    regs->rcx = 0xa00000; //RSP
    regs->rax = 1;
    regs->ds = 0;
    regs->es = 0;
    color_printk(RED,BLACK,"do_execve task is running\n");
    memcpy(user_level_function,(void *)0x800000,1024); // 定義與string.h的函式有區別，為memcpy(src,dst,size);
    return 0;
}

unsigned long init(unsigned long arg)
{
    struct pt_regs *regs;
    color_printk(RED,BLACK, "init task is running,arg:%#018lx\n", arg);
    current->thread->rip = (unsigned long)ret_system_call;
    current->thread->rsp = (unsigned long)current + STACK_SIZE - sizeof(struct pt_regs);
    regs = (struct pt_regs*)current->thread->rsp;
    __asm__ __volatile__ ( "movq    %1, %%rsp   \n\t"
                           "pushq   %2          \n\t"
                           "jmp     do_execve   \n\t"
                           ::"D"(regs),"m"(current->thread->rsp),"m"(current->thread->rip):"memory");
    return 1;
}

unsigned long do_fork(struct pt_regs *regs, unsigned long clone_flags, unsigned long stack_start, unsigned long stack_size)
{
    struct task_struct *tsk = NULL;
    struct thread_struct *thd = NULL;
    struct Page *p = NULL;
    
    color_printk(WHITE,BLACK, "alloc_pages,bitmap:%#018lx\n", *memory_management_struct.bits_map);
    p = alloc_pages(ZONE_NORMAL, 1, PG_PTable_Maped | PG_Active | PG_Kernel); // 申請一個頁，並設定頁的屬性。
    color_printk(WHITE,BLACK,"alloc_pages,bitmap:%#018lx\n",*memory_management_struct.bits_map);

    tsk = (struct task_struct *)Phy_To_Virt(p->PHY_address);
    color_printk(WHITE,BLACK,"struct task_struct address:%#018lx\n",(unsigned long)tsk);

    memset(tsk, 0, sizeof(*tsk));
    *tsk = *current; // 把當前行程的task_struct賦值給*tsk。另外current是巨集替換成函式get_current()。
    list_init(&tsk->list);
    list_add_to_before(&init_task_union.task.list,&tsk->list); // 把目前的任務放到&tsk->list前面。
    tsk->pid++;
    tsk->state = TASK_UNINTERRUPTIBLE;

    thd = (struct thread_struct*)(tsk + 1); // 把thread_struct放置到task_struct後面
    tsk->thread = thd;	

    memcpy(regs, (void*)((unsigned long)tsk + STACK_SIZE - sizeof(struct pt_regs)), sizeof(struct pt_regs));
    // 將tsk轉換成unsigned long是希望地址計算以byte為單位，並且在最外層轉換為(void*)是因為memcpy的輸入必須為指針。
    // 這裡memcpy的定義與string.h的不同，書中定義 void *memcpy(void *From, void *To, long Num);
    // 這裡的操作就相當於把regs中所有的暫存器值push到stack中。

    thd->rsp0 = (unsigned long)tsk + STACK_SIZE;
    thd->rip = regs->rip;
    thd->rsp = (unsigned long)tsk + STACK_SIZE - sizeof(struct pt_regs);

    if(!(tsk->flags & PF_KTHREAD))
        thd->rip = regs->rip = (unsigned long)ret_system_call;

    // PF_KTHREAD用來判斷這一個行程是核心層的還是應用層的。如果是應用層就把程式入口設定在ret_from_intr。
    // 感覺像是我們撰寫main函式的程式入口 _start?
    tsk->state = TASK_RUNNING;

    return 0;
}

extern void kernel_thread_func(void);
__asm__ (
".global kernel_thread_func \n\t"
"kernel_thread_func:    \n\t"
"   popq    %r15    \n\t"
"   popq    %r14    \n\t"
"   popq    %r13    \n\t"
"   popq    %r12    \n\t"
"   popq    %r11    \n\t"
"   popq    %r10    \n\t"
"   popq    %r9     \n\t"
"   popq    %r8     \n\t"
"   popq    %rbx    \n\t"
"   popq    %rcx    \n\t"
"   popq    %rdx    \n\t"
"   popq    %rsi    \n\t"
"   popq    %rdi    \n\t"
"   popq    %rbp    \n\t"
"   popq    %rax    \n\t"
"   movq    %rax,   %ds     \n\t"
"   popq    %rax            \n\t"
"   movq    %rax,   %es     \n\t"
"   popq    %rax            \n\t"
"   addq    $0x38,  %rsp    \n\t"
/////////////////////////////////
"   movq    %rdx,   %rdi    \n\t"
"   callq   *%rbx           \n\t" // 注意rbx存的是行程的入口地址，這裡用*代表使用絕對地址。
"   movq    %rax,   %rdi    \n\t"
"   callq   do_exit         \n\t" // 釋放行程
);
// stack的頂部存放struct pt_regs，這裡的動作就是透過pop恢復暫存器的值，而addq $0x38, %rsp用來平衡stack(pt_reg有一些成員用不到)
int kernel_thread(unsigned long (*fn)(unsigned long), unsigned long arg, unsigned long flags)
{
    struct pt_regs regs; // 為新的行程保存現場信息所建立的結構體。
    memset(&regs, 0, sizeof(regs)); // 初始化為0
    regs.rbx = (unsigned long)fn;
    regs.rdx = (unsigned long)arg;
    regs.ds = KERNEL_DS; // 核心的數據段
    regs.es = KERNEL_DS;
    regs.cs = KERNEL_CS; // 核心的程式碼段
    regs.ss = KERNEL_DS;
    regs.rflags = (1 << 9); // 第9位是IF標幟位表示CPU可以響應中斷。
    regs.rip = (unsigned long)kernel_thread_func; // 這是引導程式
    return do_fork(&regs,flags,0,0);
}

unsigned long do_exit(unsigned long code)
{
    color_printk(RED, BLACK, "exit task is running,arg:%#018lx\n", code);
    while(1);
}

unsigned long  system_call_function(struct pt_regs *regs)
{
    return system_call_table[regs->rax](regs);
}

void __switch_to(struct task_struct *prev, struct task_struct *next)
{
    // linux2.4後process會共用同一個TSS，準確來說是1個CPU具有1個TSS，這些TSS由全局變數init_tss數組管理。
    init_tss[0].rsp0 = next->thread->rsp0;
    set_tss64(init_tss[0].rsp0, init_tss[0].rsp1, init_tss[0].rsp2, init_tss[0].ist1, init_tss[0].ist2, init_tss[0].ist3, init_tss[0].ist4, init_tss[0].ist5, init_tss[0].ist6, init_tss[0].ist7);
    // set_tss64就是把init_tss存放到tr暫存器指向的TSS64_Table中。
    __asm__ __volatile__("movq  %%fs,   %0 \n\t":"=a"(prev->thread->fs));
    __asm__ __volatile__("movq  %%gs,   %0 \n\t":"=a"(prev->thread->gs));

    __asm__ __volatile__("movq  %0, %%fs \n\t"::"a"(next->thread->fs));
    __asm__ __volatile__("movq  %0, %%gs \n\t"::"a"(next->thread->gs));

    color_printk(WHITE,BLACK,"prev->thread->rsp0:%#018lx\n",prev->thread->rsp0);
    color_printk(WHITE,BLACK,"next->thread->rsp0:%#018lx\n",next->thread->rsp0);
}


 void task_init()
{
    struct task_struct *p = NULL;

    init_mm.pgd = (pml4t_t*)Global_CR3; // 最初的一級頁表

    init_mm.start_code = memory_management_struct.start_code; // 核心程式碼段的起始地址
    init_mm.end_code = memory_management_struct.end_code; // 核心程式碼段結束地址

    init_mm.start_data = (unsigned long)&_data; // 數據段起始地址
    init_mm.end_data = memory_management_struct.end_data; // 數據段結束地址

    init_mm.start_rodata = (unsigned long)&_rodata; // 只讀數據段起始地址
    init_mm.end_rodata = (unsigned long)&_erodata; // 只讀數據段結束地址

    init_mm.start_brk = 0;
    init_mm.end_brk = memory_management_struct.end_brk; // 核心程式碼的結束地址

    init_mm.start_stack = _stack_start; // 系統第一個行程的stack基地址

    wrmsr(0x174, KERNEL_CS); // KERNEL_CS = 0x8表示載入第一個GDT描述符。
    wrmsr(0x175, current->thread->rsp0); // 系統調用的rsp
    wrmsr(0x176, (unsigned long)system_call); // 系統調用的rip

    //	init_thread,init_tss
    set_tss64(init_thread.rsp0, init_tss[0].rsp1, init_tss[0].rsp2, init_tss[0].ist1, init_tss[0].ist2, init_tss[0].ist3, init_tss[0].ist4, init_tss[0].ist5, init_tss[0].ist6, init_tss[0].ist7);

    init_tss[0].rsp0 = init_thread.rsp0;
    
    list_init(&init_task_union.task.list);

    kernel_thread(init, 10, CLONE_FS | CLONE_FILES | CLONE_SIGNAL); // 建立init行程

    init_task_union.task.state = TASK_RUNNING; // 修改成運行狀態。

    p = container_of(list_next(&current->list), struct task_struct,list); // 從成員list反推結構體的起始地址。
    switch_to(current, p); // 切換到init行程。
}