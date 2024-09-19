#ifndef __TIME_H__
#define __TIME_H__

struct time {
    int second; // 0x00
    int minute; // 0x02
    int hour;   // 0x04
    int day;    // 0x07
    int month;  // 0x08
    int year;   // 0x32 + 0x09
};

struct time time;

#define	BCD2BIN(value)  (((value) & 0xf) + ((value) >> 4) * 10)

int get_cmos_time(struct time *time);


#endif