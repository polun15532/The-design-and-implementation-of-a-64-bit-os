#include "VFS.h"

struct file_system_type file_system = {"file_system", 0};

// 請注意文件系統格式其實並不多，這裡使用link list、double linked list、hash table沒甚麼差異，所以這裡採用最簡單的linked list
// 文件對應的結構是inode，比如可以用hash table來加速查找。
struct super_block *mount_fs(char *name, struct Disk_Partition_Table_Entry *DPTE, void *buf)
{
    struct file_system_type *p = NULL;
    for (p = &file_system; p; p = p->next) {
        if (!strcmp(p->name, name)) {
            return p->read_super_block(DPTE, buf);
        }
    }
    return NULL;
}

unsigned long register_file_system(struct file_system_type *fs)
{
    struct file_system_type *p = NULL;
    // 檢查fs是否存在於文件系統中
    for (p = &file_system; p->next; p = p->next) {
        if (!strcmp(fs->name, p->name))
            return 0;
    }

    fs->next = file_system.next;
    file_system.next = fs;

    return 1;
}

unsigned long unregister_file_system(struct file_system_type *fs)
{
    struct file_system_type *p = &file_system;

    for (; p->next; p = p->next) {
        if (p->next == fs) {
            p->next = p->next->next;
            fs->next = NULL;
            return 1;
        }
    }
    return 0;
}