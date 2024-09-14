#include "printk.h"
#include "lib.h"
#include "memory.h"

void frame_buffer_init()
{
    //re init frame buffer;
    unsigned long i;
    unsigned long *tmp;
    unsigned long *tmp1;
    // 為了讓地址可做位移運算，先將地址參數定義成unsigned long型態，可以減去多次類型轉換與括號使用帶來的閱讀負擔。
    unsigned long FB_addr = (unsigned long)Phy_To_Virt(0xe0000000);
    unsigned long CR3_base_addr = (unsigned long)Get_gdt() & ~0xfffUL;

    tmp = Phy_To_Virt((unsigned long*)(CR3_base_addr) + ((FB_addr >> PAGE_GDT_SHIFT) & 0x1ff));
    if (*tmp == 0) {
        // 如果這個頁尚未被映射，則映射到一個新的物理頁面。
        unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0);
        set_mpl4t(tmp, mk_mpl4t(Virt_To_Phy(virtual), PAGE_KERNEL_GDT));
    }

    tmp = Phy_To_Virt((unsigned long*)(*tmp & ~0xfffUL) + ((FB_addr >> PAGE_1G_SHIFT) & 0x1ff));
    if(*tmp == 0) {
        unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0);
        set_pdpt(tmp, mk_pdpt(Virt_To_Phy(virtual), PAGE_KERNEL_Dir));
    }
    
    for(i = 0; i < Pos.FB_length; i += PAGE_2M_SIZE) {
        tmp1 = Phy_To_Virt((unsigned long *)(*tmp & ~0xfffUL) + ((FB_addr + i >> PAGE_2M_SHIFT) & 0x1ff));
    
        unsigned long phy = 0xe0000000 + i;
        set_pdt(tmp1, mk_pdt(phy, PAGE_KERNEL_Page | PAGE_PWT | PAGE_PCD));
    }

    Pos.FB_addr = (unsigned int*)Phy_To_Virt(0xe0000000);

    flush_tlb(); // 刷新TLB。
}

int color_printk(unsigned int FRcolor, unsigned int BKcolor, const char *fmt, ...)
{
    int i = 0;
    int count = 0;
    int line = 0;
    va_list args;

//    if (get_rflags() & 0x200UL)
//        spin_lock(&Pos.printk_lock);
    va_start(args, fmt);
    i = vsprintf(buf, fmt, args);
    va_end(args);

    for (count = 0; count < i || line; count++){
        if (line > 0) {
            count--;
            goto Label_tab;
        }

        if ((unsigned char) *(buf + count) == '\n') {
            Pos.YPosition++;
            Pos.XPosition = 0;
        } else if ((unsigned char) *(buf + count) == '\b') {
            Pos.XPosition--;
            if (Pos.XPosition) {
                Pos.XPosition = Pos.XResolution / Pos.XCharSize - 1;
                Pos.YPosition--;
                if (Pos.YPosition < 0) {
                    Pos.YPosition = Pos.YResolution / Pos.YCharSize - 1;
                }
            }
            putchar(Pos.FB_addr, Pos.XResolution , Pos.XPosition * Pos.XCharSize, Pos.YPosition * Pos.YCharSize, FRcolor, BKcolor, ' ');
        } else if ((unsigned char) *(buf + count) == '\t') {
            line = ((Pos.XPosition + 8) & ~(8 - 1)) - Pos.XPosition; // 製表符佔去8個顯示字符，Pos.XPosition + 8跳到下一個製表位，並用 &~(8-1)使數字與8的倍數對齊

Label_tab:
            line--;
            putchar(Pos.FB_addr, Pos.XResolution ,Pos.XPosition * Pos.XCharSize, Pos.YPosition * Pos.YCharSize, FRcolor, BKcolor, ' ');	
            Pos.XPosition++;        
        } else {
            putchar(Pos.FB_addr, Pos.XResolution, Pos.XPosition * Pos.XCharSize, Pos.YPosition * Pos.YCharSize, FRcolor, BKcolor, (unsigned char) *(buf + count));
            Pos.XPosition++;            
        }

        if (Pos.XPosition >= (Pos.XResolution / Pos.XCharSize)) {
            Pos.YPosition++;
            Pos.XPosition = 0;
        }
        if (Pos.YPosition >= (Pos.YResolution / Pos.YCharSize)) {
            Pos.YPosition = 0;
        }
    }
//    if (get_rflags() & 0x200UL)
//        spin_unlock(&Pos.printk_lock);
    return i;
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
                        str = number(str,va_arg(args, unsigned long),8,field_width,precision,flags);
                    else
                        str = number(str,va_arg(args, unsigned int),8,field_width,precision,flags);
                    break;
                case 'p':
                    if (field_width == -1) {
                        field_width = 2 * sizeof(void *);
                        flags |= ZEROPAD;
                    }

                    str = number(str,(unsigned long)va_arg(args, void *),16,field_width,precision,flags);
                    break;
                case 'x':
                    flags |= SMALL;
                case 'X':
                    if(qualifier == 'l')
                        str = number(str,va_arg(args, unsigned long), 16, field_width,precision,flags);
                    else
                        str = number(str,va_arg(args, unsigned int), 16, field_width,precision,flags);
                    break;
                case 'd':
                case 'i':
                    flags |= SIGN;
                case 'u':
                    if(qualifier == 'l')
                        str = number(str,va_arg(args, long), 10, field_width,precision,flags);
                    else
                        str = number(str,va_arg(args, int), 10, field_width,precision,flags);
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

int skip_atoi(const char **s)
{
    // 將字符轉換成數字，同時透過指針的指針操作在取得數字的同時移動指針的位置。
    int i = 0;

    while (is_digit(**s))
        i = i * 10 + *((*s)++) - '0';
    return i;
}

void putchar(unsigned int *fb, int Xsize, int x, int y, unsigned int FRcolor, unsigned int BKcolor, unsigned char font)
{
    int i = 0,j = 0;
    unsigned int *addr = NULL;
    unsigned char *fontp = NULL;
    int testval = 0;
    fontp = font_ascii[font];

    for (i = 0; i < 16; i++) {
        addr = fb + Xsize *(y + i) + x;
        testval = 0x100;
        for (j = 0; j < 8; j++) {
            testval >>= 1;
            if(*fontp & testval)
                *addr = FRcolor;
            else
                *addr = BKcolor;
            addr++;
        }
        fontp++;
    }
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

