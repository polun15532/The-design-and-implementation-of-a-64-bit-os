#ifndef _PREEMPT_H_
#define _PREEMPT_H_

#include "task.h"

#define preempt_enable() \
do { \
    current->preempt_count--; \
} while (0)

#define preempt_disable() \
do { \
    current->preempt_count++; \
} while (0)

#endif