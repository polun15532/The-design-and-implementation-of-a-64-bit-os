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

#ifndef __PRINTF_H__
#define __PRINTF_H__

#include <stdarg.h>

#define ZEROPAD	1
#define SIGN    2
#define PLUS    4
#define SPACE   8
#define LEFT    16
#define SPECIAL 32
#define SMALL   64	

#define is_digit(c)	((c) >= '0' && (c) <= '9')
#define do_div(num,base) ({ \
int __res; \
__asm__("divq %%rcx":"=a" (num),"=d" (__res):"0" (num),"1" (0),"c" (base)); \
__res; })

int sprintf(char *buf, const char *fmt, ...);

int printf(const char *fmt, ...);

#endif
