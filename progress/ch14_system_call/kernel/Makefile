# 編譯器參數
CPPFLAGS := -I./include  # 預處理器標誌，用於指定頭文件路徑
CFLAGS := -mcmodel=large -fno-builtin -fno-stack-protector -m64 -c
ASFLAGS := --64
PIC := APIC  # 設定是否使用 APIC 或 8259A
CC := gcc
AS := as
LD := ld

LINK_SCRIPT = link/Kernel.lds

# 打印 PIC 變數以便檢查
$(info PIC = '$(PIC)')

# 指定源文件目錄
SRC_DIRS := init log exception mm device ipc timer sched fs sys

# 根據條件選擇排除 APIC.c 或 8259A.c
ifeq ($(strip $(PIC)), APIC)
    $(info Compiling with APIC)
    SOURCES := $(filter-out device/8259A.c, $(wildcard $(addsuffix /*.c, $(SRC_DIRS))))
    OBJECTS += device/APIC.o
else
    $(info Compiling with 8259A)
    SOURCES := $(filter-out device/APIC.c, $(wildcard $(addsuffix /*.c, $(SRC_DIRS))))
    OBJECTS += device/8259A.o
endif

# 手動指定鏈接順序，先放 head.S，entry.S，然後是 main.c 等重要文件
PRIORITY_OBJECTS := init/head.o init/entry.o init/APU_boot.o init/main.o

# 查找所有的 .S 文件並將其轉換為 .o 文件
ASM_SOURCES := $(wildcard $(addsuffix /*.S, $(SRC_DIRS)))
ASM_OBJECTS := $(patsubst %.S, %.o, $(ASM_SOURCES))

# 將所有 .c 文件轉換為 .o 文件
C_OBJECTS := $(patsubst %.c, %.o, $(SOURCES))

# 排除重複的文件
C_OBJECTS := $(filter-out $(PRIORITY_OBJECTS), $(C_OBJECTS))
ASM_OBJECTS := $(filter-out $(PRIORITY_OBJECTS), $(ASM_OBJECTS))

# 將關鍵文件放在最前面，其他文件按順序鏈接
OBJECTS := $(PRIORITY_OBJECTS) $(ASM_OBJECTS) $(C_OBJECTS)

# 目標文件（系統生成的內核二進制）
TARGET = kernel.bin

# kernel 生成
all: $(TARGET)

$(TARGET): system
	objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary system $(TARGET)

# 系統目標：鏈接所有目標文件
system: $(OBJECTS)
	$(LD) -b elf64-x86-64 -z muldefs -o system $(OBJECTS) -T $(LINK_SCRIPT)

# 通用規則：編譯 .S 文件
%.o: %.S
	$(CC) $(CPPFLAGS) -E $< > $*.s
	$(AS) $(ASFLAGS) -o $@ $*.s

# 通用規則：編譯 .c 文件
%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -o $@

# 特別規則：編譯 main.c 文件，添加 -g 調試選項
main.o: main.c
	$(CC) -g $(CFLAGS) $(CPPFLAGS) main.c -D$(PIC) -o main.o

# 清理編譯產物
clean:
	find . -type f \( -name '*.o' -o -name '*.s~' -o -name '*.s' -o -name '*.S~' -o -name '*.c~' -o -name '*.h~' \) -exec rm -f {} \;
	rm -rf system Makefile~ Kernel.lds~ $(TARGET)
