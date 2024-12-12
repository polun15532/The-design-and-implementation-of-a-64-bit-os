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