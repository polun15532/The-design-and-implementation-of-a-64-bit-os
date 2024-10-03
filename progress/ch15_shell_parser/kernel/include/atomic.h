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

#ifndef ATOMIC_H
#define ATOMIC_H

typedef struct {
    __volatile__ long value;
} atomic_t;

#define atomic_read(atomic)         (atomic)->value
#define atomic_set(atomic, val)     (atomic)->value = (val)

static inline void atomic_add(atomic_t *atomic, long value) {
    __asm__ __volatile__( "lock addq %1, %0  \n\t"
                          : "=m" (atomic->value) 
                          : "r"  (value)
                          : "memory");
}

static inline void atomic_sub(atomic_t *atomic, long value) {
    __asm__ __volatile__( "lock subq %1, %0  \n\t"
                          : "=m" (atomic->value) 
                          : "r"  (value)
                          : "memory");
}

static inline void atomic_inc(atomic_t *atomic) {
    __asm__ __volatile__( "lock incq %0     \n\t"
                          : "=m" (atomic->value) 
                          : "m" (atomic->value)
                          : "memory");
}

static inline void atomic_dec(atomic_t *atomic) {
    __asm__ __volatile__( "lock decq %0     \n\t"
                          : "=m" (atomic->value) 
                          : "m" (atomic->value)
                          : "memory");
}

static inline void atomic_set_mask(atomic_t *atomic, long mask) {
    __asm__ __volatile__( "lock orq %1, %0  \n\t"
                          : "=m" (atomic->value) 
                          : "r"  (mask)
                          : "memory");
}

static inline void atomic_clear_mask(atomic_t *atomic, long mask) {
    __asm__ __volatile__( "lock andq %1, %0  \n\t"
                          : "=m" (atomic->value) 
                          : "r"  ((~mask))
                          : "memory");
}


#endif