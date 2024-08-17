CFLAGS := -mcmodel=large -fno-builtin -m64 -c
ASFLAGS := --64
all: system
	objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary system kernel.bin

system:	head.o entry.o main.o printk.o trap.o memory.o interrupt.o task.o cpu.o
	ld -b elf64-x86-64 -z muldefs -o system head.o entry.o main.o printk.o trap.o memory.o interrupt.o task.o cpu.o -T Kernel.lds 

head.o:	head.S
	gcc -E  head.S > head.s
	as $(ASFLAGS) -o head.o head.s

entry.o: entry.S
	gcc -E  entry.S > entry.s
	as $(ASFLAGS) -o entry.o entry.s
	
main.o:	main.c
	gcc  -g $(CFLAGS) -c main.c

printk.o: printk.c
	gcc  $(CFLAGS) -fno-stack-protector printk.c
	
trap.o: trap.c
	gcc  $(CFLAGS) trap.c

memory.o: memory.c
	gcc  $(CFLAGS) memory.c

interrupt.o: interrupt.c
	gcc  $(CFLAGS) interrupt.c

task.o: task.c
	gcc  $(CFLAGS) -fno-stack-protector task.c

cpu.o: cpu.c
	gcc  $(CFLAGS) -fno-stack-protector cpu.c

clean:
	rm -rf *.o *.s~ *.s *.S~ *.c~ *.h~ system  Makefile~ Kernel.lds~ kernel.bin 
