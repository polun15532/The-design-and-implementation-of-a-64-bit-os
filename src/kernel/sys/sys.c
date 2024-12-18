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

#include "errno.h"
#include "printk.h"
#include "VFS.h"
#include "lib.h"
#include "fat32.h"
#include "functl.h"
#include "task.h"
#include "stdio.h"
#include "sched.h"
#include "memory.h"
#include "keyboard.h"
#include "sys.h"
#include "dirent.h"
#include "ptrace.h"

/**
 *  system call number: rax
 *  arg1:   rdi
 *  arg2:   rsi
 *  arg3:   rdx
 *  arg4:   rcx
 *  arg5:   r8
 *  arg6:   r9
 * 
 *  sysenter rdx(rip) rcx(rsp) 這兩個暫存器儲存核心層的rip與rsp。
 *  syscall need rcx(rip) r11(rflags)
 *  xchg rdx to r10, rcx to r11
 */

unsigned long sys_exit(int error_code)
{
    color_printk(GREEN, BLACK, "sys_exit\n");
    return do_exit(error_code);
}

unsigned long sys_wait4(unsigned long pid, int *status, int options, void *rusage)
{
    int retval = 0;
    struct task_struct *child = NULL;
    struct task_struct *tsk = NULL;

    color_printk(GREEN, BLACK, "sys_wait4\n");
    for (tsk = &init_task_union.task; tsk->next != &init_task_union.task; tsk = tsk->next) {
        if (tsk->next->pid == pid) {
            child = tsk->next;
            break;
        }
    }

    if (child == NULL) return -ECHILD;
    if (options) return -EINVAL;

    if (child->state == TASK_ZOMBIE) {
        // 子行程已結束
        copy_to_user(&child->exit_code, status, sizeof(int));
    } else {
        // 子行程尚未結束，等待其變為 TASK_ZOMBIE
        interruptible_sleep_on(&current->wait_childexit);
        copy_to_user(&child->exit_code, status, sizeof(long));
    }

    // 清理子行程結構
    tsk->next = child->next;
    exit_mm(child);
    kfree(child);

    return retval;
}


unsigned long sys_execve()
{
    char *path_name = NULL;
    long path_len = 0;
    long error = 0;
    struct pt_regs *regs = (struct pt_regs*)current->thread->rsp0 - 1;
    color_printk(GREEN, BLACK, "sys_execve\n");
    path_name = (char*)kmalloc(PAGE_4K_SIZE, 0);
    
    if (path_name == NULL) return -ENOMEM;

    path_len = strnlen_user((char*)regs->rsi, PAGE_4K_SIZE);

    if (path_len <= 0) {
        kfree(path_name);
        return -EFAULT;
    } else if (path_len >= PAGE_4K_SIZE) {
        kfree(path_name);
        return -ENAMETOOLONG;        
    }

    strncpy((char*)regs->rdi, path_name, path_len);
    path_name[path_len] = '\0';
    error = do_execve(regs, path_name, (char**)regs->rsi, NULL);
    kfree(path_name);
    return error;
}

int fill_dentry(void *buf, char *name, long name_len, long type, long offset)
{

    if ((unsigned long)buf < TASK_SIZE && !verify_area(buf, sizeof(struct dirent) + name_len))
        return -EFAULT;
    *(struct dirent*)buf = (struct dirent) {
        .d_name_len = name_len,
        .d_type = type,
        .d_offset = offset,
    };
    memcpy(name, ((struct dirent*)buf)->d_name, name_len);

    return sizeof(struct dirent) + name_len;
}

unsigned long sys_getdents(int fd, void *dirent, long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;
    if (fd < 0 || fd >= TASK_FILE_MAX) return -EBADF;
    // 非法文件描述符
    if (count < 0) return -EINVAL;
    // 非法值
    filp = current->file_struct[fd];
    if (filp->f_ops && filp->f_ops->readdir)
        ret = filp->f_ops->readdir(filp, dirent, fill_dentry);
    return ret;
}

unsigned long sys_chdir(char *filename)
{
    char *path = NULL;
    long path_len = 0;
    struct dir_entry *dentry = NULL;

    color_printk(GREEN, BLACK, "sys_chdir\n");
    path = (char*)kmalloc(PAGE_4K_SIZE, 0);
    
    if (path == NULL) return -ENOMEM;

    path_len = strnlen_user(filename, PAGE_4K_SIZE);
    if (path_len <= 0) {
        kfree(path);
        return -EFAULT;
    } else if (path_len >= PAGE_4K_SIZE) {
        kfree(path);
        return -ENAMETOOLONG;
    }

    strncpy_from_user(filename, path, path_len);
    path[path_len] = '\0';

    dentry = path_walk(path, 0);
    kfree(path);

    if (dentry == NULL) return -ENOENT;
    if (!(dentry->dir_inode->attribute & FS_ATTR_DIR)) return -ENOTDIR;
    
    return 0;
}

unsigned long sys_reboot(unsigned long cmd, void *arg)
{
    color_printk(GREEN, BLACK, "sys_reboot\n");
    switch (cmd) {
        case SYS_REBOOT:
            io_out8(0x64, 0xFE); // 重啟系統
            break;

        case SYS_POWEROFF:
            color_printk(GREEN, BLACK, "sys_reboot and poweroff\n");
            break;

        default:
            color_printk(GREEN, BLACK, "sys_reboot cmd ERROR!\n");
            break;
    }
    return 0;
}

