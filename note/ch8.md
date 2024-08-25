# <<一個64位操作系統的設計與實現>> 第八章 内核主程序 學習筆記
## 作業系統的kernal.lds鏈結腳本
鏈結表本的主要作用就是描述如何將輸入文件中的各個段(數據段、程式碼段、heap、stack、BSS等)部屬到輸出文件中，並規劃輸出文件在各程式段在內存中的布局。另外核心程式段的位置往往會經過特殊設計，這使得他不能使用默認的鏈結腳本，這也是為什麼作者在這裡提供kernel.lds。
```
kernel/kernel.lds

OUTPUT_FORMAT("elf64-x86-64","elf64-x86-64","elf64-x86-64")
OUTPUT_ARCH(i386:x86-64)
ENTRY(_start)
SECTIONS
{

    . = 0xffff800000000000 + 0x100000;
    .text :
    {
        _text = .;
        *(.text)
        _etext = .;
    }

    . = ALIGN(8);

    .data :
    {
        _data = .;
        *(.data)		
        _edata = .;
    }

    .rodata : 
    {
        _rodata = .;	
        *(.rodata)
        _erodata = .;
    }

    . = ALIGN(32768);
    .data.init_task : { *(.data.init_task) }

    .bss :
    {
        _bss = .;
        *(.bss)
        _ebss = .;
    }

    _end = .;
}
```
在鏈結腳本中使用了OUTPUT_FORMAT、OUTPUT_ARCH、ENTRY、SECTIONS這些段鍵字對核心程式的內存布局加以描述。符號 . 是一個定位器，用於訂位程式的地址或是調整程式的布局位置。
`. = 0xffff800000000000 + 0x100000`這將核心程式的的起始地址定位到線性地址0xffff800000100000處。
`OUTPUT_FORMAT(DEFAULT,BIG,LITTLE)`他為程式的鏈結過程提供3種選項DEFAULT默認、BIG大端、LITTLE小端三種文件輸出格式。如果鏈結的命令有-EB生成的文件就是大端，如果有-EL則是小端，否則就輸出DEFAULT指代的文件格式。而在這裡把3種輸出都定義成elf64-x86-64。
`_ARCH(i386:x86-64)`設置輸出文件的處理器體系結構為i386:x86-64。
`ENTRY(_start)`將head.S文件的_start標示符作為程式的入口地址。
而SECTIONS關鍵字則負責向鏈結器描述輸入文件中的各個段是如何部屬到輸出文件中，同時規劃段在內存中的布局。
在SECTION的開始，利用符號 . 將程式的起始線性地址定位到0xffff800000000000處，因此核心程式的.text就是從這個地址開始。而腳本內的*(.text)正則表達式，*用於匹配所有輸出文件的程式碼段。而夾在前後的了_text、_etext標誌符來標記.text的起始地址與結束地址，可在C語言中以extern引用。

