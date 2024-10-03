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

#include "fat32.h"
#include "VFS.h"
#include "disk.h"
#include "printk.h"
#include "lib.h"
#include "memory.h"
#include "errno.h"
#include "stdio.h"

unsigned int DISK1_FAT32_read_FAT_Entry(struct FAT32_sb_info *fsbi, unsigned int fat_entry)
{
    unsigned int buf[128];
    memset(buf, 0, sizeof buf);
    IDE_device_operation.transfer(ATA_READ_CMD,
                                  fsbi->FAT1_firstsector + (fat_entry >> 7),
                                  1,
                                  (unsigned char*)buf);
    // FAT表中一個扇區具有128個FAT表項，這裡右移7位可直接定位目標FAT表項的儲存扇區。

    return buf[fat_entry & 0x7f] & 0x0fffffff;
}

unsigned long DISK1_FAT32_write_FAT_Entry(struct FAT32_sb_info *fsbi, unsigned int fat_entry, unsigned int value)
{
    unsigned int buf[128];
    memset(buf, 0, sizeof(buf));

    IDE_device_operation.transfer(ATA_READ_CMD, 
                                  fsbi->FAT1_firstsector + (fat_entry >> 7),
                                  1, 
                                  (unsigned char *)buf);


    buf[fat_entry & 0x7f] = (buf[fat_entry & 0x7f] & 0xf0000000) | (value & 0x0fffffff);
    // value是往FAT表寫入的值，在FAT32僅低28位有效，這裡高4位僅為了保證數據儲存的一致性。
    IDE_device_operation.transfer(ATA_WRITE_CMD,
                                  fsbi->FAT1_firstsector + (fat_entry >> 7),
                                  1,
                                  (unsigned char *)buf);

    IDE_device_operation.transfer(ATA_WRITE_CMD,
                                  fsbi->FAT1_firstsector + (fat_entry >> 7),
                                  1,
                                  (unsigned char *)buf);
    return 1;	
}

long FAT32_readdir(struct file *filp, void *dirent, filldir_t filler)
{
    struct FAT32_inode_info *finode = filp->dentry->dir_inode->private_index_info;
    struct FAT32_sb_info *fsbi = filp->dentry->dir_inode->sb->private_sb_info;
    unsigned int cluster = finode->first_cluster;
    unsigned long sector = 0;
    unsigned char *buf = NULL;
    char *name = NULL;
    int name_len = 0;
    int i = 0, j = 0, x = 0, y = 0;
    struct FAT32_Directory *tmp_dentry = NULL;
    struct FAT32_LongDirectory *tmp_ldentry = NULL;    

    buf = kmalloc(fsbi->bytes_per_cluster, 0);
    cluster = finode->first_cluster;
    j = filp->position / fsbi->bytes_per_cluster;

    for (i = 0; i < j; i++) {
        cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster);
        if (cluster > 0x0ffffff7) {
            color_printk(RED, BLACK, "FAT32 FS(readdir) cluster didn`t exist\n");
            return NULL;
        }
    }
