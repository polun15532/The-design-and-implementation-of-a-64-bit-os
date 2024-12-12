#include "VFS.h"
#include "printk.h"

struct file_system_type file_system = {"file_system", 0};
struct super_block *root_sb = NULL;

struct dir_entry *path_walk(char *name, unsigned long flags)
{
    char *tmp_name = NULL;
    int tmp_name_len = 0;
    struct dir_entry *parent = root_sb->root;
    struct dir_entry *path = NULL;

    while (*name == '/')
        name++;

    if (*name == '\0')
        return parent; // 回傳根目錄
        

    for (;;) {
        tmp_name = name;
        while (*name && (*name!= '/'))
            name++;
        // 這是雙指針，name為一個文件名或目錄名的左端點，tmp_name為右端點。
        tmp_name_len = name - tmp_name; // 文件名長度。
        path = (struct dir_entry*)kmalloc(sizeof(*path), 0);
        memset(path, 0, sizeof(*path));

        path->name = (char*)kmalloc(tmp_name_len + 1, 0);
        memset(path->name, 0, tmp_name_len + 1);
        
        memcpy(tmp_name, path->name, tmp_name_len);

        path->name_length = tmp_name_len;
        // 查找文件
        if (parent->dir_inode->inode_ops->look_up(parent->dir_inode, path) == NULL) {
            color_printk(RED, WHITE, "can not find file or dir:%s\n", path->name);
            kfree(path->name);
            kfree(path);
            return NULL;            
        }

        list_init(&path->child_node);
        list_init(&path->subdirs_list);
        path->parent = parent;
        list_add_to_behind(&parent->subdirs_list, &path->child_node);

        if (!*name)
            goto last_component; // 找到目標文件。
        while (*name == '/')
            name++;
        if (!*name)
            goto last_slash;
        
        parent = path; // 如果不是目標文件，繼續往下找。
    }

last_slash:
last_component:

    return flags & 1 ? parent : path;
}

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