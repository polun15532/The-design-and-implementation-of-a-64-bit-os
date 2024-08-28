#include "APIC.h"
#include "lib.h"
#include "printk.h"
#include "memory.h"
#include "gate.h"
#include "cpu.h"
#include "interrupt.h"

void IOAPIC_enable(unsigned long irq)
{
    unsigned long value = 0;
    value = ioapic_rte_read((irq - 32) * 2 + 0x10);
    value &= ~0x10000UL; // 啟用中斷。
    ioapic_rte_write((irq - 32) * 2 + 0x10, value);    
}

void IOAPIC_disable(unsigned long irq)
{
    unsigned long value = 0;
    value = ioapic_rte_read((irq - 32) * 2 + 0x10);
    value = value | 0x10000UL;  // 屏蔽中斷
    ioapic_rte_write((irq - 32) * 2 + 0x10,value);
}

unsigned long IOAPIC_install(unsigned long irq, void *arg)
{
    struct IO_APIC_RET_entry *entry = (struct IO_APIC_RET_entry*)arg;
    ioapic_rte_write((irq - 32) * 2 + 0x10, *(unsigned long*)entry);
    return 1;
}

void IOAPIC_uninstall(unsigned long irq)
{
    ioapic_rte_write((irq - 32) * 2 + 0x10, 0x10000UL); // 屏蔽中斷並清除中斷向量號
}

void IOAPIC_level_ack(unsigned long irq)
{
    __asm__ __volatile__( "movq $0x00,  %%rdx  \n\t"
                          "movq $0x00,  %%rax  \n\t"
                          "movq $0x80b, %%rcx  \n\t"
                          "wrmsr               \n\t"
                          :::"memory");
    // 中斷已完成     
    *ioapic_map.virtual_EOI_address = 0;
}

void IOAPIC_edge_ack(unsigned long irq)
{
    __asm__ __volatile__( "movq $0x00,  %%rdx  \n\t"
                          "movq $0x00,  %%rax  \n\t"
                          "movq $0x80b, %%rcx  \n\t"
                          "wrmsr               \n\t"
                          :::"memory");
}



unsigned long ioapic_rte_read(unsigned char index)
{
    unsigned long ret;
    // 由於以下的指令將操作到I/O APIC暫存器，因此必須設定內存屏障 Memory Fence，內存操作順序的一致性。
    *ioapic_map.virtual_index_address = index + 1;
    io_mfence(); // 防止指令重排序
    ret = *ioapic_map.virtual_data_address;
    ret <<= 32;
    io_mfence();

    *ioapic_map.virtual_index_address = index;
    io_mfence();
    ret |= *ioapic_map.virtual_data_address;
    io_mfence();

    return ret;
}

void ioapic_rte_write(unsigned char index, unsigned long value)
{
    *ioapic_map.virtual_index_address = index;
    io_mfence();
    *ioapic_map.virtual_data_address = value & 0xffffffff;
    value >>= 32;
    io_mfence();
    *ioapic_map.virtual_index_address = index + 1;
    io_mfence();
    *ioapic_map.virtual_data_address = value & 0xffffffff;
    io_mfence();
}

void IOAPIC_pagetable_remap()
{
    unsigned long *tmp;
    unsigned char *IOAPIC_addr = (unsigned char*)Phy_To_Virt(0xfec00000);

    ioapic_map.physical_address      = 0xfec00000;
    ioapic_map.virtual_index_address = IOAPIC_addr;
    ioapic_map.virtual_data_address  = (unsigned int*)(IOAPIC_addr + 0x10);
    ioapic_map.virtual_EOI_address   = (unsigned int*)(IOAPIC_addr + 0x40);

    Global_CR3 = Get_gdt();

    tmp = Phy_To_Virt(Global_CR3 + (((unsigned long)IOAPIC_addr >> PAGE_GDT_SHIFT) & 0x1ff));

    if (*tmp == 0) {
        unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0);
        set_mpl4t(tmp, mk_mpl4t(Virt_To_Phy(virtual), PAGE_KERNEL_GDT));
    }

    tmp = Phy_To_Virt((unsigned long*)(*tmp & ~0xfffUL) + (((unsigned long)IOAPIC_addr >> PAGE_1G_SHIFT) & 0x1ff));
    if (*tmp == 0) {
        unsigned long *virtual = kmalloc(PAGE_4K_SIZE, 0);
        set_pdpt(tmp, mk_pdpt(Virt_To_Phy(virtual), PAGE_KERNEL_Dir));        
    }

    tmp = Phy_To_Virt((unsigned long*)(*tmp & ~0xfffUL) + (((unsigned long)IOAPIC_addr >> PAGE_2M_SHIFT) & 0x1ff));
    set_pdt(tmp, mk_pdt(ioapic_map.physical_address, PAGE_KERNEL_Page | PAGE_PWT | PAGE_PCD));

    color_printk(BLUE, BLACK, "ioapic_map.physical_address:%#010x\t\t\n", ioapic_map.physical_address);
    color_printk(BLUE, BLACK, "ioapic_map.virtual_address:%#018lx\t\t\n", (unsigned long)ioapic_map.virtual_index_address);
    flush_tlb();
}

