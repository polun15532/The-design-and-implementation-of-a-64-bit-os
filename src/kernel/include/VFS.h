#ifndef __VFS_H__
#define __VFS_H__

#include "lib.h"

struct Disk_Partition_Table_Entry {
    unsigned char flags;
    unsigned char start_head;
    unsigned short start_sector     :6,  // 0-5
                   start_cylinder   :10; // 6-15
    unsigned char type;
    unsigned char end_head;
    unsigned short end_sector       :6,  // 0-5
                   end_cylinder     :10; // 6-15
    unsigned int start_LBA;
    unsigned int sectors_limit;
}__attribute__((packed));

struct Disk_Partition_Table {
    unsigned char BS_Reserved[446];
    struct Disk_Partition_Table_Entry DPTE[4];
    unsigned short BS_TrailSig;
}__attribute__((packed));

struct super_block_operations;
struct index_node_operations;
struct dir_entry_operations;
struct file_operations;

struct file_system_type {
    char *name; // 文件系統的名稱
    int fs_flags;
    struct super_block *(*read_super_block)(struct Disk_Partition_Table_Entry *DPTE, void *buf); // 讀取並初始化超級塊
    struct file_system_type *next;
};

struct super_block {
    struct dir_entry *root; // 文件系統的根目錄項
    struct super_block_operations *sb_ops; // 超級塊操作方法集合
    void *private_sb_info; // 超級塊結構體，不同文件系統有不同定義所以使用(void*)指針
};

struct super_block *mount_fs(char *name, struct Disk_Partition_Table_Entry *DPTE, void *buf);
unsigned long register_file_system(struct file_system_type *fs);
unsigned long unregister_file_system(struct file_system_type *fs);

struct index_node {
    unsigned long file_size;
    unsigned long blocks;
    unsigned long attribute;

    struct super_block *sb;

    struct file_operations *f_ops;
    struct index_node_operations *inode_ops;

    void *private_index_info;
};

#define FS_ATTR_FILE    (1UL << 0)
#define FS_ATTR_DIR     (1UL << 1)
#define FS_ATTR_DEVICE  (1UL << 2)

struct dir_entry {
    char *name;
    int name_length;
    struct List child_node;
    struct List subdirs_list;

    struct index_node *dir_inode;
    struct dir_entry *parent;

    struct dir_entry_operations *dir_ops;
};

struct file {
    long position;
    unsigned long mode;
    
    struct dir_entry *dentry;
    struct file_operations *f_ops;

    void *private_data;
};

struct super_block_operations {
    void (*write_super_block)(struct super_block *sb);
    void (*put_super_block)(struct super_block *sb);

    void (*write_inode)(struct index_node *inode);
};

struct index_node_operations {
    long (*create)(struct index_node *inode, struct dir_entry *dentry, int mode);
    struct dir_entry *(*look_up)(struct index_node *parent_node, struct dir_entry *dst_dentry);
    long (*mkdir)(struct index_node *inode, struct dir_entry *dentry, int mode);
    long (*rmdir)(struct index_node *inode, struct dir_entry *dentry);
    long (*rename)(struct index_node *old_inode, struct dir_entry *old_dentry, struct index_node *new_inode, struct dir_entry *new_dentry);
    long (*getattr)(struct dir_entry *dentry, unsigned long *attr);
    long (*setattr)(struct dir_entry *dentry, unsigned long *attr);
};

struct dir_entry_operations {
    long (*compare)(struct dir_entry *parent_dentry, char *src_file_name, char *dest_file_name);
    long (*hash)(struct dir_entry *dentry, char *file_name);
    long (*release)(struct dir_entry *dentry);
    long (*iput)(struct dir_entry *dentry, struct index_node *inode);
};

typedef int (*filldir_t)(void *buf, char *name, long name_len, long type, long offset);

struct file_operations {
    long (*open)(struct index_node *inode, struct file *filp);
    long (*close)(struct index_node *inode, struct file *filp);
    long (*read)(struct file *filp, char *buf, unsigned long count, long *position);
    long (*write)(struct file *filp, char *buf, unsigned long count, long *position);
    long (*lseek)(struct file *filp, long offset, int origin);
    long (*ioctl)(struct index_node *inode, struct file *filp, unsigned long cmd, unsigned long arg);
    long (*readdir)(struct file *filp, void *dirent, filldir_t filler);
};

struct dir_entry *path_walk(char *name, unsigned long flags);
extern struct super_block *root_sb;
#endif