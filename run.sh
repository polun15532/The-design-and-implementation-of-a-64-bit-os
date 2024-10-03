#!/bin/bash

# 獲取當前工作目錄的絕對路徑
BASEDIR=$(pwd)

# 編譯 bootloader、kernel、Kallsyms、user與test
echo "Compiling bootloader..."
make -C "$BASEDIR/src/bootloader" || { echo "Bootloader compilation failed"; exit 1; }
echo "Compiling kernel..."
make -C "$BASEDIR/src/kernel" || { echo "Kernel compilation failed"; exit 1; }
echo "Compiling user program..."
make -C "$BASEDIR/src/user" || { echo "User program compilation failed"; exit 1; }
echo "Compiling test program..."
make -C "$BASEDIR/src/test" || { echo "TestUser program compilation failed"; exit 1; }

echo "Creating boot image..."
sudo dd if="$BASEDIR/src/bootloader/boot.bin" of="$BASEDIR/boot.img" bs=512 count=1 conv=notrunc || { echo "Failed to create boot image"; exit 1; }

# 確保掛載點 /media 為空
if mount | grep /media; then
    echo "/media is already mounted, attempting to unmount"
    sudo umount /media || { echo "Failed to unmount /media"; exit 1; }
fi

# 挂載 boot.img 到 /media 
echo "Mounting boot.img to /media..."
sudo mount "$BASEDIR/boot.img" /media/ -t vfat -o loop || { echo "Failed to mount boot image"; exit 1; }

# 複製文件到掛載點
echo "Copying loader.bin and kernel.bin to /media..."
sudo cp "$BASEDIR/src/bootloader/loader.bin" /media/ || { echo "Failed to copy loader.bin"; exit 1; }
sudo cp "$BASEDIR/src/kernel/kernel.bin" /media/ || { echo "Failed to copy kernel.bin"; exit 1; }

# 確認文件是否成功複製
if ! ls /media/ | grep -E "loader\.bin|kernel\.bin"; then
    echo "Error: loader.bin or kernel.bin not copied successfully"
    sudo umount /media
    exit 1
fi

# 卸載 /media
echo "Unmounting /media..."
sudo umount /media || { echo "Failed to unmount /media"; exit 1; }

# 複製 boot.img 和 user 的 init.bin 到 bochs 所需的位置
echo "Copying boot.img and init.bin to bochs directory..."
cp "$BASEDIR/boot.img" "$BASEDIR/../bochs/" || { echo "Failed to copy boot.img"; exit 1; }
cp "$BASEDIR/src/user/init.bin" "$BASEDIR/../bochs/vvfat_disk" || { echo "Failed to copy init.bin"; exit 1; }
cp "$BASEDIR/src/test/test.bin" "$BASEDIR/../bochs/vvfat_disk" || { echo "Failed to copy test.bin"; exit 1; }

# 清理 bootloader, kernel, 和 user 的編譯產物
echo "Cleaning up compilation artifacts..."
make -C "$BASEDIR/src/bootloader" clean || { echo "Failed to clean bootloader"; exit 1; }
make -C "$BASEDIR/src/kernel" clean || { echo "Failed to clean kernel"; exit 1; }
make -C "$BASEDIR/src/user" clean || { echo "Failed to clean user"; exit 1; }
make -C "$BASEDIR/src/test" clean || { echo "Failed to clean test"; exit 1; }

echo "Process completed successfully."
