#include "disk.h"
#include "interrupt.h"
#include "APIC.h"
#include "memory.h"
#include "printk.h"
#include "lib.h"
#include "block.h"
#include "semaphore.h"
#include "schedule.h"

static int disk_flags = 0;

struct request_queue disk_request;

struct block_device_operation IDE_device_operation;


void end_request(struct block_buffer_node *node)
{
    if (node == NULL)
        color_printk(RED, BLACK, "end_request error\n");
    node->wait_queue.tsk->state = TASK_RUNNING; // 喚醒任務 
    insert_task_queue(node->wait_queue.tsk);     
    current->flags |= NEED_SCHEDULE;
    kfree((unsigned long*)disk_request.in_using);
    disk_request.in_using = NULL;
    
    if(disk_request.block_request_count)
        cmd_out();
}

void add_request(struct block_buffer_node * node)
{
    list_add_to_before(&disk_request.wait_queue_list.wait_list,
                       &node->wait_queue.wait_list);
    disk_request.block_request_count++;
}

long cmd_out()
{
    wait_queue_t *wait_queue_tmp;
    wait_queue_tmp = container_of(list_next(&disk_request.wait_queue_list.wait_list),
                                  wait_queue_t,
                                  wait_list);
    struct block_buffer_node *node = container_of(wait_queue_tmp,
                                                  struct block_buffer_node,
                                                  wait_queue);
    disk_request.in_using = node;

    list_del(&disk_request.in_using->wait_queue.wait_list); // 從循環佇列中刪除
    disk_request.block_request_count--;

    while(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_BUSY)
        nop(); // 等待硬碟

    switch (node->cmd) {
        case ATA_WRITE_CMD:	
            io_out8(PORT_DISK1_DEVICE,0x40);

            io_out8(PORT_DISK1_ERR_FEATURE, 0);
            io_out8(PORT_DISK1_SECTOR_CNT, (node->count >> 8) & 0xff);
            io_out8(PORT_DISK1_SECTOR_LOW , (node->LBA >> 24) & 0xff);
            io_out8(PORT_DISK1_SECTOR_MID , (node->LBA >> 32) & 0xff);
            io_out8(PORT_DISK1_SECTOR_HIGH, (node->LBA >> 40) & 0xff);

            io_out8(PORT_DISK1_ERR_FEATURE, 0);
            io_out8(PORT_DISK1_SECTOR_CNT, node->count & 0xff);
            io_out8(PORT_DISK1_SECTOR_LOW, node->LBA & 0xff);
            io_out8(PORT_DISK1_SECTOR_MID, (node->LBA >> 8) & 0xff);
            io_out8(PORT_DISK1_SECTOR_HIGH, (node->LBA >> 16) & 0xff);

            while(!(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_READY))
                nop();
            io_out8(PORT_DISK1_STATUS_CMD, node->cmd); // 發送ATA命令

            while(!(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_REQ))
                nop();
            port_outsw(PORT_DISK1_DATA, node->buffer, 256); // 寫入緩衝區
            break;

        case ATA_READ_CMD:
            io_out8(PORT_DISK1_DEVICE,0x40);

            io_out8(PORT_DISK1_ERR_FEATURE, 0);
            io_out8(PORT_DISK1_SECTOR_CNT, (node->count >> 8) & 0xff);
            io_out8(PORT_DISK1_SECTOR_LOW , (node->LBA >> 24) & 0xff);
            io_out8(PORT_DISK1_SECTOR_MID , (node->LBA >> 32) & 0xff);
            io_out8(PORT_DISK1_SECTOR_HIGH, (node->LBA >> 40) & 0xff);

            io_out8(PORT_DISK1_ERR_FEATURE, 0);
            io_out8(PORT_DISK1_SECTOR_CNT, node->count & 0xff);
            io_out8(PORT_DISK1_SECTOR_LOW, node->LBA & 0xff);
            io_out8(PORT_DISK1_SECTOR_MID, (node->LBA >> 8) & 0xff);
            io_out8(PORT_DISK1_SECTOR_HIGH, (node->LBA >> 16) & 0xff);

            while(!(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_READY))
                nop();
            io_out8(PORT_DISK1_STATUS_CMD, node->cmd);
            break;
            
        case GET_IDENTIFY_DISK_CMD:

            io_out8(PORT_DISK1_DEVICE, 0xe0);

            while(!(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_READY))
                nop();
            io_out8(PORT_DISK1_STATUS_CMD, node->cmd);
            break;
        default:
            color_printk(BLACK, WHITE, "ATA CMD Error\n");
            break;
    }
    return 1;
}

void read_handler(unsigned long nr, unsigned long parameter)
{
    struct block_buffer_node *node = ((struct request_queue*)parameter)->in_using;
    
    // 判斷硬碟操作是否出錯。
    if(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_ERROR)
        color_printk(RED, BLACK, "read_handler:%#010x\n", io_in8(PORT_DISK1_ERR_FEATURE)); // 取得錯誤狀態
    else
        port_insw(PORT_DISK1_DATA, node->buffer, 256);  // 這裡寫256是因為insw指令每次處理2byte(w表示word)。
    
    node->count--;
    if (node->count) {
        node->buffer += 512;
        return;        
    }
    end_request(node);
}

