#include "ptrace.h"
#include "lib.h"
#include "memory.h"
#include "linkage.h"
#include "gate.h"
#include "schedule.h"
#include "printk.h"
#include "SMP.h"
#include "fat32.h"
#include "unistd.h"
#include "VFS.h"
#include "stdio.h"
#include "errno.h"
#include "sched.h"
#include "functl.h"

struct mm_struct init_mm;

struct thread_struct init_thread = {
    .rsp0 = (unsigned long)init_task_union.stack + STACK_SIZE,
    .rsp = (unsigned long)init_task_union.stack + STACK_SIZE,
    .fs = KERNEL_DS,
    .gs = KERNEL_DS,
    .cr2 = 0,
    .trap_nr = 0,
    .error_code = 0
};

union task_union init_task_union __attribute__((__section__ (".data.init_task"))) = {INIT_TASK(init_task_union.task)};
struct task_struct *init_task[NR_CPUS] = {&init_task_union.task, 0};
struct tss_struct init_tss[NR_CPUS] = { [0 ... NR_CPUS-1] = INIT_TSS};

long global_pid;

struct task_struct *get_task(long pid)
{
    for (struct task_struct *tsk = init_task_union.task.next;
         tsk != &init_task_union.task;
         tsk = tsk->next) {
        if (tsk->pid == pid)
            return tsk;
    }
    return NULL;
}

struct file *open_exec_file(char *path)
{
    struct dir_entry *dentry = path_walk(path, 0);

    if (!dentry) return (void*) -ENOENT;
    
    if (dentry->dir_inode->attribute == FS_ATTR_DIR) return (void*) -ENOTDIR;

    struct file *filp = (struct file*)kmalloc(sizeof(*filp), 0);

    if (!filp) return (void*) -ENOMEM;

    *filp = (struct file) {
        .dentry = dentry,
        .mode = O_RDONLY,
        .f_ops = dentry->dir_inode->f_ops,
    };

    return filp;
}

unsigned long init(unsigned long arg)
{
    DISK1_FAT32_FS_init();
    color_printk(RED, BLACK, "init task is running,arg:%#018lx\n", arg);

    current->thread->rip = (unsigned long)ret_system_call;
    current->thread->rsp = (unsigned long)current + STACK_SIZE - sizeof(struct pt_regs);
    current->thread->gs = USER_DS;
    current->thread->fs = USER_DS;
    current->flags &= ~PF_KTHREAD;

    __asm__ __volatile__ ("movq    %1, %%rsp   \n\t"
                          "pushq   %2          \n\t"
                          "jmp     do_execve   \n\t"
                          :
                          :"D"(current->thread->rsp),
                           "m"(current->thread->rsp),
                           "m"(current->thread->rip),
                           "S"("/init.bin"),
                           "d"(NULL),
                           "c"(NULL)
                          :"memory");
    return 1;
}

void kernel_thread_func(void);
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
    "   movq    %rdx,   %rdi    \n\t"
    "   callq   *%rbx           \n\t"
    "   movq    %rax,   %rdi    \n\t"
    "   callq   do_exit         \n\t"
    );



void wakeup_process(struct task_struct *tsk)
{
    tsk->state = TASK_RUNNING;
    insert_task_queue(tsk);
    current->flags |= NEED_SCHEDULE;
}

unsigned long copy_flags(unsigned long clone_flags, struct task_struct *tsk)
{
    if (clone_flags & CLONE_VM) tsk->flags |= PF_VFORK;
    return 0;
}

unsigned long copy_files(unsigned long clone_flags, struct task_struct *tsk)
{
    if (clone_flags & CLONE_FS) return 0;
    struct task_struct *current_tsk = current;

    for (int i = 0; i < TASK_FILE_MAX; i++) {
        if (current_tsk->file_struct[i]) {
            tsk->file_struct[i] = (struct file*)kmalloc(sizeof(struct file), 0);
            
            if (!tsk->file_struct[i]) return -ENOMEM;

            memcpy(current_tsk->file_struct[i], tsk->file_struct[i], sizeof(struct file)); 
        }
    }

    return 0;
}

void exit_files(struct task_struct *tsk)
{
    int i = 0;
    if (!(tsk->flags & PF_VFORK)) {
        for (i = 0; i < TASK_FILE_MAX; i++) {
            if (tsk->file_struct[i]) kfree(tsk->file_struct[i]);
        }
    }
    memset(tsk->file_struct, 0, sizeof(struct file*) * TASK_FILE_MAX);
}