next_cluster:
    sector = fsbi->Data_firstsector + (cluster - 2) * fsbi->sector_per_cluster;
    if (!IDE_device_operation.transfer(ATA_READ_CMD, sector, fsbi->sector_per_cluster, buf)) {
        color_printk(RED, BLACK, "FAT32 FS(readdir) read disk ERROR!!!!!!!!!!\n");
        kfree(buf);
        return NULL;
    }
    tmp_dentry = (struct FAT32_Directory*)(buf + filp->position % fsbi->bytes_per_cluster);

    for (i = filp->position % fsbi->bytes_per_cluster; i < fsbi->bytes_per_cluster; i += 32, tmp_dentry++, filp->position += 32) {
        if (tmp_dentry->DIR_Attr == ATTR_LONG_NAME)
            continue;
        if (tmp_dentry->DIR_Name[0] == 0xe5 ||
           tmp_dentry->DIR_Name[0] == 0x00 ||
           tmp_dentry->DIR_Name[0] == 0x05)
            continue;

        name_len = 0;
        tmp_ldentry = (struct FAT32_LongDirectory *)tmp_dentry - 1;

        if (tmp_ldentry->LDIR_Attr == ATTR_LONG_NAME && 
           tmp_ldentry->LDIR_Ord != 0xe5 &&
           tmp_ldentry->LDIR_Ord != 0x00 && 
           tmp_ldentry->LDIR_Ord != 0x05) {
            j = 0;
            //long file/dir name read
            while (tmp_ldentry->LDIR_Attr == ATTR_LONG_NAME &&
                  tmp_ldentry->LDIR_Ord != 0xe5 &&
                  tmp_ldentry->LDIR_Ord != 0x00 &&
                  tmp_ldentry->LDIR_Ord != 0x05) {
                j++;
                if (tmp_ldentry->LDIR_Ord & 0x40)
                    break;
                tmp_ldentry--;
            }

            name = kmalloc(j * 13 + 1, 0);
            memset(name, 0, j * 13 + 1);
            tmp_ldentry = (struct FAT32_LongDirectory*)tmp_dentry - 1;

            for (x = 0; x < j; x++, tmp_ldentry--) {
                for (y = 0; y < 5; y++)
                    if (tmp_ldentry->LDIR_Name1[y] != 0xffff &&
                       tmp_ldentry->LDIR_Name1[y] != 0x0000)
                        name[name_len++] = (char)tmp_ldentry->LDIR_Name1[y];

                for (y = 0;y < 6; y++)
                    if (tmp_ldentry->LDIR_Name2[y] != 0xffff &&
                       tmp_ldentry->LDIR_Name1[y] != 0x0000)
                        name[name_len++] = (char)tmp_ldentry->LDIR_Name2[y];

                for (y = 0; y < 2; y++)
                    if (tmp_ldentry->LDIR_Name3[y] != 0xffff &&
                       tmp_ldentry->LDIR_Name1[y] != 0x0000)
                        name[name_len++] = (char)tmp_ldentry->LDIR_Name3[y];
            }
            goto find_lookup_success;
        }

        name = kmalloc(15, 0);
        memset(name, 0, 15);
        //short file/dir base name compare
        for (x = 0; x < 8; x++) {
            if (tmp_dentry->DIR_Name[x] == ' ')
                break;
            if (tmp_dentry->DIR_NTRes & LOWERCASE_BASE)
                name[name_len++] = tmp_dentry->DIR_Name[x] + 32;
            else
                name[name_len++] = tmp_dentry->DIR_Name[x];
        }

        if (tmp_dentry->DIR_Attr & ATTR_DIRECTORY)
            goto find_lookup_success;

        name[name_len++] = '.';

        //short file ext name compare
        for (x = 8; x < 11; x++) {
            if (tmp_dentry->DIR_Name[x] == ' ')
                break;
            if (tmp_dentry->DIR_NTRes & LOWERCASE_EXT)
                name[name_len++] = tmp_dentry->DIR_Name[x] + 32;
            else
                name[name_len++] = tmp_dentry->DIR_Name[x];
        }
        if (x == 8)
            name[--name_len] = 0;
        goto find_lookup_success;
    }
    
    cluster = DISK1_FAT32_read_FAT_Entry(fsbi,cluster);
    if (cluster < 0x0ffffff7)
        goto next_cluster;

    kfree(buf);
    return NULL;

find_lookup_success:

    filp->position += 32;
    return filler(dirent, name, name_len, 0, 0);
}

long FAT32_open(struct index_node *inode, struct file *filp)
{
    return 1;
}

long FAT32_close(struct index_node *inode, struct file *filp)
{
    return 1;
}

