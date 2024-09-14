#include "lib.h"
#include "time.h"

#define COMS_READ(addr) ({ \
    io_out8(0x70, 0x80 | addr); \
    io_in8(0x71); \
})

int get_cmos_time(struct time *time)
{
    // cli();
    do {
        time->year = COMS_READ(0x09) + COMS_READ(0x32) * 0x100;
        time->month = COMS_READ(0x08);
        time->day = COMS_READ(0x07);
        time->hour = COMS_READ(0x04);
        time->minute = COMS_READ(0x02);
        time->second = COMS_READ(0x00);
    } while (time->second != COMS_READ(0x00));
    io_out8(0x70, 0x00);
    // sti();
    return 0;
}