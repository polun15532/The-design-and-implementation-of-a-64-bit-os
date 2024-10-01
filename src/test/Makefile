CPPFLAGS := -I./include
CFLAGS := -mcmodel=large -fno-builtin -fno-stack-protector -m64 -c
CC := gcc

OBJECTS := test.o lib.o errno.o printf.o string.o

$(info $(OBJECTS))

all: system_api_lib
	objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary system_api_lib test.bin

system_api_lib: $(OBJECTS)
	ld -b elf64-x86-64 -z muldefs -o system_api_lib $(OBJECTS) -T User.lds

# 通用規則:編譯.c文件
%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -rf *.o *.s~ *.s *.S~ *.c~ *.h~ Makefile~ User.lds~ system_api_lib test.bin