long FAT32_read(struct file *filp, char *buf, unsigned long count, long *position)
{
    
    struct FAT32_inode_info *finode = filp->dentry->dir_inode->private_index_info;
    struct FAT32_sb_info *fsbi = filp->dentry->dir_inode->sb->private_sb_info;
    unsigned long cluster = finode->first_cluster; // 文件的起始叢集號
    unsigned long sector = 0;
    int i, length = 0;
    long retval = 0;  // 返回值，記錄成功讀取的數據量或錯誤代碼

    // 計算當前讀取的位置的叢集號（index）和偏移量（offset）
    int index = *position / fsbi->bytes_per_cluster;
    long offset = *position % fsbi->bytes_per_cluster;

    // 如果文件的起始簇為 0，返回錯誤，這表示文件無效
    if (!cluster)
        return -EFAULT;
    char *buffer = (char *)kmalloc(fsbi->bytes_per_cluster, 0);

    for (i = 0; i < index; i++)
        cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster);

    // 如果當前讀取位置超過了文件大小，調整讀取範圍。
    if (*position + count > filp->dentry->dir_inode->file_size)
        count = filp->dentry->dir_inode->file_size - *position;
    
    index = count;

    color_printk(GREEN,
                 BLACK,
                 "FAT32_read first_cluster:%d,size:%d,preempt_count:%d\n",
                 finode->first_cluster,
                 filp->dentry->dir_inode->file_size,
                 current->preempt_count);

    for (; index && cluster; cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster)) {

        memset(buffer, 0, fsbi->bytes_per_cluster);

        // 計算扇區號
        sector = fsbi->Data_firstsector + (cluster - 2) * fsbi->sector_per_cluster;
        
        if (!IDE_device_operation.transfer(ATA_READ_CMD, sector, fsbi->sector_per_cluster, (unsigned char*)buffer)) {
            color_printk(RED, BLACK, "FAT32 FS(read) read disk ERROR!!!!!!!!!!\n");
            retval = -EIO;
            break;
        }

        length = index <= fsbi->bytes_per_cluster - offset ? index : fsbi->bytes_per_cluster - offset;

        if ((unsigned long)buf < TASK_SIZE)
            copy_to_user(buffer + offset, buf, length);
        else
            memcpy(buffer + offset, buf, length);

        index -= length;
        buf += length;
    
        offset = 0; // 只有第一次操作需要考慮偏移量
        *position += length;
    }

    kfree(buffer);
    if (!index)
        retval = count;
    return retval;
}

unsigned int FAT32_find_available_cluster(struct FAT32_sb_info *fsbi)
{
    int i,j;
    int fat_entry;
    unsigned long sector_per_fat = fsbi->sector_per_FAT;
    unsigned int buf[128]; // 一個扇區有 128 個 FAT 表項

    for (i = 0;i < sector_per_fat;i++) {
        // 遍例 FAT 表所有叢集直至找到空閒叢集

        memset(buf, 0, 512);
        IDE_device_operation.transfer(ATA_READ_CMD, fsbi->FAT1_firstsector + i, 1, (unsigned char*)buf);

        for (j = 0;j < 128; ++j) {
            if ((buf[j] & 0x0fffffff) == 0)
                return (i << 7) + j;
        }
    }
    return 0;
}

long FAT32_write(struct file *filp, char *buf, unsigned long count, long *position)
{
    struct FAT32_inode_info *finode = filp->dentry->dir_inode->private_index_info;
    struct FAT32_sb_info *fsbi = filp->dentry->dir_inode->sb->private_sb_info;

    unsigned long cluster = finode->first_cluster;
    unsigned long next_cluster = 0;
    unsigned long sector = 0;
    int i, length = 0;
    long retval = 0;
    long flags = 0;
    int index = *position / fsbi->bytes_per_cluster;
    long offset = *position % fsbi->bytes_per_cluster;
    char *buffer = (char*)kmalloc(fsbi->bytes_per_cluster, 0);

    if (cluster == 0) {
        // 這是空文件的狀況
        cluster = FAT32_find_available_cluster(fsbi); // 查找可用的叢集
        flags = 1;
    } else {
        for (i = 0; i < index; i++)
            cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster);
    }

    if (cluster == NULL) {
        kfree(buffer);
        return -ENOSPC;
    }

    if (flags) {
        finode->first_cluster = cluster;
        filp->dentry->dir_inode->sb->sb_ops->write_inode(filp->dentry->dir_inode);
        DISK1_FAT32_write_FAT_Entry(fsbi, cluster, 0x0ffffff8);
        // 標記為文件結束叢集
    }

    index = count; // 剩餘寫入資料量

    for (; index;) {
        if (!flags) {
            memset(buffer, 0, fsbi->bytes_per_cluster);
            sector = fsbi->Data_firstsector + (cluster - 2) * fsbi->sector_per_cluster;
            if (!IDE_device_operation.transfer(ATA_READ_CMD, sector, fsbi->sector_per_cluster, (unsigned char*)buffer)) {
                color_printk(RED, BLACK, "FAT32 FS(write) read disk ERROR!!!!!!!!!!\n");
                retval = -EIO;
                break;
            }
        }

        length = index <= fsbi->bytes_per_cluster - offset ? index : fsbi->bytes_per_cluster - offset;

        if ((unsigned long)buf < TASK_SIZE)
            copy_from_user(buf, buffer + offset, length);
        else
            memcpy(buf, buffer + offset, length);

        if (!IDE_device_operation.transfer(ATA_WRITE_CMD, sector, fsbi->sector_per_cluster, (unsigned char*)buffer)) {
            color_printk(RED, BLACK, "FAT32 FS(write) write disk ERROR!!!!!!!!!!\n");
            retval = -EIO;
            break;
        }

        index -= length;
        buf += length;
        offset = 0;
        *position += length;

        if (index == NULL)
            break;

        next_cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster);

        if (next_cluster >= 0x0ffffff8) {
            next_cluster = FAT32_find_available_cluster(fsbi);
            if (next_cluster == NULL) {
                kfree(buffer);
                return -ENOSPC;
            }			

            DISK1_FAT32_write_FAT_Entry(fsbi, cluster, next_cluster);
            DISK1_FAT32_write_FAT_Entry(fsbi, next_cluster, 0x0ffffff8);
            cluster = next_cluster;
            flags = 1;
        }
    }


    if (*position > filp->dentry->dir_inode->file_size) {
        filp->dentry->dir_inode->file_size = *position;
        filp->dentry->dir_inode->sb->sb_ops->write_inode(filp->dentry->dir_inode);
    }

    kfree(buffer);
    if (!index)
        retval = count;
    return retval;
}

