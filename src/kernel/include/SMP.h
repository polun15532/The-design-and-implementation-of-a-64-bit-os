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