unsigned long copy_mm(unsigned long clone_flags, struct task_struct *tsk)
{
    int error = 0;
    struct mm_struct *newmm = NULL;
    unsigned long code_start_addr = 0x800000; // 程式碼段的起始位址
    unsigned long stack_start_addr = 0xa00000; // stack 的起始地址
    unsigned long brk_start_addr = 0xc00000;
    unsigned long *tmp;
    struct Page *p = NULL;

    if (clone_flags & CLONE_VM) {
        // 若設置 CLONE_VM，則表示新行程將與父行程共用記憶體空間
        newmm = current->mm;
        goto out; // 跳到 out，不再執行記憶體分配操作
    }

    newmm = (struct mm_struct*)kmalloc(sizeof(*newmm), 0);
    memcpy(current->mm, newmm, sizeof(*newmm));

    newmm->pgd = (pml4t_t*)(Virt_To_Phy(kmalloc(PAGE_4K_SIZE, 0)));

    memcpy(Phy_To_Virt(init_task[SMP_cpu_id()]->mm->pgd) + 256,
           Phy_To_Virt(newmm->pgd)+ 256,
           PAGE_4K_SIZE / 2);
    // 複製 PML4 頁表的後半部分（從第 256 項開始)也就是核心層空間

    memset(Phy_To_Virt(newmm->pgd), 0, PAGE_4K_SIZE / 2);
    // 清空前 256 項的頁表，這些頁表指向應用層空間

    // 接下來將為新行程配置頁表，這裡假設行程使用的空間小於 2 MB

    // 根據程式碼段地址訪問頁表，並設置頁表條目
    tmp = Phy_To_Virt((unsigned long*)((unsigned long)newmm->pgd & (~0xfffUL)) +
                      ((code_start_addr >> PAGE_GDT_SHIFT) & 0x1ff));

    create_new_set_mpl4t(tmp);

    tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                      ((code_start_addr >> PAGE_1G_SHIFT) & 0x1ff));
    create_new_pdpt(tmp);

    tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                     ((code_start_addr >> PAGE_2M_SHIFT) & 0x1ff));
    p = create_new_pdt(tmp);

    // 將當前行程的程式碼段從間複製到新頁中
    memcpy((void*)code_start_addr,
           Phy_To_Virt(p->PHY_address),
           stack_start_addr - code_start_addr);

    if (current->mm->end_brk > current->mm->start_brk) {
        tmp = Phy_To_Virt((unsigned long*)((unsigned long)newmm->pgd & (~0xfffUL)) +
                         ((brk_start_addr >> PAGE_GDT_SHIFT) & 0x1ff));
        
        tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                         ((brk_start_addr >> PAGE_1G_SHIFT) & 0x1ff));
        
        tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                         ((brk_start_addr >> PAGE_2M_SHIFT) & 0x1ff));

        create_new_pdt(tmp);

        // 複製 parent 的 heap
        memcpy((void*)brk_start_addr, Phy_To_Virt(p->PHY_address), PAGE_2M_SIZE);
    }
out:
    tsk->mm = newmm;
    return error;
}

void exit_mm(struct task_struct *tsk)
{
    unsigned long code_start_addr = 0x800000;
    unsigned long *tmp4;
    unsigned long *tmp3;
    unsigned long *tmp2;
    
    // 如果是共享資源則不釋放
    if (tsk->flags & PF_VFORK)
        return;

    if (tsk->mm->pgd != NULL) {
        // 清空頁表
        tmp4 = Phy_To_Virt((unsigned long *)((unsigned long)tsk->mm->pgd & (~0xfffUL)) +
                           ((code_start_addr >> PAGE_GDT_SHIFT) & 0x1ff));

        tmp3 = Phy_To_Virt((unsigned long *)(*tmp4 & (~0xfffUL)) +
                           ((code_start_addr >> PAGE_1G_SHIFT) & 0x1ff));
        
        tmp2 = Phy_To_Virt((unsigned long *)(*tmp3 & (~0xfffUL)) +
                           ((code_start_addr >> PAGE_2M_SHIFT) & 0x1ff));
        
        free_pages(Phy_to_2M_Page(*tmp2), 1);

        kfree(Phy_To_Virt(*tmp3));
        kfree(Phy_To_Virt(*tmp4));
        kfree(Phy_To_Virt(tsk->mm->pgd));
    }
    if (tsk->mm != NULL)
        kfree(tsk->mm);
}


