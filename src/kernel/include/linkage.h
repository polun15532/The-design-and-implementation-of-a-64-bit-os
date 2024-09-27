#ifndef _LINKAGE_H_
#define _LINKAGE_H_

#define L1_CACHE_BYTES 32
#define asmlinkage __attribute__((regparm(0))) // 參數只用stack傳遞不使用暫存器
#define ____cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))

#define SYMBOL_NAME(X)  X
#define SYMBOL_NAME_STR(X)  #X
#define SYMBOL_NAME_LABEL(X) X##:

#define ENTRY(name)     \
.global	SYMBOL_NAME(name);  \
SYMBOL_NAME_LABEL(name)

#endif
