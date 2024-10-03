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

#ifndef _SEMAPHORE_H_
#define _SEMAPHORE_H_

#include "atomic.h"
#include "lib.h"
#include "task.h"
#include "waitqueue.h"

typedef struct {
    atomic_t counter;
    wait_queue_t wait;
} semaphore_t;

void semaphore_init(semaphore_t *semaphore, unsigned int count);
void semaphore_down(semaphore_t *semaphore);
void semaphore_up(semaphore_t *semaphore);

#endif