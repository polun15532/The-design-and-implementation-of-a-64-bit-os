#include "fat32.h"
#include "disk.h"
#include "printk.h"
#include "lib.h"


unsigned long FirstDataSector = 0;
unsigned long BytesPerClus = 0;
unsigned long FirstFAT1Sector = 0;
unsigned long FirstFAT2Sector = 0;

void DISK1_FAT32_FS_init()
{
    int i;
    struct Disk_Partition_Table DPT;
    struct FAT32_BootSector fat32_bootsector;
    struct FAT32_FSInfo fat32_fsinfo;
    unsigned char buf[512];

    memset(buf, 0, sizeof buf);
    IDE_device_operation.transfer(ATA_READ_CMD, 0, 1, buf);
    DPT = *(struct Disk_Partition_Table*) buf;
    color_printk(BLACK, WHITE, "DPTR[0] start_LBA:%#018lx\ttype:%#018lx\n", 
                 DPT.DPTE[0].start_LBA, DPT.DPTE[0].type);

    memset(buf, 0, sizeof buf);
    IDE_device_operation.transfer(ATA_READ_CMD, DPT.DPTE[0].start_LBA, 1, buf);
    fat32_bootsector = *(struct FAT32_BootSector*)buf;
    color_printk(BLUE, BLACK, "FAT32 Boot Sector\n\tBPB_FSInfo:%#018lx\n\tBPB_BkBootSec:%#018lx\n\tBPB_TotSec32:%#018lx\n",
                 fat32_bootsector.BPB_FSInfo, fat32_bootsector.BPB_BkBootSec, fat32_bootsector.BPB_TotSec32);
    
    memset(buf, 0, sizeof buf);

    IDE_device_operation.transfer(ATA_READ_CMD, DPT.DPTE[0].start_LBA + fat32_bootsector.BPB_FSInfo, 1,(unsigned char*)buf);
    fat32_fsinfo = *(struct FAT32_FSInfo*)buf;
    
    color_printk(BLUE, BLACK, "FAT32 FSInfo\n\tFSI_LeadSig:%lx\n\tFSI_StrucSig:%lx\n\tFSI_Free_Count:%lx\n",
                 fat32_fsinfo.FSI_LeadSig, fat32_fsinfo.FSI_StrucSig, fat32_fsinfo.FSI_Free_Count);
    
    
}