unsigned long sys_brk(unsigned long brk)
{
    struct mm_struct *cur_mm = current->mm;
    unsigned long new_brk = PAGE_2M_ALIGN(brk); // 每次修改 brk 以頁為單位
    if (new_brk == 0)
        return cur_mm->start_brk; // 如果傳入的 brk 為 0 就不做任何更改。

    if (new_brk < cur_mm->end_brk) // 目前尚不支援縮小 heap 空間的操作
        return 0;

    new_brk = do_brk(cur_mm->end_brk, new_brk - cur_mm->end_brk); // 擴展 heap 邊界

    cur_mm->end_brk = new_brk;

    return new_brk;
}

unsigned long sys_fork()
{
    struct pt_regs *regs = (struct pt_regs*)current->thread->rsp0 - 1; // 核心層 rsp
    color_printk(GREEN, BLACK, "sys_fork\n");
    return do_fork(regs, 0, regs->rsp, 0);	    
}

unsigned long sys_vfork()
{
    struct pt_regs *regs = (struct pt_regs*)current->thread->rsp0 - 1;
    color_printk(GREEN, BLACK, "sys_Vfork\n");
    return do_fork(regs, CLONE_VM | CLONE_FS | CLONE_SIGNAL, regs->rsp, 0);      
}

unsigned long sys_lseek(int filds, long offset, int whence)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    color_printk(GREEN, BLACK, "sys_leek:%d\n", filds); // 打印文件描述符

    // 無效的文件描述符
    if (filds < 0 || filds >= TASK_FILE_MAX) return -EBADF;
    // 無效的訪問基地址
    if (whence < 0 || whence >= SEEK_MAX) return -EINVAL;

    filp = current->file_struct[filds];
    if (filp && filp->f_ops && filp->f_ops->lseek)
        ret = filp->f_ops->lseek(filp, offset, whence);
    return ret;
}

unsigned long sys_write(int fd,void * buf,long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    // color_printk(GREEN, BLACK, "sys_write:%d\n", fd);
    if (fd < 0 || fd >= TASK_FILE_MAX) return -EBADF;
    
    if (count < 0) return -EINVAL;

    filp = current->file_struct[fd];
    if (filp && filp->f_ops && filp->f_ops->write)
        ret = filp->f_ops->write(filp, buf, count, &filp->position);
    return ret;
}


unsigned long sys_read(int fd, void *buf, long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    if (fd < 0 || fd >= TASK_FILE_MAX)
        return -EBADF;
    if (count < 0)
        return -EINVAL;

    filp = current->file_struct[fd];

    if (filp && filp->f_ops && filp->f_ops->read)
        ret = filp->f_ops->read(filp, buf, count, &filp->position);
    return ret;
}

unsigned long sys_close(int fd)
{
    struct file *filp = NULL;

    color_printk(GREEN, BLACK, "sys_close:%d\n",fd);
    if (fd < 0 || fd >= TASK_FILE_MAX) return -EBADF;

    filp = current->file_struct[fd]; // 從文件描述符找到目標文件

    if (filp && filp->f_ops && filp->f_ops->close)
        filp->f_ops->close(filp->dentry->dir_inode, filp);

    kfree(filp);
    current->file_struct[fd] = NULL; // 釋放文件描述符

    return 0;
}

unsigned long sys_open(char *filename, int flags)
{
    char *path = NULL;
    long path_len = 0;
    long error = 0;
    struct dir_entry *dentry = NULL;
    struct file *filp = NULL;
    struct file **f = NULL;
    int fd = -1;
    
    path = (char*)kmalloc(PAGE_4K_SIZE, 0);
    
    if (path == NULL) return -ENOMEM;

    // 驗證用戶傳入的文件名長度是否超過 4KB 緩衝區
    path_len = strnlen_user(filename, PAGE_4K_SIZE);

    if (path_len <= 0) {
        kfree(path);
        return -EFAULT;
    } else if (path_len >= PAGE_4K_SIZE) {
        kfree(path);
        return -ENAMETOOLONG;
    }
    strncpy_from_user(filename, path, path_len);
    path[path_len] = '\0';

    dentry = path_walk(path, 0);

    kfree(path);

    if (dentry == NULL) {
        color_printk(BLUE, WHITE, "Can`t find file\n");
        return -ENOENT;
    }

    if (!!(flags & O_DIRECTORY) ^ (dentry->dir_inode->attribute == FS_ATTR_DIR)) {
        return flags & O_DIRECTORY ? -ENOTDIR : -EISDIR;   
    }

    filp = (struct file*)kmalloc(sizeof(*filp), 0);
    memset(filp, 0, sizeof(*filp));
    
    filp->dentry = dentry;
    filp->mode = flags;

    if (dentry->dir_inode->attribute & FS_ATTR_DEVICE)
        filp->f_ops = &keyboard_fops;
    else
        filp->f_ops = dentry->dir_inode->f_ops;
    // 如果文件有自定義的打開操作，則調用
    if (filp && filp->f_ops && filp->f_ops->open)
        error = filp->f_ops->open(dentry->dir_inode, filp);

    if (error != 1) {
        kfree(filp);
        return -EFAULT;
    }

    if (filp->mode & O_TRUNC) {
        filp->dentry->dir_inode->file_size = 0;
    }

    if (filp->mode & O_APPEND) {
        filp->position = filp->dentry->dir_inode->file_size;
    }

    f = current->file_struct;

    for (fd = 0; fd < TASK_FILE_MAX && f[fd]; fd++);

    if (fd == TASK_FILE_MAX) {
        kfree(filp);
        return -EMFILE;
    }
    f[fd] = filp;

    return fd;
}

unsigned long no_system_call(void)
{
    color_printk(RED, BLACK,"no_system_call is calling\n");
    return -ENOSYS; 
}

unsigned long sys_putstring(char *string)
{
    // color_printk(GREEN, BLACK,"sys_putstring\n");
    color_printk(ORANGE, WHITE, string);
    return 0;
}