long FAT32_lseek(struct file *filp, long offset, int origin)
{
    long pos = 0;

    switch (origin) {
        case SEEK_SET:
            pos = offset;  // 從文件的起始位置進行偏移
            break;

        case SEEK_CUR:
            pos = filp->position + offset;  // 從當前文件指針位置進行偏移
            break;

        case SEEK_END:
            pos = filp->dentry->dir_inode->file_size + offset;  // 從文件末尾進行偏移
            break;

        default:
            return -EINVAL;  // origin 無效
            break;        
    }

    // 檢查文件指針位置是否合法，不可超出文件大小或為負數
    if (pos < 0 || pos > filp->dentry->dir_inode->file_size)
        return -EOVERFLOW;

    filp->position = pos;

    color_printk(GREEN, BLACK, "FAT32 FS(lseek) alert position:%d\n", filp->position);

    return pos;
}


long FAT32_ioctl(struct index_node *inode, struct file *filp, unsigned long cmd, unsigned long arg)
{
    return 0;
}

struct file_operations FAT32_file_ops = {
    .open = FAT32_open,
    .close = FAT32_close,
    .read = FAT32_read,
    .write = FAT32_write,
    .lseek = FAT32_lseek,
    .ioctl = FAT32_ioctl,
    .readdir = FAT32_readdir
};

long FAT32_create(struct index_node *inode, struct dir_entry *dentry, int mode)
{
    return 0;
}


struct dir_entry *FAT32_look_up(struct index_node *parent_inode, struct dir_entry *dst_dentry)
{
    struct FAT32_inode_info *finode = parent_inode->private_index_info;
    struct FAT32_sb_info *fsbi = parent_inode->sb->private_sb_info;

    unsigned long cluster = 0;
    unsigned long sector = 0;
    unsigned char *buf = NULL;

    int i, j, x;
    char tmp; // 匹配短目錄項用的字元。

    struct FAT32_Directory *tmp_dentry = NULL; // 短目錄項
    struct FAT32_LongDirectory *tmpl_dentry = NULL; // 長目錄項。
    struct index_node *p = NULL; 

    buf = (unsigned char*)kmalloc(fsbi->bytes_per_cluster, 0);  

    cluster = finode->first_cluster;

next_cluster:

    sector = fsbi->Data_firstsector + (cluster - 2) * fsbi->sector_per_cluster; // 前兩個FAT表的叢集編號不用計入。

    if (!IDE_device_operation.transfer(ATA_READ_CMD,
                                      sector,
                                      fsbi->sector_per_cluster,
                                      buf)) {
        color_printk(RED, BLACK, "FAT32 FS (lookup) read disk ERROR!!!!!\n");
        kfree(buf);
        return NULL;        
    }

    tmp_dentry = (struct FAT32_Directory*)buf;

