#ifndef __PRINTK_H__
#define __PRINTK_H__

#include <stdarg.h>
#include "font.h"
#include "linkage.h"
#include "spinlock.h"

// 這裡的巨集將對應變數flags，數字表示位域
#define ZEROPAD	1   // bit0用數字的前導0取代空格
#define SIGN    2   // bit1無符號或是有符號(有符號表示印出+)
#define PLUS    4
#define SPACE   8
#define LEFT    16
#define SPECIAL 32
#define SMALL   64	


#define WHITE   0x00ffffff		//白
#define BLACK   0x00000000		//黑
#define RED	    0x00ff0000		//紅
#define ORANGE  0x00ff8000		//橙
#define YELLOW  0x00ffff00		//黃
#define GREEN   0x0000ff00		//綠
#define BLUE    0x000000ff		//藍
#define INDIGO  0x0000ffff		//靛
#define PURPLE  0x008000ff		//紫

#define is_digit(c)	((c) >= '0' && (c) <= '9')
#define do_div(num,base) ({ \
int __res; \
__asm__("divq %%rcx":"=a" (num),"=d" (__res):"0" (num),"1" (0),"c" (base)); \
__res; })
//內嵌組合語言的語法為 指令:輸出:輸入:損壞，在這裡用於對rcx暫存器做除法，

extern unsigned char font_ascii[256][16];

struct position {
    int XResolution; //螢幕分辨率
    int YResolution;

    int XPosition;  //游標位置
    int YPosition;

    int XCharSize; //字符矩陣尺寸
    int YCharSize;

    unsigned int *FB_addr; // frame buffer address
    unsigned long FB_length;

    spinlock_t printk_lock;
} Pos;

void frame_buffer_init();
int color_printk(unsigned int FRcolor, unsigned int BKcolor, const char *fmt,...);
int vsprintf(char * buf,const char *fmt, va_list args);
int skip_atoi(const char **s);
void putchar(unsigned int * fb, int Xsize, int x, int y, unsigned int FRcolor, unsigned int BKcolor, unsigned char font);
static char * number(char * str, long num, int base, int size, int precision,	int type);
#endif