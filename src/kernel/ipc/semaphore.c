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

#include "lib.h"
#include "semaphore.h"
#include "schedule.h"

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