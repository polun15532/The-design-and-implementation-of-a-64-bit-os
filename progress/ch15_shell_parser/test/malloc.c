
#include "limits.h"
#include "unistd.h"
#include "stdio.h"
#include "printf.h"
#include "stddef.h"

#define SIZE_ALIGN  (8 * sizeof(unsigned long))

static unsigned long brk_start_address = 0;
static unsigned long brk_used_address = 0;
static unsigned long brk_end_address = 0;

void *malloc(unsigned long size)
{
    unsigned long address = 0;
    if (size <= 0) {
        printf("malloc size <= 0\n");
        return NULL;
    }
    if (brk_start_address == 0)
        brk_start_address = brk_used_address = brk_end_address = brk(0); // 返回 heap 起始地址

    if(brk_end_address <= brk_used_address + SIZE_ALIGN + size)
        brk_end_address = brk(brk_end_address + ((size + SIZE_ALIGN + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1)));
    
    address = brk_used_address;
    brk_used_address += size + SIZE_ALIGN;
    return (void*)address;
}

void free(void *address)
{

}