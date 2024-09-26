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

unsigned long sys_brk(unsigned long brk)
{
    unsigned long new_brk = PAGE_2M_ALIGN(brk); // 每次修改 brk 以頁為單位
    
    color_printk(GREEN, BLACK, "sys_brk:%#018lx\n", brk);
    
    color_printk(RED,
                 BLACK,
                 "brk:%#018lx,new_brk:%#018lx,current->mm->end_brk:%#018lx\n",
                 brk,
                 new_brk,
                 current->mm->end_brk);

    if (new_brk == 0)
        return current->mm->start_brk; // 如果傳入的 brk 為 0 就不做任何更改。

    if (new_brk < current->mm->end_brk) // 目前尚不支援縮小 heap 空間的操作
        return 0;

    new_brk = do_brk(current->mm->end_brk, new_brk - current->mm->end_brk); // 擴展 heap 邊界

    current->mm->end_brk = new_brk;

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
    if (filds < 0 || filds >= TASK_FILE_MAX)
        return -EBADF;
    // 無效的訪問基地址
    if (whence < 0 || whence >= SEEK_MAX)
        return -EINVAL;

    filp = current->file_struct[filds];
    if (filp && filp->f_ops && filp->f_ops->lseek)
        ret = filp->f_ops->lseek(filp, offset, whence);
    return ret;
}

unsigned long sys_write(int fd,void * buf,long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    color_printk(GREEN, BLACK, "sys_write:%d\n", fd);
    if (fd < 0 || fd >= TASK_FILE_MAX)
        return -EBADF;
    if (count < 0)
        return -EINVAL;

    filp = current->file_struct[fd];
    if (filp && filp->f_ops && filp->f_ops->write)
        ret = filp->f_ops->write(filp, buf, count, &filp->position);
    return ret;
}


unsigned long sys_read(int fd, void *buf, long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    color_printk(GREEN, BLACK, "sys_read:%d\n", fd);
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
    if (fd < 0 || fd >= TASK_FILE_MAX)
        return -EBADF;

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
    int fd = 0;

    color_printk(GREEN, BLACK,"sys_open\n");
    
    path = (char*)kmalloc(PAGE_4K_SIZE, 0);
    if (path == NULL)
        return -ENOMEM;

    memset(path, 0, PAGE_4K_SIZE);

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
    dentry = path_walk(path, 0);

    kfree(path);

    if (dentry) {
         color_printk(BLUE,
                     WHITE,
                     "Find 89AIOlejk.TXT\nDIR_FirstCluster:%#018lx\tDIR_FileSize:%#018lx\n",
                     ((struct FAT32_inode_info*)(dentry->dir_inode->private_index_info))->first_cluster,
                     dentry->dir_inode->file_size);
    } else {
        color_printk(BLUE, WHITE, "Can`t find file\n");
        return -ENOENT;
    }

    if (dentry->dir_inode->attribute == FS_ATTR_DIR)
        return -EISDIR;
    filp = (struct file*)kmalloc(sizeof(*filp), 0);
    memset(filp, 0, sizeof(*filp));

    filp->dentry = dentry;
    filp->mode = flags;
    filp->f_ops = dentry->dir_inode->f_ops;

    // 如果文件有自定義的打開操作，則調用
    if (filp && filp->f_ops && filp->f_ops->open)
        error = filp->f_ops->open(dentry->dir_inode,filp);

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
    color_printk(GREEN, BLACK,"sys_putstring\n");
    color_printk(ORANGE, WHITE, string);
    return 0;
}
