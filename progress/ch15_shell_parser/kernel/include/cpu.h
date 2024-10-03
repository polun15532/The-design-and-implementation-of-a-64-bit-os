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

#ifndef __CPU_H__
#define __CPU_H__

#define NR_CPUS 8
/*
 * @brief 調用cpuid指令並利用指針a、b、c、d獲取返回結果。
 * @param Mop主功能號
 * @param Sop子功能號
 * @param a指針用於返回eax暫存器的值
 * @param b指針用於返回ebx暫存器的值
 * @param c指針用於返回ecx暫存器的值
 * @param d指針用於返回edx暫存器的值
 */
static inline void get_cpuid(unsigned int Mop, unsigned int Sop, unsigned int *a, unsigned int *b, unsigned int *c, unsigned int *d)
{
    __asm__ __volatile__	(   "cpuid  \n\t"
                    :"=a"(*a),"=b"(*b),"=c"(*c),"=d"(*d)
                    :"0"(Mop),"2"(Sop)
                    );
}

void init_cpu(void);
#endif