    // 一個目錄項佔據32byte。
    for (i = 0; i < fsbi->bytes_per_cluster; i += 32, tmp_dentry++) {
        if (tmp_dentry->DIR_Attr == ATTR_LONG_NAME ||
            tmp_dentry->DIR_Name[0] == 0xe5 ||
            tmp_dentry->DIR_Name[0] == 0x00 ||
            tmp_dentry->DIR_Name[0] == 0x05)
            continue;
        // 跳過長目錄項與空閒目錄項。
        // 0x05實際上是對應KANJI字元集的特例，由於0xe5在KANJI中是有效字所以使用0x05代替0xe5表示空閒目錄項。
    
        tmpl_dentry = (struct FAT32_LongDirectory*)tmp_dentry - 1; // FAT32中對應文件名的目錄項是以逆序儲存的。
        j = 0;
    
        while (tmpl_dentry->LDIR_Attr == ATTR_LONG_NAME && tmpl_dentry->LDIR_Ord != 0xe5) {

            // 長目錄項將文件名拆成3部分，分別對應5個字符、6個字符、2個字符，並且每一部分都以Unicode編碼(2byte)。
            for (x = 0; x < 5; x++) {
                if (j > dst_dentry->name_length && tmpl_dentry->LDIR_Name1[x] == 0xffff)
                    continue;
                else if (j > dst_dentry->name_length ||
                         tmpl_dentry->LDIR_Name1[x] != (unsigned short)dst_dentry->name[j++])
                    goto continue_cmp_fail;
            }

            for (x = 0; x < 6; x++) {
                if (j > dst_dentry->name_length && tmpl_dentry->LDIR_Name2[x] == 0xffff)
                    continue;
                else if (j > dst_dentry->name_length ||
                         tmpl_dentry->LDIR_Name2[x] != (unsigned short)dst_dentry->name[j++])
                    goto continue_cmp_fail;                
            }

            for (x = 0; x < 2; x++) {
                if (j > dst_dentry->name_length && tmpl_dentry->LDIR_Name3[x] == 0xffff)
                    continue;
                else if (j > dst_dentry->name_length ||
                         tmpl_dentry->LDIR_Name3[x] != (unsigned short)dst_dentry->name[j++])
                    goto continue_cmp_fail;                 
            }

            if (j >= dst_dentry->name_length)
              goto find_lookup_success;

            tmpl_dentry--; // 匹配下一個長目錄項。
        }

        j = 0;
        //  匹配短目錄項的基礎名(前8byte)。
        for (x = 0; x < 8; x++) {
            tmp = tmp_dentry->DIR_Name[x];
            switch (tmp) {
                case ' ':
                    // 考慮是目錄的狀況
                    if (!(tmp_dentry->DIR_Attr & ATTR_DIRECTORY)) {
                        if (dst_dentry->name[j] == '.') {
                            continue; 
                        } else if (tmp == dst_dentry->name[j]) {
                            j++;
                            break;
                        } else {
                            goto continue_cmp_fail;
                        }
                    } else {
                        if (j < dst_dentry->name_length && tmp == dst_dentry->name[j]) {
                            j++;
                            break;
                        } else if (j == dst_dentry->name_length) {
                            continue;
                        } else {
                            goto continue_cmp_fail;                            
                        }
                    }

                case 'A' ... 'Z':
                case 'a' ... 'z':
                    // 目前的作業系統只支援ASCII編碼
                    // FAT32使用DIR_NTRes來標示短目錄項的大小寫。(短目錄項一律儲存大寫字母)
                    tmp ^= tmp_dentry->DIR_NTRes & LOWERCASE_BASE ? 1 << 5 : 0;

                    if (j < dst_dentry->name_length && (tmp != dst_dentry->name[j]))
                        goto continue_cmp_fail;
                    j++;
                    break;
                
                case '0' ... '9':
                    if (j < dst_dentry->name_length && (tmp != dst_dentry->name[j]))
                        goto continue_cmp_fail;
                    j++;
                    break;

                default:
                    j++;
                    break;
                // 如果基礎名小於8個字符剩下會使用空格代替。
            }
        }
        //  匹配短目錄項的擴展名(後3byte)。
        if (!(tmp_dentry->DIR_Attr & ATTR_DIRECTORY)) {
            j++;
            for (x = 8; x < 11; x++) {
                tmp = tmp_dentry->DIR_Name[x];
                switch (tmp) {
                    case 'A' ... 'Z':
                    case 'a' ... 'z':
                        tmp ^= tmp_dentry->DIR_NTRes & LOWERCASE_EXT ? 1 << 5 : 0;
                        if (j < dst_dentry->name_length && (tmp != dst_dentry->name[j]))
                            goto continue_cmp_fail;
                        j++;
                        break;
                    
                    case '0' ... '9':
                        if (j < dst_dentry->name_length && (tmp != dst_dentry->name[j]))
                            goto continue_cmp_fail;
                        j++;
                        break;

                    case ' ':
                        if (j < dst_dentry->name_length && (tmp != dst_dentry->name[j]))
                            goto continue_cmp_fail;
                        j++;
                        break;                        
                    default:
                        goto continue_cmp_fail;
                }                
            }
        }
        goto find_lookup_success;
continue_cmp_fail:;
    }