void write_handler(unsigned long nr, unsigned long parameter)
{
    struct block_buffer_node *node = ((struct request_queue *)parameter)->in_using;

    if(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_ERROR)
        color_printk(RED, BLACK, "write_handler:%#010x\n", io_in8(PORT_DISK1_ERR_FEATURE));
    
    node->count--;
    if (node->count) {
        node->buffer += 512;
        while(!(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_REQ))
            nop();
        port_outsw(PORT_DISK1_DATA,node->buffer,256);
        return;
    }
    end_request(node);
}

void other_handler(unsigned long nr, unsigned long parameter)
{
    struct block_buffer_node *node = ((struct request_queue *)parameter)->in_using;

    if(io_in8(PORT_DISK1_STATUS_CMD) & DISK_STATUS_ERROR)
        color_printk(RED, BLACK, "other_handler:%#010x\n", io_in8(PORT_DISK1_ERR_FEATURE));
    else
        port_insw(PORT_DISK1_DATA, node->buffer, 256);
    end_request(node);
}

struct block_buffer_node *make_request(long cmd, unsigned long blocks, long count, unsigned char *buffer)
{
    struct block_buffer_node *node = (struct block_buffer_node*)kmalloc(sizeof(*node), 0);
    wait_queue_init(&node->wait_queue, current); // 為當前的行程製作請求包
    switch (cmd) {
        case ATA_READ_CMD:
            node->end_handler = read_handler;
            break;
        case ATA_WRITE_CMD:
            node->end_handler = write_handler;
            break;
        default:
            node->end_handler = other_handler; // 目前僅有硬碟設備信息讀取命令
            break;
    }
    node->cmd = cmd;
    node->LBA = blocks;
    node->count = count;
    node->buffer = buffer;
    return node;
}

void submit(struct block_buffer_node *node)
{	
    add_request(node);
    if(disk_request.in_using == NULL)
        cmd_out();
}

void wait_for_finish()
{
    current->state = TASK_INTERRUPTIBLE;
    schedule();
}

long IDE_open()
{
    // 目前無設置操作
    color_printk(BLACK ,WHITE, "DISK1 Opened\n");
    return 1;
}

long IDE_close()
{
    // 目前無設置操作
    color_printk(BLACK, WHITE, "DISK1 Closed\n");
    return 1;
}

long IDE_ioctl(long cmd, long arg)
{
    struct block_buffer_node *node = NULL;
    
    if (cmd == GET_IDENTIFY_DISK_CMD) {
        node = make_request(cmd, 0, 0, (unsigned char*)arg);
        submit(node);
        wait_for_finish();
        return 1;
    }
    return 0;
}


long IDE_transfer(long cmd, unsigned long blocks, long count, unsigned char *buffer)
{
    struct block_buffer_node *node = NULL;
  
    if(cmd == ATA_READ_CMD || cmd == ATA_WRITE_CMD) {
        // 僅硬碟讀寫命令才操作
        node = make_request(cmd, blocks, count, buffer); // 建立請求包
        submit(node); // 提交請求包
        wait_for_finish(); // 等待
    } else {
        return 0;
    }
    return 1;
}

struct block_device_operation IDE_device_operation = {
    .open = IDE_open,
    .close = IDE_close,
    .ioctl = IDE_ioctl,
    .transfer = IDE_transfer
};

hw_int_controller disk_int_controller = {
    .enable = IOAPIC_enable,
    .disable = IOAPIC_disable,
    .install = IOAPIC_install,
    .uninstall = IOAPIC_uninstall,
    .ack = IOAPIC_edge_ack
};


void disk_handler(unsigned long nr, unsigned long parameter, struct pt_regs *regs)
{
    struct block_buffer_node *node = ((struct request_queue *)parameter)->in_using;
    color_printk(BLACK, WHITE, "disk_handler\n");
    node->end_handler(nr, parameter);
}

void disk_init()
{
    struct IO_APIC_RET_entry entry;

    entry.vector = 0x2f;
    entry.deliver_mode = APIC_ICR_IOAPIC_Fixed ;
    entry.dest_mode = ICR_IOAPIC_DELV_PHYSICAL;
    entry.deliver_status = APIC_ICR_IOAPIC_Idle;
    entry.polarity = APIC_IOAPIC_POLARITY_HIGH;
    entry.irr = APIC_IOAPIC_IRR_RESET;
    entry.trigger = APIC_ICR_IOAPIC_Edge;
    entry.mask = APIC_ICR_IOAPIC_Masked;
    entry.reserved = 0;

    entry.destination.physical.reserved1 = 0;
    entry.destination.physical.phy_dest = 0;
    entry.destination.physical.reserved2 = 0;

    register_irq(0x2f, &entry, &disk_handler, (unsigned long)&disk_request, &disk_int_controller, "disk1"); // 註冊硬碟中斷
    // 向量號0x2e與0x2f都是硬碟的中斷，但對應不同的硬碟驅動器。

    io_out8(PORT_DISK1_ALT_STA_CTL, 0); // 啟用中斷。

    wait_queue_init(&disk_request.wait_queue_list, NULL);
    disk_request.in_using = NULL;
    disk_request.block_request_count = 0;
}

void disk_exit()
{
    unregister_irq(0x2f);
}