unsigned long copy_thread(unsigned long clone_flags,
                          unsigned long stack_start,
                          unsigned long stack_size,
                          struct task_struct *tsk,
                          struct pt_regs * regs)
{
    unsigned long tsk_end = (unsigned long)tsk + STACK_SIZE;

    struct thread_struct *thd = (struct thread_struct*)(tsk + 1);
    struct pt_regs *child_regs = (struct pt_regs *)tsk_end - 1;

    *child_regs = *regs;
    child_regs->rax = 0;
    child_regs->rsp = stack_start; 

    *thd = (struct thread_struct) {
        .rsp0 = tsk_end,
        .rsp  = (unsigned long)child_regs,
        .fs   = current->thread->fs,
        .gs   = current->thread->gs,
        .rip  = (tsk->flags & PF_KTHREAD) ? 
                    (unsigned long)kernel_thread_func : 
                    (unsigned long)ret_system_call,
    };

    tsk->thread = thd;
    
    return 0;
    /*
    color_printk(WHITE,
                 BLACK,
                 "current user ret addr:%#018lx,rsp:%#018lx\n",
                 regs->r10,
                 regs->r11);
    
    color_printk(WHITE,
                 BLACK,
                 "new user ret addr:%#018lx,rsp:%#018lx\n",
                 child_regs->r10,
                 child_regs->r11);
    */
}

void exit_thread(struct task_struct *tsk)
{

}

unsigned long do_fork(struct pt_regs *regs, unsigned long clone_flags, unsigned long stack_start, unsigned long stack_size)
{
    int retval = 0;
    struct task_struct *tsk = (struct task_struct*)kmalloc(STACK_SIZE, 0);
    if (!tsk) return -EAGAIN;

//	alloc & copy task struct
    color_printk(WHITE, BLACK, "struct task_struct address:%#018lx\n", (unsigned long)tsk);

    *tsk = *current;

    list_init(&tsk->list);
    tsk->priority = 2;
    tsk->pid = global_pid++;
    tsk->preempt_count = 0;
    tsk->cpu_id = SMP_cpu_id();
    tsk->state = TASK_UNINTERRUPTIBLE;
    tsk->next = init_task_union.task.next;
    tsk->parent = current;
    wait_queue_init(&tsk->wait_childexit,NULL);
    init_task_union.task.next = tsk;

    retval = -ENOMEM;
//	copy flags
    if(copy_flags(clone_flags, tsk)) goto copy_flags_fail;

//	copy mm struct
    if(copy_mm(clone_flags, tsk)) goto copy_mm_fail;

//	copy file struct
    if(copy_files(clone_flags, tsk)) goto copy_files_fail;

//	copy thread struct
    if(copy_thread(clone_flags, stack_start, stack_size, tsk, regs)) goto copy_thread_fail;

    retval = tsk->pid;

    wakeup_process(tsk);

fork_ok:
    return retval;


copy_thread_fail:
    exit_thread(tsk);
copy_files_fail:
    exit_files(tsk);
copy_mm_fail:
    exit_mm(tsk);
copy_flags_fail:
    kfree(tsk);

    return retval;
}

void exit_notify()
{
    // 通知父行程
    wakeup(&current->parent->wait_childexit, TASK_INTERRUPTIBLE);
}

unsigned long do_exit(unsigned long exit_code)
{
    struct task_struct *tsk = current;
    color_printk(RED, BLACK, "exit task is running,arg:%#018lx\n", exit_code);

do_exit_again:

    cli();
    tsk->state = TASK_ZOMBIE;
    tsk->exit_code = exit_code;
    exit_thread(tsk);
    exit_files(tsk);
    sti();

    exit_notify();
    schedule();
    goto do_exit_again;
    return 0;
}

static inline void setup_new_pgd(struct mm_struct *mm)
{
    mm->pgd = (pml4t_t*)Virt_To_Phy(kmalloc(PAGE_4K_SIZE, 0));
    memset(Phy_To_Virt(mm->pgd), 0, PAGE_4K_SIZE / 2); // 清空應用層空間的頁表
    // kernel space 記憶體共用
    memcpy(Phy_To_Virt(init_task[SMP_cpu_id()]->mm->pgd) + 256,
           Phy_To_Virt(mm->pgd) + 256,
           PAGE_4K_SIZE / 2);
}

