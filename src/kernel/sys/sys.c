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
#define validate_fd(fd) !((fd) < 0 || (fd) >= TASK_FILE_MAX)

static inline long copy_string_from_user(const char *usr, char **buffer, unsigned long size)
{
    if (!usr || !buffer || size == 0) return -EINVAL;

    long length = strnlen_user(usr, size);
    if (length <= 0) return -EFAULT;

    if (length >= size) return -ENAMETOOLONG;

    *buffer = (char*)kmalloc(length + 1, 0);

    if (!*buffer) return -ENOMEM;

    strncpy_from_user(usr, *buffer, size);
    (*buffer)[length] = '\0';
    return 0;
}

static inline long get_dentry_from_user_path(const char *user_path, struct dir_entry **dentry)
{
    char *path = NULL;
    long error_code = copy_string_from_user(user_path, &path, PAGE_4K_SIZE);
    if (error_code) return error_code;

    *dentry = path_walk(path, 0);
    kfree(path);

    return *dentry == NULL ?  -ENOENT : 0;
}

static inline long alloc_fd(struct file **f_array)
{
    for (int fd = 0; fd < TASK_FILE_MAX; ++fd) {
        if (f_array[fd] == NULL)
            return fd;
    }
    return -EMFILE; // 沒有可用的檔案描述符
}

static inline struct file *create_file_struct(struct dir_entry *dentry, int flags) {
    struct file *filp = (struct file*)kmalloc(sizeof(*filp), 0);
    if (!filp) return NULL;

    *filp = (struct file){
        .dentry = dentry,
        .mode = flags,
        .f_ops = (dentry->dir_inode->attribute & FS_ATTR_DEVICE) ? &keyboard_fops : dentry->dir_inode->f_ops,
    };
    return filp;    
}

static inline long do_file_open(struct file *filp)
{
    if (filp->f_ops && filp->f_ops->open)
        return filp->f_ops->open(filp->dentry->dir_inode, filp) == 1 ? 0 : -EFAULT;
    return 0;
}

static inline void handle_truncate_append(struct file *filp) {
    if (filp->mode & O_TRUNC)
        filp->dentry->dir_inode->file_size = 0;
    if (filp->mode & O_APPEND)
        filp->position = filp->dentry->dir_inode->file_size;
}


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
    char *path = NULL;
    long path_len = 0;
    unsigned long error_code = 0;
    struct pt_regs *regs = (struct pt_regs*)current->thread->rsp0 - 1;
    color_printk(GREEN, BLACK, "sys_execve\n");

    error_code = copy_string_from_user((char*)regs->rsi, &path, PAGE_4K_SIZE);

    if (error_code) return error_code;

    error_code = do_execve(regs, path, (char**)regs->rsi, NULL);
    kfree(path);
    return error_code;
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

    if (!validate_fd(fd)) return -EBADF;
    // 非法檔案描述符

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
    struct dir_entry *dentry = NULL;
    unsigned long error_code;

    color_printk(GREEN, BLACK, "sys_chdir\n");
    error_code = get_dentry_from_user_path(filename, &dentry);
    
    if (error_code) return error_code;

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

unsigned long sys_lseek(int fd, long offset, int whence)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    color_printk(GREEN, BLACK, "sys_leek:%d\n", fd); // 打印檔案描述符

    // 無效的文件描述符
    if (!validate_fd(fd)) return -EBADF;
    // 無效的訪問基地址
    if (whence < 0 || whence >= SEEK_MAX) return -EINVAL;

    filp = current->file_struct[fd];
    if (filp && filp->f_ops && filp->f_ops->lseek)
        ret = filp->f_ops->lseek(filp, offset, whence);
    return ret;
}

unsigned long sys_write(int fd,void * buf,long count)
{
    struct file *filp = NULL;
    unsigned long ret = 0;

    color_printk(GREEN, BLACK, "sys_write:%d\n", fd);
    if (!validate_fd(fd)) return -EBADF;
    
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
    if (!validate_fd(fd)) return -EBADF;

    if (count < 0) return -EINVAL;

    filp = current->file_struct[fd];

    if (filp && filp->f_ops && filp->f_ops->read)
        ret = filp->f_ops->read(filp, buf, count, &filp->position);
    return ret;
}

unsigned long sys_close(int fd)
{
    struct file *filp = NULL;

    color_printk(GREEN, BLACK, "sys_close:%d\n",fd);

    if (!validate_fd(fd)) return -EBADF;

    filp = current->file_struct[fd]; // 從文件描述符找到目標文件

    if (filp && filp->f_ops && filp->f_ops->close)
        filp->f_ops->close(filp->dentry->dir_inode, filp);

    kfree(filp);
    current->file_struct[fd] = NULL; // 釋放文件描述符

    return 0;
}

unsigned long sys_open(char *filename, int flags)
{
    long error_code = 0;
    struct dir_entry *dentry = NULL;
    struct file *filp = NULL;
    struct file **f = current->file_struct;
    int fd = -1;

    error_code = get_dentry_from_user_path(filename, &dentry);
    
    if (error_code) return error_code;

    // 驗證是否為目錄或檔案型別與 flags 相符
    if (!!(flags & O_DIRECTORY) ^ (dentry->dir_inode->attribute == FS_ATTR_DIR))
        return flags & O_DIRECTORY ? -ENOTDIR : -EISDIR;   

    filp = create_file_struct(dentry, flags);
    if (!filp) return -ENOMEM;

    error_code = do_file_open(filp);

    if (error_code) {
        kfree(filp);
        return -EFAULT;
    }

    handle_truncate_append(filp);

    fd = alloc_fd(f);

    if (!validate_fd(fd)) {
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
