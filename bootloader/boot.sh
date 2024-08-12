#!/bin/bash
USER_HOME=$HOME
BOCHS_DIR="$USER_HOME/bochs"
BOOT_IMG="$USER_HOME/bochs/boot.img"

make

dd if=boot.bin of=$BOOT_IMG bs=512 count=1 conv=notrunc
mount $BOOT_IMG /media/ -t vfat -o loop
cp loader.bin /media/
sync
umount /media/