unsigned long do_execve(struct pt_regs *regs, char *name, char *argv[], char *envp[])
{
    // 執行此函式後行程將獨立於父行程
    unsigned long code_start_addr = 0x800000;
    unsigned long stack_start_addr = 0xa00000;
    unsigned long brk_start_addr = 0xc00000;
    unsigned long *tmp;
    struct file *filp = NULL;
    unsigned long retval = 0;
    long pos = 0;

    color_printk(RED, BLACK, "do_execve task is running\n");

    current->mm = kmalloc(sizeof(struct mm_struct), 0);
    *current->mm = (struct mm_struct) {
        .start_code = code_start_addr,
        .end_code = 0,
        .start_data = 0,
        .end_data = 0,
        .start_rodata = 0,
        .end_rodata = 0,
        .start_bss = 0,
        .end_bss = 0,
        .start_brk = brk_start_addr,
        .end_brk = brk_start_addr,
        .start_stack = stack_start_addr,
        .pgd = NULL, // 之後再來設定
    };


    if (current->flags & PF_VFORK) {
        // 如果行程經由 vfork 創建，則必須創建新的記憶體空間。
        setup_new_pgd(current->mm);
    }

    // 設置頁表條目，建立用戶程式的虛擬地址空間
    tmp = Phy_To_Virt((unsigned long*)((unsigned long)current->mm->pgd & (~0xfffUL)) +
                     ((code_start_addr >> PAGE_GDT_SHIFT) & 0x1ff));

    if (!(*tmp)) create_new_set_mpl4t(tmp);

    tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                     ((code_start_addr >> PAGE_1G_SHIFT) & 0x1ff));
    if (!(*tmp)) create_new_pdpt(tmp);

    tmp = Phy_To_Virt((unsigned long*)(*tmp & (~0xfffUL)) +
                     ((code_start_addr >> PAGE_2M_SHIFT) & 0x1ff));
    if (!(*tmp)) create_new_pdt(tmp);

    // 刷新頁表快取
    __asm__ __volatile__ ("mfence           \n\t"
                          "movq %0, %%cr3   \n\t"
                          ::"r"(current->mm->pgd):"memory");
    
    // 開啟並讀取指定的可執行檔案
    filp = open_exec_file(name);

    if ((unsigned long)filp > -0x1000UL)
        return (unsigned long)filp;

    // 如果當前行程不是核心執行緒，設置其記憶體訪問限制
    if (!(current->flags & PF_KTHREAD))
        current->addr_limit = TASK_SIZE;
    
    // 配置記憶體管理結構的程式段、數據段等範圍


    exit_files(current);

    // 清除 PF_VFORK 標誌
    current->flags &= ~PF_VFORK;

    if (argv) {
        int argc = 0;
        int len = 0;
        int i = 0;
        char **dargv = (char**)(stack_start_addr - 10 * sizeof(char*));
        pos = (unsigned long)dargv;
        for (i = 0; i < 10 && argv[i]; i++) {
            len = strnlen_user(argv[i], 1024) + 1;
            strcpy((char*)pos - len, argv[i]);
            dargv[i] = (char*)(pos - len);
            pos -= len;
        }
        stack_start_addr = pos - 10;
        regs->rdi = i; // argc
        regs->rsi = (unsigned long)dargv; // argv
    }

    memset((void *)code_start_addr, 0, stack_start_addr - code_start_addr);
    // 清空程式碼段
    pos = 0;

    // 從可執行檔案中讀取程式碼，載入到記憶體中  
    retval = filp->f_ops->read(filp,
                               (void *)code_start_addr,
                               filp->dentry->dir_inode->file_size,
                               &pos);
    
    __asm__	__volatile__ ( "movq %0, %%gs   \n\t"
                           "movq %0, %%fs   \n\t"
                           ::"r"(0UL));

    // 設置用戶態的段寄存器，準備執行用戶態程式
    regs->ds = USER_DS;
    regs->es = USER_DS;
    regs->ss = USER_DS;
    regs->cs = USER_CS;

    // 設置用戶態程序的指令指針和堆疊指針
    regs->r10 = code_start_addr; // RIP 指向程式碼起始地址
    regs->r11 = stack_start_addr; // RSP 指向堆疊起始地址
    regs->rax = 1;
    
    color_printk(RED, BLACK, "do_execve task is running\n");
    return retval;
}