    cluster = DISK1_FAT32_read_FAT_Entry(fsbi, cluster);
    if (cluster < 0x0ffffff7)
        goto next_cluster;

    kfree(buf);
    return NULL;

find_lookup_success:

    p = (struct index_node*)kmalloc(sizeof(*p), 0);
    memset(p, 0, sizeof(*p));
    p->file_size = tmp_dentry->DIR_FileSize;
    p->blocks = (p->file_size + fsbi->bytes_per_cluster - 1) / fsbi->bytes_per_cluster;
    p->attribute = tmp_dentry->DIR_Attr & ATTR_DIRECTORY ? FS_ATTR_DIR : FS_ATTR_FILE;
    p->sb = parent_inode->sb;
    p->f_ops = &FAT32_file_ops;
    p->inode_ops = &FAT32_inode_ops;

    p->private_index_info = (struct FAT32_inode_info*)kmalloc(sizeof(struct FAT32_inode_info), 0);
    memset(p->private_index_info, 0, sizeof(struct FAT32_inode_info));
    finode = p->private_index_info;
    finode->first_cluster = (tmp_dentry->DIR_FstClusLO | (tmp_dentry->DIR_FstClusHI << 16)) & 0x0fffffff;
    finode->dentry_location = cluster;
    finode->dentry_position = tmp_dentry - (struct FAT32_Directory*)buf;
    finode->create_date = tmp_dentry->DIR_CrtTime;
    finode->create_time = tmp_dentry->DIR_CrtDate;
    finode->write_date = tmp_dentry->DIR_WrtTime;
    finode->write_time = tmp_dentry->DIR_WrtDate;

    if (!strncmp((unsigned char*)tmp_dentry->DIR_Name + 8, "DEV", 3))
        p->attribute |= FS_ATTR_DEVICE;
    dst_dentry->dir_inode = p;
    kfree(buf);
    return dst_dentry;
}

long FAT32_mkdir(struct index_node *inode, struct dir_entry *dentry, int mode)
{
    return 0;
}


long FAT32_rmdir(struct index_node *inode, struct dir_entry *dentry)
{
    return 0;
}

long FAT32_rename(struct index_node *old_inode,
                 struct dir_entry *old_dentry,
                 struct index_node *new_inode,
                 struct dir_entry *new_dentry)
{

}

long FAT32_getattr(struct dir_entry *dentry, unsigned long *attr)
{
    return 0;
}

long FAT32_setattr(struct dir_entry *dentry, unsigned long *attr)
{
    return 0;
}

struct index_node_operations FAT32_inode_ops = {
    .create = FAT32_create,
    .look_up = FAT32_look_up,
    .mkdir = FAT32_mkdir,
    .rmdir = FAT32_rmdir,
    .rename = FAT32_rename,
    .getattr = FAT32_getattr,
    .setattr = FAT32_setattr,
};

// these operation need cache and list
long FAT32_compare(struct dir_entry * parent_dentry,
                   char * source_filename,
                   char * destination_filename)
{
    return 0;
}

long FAT32_hash(struct dir_entry *dentry, char *filename)
{
    return 0;
}

long FAT32_release(struct dir_entry *dentry)
{
    return 0;
}

long FAT32_iput(struct dir_entry *dentry,struct index_node *inode)
{
    return 0;
}

struct dir_entry_operations FAT32_dentry_ops = {
    .compare = FAT32_compare,
    .hash = FAT32_hash,
    .release = FAT32_release,
    .iput = FAT32_iput,
};

void fat32_write_super_block(struct super_block *sb)
{

}