**作業系統的線性地址劃分**
![image](https://hackmd.io/_uploads/H19yRRT9A.png)
在這個系統中把物理內存的前4GB作為固定映射的空間將線性地址減上PAGE_OFFSET即為物理地址，而其他的合法線性地址則屬於非固定應社區交由內存管理系統調配，並允許多個線性地址映射到同一物理頁。

## 處理器的硬體信息
在這一節中，我們將使用CPUID指令以獲取處理器的產品信息、版本信息等基礎信息。CPUID利用EAAX暫存器選定主功能號，對於複雜的功能則會使用ECX暫存器做為子功能號。並且在執行完指令後會將返回值一需求存放在EAX、EBX、ECX、EDX暫存器。
```
/*
 * @brief 調用cpuid指令並利用指針a、b、c、d獲取返回結果。
 * @param Mop主功能號
 * @param Sop子功能號
 * @param a指針用於返回eax暫存器的值
 * @param b指針用於返回ebx暫存器的值
 * @param c指針用於返回ecx暫存器的值
 * @param d指針用於返回edx暫存器的值
 */
static inline void get_cpuid(unsigned int Mop, unsigned int Sop, unsigned int *a, unsigned int *b, unsigned int *c, unsigned int *d)
{
    __asm__ __volatile__	(   "cpuid  \n\t"
                    :"=a"(*a),"=b"(*b),"=c"(*c),"=d"(*d)
                    :"0"(Mop),"2"(Sop)
                    );
}
```
在這裡撰寫封裝CPUID指令的函式，作業系統可調用get_cpuid獲取CPU硬體信息。

```
kernel/cpu.c
void init_cpu(void)
{
    int i, j;
    unsigned int CpuFacName[4] = {0};
    char FactoryName[17] = {0};
    // vendor_string
    get_cpuid(0, 0, &CpuFacName[0], &CpuFacName[1], &CpuFacName[2], &CpuFacName[3]);
    *(unsigned int*)FactoryName = CpuFacName[0];
    *((unsigned int*)FactoryName + 1) = CpuFacName[3];
    *((unsigned int*)FactoryName + 2) = CpuFacName[2];
    FactoryName[12] = '\0';

    color_printk(YELLOW, BLACK, "%s\t%#010x\t%#010x\t%#010x\n", FactoryName, CpuFacName[1], CpuFacName[3], CpuFacName[2]);

	for (i = 0x80000002; i < 0x80000005; ++i) {
        get_cpuid(i, 0, &CpuFacName[0], &CpuFacName[1], &CpuFacName[2], &CpuFacName[3]);
        *(unsigned int*)FactoryName = CpuFacName[0];
        *((unsigned int*)FactoryName + 1) = CpuFacName[1];
        *((unsigned int*)FactoryName + 2) = CpuFacName[2];
        *((unsigned int*)FactoryName + 3) = CpuFacName[3];
        FactoryName[12] = '\0';
        color_printk(YELLOW, BLACK, "%s", FactoryName);
    }
	//Version Informatin Type,Family,Model,and Stepping ID
	get_cpuid(1, 0, &CpuFacName[0], &CpuFacName[1], &CpuFacName[2], &CpuFacName[3]);
	color_printk(YELLOW, BLACK, "Family Code:%#010x,Extended Family:%#010x,Model Number:%#010x,Extended Model:%#010x,Processor Type:%#010x,Stepping ID:%#010x\n", (CpuFacName[0] >> 8 & 0xf), (CpuFacName[0] >> 20 & 0xff), (CpuFacName[0] >> 4 & 0xf), (CpuFacName[0] >> 16 & 0xf), (CpuFacName[0] >> 12 & 0x3), (CpuFacName[0] & 0xf));

	//get Linear/Physical Address size
	get_cpuid(0x80000008,0,&CpuFacName[0],&CpuFacName[1],&CpuFacName[2],&CpuFacName[3]);
	color_printk(YELLOW, BLACK, "Physical Address size:%08d,Linear Address size:%08d\n", (CpuFacName[0] & 0xff), (CpuFacName[0] >> 8 & 0xff));

	//max cpuid operation code
	get_cpuid(0, 0, &CpuFacName[0], &CpuFacName[1], &CpuFacName[2], &CpuFacName[3]);
	color_printk(WHITE, BLACK, "MAX Basic Operation Code :%#010x\t", CpuFacName[0]);

	get_cpuid(0x80000000, 0, &CpuFacName[0], &CpuFacName[1], &CpuFacName[2], &CpuFacName[3]);
	color_printk(WHITE, BLACK, "MAX Extended Operation Code :%#010x\n",CpuFacName[0]);
}
```
![image](https://hackmd.io/_uploads/rJqc-Z05C.png)
這是BOCHS虛擬機的執行結果，顯示了CPU的硬體信息。如產品號為Intel(R) Core i7-4770 CPU @3.40 GHz。物理地址循址位寬為40位元，線係地址循址位寬為48位元。
下表為CPUID主功能號的返回信息。

| 主功能號  | 暫存器 | 信息                                        |
| --------- | ------ | ------------------------------------------- |
| 00h       | EAX    | 處理器支援的最大基礎主功能號                |
|           | EBX    | 字串Genu                                    |
|           | ECX    | 字串ntel                                    |
|           | EDX    | 字串intel                                   |
| 01h       | EAX    | 處理器版本信息                              |
|           | EBX    | (0-7位)處理器商標信息索引值                 |
|           |        | (8-15位)CLFLUSH刷新的快取容量(單位8byte)    |
|           |        | (16-23位)處理器包內的最大可尋邏輯處理器ID值 |
|           |        | (24-31位)初始APIC ID值                      |
|           | ECX    | 處理器支援的機能信息                        |
|           | EDX    | 處理器支援的機能信息                        |
| 80000000h | EAX    | 處理器支援的最大擴展主功能號                |
| 80000002h | EAX    | 處理器商標信息(字串)                        |
|           | EBX    | 處理器商標信息(字串)                        |
|           | ECX    | 處理器商標信息(字串)                        |
|           | EDX    | 處理器商標信息(字串)                        |
| 80000003h | EAX    | 處理器商標信息(字串)                        |
|           | EBX    | 處理器商標信息(字串)                        |
|           | ECX    | 處理器商標信息(字串)                        |
|           | EDX    | 處理器商標信息(字串)                        |
| 80000004h | EAX    | 處理器商標信息(字串)                        |
|           | EBX    | 處理器商標信息(字串)                        |
|           | ECX    | 處理器商標信息(字串)                        |
|           | EDX    | 處理器商標信息(字串)                        |
| 80000008h | EAX    | (0-7位)物理地址位寬                         |
|           |        | (8-15位)線性地址位寬                        |
|           |        | (16-31位)保留                              |
