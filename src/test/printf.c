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

#include <stdarg.h>
#include "printf.h"
#include "string.h"
#include "stdio.h"

int skip_atoi(const char **s)
{
    // 將字符轉換成數字，同時透過指針的指針操作在取得數字的同時移動指針的位置。
    int i = 0;

    while (is_digit(**s))
        i = i * 10 + *((*s)++) - '0';
    return i;
}

static char *number(char *str, long num, int base, int size, int precision, int type)
{
    char c, sign, tmp[50];
    const char *digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int i;

    if (type & SMALL)
        digits = "0123456789abcdefghijklmnopqrstuvwxyz";
    if (type & LEFT)
        type &= ~ZEROPAD;
    if (base < 2 || base > 36)
        return 0;
    c = type & ZEROPAD ? '0' : ' ';
    sign = 0;
    if (type&SIGN && num < 0) {
        sign = '-';
        num = -num;
    } else {
        sign = (type & PLUS) ? '+' : (type & SPACE ? ' ' : 0);
    }

    if (sign)
        --size;
    if (type & SPECIAL) {
        size -= base == 16 ? 2 : (base == 8 ? 1 : 0);
    }
    i = 0;
    if (num == 0)
        tmp[i++] = '0';
    else while (num != 0)
        tmp[i++] = digits[do_div(num, base)];
    if (i > precision)
        precision = i;
    size -= precision;
    if (!(type & (ZEROPAD + LEFT)))
        while(size-- > 0)
            *str++ = ' ';
    if (sign)
        *str++ = sign;
    if (type & SPECIAL)
        if (base == 8) {
            *str++ = '0';
        } else if (base == 16) {
            *str++ = '0';
            *str++ = digits[33];
        }
    if (!(type & LEFT))
        while(size-- > 0)
            *str++ = c;

    while(i < precision--)
        *str++ = '0';
    while(i-- > 0)
        *str++ = tmp[i];
    while(size-- > 0)
        *str++ = ' ';
    return str;
}

int vsprintf(char * buf,const char *fmt, va_list args)
{
    char *str, *s;
    int flags;
    int field_width;
    int precision;
    int len, i;
    int qualifier;		/* 'h', 'l', 'L' or 'Z' for integer fields */

    for (str = buf; *fmt; fmt++) {
        /* *fmt == '\0'為截止條件 */
        if (*fmt != '%') {
            *str++ = *fmt; // 如果不是%則視為可顯示字符值皆填入buf中。
            continue;
        }

        flags = 0;
        repeat:
            fmt++;
            switch (*fmt) {
                case '-':
                    flags |= LEFT;	
                    goto repeat;
                case '+':
                    flags |= PLUS;	
                    goto repeat;
                case ' ':
                    flags |= SPACE;	
                    goto repeat;
                case '#':
                    flags |= SPECIAL;	
                    goto repeat;
                case '0':
                    flags |= ZEROPAD;	
                    goto repeat;
            }

            /* get field width */

            field_width = -1;
            if (is_digit(*fmt)) { /* 如果是數字 */
                field_width = skip_atoi(&fmt);
            } else if (*fmt == '*') { 
                fmt++;
                field_width = va_arg(args, int); // 字符*表示讓數據區的寬度由可變參數提供
                if(field_width < 0) {
                    field_width = -field_width;
                    flags |= LEFT;
                }
            }

            /* get the precision */

            precision = -1;
            if (*fmt == '.') {
                fmt++;
                if (is_digit(*fmt)) {
                    precision = skip_atoi(&fmt);
                } else if (*fmt == '*') {	
                    fmt++;
                    precision = va_arg(args, int);
                }
                if (precision < 0)
                    precision = 0;
            }

            qualifier = -1;
            if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt == 'Z') {	
                qualifier = *fmt;
                fmt++;
            }
                            
            switch(*fmt) {
                case 'c':
                    if (!(flags & LEFT))
                        while (--field_width > 0)
                            *str++ = ' ';
                    *str++ = (unsigned char) va_arg(args, int);
                    while (--field_width > 0)
                        *str++ = ' ';
                    break;

                case 's':
                    s = va_arg(args, char *);
                    if (!s)
                        s = '\0';
                    len = strlen(s);
                    if (precision < 0)
                        precision = len;
                    else if (len > precision)
                        len = precision;

                    if (!(flags & LEFT))
                        while (len < --field_width)
                            *str++ = ' ';
                    for (i = 0; i < len; i++)
                        *str++ = *s++;
                    while (len < --field_width)
                        *str++ = ' ';
                    break;
                case 'o':
                    if(qualifier == 'l')
                        str = number(str, va_arg(args, unsigned long), 8, field_width, precision, flags);
                    else
                        str = number(str, va_arg(args, unsigned int), 8, field_width, precision, flags);
                    break;
                case 'p':
                    if (field_width == -1) {
                        field_width = 2 * sizeof(void *);
                        flags |= ZEROPAD;
                    }

                    str = number(str, (unsigned long)va_arg(args, void*), 16, field_width,precision, flags);
                    break;
                case 'x':
                    flags |= SMALL;
                case 'X':
                    if(qualifier == 'l')
                        str = number(str, va_arg(args, unsigned long), 16, field_width, precision, flags);
                    else
                        str = number(str, va_arg(args, unsigned int), 16, field_width, precision, flags);
                    break;
                case 'd':
                case 'i':
                    flags |= SIGN;
                case 'u':
                    if(qualifier == 'l')
                        str = number(str, va_arg(args, long), 10, field_width,precision,flags);
                    else
                        str = number(str, va_arg(args, int), 10, field_width,precision,flags);
                    break;
                case 'n':
                    if(qualifier == 'l') {
                        long *ip = va_arg(args, long*);
                        *ip = (str - buf);
                    } else {
                        int *ip = va_arg(args, int*);
                        *ip = (str - buf);
                    }
                    break;
                case '%':
                    *str++ = '%';
                    break;
                default:
                    *str++ = '%';	
                    if(*fmt)
                        *str++ = *fmt;
                    else
                        --fmt;
                    break;
            }

    }
    *str = '\0';
    return str - buf;
}

int sprintf(char *buf, const char *fmt, ...)
{
    int count = 0;
    va_list args;
    va_start(args, fmt);
    count = vsprintf(buf, fmt, args);
    va_end(args);
    return count;
}

int printf(const char *fmt, ...)
{
    char buf[1024];
    int count = 0;
    va_list args;

    va_start(args, fmt);
    count = vsprintf(buf, fmt, args);
    va_end(args);
    putstring(buf);
    return count;
}