void fat32_put_super_block(struct super_block *sb)
{
    kfree(sb->private_sb_info);
    kfree(sb->root->dir_inode->private_index_info);
    kfree(sb->root->dir_inode);
    kfree(sb->root);
    kfree(sb);
}

void fat32_write_inode(struct index_node *inode)
{
    struct FAT32_Directory *fdentry = NULL;
    struct FAT32_Directory *buf = NULL;
    struct FAT32_inode_info *finode = inode->private_index_info;
    struct FAT32_sb_info *fsbi = inode->sb->private_sb_info;
    unsigned long sector = 0;

    // 檢查是否是根目錄，根目錄不可寫入
    if (finode->dentry_location == NULL) {
        color_printk(RED, BLACK, "FS ERROR:write root inode!\n");	
        return;     
    }

    // 計算目錄項所在的扇區
    sector = fsbi->Data_firstsector + (finode->dentry_location - 2) * fsbi->sector_per_cluster;

    // 讀取目錄叢集的內容到緩衝區
    buf = (struct FAT32_Directory*)kmalloc(fsbi->bytes_per_cluster, 0);
    memset(buf, 0, fsbi->bytes_per_cluster);
    IDE_device_operation.transfer(ATA_READ_CMD, 
                                  sector,fsbi->sector_per_cluster,
                                  (unsigned char*)buf);
    // 定位要更新的目錄項
    fdentry = buf + finode->dentry_position;
    // 更新目錄項的文件大小和起始簇號
    fdentry->DIR_FileSize = inode->file_size;
    fdentry->DIR_FstClusLO = finode->first_cluster & 0xffff;
    fdentry->DIR_FstClusHI = (fdentry->DIR_FstClusHI & 0xf000) |
                             (finode->first_cluster >> 16);
    // 將更新後的內容寫回硬碟
    IDE_device_operation.transfer(ATA_WRITE_CMD, sector, fsbi->sector_per_cluster, (unsigned char*)buf);
    kfree(buf);
}

struct super_block_operations FAT32_sb_ops = {
    .write_super_block = fat32_write_super_block,
    .put_super_block = fat32_put_super_block,
    .write_inode = fat32_write_inode
};

struct super_block *fat32_read_super_block(struct Disk_Partition_Table_Entry *DPTE, void *buf)
{

    struct super_block *sbp = NULL;
    struct FAT32_inode_info *finode = NULL;
    struct FAT32_BootSector *fbs = NULL;
    struct FAT32_sb_info *fsbi = NULL;
    struct dir_entry *root = NULL;
    struct index_node *dir_inode = NULL;

    // super block
    sbp = (struct super_block*)kmalloc(sizeof(*sbp), 0); 
    memset(sbp, 0, sizeof(*sbp));

    sbp->sb_ops = &FAT32_sb_ops;
    sbp->private_sb_info = (struct FAT32_sb_info*)kmalloc(sizeof(struct FAT32_sb_info), 0);
    memset(sbp->private_sb_info, 0, sizeof(struct FAT32_sb_info));

    // FAT32 boot sector 
    fbs = (struct FAT32_BootSector*)buf; // 將FAT32文件系統的引導扇區傳遞給fbs
    fsbi = sbp->private_sb_info;
    fsbi->start_sector = DPTE->start_LBA;
    fsbi->sector_count = DPTE->sectors_limit;
    fsbi->sector_per_cluster = fbs->BPB_SecPerClus;
    fsbi->bytes_per_cluster = fbs->BPB_SecPerClus * fbs->BPB_BytesPerSec;
    fsbi->bytes_per_sector = fbs->BPB_BytesPerSec;
    fsbi->Data_firstsector = DPTE->start_LBA + fbs->BPB_RsvdSecCnt + fbs->BPB_FATSz32 * fbs->BPB_NumFATs;
    fsbi->FAT1_firstsector = DPTE->start_LBA + fbs->BPB_RsvdSecCnt;
    fsbi->sector_per_FAT = fbs->BPB_FATSz32;
    fsbi->NumFATs = fbs->BPB_NumFATs;
    fsbi->fsinfo_sector_infat = fbs->BPB_FSInfo;
    fsbi->bootsector_bk_infat = fbs->BPB_BkBootSec;	

