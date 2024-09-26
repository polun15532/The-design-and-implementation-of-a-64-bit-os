CFLAGS := -mcmodel=large -fno-builtin -fno-stack-protector -m64 -c
ASFLAGS := --64
PIC := APIC
CC := gcc
AS := as

# 目標文件
OBJECTS := head.o entry.o APU_boot.o main.o printk.o trap.o memory.o \
			interrupt.o PIC.o task.o cpu.o keyboard.o mouse.o \
			disk.o SMP.o time.o HPET.o timer.o softirq.o schedule.o \
			fat32.o VFS.o sys.o syscalls.o

$(info $(OBJECTS))

all: system
	objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary system kernel.bin

system:	$(OBJECTS)
	ld -b elf64-x86-64 -z muldefs -o system $(OBJECTS) -T Kernel.lds 

# 通用規則:編譯.s文件
%.o: %.S
	$(CC) -E $< > $*.s
	$(AS) $(ASFLAGS) -o $@ $*.s

# 通用規則:編譯.c文件
%.o: %.c
	$(CC) $(CFLAGS) $< -o $@
	
main.o:	main.c
	gcc -g $(CFLAGS) main.c -D$(PIC)

ifeq ($(PIC),APIC)
PIC.o: APIC.c
	gcc $(CFLAGS) APIC.c -o PIC.o
else
PIC.o: 8259A.c
	gcc $(CFLAGS) 8259A.c -o PIC.o
endif

clean:
	rm -rf *.o *.s~ *.s *.S~ *.c~ *.h~ system  Makefile~ Kernel.lds~ kernel.bin 
