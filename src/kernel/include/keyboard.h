#ifndef __KEYBOARD_H__
#define __KEYBOARD_H__

#define KB_BUF_SIZE     100
extern struct keyboard_inputbuffer *p_kb;

struct keyboard_inputbuffer {
    unsigned char *p_head;
    unsigned char *p_tail;
    int count;
    unsigned char buf[KB_BUF_SIZE];
};


#define PORT_KB_DATA    0x60
#define PORT_KB_STATUS  0x64
#define PORT_KB_CMD     0x64

#define KBCMD_WRITE_CMD 0x60
#define KBCMD_READ_CMD  0x20

#define KB_INIT_MODE    0x47

#define KBSTATUS_IBF    0x02
#define KBSTATUS_OBF    0x01


extern struct file_operations keyboard_fops;

#define  wait_KB_write()    while(io_in8(PORT_KB_STATUS) & KBSTATUS_IBF)
#define  wait_KB_read()     while(io_in8(PORT_KB_STATUS) & KBSTATUS_OBF)

void keyboard_init();
void keyboard_exit();

void analysis_keycode();

#endif