    color_printk(BLUE, 
                 WHITE,
                 "FAT32 Boot Sector\n\tBPB_FSInfo:%lx\n\tBPB_BkBootSec:%lx\n\tBPB_TotSec32:%lx\n",
                 fbs->BPB_FSInfo,
                 fbs->BPB_BkBootSec,
                 fbs->BPB_TotSec32);
    // FAT32 fsinfo sector
    fsbi->fat_fsinfo = (struct FAT32_FSInfo*)kmalloc(sizeof(*fsbi->fat_fsinfo), 0);
    memset(fsbi->fat_fsinfo, 0, sizeof(*fsbi->fat_fsinfo));
    IDE_device_operation.transfer(ATA_READ_CMD,
                                  DPTE->start_LBA + fbs->BPB_FSInfo,
                                  1,
                                  (unsigned char*)fsbi->fat_fsinfo);
    color_printk(BLUE,
                 WHITE,
                 "FAT32 FSInfo\n\tFSI_LeadSig:%lx\n\tFSI_StrucSig:%lx\n\tFSI_Free_Count:%lx\n",
                 fsbi->fat_fsinfo->FSI_LeadSig,
                 fsbi->fat_fsinfo->FSI_StrucSig,
                 fsbi->fat_fsinfo->FSI_Free_Count);
    // directory entry

    sbp->root = (struct dir_entry*)kmalloc(sizeof(*sbp->root), 0);
    memset(sbp->root, 0, sizeof(*sbp->root));

    list_init(&sbp->root->child_node);
    list_init(&sbp->root->subdirs_list);
    
    root = sbp->root;

    root->parent = sbp->root;
    root->dir_ops = &FAT32_dentry_ops;
    root->name = (char*)kmalloc(2, 0);
    root->name[0] = '/';
    root->name[1] = '\0';
    root->name_length = 1;
    
    // index node
    root->dir_inode = (struct index_node*)kmalloc(sizeof(*root->dir_inode), 0);
    dir_inode = root->dir_inode;

    memset(dir_inode, 0, sizeof(*dir_inode));
    dir_inode->inode_ops = &FAT32_inode_ops;
    dir_inode->f_ops = &FAT32_file_ops;
    dir_inode->file_size = 0;
    dir_inode->blocks = (dir_inode->file_size + fsbi->bytes_per_cluster - 1) / fsbi->bytes_per_sector;
    dir_inode->attribute = FS_ATTR_DIR;
    dir_inode->sb = sbp;

    // FAT32 root node
    dir_inode->private_index_info = (struct FAT32_inode_info*)kmalloc(sizeof(struct FAT32_inode_info), 0);
    memset(dir_inode->private_index_info, 0, sizeof(struct FAT32_inode_info));
    finode = (struct FAT32_inode_info *)dir_inode->private_index_info;
    finode->first_cluster = fbs->BPB_RootClus;
    finode->dentry_location = 0;
    finode->dentry_position = 0; 
    finode->create_date = 0;
    finode->create_time = 0;
    finode->write_date = 0;
    finode->write_time = 0;

    return sbp;
}

struct file_system_type FAT32_fs_type = {
    .name = "FAT32",
    .fs_flags = 0,
    .read_super_block = fat32_read_super_block,
    .next = NULL
};

void DISK1_FAT32_FS_init()
{
    
    int i;
    unsigned char buf[512];
    struct dir_entry *dentry = NULL;
    struct Disk_Partition_Table DPT = {0};

    register_file_system(&FAT32_fs_type); // 註冊fat32文件系統

    memset(buf, 0, sizeof(buf));

    IDE_device_operation.transfer(ATA_READ_CMD, 0, 1, buf); // 讀取MBR
    
    DPT = *(struct Disk_Partition_Table*)buf;
    color_printk(BLACK,
                 WHITE,
                 "DPTR[0] start_LBA:%#018lx\ttype:%#018lx\n", 
                 DPT.DPTE[0].start_LBA,
                 DPT.DPTE[0].type);
    memset(buf, 0, sizeof(buf));
    // 根據分區表讀取FAT32文件的起始扇區。
    IDE_device_operation.transfer(ATA_READ_CMD, DPT.DPTE[0].start_LBA, 1, buf); // 讀取FAT32文件系統的超級塊。
    
    root_sb = mount_fs("FAT32", &DPT.DPTE[0], buf); // 初始化FAT32文件系統的超級塊信息與根目錄項。
 
}