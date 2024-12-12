
#include "timer.h"
#include "softirq.h"
#include "printk.h"
#include "lib.h"
#include "memory.h"

void init_timer(struct timer_list *timer, void (*func)(void *data), void *data, unsigned long expire_jiffies)
{
    *timer = (struct timer_list) {
        .expire_jiffies = expire_jiffies,
        .func = func,
        .data = data,
    };

    list_init(&timer->list);
}

void add_timer(struct timer_list *timer)
{
    struct timer_list *tmp = container_of(list_next(&timer_list_head.list), struct timer_list, list);
    if (!list_is_empty(&timer_list_head.list)) { // 這裡的判斷可省，因為初始化時加入了哨兵定時器
        while (tmp->expire_jiffies < timer->expire_jiffies)
            tmp = container_of(list_next(&tmp->list), struct timer_list, list);
    }
    list_add_to_behind(&tmp->list, &timer->list);
}

void del_timer(struct timer_list *timer)
{
    list_del(&timer->list);
}

void test_timer(void *data)
{
    color_printk(BLUE, WHITE, "test_timer");
}

void timer_init()
{
    struct timer_list *tmp = NULL;
    jiffies = 0;
    init_timer(&timer_list_head, NULL, NULL, -1UL); // 哨兵定時器 -1UL = ULLONG_MAX
    register_softirq(0, &do_timer, NULL);
}

void do_timer(void *data)
{
    struct timer_list *tmp = container_of(list_next(&timer_list_head.list), struct timer_list, list);
    while (!list_is_empty(&timer_list_head.list) && tmp->expire_jiffies <= jiffies) {
        del_timer(tmp);
        tmp->func(tmp->data);
        tmp = container_of(list_next(&timer_list_head.list), struct timer_list, list);
    }
    color_printk(RED, WHITE, "(HPET:%ld)", jiffies);
}