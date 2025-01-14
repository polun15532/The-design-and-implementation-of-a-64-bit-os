#include "softirq.h"
#include "lib.h"
#include "printk.h"

void set_softirq_status(unsigned long status)
{
    softirq_status |= status;
}

unsigned long get_softirq_status()
{
    return softirq_status;
}

void register_softirq(int nr, void (*action)(void *data), void *data)
{
    softirq_vector[nr].action = action;
    softirq_vector[nr].data = data;
}

void unregister_softirq(int nr)
{
    softirq_vector[nr].action = NULL;
    softirq_vector[nr].data = NULL;
}

// 離開中斷時調用(entry.S中宣告)
void do_softirq()
{
    sti();
    for (int i = 0; i < 64 && softirq_status; i++) {
        if(softirq_status & (1 << i)) {
            softirq_vector[i].action(softirq_vector[i].data);
            softirq_status &= ~(1 << i);
        }
    }
    cli();
}

void softirq_init()
{
    softirq_status = 0;
    memset(softirq_vector, 0, sizeof(softirq_vector));
}
