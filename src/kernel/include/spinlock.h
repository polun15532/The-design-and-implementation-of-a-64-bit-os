#ifndef _SPINLOCK_H_
#define _SPINLOCK_H_

#include "preempt.h"
#include "lib.h"

typedef struct {
    __volatile__ unsigned long lock; // 1:unlock, 0:lock
} spinlock_t;

static inline void spin_init(spinlock_t *lock)
{
    lock->lock = 1;
}

static inline void spin_lock(spinlock_t *lock)
{
    preempt_disable();
    __asm__ __volatile__( "1:           \n\t"
                          "lock decq %0 \n\t" // 這個 -1 將檢查與修改放在同一步完成
                          "jns  3f      \n\t"
                          "2:           \n\t"
                          "pause        \n\t"
                          "cmpq $0,  %0 \n\t"
                          "jle  2b      \n\t"
                          "jmp  1b      \n\t"
                          "3:           \n\t"
                          : "=m" (lock->lock)
                          :
                          : "memory");
}

static inline void spin_unlock(spinlock_t *lock)
{
    __asm__ __volatile__( "movq $1, %0 \n\t"
                          : "=m" (lock->lock)
                          :
                          : "memory");
    preempt_enable();
}

static inline long spin_trylock(spinlock_t *lock)
{
    unsigned long tmp = 0;
    preempt_disable();
    __asm__ __volatile__( "xchgq $0, %1 \n\t"
                          : "=q"(tmp), "=m"(lock->lock)
                          : "0"(0)
                          : "memory");
    if (!tmp)
        preempt_enable();
    return tmp;
}

#define local_irq_save(x)       __asm__ __volatile__("pushfq ; popq %0 ; cli":"=g"(x)::"memory")
#define local_irq_restore(x)    __asm__ __volatile__("pushq %0 ; popfq"::"g"(x):"memory")
#define local_irq_disable()	    cli();
#define local_irq_enable()	    sti();

#define spin_lock_irqsave(lock, flags)  \
do {                                    \
    local_irq_save(flags);              \
    spin_lock(lock);                    \
} while (0)

#define spin_unlock_irqrestore(lock, flags)   \
do {                                        \
    spin_unlock(lock);                      \
    local_irq_restore(flags);               \
} while (0)

#define spin_lock_irq(lock) \
do {                        \
    local_irq_disable();    \
    spin_lock(lock);        \
} while (0)

#define spin_unlock_irq(lock) \
do {                          \
    spin_unlock(lock);        \
    local_irq_enable();       \
} while (0)

#endif
