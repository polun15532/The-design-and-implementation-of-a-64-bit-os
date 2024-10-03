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

#include "keyboard.h"
#include "lib.h"
#include "interrupt.h"
#include "APIC.h"
#include "memory.h"
#include "printk.h"
#include "VFS.h"
#include "waitqueue.h"

struct keyboard_inputbuffer *p_kb = NULL;
wait_queue_t keyboard_wait_queue;

void keyboard_handler(unsigned long nr, unsigned long parameter, struct pt_regs *regs)
{
    unsigned char x;
    x = io_in8(0x60); // 讀取鍵盤掃描碼
    // color_printk(WHITE, BLACK, "(K:%02x)", x); // 打印讀取到的掃描碼

    if (p_kb->p_head == p_kb->buf + KB_BUF_SIZE)
        p_kb->p_head = p_kb->buf; // 到緩衝區尾部回到起始位置

    *p_kb->p_head = x;
    p_kb->count++;
    p_kb->p_head++;
    wakeup(&keyboard_wait_queue, TASK_UNINTERRUPTIBLE);
}

hw_int_controller keyboard_int_controller = 
{
    .enable = IOAPIC_enable,
    .disable = IOAPIC_disable,
    .install = IOAPIC_install,
    .uninstall = IOAPIC_uninstall,
    .ack = IOAPIC_edge_ack,
};

void keyboard_exit()
{
    unregister_irq(0x21);
    kfree((unsigned long*)p_kb);
}

void keyboard_init()
{
    struct IO_APIC_RET_entry entry;
    unsigned long i;

    wait_queue_init(&keyboard_wait_queue, NULL);
    p_kb = (struct keyboard_inputbuffer*) kmalloc(sizeof(struct keyboard_inputbuffer), 0);

    p_kb->p_head = p_kb->buf;
    p_kb->p_tail = p_kb->buf;
    p_kb->count = 0;

    memset(p_kb->buf, 0, KB_BUF_SIZE);

    entry.vector = 0x21;
    entry.deliver_mode = APIC_ICR_IOAPIC_Fixed; // 標準模式
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

    wait_KB_write(); // 等待鍵盤控制器響應完成
    io_out8(PORT_KB_CMD, KBCMD_WRITE_CMD);
    wait_KB_write();
    io_out8(PORT_KB_DATA, KB_INIT_MODE);

    for (i = 0; i < 1000000; i++)
        nop();

    register_irq(0x21, &entry, &keyboard_handler, (unsigned long)p_kb, &keyboard_int_controller, "ps/2 keyboard");
}

long keyboard_open(struct index_node *inode, struct file *filp)
{
    filp->private_data = p_kb;
    p_kb->p_head = p_kb->buf;
    p_kb->p_tail = p_kb->buf;
    p_kb->count = 0;
    memset(p_kb->buf, 0, KB_BUF_SIZE);
    return 1;
}

long keyboard_close(struct index_node *inode, struct file *filp)
{
    filp->private_data = NULL;
    p_kb->p_head = p_kb->buf;
    p_kb->p_tail = p_kb->buf;
    p_kb->count = 0;
    memset(p_kb->buf, 0, KB_BUF_SIZE);
    return 1;
}

#define KEY_CMD_RESET_BUFFER    0

long keyboard_ioctl(struct index_node *inode,
                    struct file *filp,
                    unsigned long cmd,
                    unsigned long arg)
{
    switch (cmd) {
        case KEY_CMD_RESET_BUFFER:
            p_kb->p_head = p_kb->buf;
            p_kb->p_tail = p_kb->buf;
            p_kb->count = 0;
            memset(p_kb->buf, 0, KB_BUF_SIZE);
            break;

        default:
            break;
    }
    return 0;
}

long keyboard_read(struct file *filp, char *buf, unsigned long count, long *position)
{
    long counter = 0;
    unsigned char *tail = NULL;
    if (p_kb->count == 0)
        sleep_on(&keyboard_wait_queue); // 避免鍵盤傳遞數據時行程浪費CPU資源
    counter = p_kb->count >= count ? count : p_kb->count;
    tail = p_kb->p_tail;
    if (counter <= (p_kb->buf + KB_BUF_SIZE - tail))
    {
        copy_to_user(tail, buf, counter);
        p_kb->p_tail += counter;
    } else {
        copy_to_user(tail, buf, (p_kb->buf + KB_BUF_SIZE - tail));
        copy_to_user(p_kb->p_head, buf,counter - (p_kb->buf + KB_BUF_SIZE - tail));
        p_kb->p_tail = p_kb->p_head + (counter - (p_kb->buf + KB_BUF_SIZE - tail));    
    }
    p_kb->count -= counter;
}

long keyboard_write(struct file *filp, char *buf, unsigned long count, long *position)
{
    return 0;
}

struct file_operations keyboard_fops = {
    .open   = keyboard_open,
    .close  = keyboard_close,
    .ioctl  = keyboard_ioctl,
    .read   = keyboard_read,
    .write  = keyboard_write
};
