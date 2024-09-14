#ifndef _SEMAPHORE_H_
#define _SEMAPHORE_H_

#include "atomic.h"
#include "lib.h"
#include "task.h"
#include "schedule.h"

typedef struct {
    struct List wait_list;
    struct task_struct *tsk;
} wait_queue_t;

typedef struct {
    atomic_t counter;
    wait_queue_t wait;
} semaphore_t;

void wait_queue_init(wait_queue_t *wait_queue, struct task_struct *tsk)
{
    list_init(&wait_queue->wait_list);
    wait_queue->tsk = tsk;
}

void semaphore_init(semaphore_t *semaphore, unsigned int count)
{
    atomic_set(&semaphore->counter, count);
    wait_queue_init(&semaphore->wait, NULL);
}

void __down(semaphore_t *semaphore)
{
    wait_queue_t wait;
    wait_queue_init(&wait, current); // 任務休眠。
    current->state = TASK_UNINTERRUPTIBLE;
    list_add_to_before(&semaphore->wait.wait_list, &wait.wait_list);
    schedule(); // 切換任務。
}

void semaphore_down(semaphore_t *semaphore)
{
    // 嘗試獲取資源
    if (atomic_read(&semaphore->counter) > 0)
        atomic_dec(&semaphore->counter); // 獲取成功則減少資源計數。
    else
        __down(semaphore); // 資源不可用則休眠。
}

void __up(semaphore_t *semaphore)
{
    wait_queue_t *wait = container_of(list_next(&semaphore->wait.wait_list), wait_queue_t, wait_list);
    list_del(&wait->wait_list);
    wait->tsk->state = TASK_RUNNING;
    insert_task_queue(wait->tsk);
}

void semaphore_up(semaphore_t *semaphore)
{
    // 釋放資源後的操作
    if (list_is_empty(&semaphore->wait.wait_list))
        atomic_inc(&semaphore->counter); // 無任務等待喚醒，則增加資源計數。
    else
        __up(semaphore); // 喚醒任務。
}
#endif