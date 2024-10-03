#ifndef _KALLSYMS_H_
#define _KALLSYMS_H_

struct symbol_entry {
    unsigned long long address;
    char type;
    char *symbol;
    int symbol_length;
};

#endif