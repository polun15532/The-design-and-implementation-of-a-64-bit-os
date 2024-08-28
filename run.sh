#!/bin/bash
echo password | sudo -S sh
cd bootloader
make
sudo dd if=boot.bin of=../boot.img bs=512 count=1 conv=notrunc
cd ../kernel
make

cd ..

sudo mount boot.img /media/ -t vfat -o loop
sudo cp bootloader/loader.bin /media/
sudo cp kernel/kernel.bin /media/
sync
sudo umount /media/
cp boot.img ../bochs/

cd bootloader
make clean
cd ../kernel
make clean
