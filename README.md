# 64-bit-operating-system
參考書籍《一个64位操作系统的设计与实现》學習並實現一個64位元作業系統。
此專案用於記錄我的學習所得，從0開始實現64位元作業系統。這裡的程式碼多源自於書籍，有興趣的同學可參考作者田宇先生的[MINE操作系统](https://gitee.com/MINEOS_admin/publish)。  

以下為我的系統環境  
>1.Ubuntu 22.04.4 LTS (WSL2)  
>2.gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0  
>3.bochs 2.7  

這裡主要紀錄學習過程中的心得與遇到的一些問題，progress資料夾內放置每一章節的程式碼進度，而note資料夾則為相應的筆記。  

[第3章 bootloader](./note/ch3.md)  
[第4章 核心層](./note/ch4.md)  
[第5章 應用層](./note/ch5.md)  
[第8章 核心主程式](./note/ch8.md)  
[第9章 高級內存管理單元](./note/ch9.md)  
[第11章 設備驅動程式](./note/ch11.md)  

## BOCHS環境搭建

這本書使用的bochs版本為2.6.8，但如果依照書上的說明安裝最新版的bochs會出現usb上的問題，因此建議使用2.7版本。如果僅作為模擬軟碟開機部模擬usb功能可安裝2.6.8，記得在configure時不要添加`--enable-usb`。  
以下是我按照作者的指示安裝bochs 2.6.8出現的錯誤。  
```
>>PANIC<< dlopen failed for module 'usb_uhci' (libbx_usb_uhci.so): file not found
```
此連結為相關的[討論串](https://sourceforge.net/p/bochs/discussion/39592/thread/58822184/)。  
這是因為usb_uhci有未解析符號引起的。看了一些討論串如果安裝2.6.10以後版本就不會出現此問題。  
以下為作者提供的configure工具配置信息。  
```
./configure \
--with-x11 \
--with-wx \
--enable-debugger \
--enable-all-optimizations \
--enable-readline \
--enable-long-phy-address \
--enable-ltdl-install \
--enable-idle-hack \
--enable-plugins \
--enable-a20-pin \
--enable-x86-64 \
--enable-smp \
--enable-cpu-level=6 \
--enable-large-ramfile \
--enable-repeat-speedups \
--enable-fast-function-calls \
--enable-handlers-chaining \
--enable-trace-linking \
--enable-configurable-msrs \
--enable-show-ips \
--enable-debugger-gui \
--enable-iodebug \
--enable-logging \
--enable-assert-checks \
--enable-fpu \
--enable-vmx=2 \
--enable-svm \
--enable-3dnow \
--enable-alignment-check \
--enable-monitor-mwait \
--enable-avx \
--enable-evex \
--enable-x86-debugger \
--enable-pci \
--enable-usb \
--enable-voodoo \
--enable-pcidev
```

作者在第6章後就全面切換到物理平台，而這個作業系統我仍在bochs虛擬平台上模擬，因此我的.bochsrc文件設定會與作者不同。  
除了原始的boot.img的軟碟驅動外，我另外加了四個用於模擬硬碟的鏡像文件並銜接至ata0與ata1。  
