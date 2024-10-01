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

#ifndef __TIME_H__
#define __TIME_H__

struct time {
    int second; // 0x00
    int minute; // 0x02
    int hour;   // 0x04
    int day;    // 0x07
    int month;  // 0x08
    int year;   // 0x32 + 0x09
};

struct time time;

#define	BCD2BIN(value)  (((value) & 0xf) + ((value) >> 4) * 10)

int get_cmos_time(struct time *time);


#endif