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