// stack的頂部存放struct pt_regs，這裡的動作就是透過pop恢復暫存器的值，而addq $0x38, %rsp用來平衡stack(pt_reg有一些成員用不到)
int kernel_thread(unsigned long (*fn)(unsigned long), unsigned long arg, unsigned long flags)
{
    //保存現場信息
    struct pt_regs regs = {
        .rbx = (unsigned long)fn,
        .rdx = (unsigned long)arg,
        .ds = KERNEL_DS, // 核心的數據段
        .es = KERNEL_DS,
        .cs = KERNEL_CS, // 核心的程式碼段
        .ss = KERNEL_DS,
        .rflags = 1 << 9, // 第9位是IF標幟位表示CPU可以響應中斷。
        .rip = (unsigned long)kernel_thread_func, // 這是引導程式
    };
    return do_fork(&regs, flags | CLONE_VM, 0, 0);
}

inline void switch_mm(struct task_struct *prev,struct task_struct *next)
{
    __asm__ __volatile__ ("movq %0, %%cr3   \n\t"::"r"(next->mm->pgd):"memory");
}

void __switch_to(struct task_struct *prev, struct task_struct *next);

inline void __switch_to(struct task_struct *prev, struct task_struct *next)
{
    // process會共用同一個TSS，1個處理器具有1個TSS，這些TSS由全局變數init_tss數組管理。
    init_tss[SMP_cpu_id()].rsp0 = next->thread->rsp0;

    __asm__ __volatile__("movq  %%fs, %0 \n\t":"=a"(prev->thread->fs));
    __asm__ __volatile__("movq  %%gs, %0 \n\t":"=a"(prev->thread->gs));

    __asm__ __volatile__("movq  %0, %%fs \n\t"::"a"(next->thread->fs));
    __asm__ __volatile__("movq  %0, %%gs \n\t"::"a"(next->thread->gs));

    wrmsr(0x175, next->thread->rsp0); // 系統調用的入口位置
}

void task_init()
{
    unsigned long *tmp = NULL;
    unsigned long *vaddr = NULL;
    int i = 0;
    int cpu_id = SMP_cpu_id();

    vaddr = (unsigned long*)Phy_To_Virt((unsigned long)Get_gdt() & (~0xfffUL));
    *vaddr = 0UL; // 取消映射關係 kernel space 與 user space 在一級頁表的映射關係。

    for (i = 256; i < 512; i++) {
        tmp = vaddr + i;
        if (!(*tmp)) create_new_set_mpl4t(tmp);
    }

    init_mm = (struct mm_struct) {
        .pgd = (pml4t_t*)Get_gdt(), // 最初的一級頁表
        .start_code = memory_management_struct.start_code, // 核心程式碼段的起始地址
        .end_code = memory_management_struct.end_code, // 核心程式碼段結束地址
        .start_data = (unsigned long)&_data, // 數據段起始地址
        .end_data = memory_management_struct.end_data, // 數據段結束地址
        .start_rodata = (unsigned long)&_rodata, // 只讀數據段起始地址
        .end_rodata = memory_management_struct.end_rodata, // 只讀數據段結束地址
        .start_bss = (unsigned long)&_bss,
        .end_bss = (unsigned long)&_ebss,
        .start_brk = memory_management_struct.start_brk,
        .end_brk = current->addr_limit,
        .start_stack = _stack_start,
    };

    // 這裡寫入MSR地址是希望透過sysenter與sysexit實現系統調用，這比ret類指令跳快。
    wrmsr(0x174, KERNEL_CS); // KERNEL_CS = 0x8表示載入第一個GDT描述符。
    wrmsr(0x175, current->thread->rsp0); // 系統調用的rsp
    wrmsr(0x176, (unsigned long)system_call); // 系統調用的rip

    init_tss[cpu_id].rsp0 = init_thread.rsp0;
    
    list_init(&init_task_union.task.list); // 初始化任務佇列

    kernel_thread(init, 10, CLONE_FS | CLONE_SIGNAL); // 建立init行程

    init_task_union.task.preempt_count = 0;
    init_task_union.task.state = TASK_RUNNING; // 修改成運行狀態。
    init_task_union.task.cpu_id = cpu_id;

}