void Local_APIC_init()
{
    unsigned int x, y;
    unsigned int a, b, c, d;

    get_cpuid(1, 0, &a, &b, &c, &d); // CPUID.01h可用於檢查是否支援xAPIC(edx)與x2APIC(ecx)

    if((1 << 9) & d)
        color_printk(WHITE, BLACK, "HW support APIC&xAPIC\t");
    else
        color_printk(WHITE, BLACK, "HW NO support APIC&xAPIC\t");
    
    if((1 << 21) & c)
        color_printk(WHITE, BLACK, "HW support x2APIC\n");
    else
        color_printk(WHITE, BLACK, "HW NO support x2APIC\n");

    __asm__ __volatile__( "movq $0x1b, %%rcx \n\t" // IA32_APIC_BASE_MSR = 0x1b
                          "rdmsr             \n\t"
                          "bts $10,   %%rax  \n\t" // enable x2APIC
                          "bts $11,   %%rax  \n\t" // enable xAPIC
                          "wrmsr             \n\t" // write to MSR
                          "mov $0x1b, %%rcx  \n\t"
                          "rdmsr             \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");
    // 這段程式碼用rdmsr指令讀取IA32_APIC_BASE，然後將第10與第11位設為1並寫回MSR，表示啟用x2APIC與xAPIC。

    color_printk(WHITE, BLACK, "eax:%#010x,edx:%#010x\t", x, y);
    
    if (x & 0xc00)
        color_printk(WHITE, BLACK, "xAPIC & x2APIC enabled\n");
    // 檢查返回值x(eax)以確認是否可啟用x2APIC與xAPIC。

    __asm__ __volatile__( "movq $0x80f, %%rcx \n\t" // Spurious Interrupt Vector Register
                          "rdmsr              \n\t"
                          "bts  $8,  %%rax    \n\t" // enable APIC
                          // "bts  $12, %%rax    \n\t" // disable EOI broadcasting
                          "wrmsr              \n\t"
                          "mov $0x80f, %%rcx  \n\t"
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");

    // 通過wrmsr指令向SIV暫存器(0x80f)的第8與第12位設為1，表示啟用local APIC與禁止廣播EOI。
    color_printk(WHITE,BLACK, "eax:%#010x, edx:%#010x\t", x, y);

    if(x & 0x100)
        color_printk(WHITE, BLACK, "SVR[8] enabled\n");
    if(x & 0x1000)
        color_printk(WHITE, BLACK, "SVR[12] enabled\n");

    // get local APIC ID
    __asm__ __volatile__( "movq $0x802, %%rcx \n\t" // Local APIC ID Register
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");
    color_printk(WHITE, BLACK, "eax:%#010x,edx:%#010x\tx2APIC ID:%#010x\n", x, y, x);

    // get local APIC version
    __asm__ __volatile__( "movq $0x803, %%rcx \n\t" // Local APIC Version Register
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");

    color_printk(WHITE, BLACK, "local APIC Version:%#010x,Max LVT Entry:%#010x,SVR(Suppress EOI Broadcast):%#04x\t"
                , x & 0xff, (x >> 16 & 0xff) + 1, x >> 24 & 0x1);

    if((x & 0xff) < 0x10)
        color_printk(WHITE, BLACK, "82489DX discrete APIC\n");
    else if((x & 0xff) >= 0x10 && (x & 0xff) <= 0x15)
        color_printk(WHITE, BLACK,"Integrated APIC\n");
    
    // mask all LVT
    __asm__ __volatile__( "movq $0x82f, %%rcx \n\t" // CMCI
                          "wrmsr              \n\t"
                          "movq $0x832, %%rcx \n\t" // Timer
                          "wrmsr              \n\t"
                          "movq $0x833, %%rcx \n\t" // Thermal Monitor
                          "wrmsr              \n\t"
                          "movq $0x834, %%rcx \n\t" // Performance Counter
                          "wrmsr              \n\t"
                          "movq $0x835, %%rcx \n\t" // LINT0
                          "wrmsr              \n\t"
                          "movq $0x836, %%rcx \n\t" // LINT1
                          "wrmsr              \n\t"
                          "movq $0x837, %%rcx \n\t" // Error
                          "wrmsr              \n\t"
                          :
                          :"a"(0x10000), "d"(0x00)
                          :"memory");
    // eax = 0x10000，置位的位元表示mask即屏蔽所有中斷。
    color_printk(GREEN, BLACK, "Mask ALL LVT\n");

    // TPR
    __asm__ __volatile__( "movq $0x808, %%rcx \n\t"
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");
    color_printk(GREEN, BLACK, "Set LVT TPR:%#010x\t", x);

    // PPR
    __asm__ __volatile__( "movq $0x80a, %%rcx \n\t"
                          "rdmsr              \n\t"
                          :"=a"(x), "=d"(y)
                          :
                          :"memory");
    color_printk(GREEN, BLACK, "Set LVT PPR:%#010x\n", x);
}

void IOAPIC_init()
{
    int i;
    *ioapic_map.virtual_index_address = 0x00; // I/O APIC ID
    io_mfence();
    *ioapic_map.virtual_data_address = 0x0f000000;
    io_mfence();
    color_printk(GREEN, BLACK, "Get IOAPIC ID REG:%#010x,ID:%#010x\n", *ioapic_map.virtual_data_address, *ioapic_map.virtual_data_address >> 24 & 0xf);
    io_mfence();

    *ioapic_map.virtual_index_address = 0x01; // I/O APIC version
    io_mfence();   
    color_printk(GREEN, BLACK, "Get IOAPIC Version REG:%#010x,MAX redirection enties:%#08d\n"
                , *ioapic_map.virtual_data_address , ((*ioapic_map.virtual_data_address >> 16) & 0xff) + 1);

    for(i = 0x10; i < 0x40; i += 2)
        ioapic_rte_write(i, 0x10020 + ((i - 0x10) >> 1)); // 將中斷向量號0x20-0x37映射到RTE暫存器0x10-0x3f，並將模式設為屏蔽。

    ioapic_rte_write(0x12, 0x21); // 開啟RTE1以接收鍵盤中斷請求。
    color_printk(GREEN, BLACK, "I/O APIC Redirection Table Entries Set Finished.\n");	    
}

void APIC_IOAPIC_init()
{
    // init trap abort fault
    int i;
    unsigned int x;
    unsigned int *p;

    IOAPIC_pagetable_remap();

    for (i = 32; i < 56; i++) {
        set_intr_gate(i, 2, interrupt[i - 32]);
        // 前32個向量號是系統中斷不能用，這裡的2是指ist2(TSS描述符指定)。
    }

    color_printk(GREEN, BLACK, "MASK 8259A\n");
    io_out8(0x21, 0xff); // 屏蔽8259A主晶片所有中斷
    io_out8(0xa1, 0xff); // 屏蔽8259A從晶片所有中斷

    // enable IMCR
    io_out8(0x22, 0x70); // IMCR利用I/O端口0x22並寫入0x70時表示選取IMCR
    io_out8(0x23, 0x01); // 向I/O端口0x23寫入0x01，啟用IMCR。

    //init local apic
    Local_APIC_init();

    //init ioapic
    IOAPIC_init();

    //get RCBA address
    io_out32(0xcf8, 0x8000f8f0);
    x = io_in32(0xcfc);
    color_printk(RED,BLACK,"Get RCBA Address:%#010x\n", x);	
    x &= 0xffffc000;
    color_printk(RED,BLACK,"Get RCBA Address:%#010x\n", x);

    //get OIC address
    if (x > 0xfec00000 && x < 0xfee00000) {
        p = (unsigned int*)Phy_To_Virt(x + 0x31feUL);
    }

    //enable IOAPIC
    x = (*p & 0xffffff00) | 0x100;
    io_mfence();
    *p = x;
    io_mfence();

    memset(interrupt_desc, 0, sizeof(irq_desc_T)*NR_IRQS);

    sti(); 
}

void do_IRQ(struct pt_regs *regs, unsigned long nr)
{
    unsigned char x;
    irq_desc_T *irq = &interrupt_desc[nr - 32];

    x = io_in8(0x60); // 取得鍵盤控制器的數據
    color_printk(BLUE, WHITE, "(IRQ:%#04x)\tkey code:%#04x\n", nr, x);

    if(irq->handler)
        irq->handler(nr,irq->parameter,regs);

    if(irq->controller && irq->controller->ack)
        irq->controller->ack(nr);


    __asm__ __volatile__( "movq $0x00,  %%rdx \n\t"
                          "movq $0x00,  %%rax \n\t"
                          "movq $0x80b, %%rcx \n\t"
                          "wrmsr              \n\t"
                          :::"memory");
    // 0x80b為EOI暫存器的地址，將其設為0x00，表示告訴PIC中斷已完成。
}