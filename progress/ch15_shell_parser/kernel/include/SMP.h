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

#ifndef __SMP_H__
#define __SMP_H__

#include "task.h"
#include "spinlock.h"

struct ICR_REG_entry {
    unsigned int vector: 8,
                 deliver_mode: 3,
                 dest_mode: 1,
                 deliver_state:1,
                 reserved1: 1,
                 level: 1,
                 trigger: 1,
                 reserved2: 2,
                 dest_shorthand: 2,
                 reserved3: 12;
    union {
        unsigned int x2APIC;
        unsigned int reserved: 24,
                     xAPIC: 8;
    } dest_field;
} __attribute__((packed));

#define SMP_cpu_id()    (current->cpu_id)


extern unsigned char _APU_boot_start[];
extern unsigned char _APU_boot_end[];

extern spinlock_t SMP_lock;
extern int global_i;
void SMP_init();
void Start_SMP();

#endif