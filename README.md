# 64-bit-operating-system  
這是基於《一个64位操作系统的设计与实现》一書的學習與實現專案，目標是從零開始實現一個完整的 64 位操作系統。此專案記錄了學習過程中的心得與實作，並基於書籍中的程式碼進行實現。有興趣的朋友可以參考作者田宇先生的 [MINE操作系统](https://gitee.com/MINEOS_admin/publish)。  

## 系統環境
此專案基於以下環境進行開發與測試：  
>Ubuntu: 22.04.4 LTS (WSL2)  
>GCC: 11.4.0  
>Bochs: 2.7  

## 專案結構  

```
/src
├── /bootloader         # Bootloader 文件
├── /kernel             # 核心文件
│   ├── /dev            # 設備驅動
│   ├── /exception      # 異常和中斷處理
│   ├── /fs             # 文件系統
│   ├── /include        # 頭文件
│   ├── /init           # 初始化程式碼
│   ├── /link           # 鏈接腳本
│   ├── /ipc            # 行程間通信
│   ├── /log            # 日誌系統
│   ├── /mm             # 內存管理
│   ├── /sched          # 任務排程
│   ├── /sys            # 系統調用
│   └── /timer          # 定時器
├── /user               # init 行程
└── /test               # 測試程式


```

/bootloader：負責作業系統啟動的初始程序，包括 boot.asm 和 loader.asm。這些程式碼在系統啟動過程中首先執行，負責加載核心到內存並轉交控制權。  

/kernel：作業系統的核心，涵蓋多個子模組，如設備驅動、異常和中斷處理、文件系統、內存管理、任務排程等。每個模組負責處理系統內特定的核心功能，確保系統能夠正常運作和管理各種資源。  

/user：放置系統的 init 行程，它是作業系統啟動後執行的第一個用戶空間程序，負責完成系統初始化並管理後續行程。在目前的實現中，init 最終演變為一個簡單的 shell 命令解析器，允許用戶輸入並執行基本命令，實現與系統的互動。  

/test：測試程式，目前用於產生測試 exec 命令的可執行文件 test.bin。  

## 學習進度與筆記  
專案中的 progress 資料夾記錄了每一章節的程式碼進度，note 資料夾則放置相應的筆記與學習心得。以下是已完成的章節：  

[第3章 bootloader](./note/ch3.md)  
[第4章 核心層](./note/ch4.md)  
[第5章 應用層](./note/ch5.md)  
[第8章 核心主程式](./note/ch8.md)  
[第9章 高級內存管理單元](./note/ch9.md)  
[第11章 設備驅動程式](./note/ch11.md)  
[第12章 行程管理](./note/ch12.md)  
[第13章 文件系統](./note/ch13.md)  
[第14章 系統調用API](./note/ch14.md)  
[第15章 shell 解析器]()

## Bochs 模擬環境搭建  

書中使用的是 Bochs 2.6.8 版本。然而，由於最新的 Bochs 版本會在 USB 模擬上出現問題，因此建議使用 Bochs 2.7。如果只需要模擬軟碟啟動且不需要 USB 功能，可以安裝 2.6.8 版本，並在 configure 配置時避免添加 --enable-usb。  

使用 2.6.8 版本時，可能會遇到以下錯誤：  

```
>>PANIC<< dlopen failed for module 'usb_uhci' (libbx_usb_uhci.so): file not found
```
這是因為 usb_uhci 模組存在未解析符號的問題。這個問題在 Bochs 2.6.10 及以後的版本中得到了修正。相關討論可以參考[討論串](https://sourceforge.net/p/bochs/discussion/39592/thread/58822184/)。  
這是因為usb_uhci有未解析符號引起的。看了一些討論串如果安裝2.6.10以後版本就不會出現此問題。  

以下是我使用的 Bochs 配置選項：  
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

## 模擬環境設置  

從第 6 章開始，書中的實驗轉向物理平台，但我仍然使用 Bochs 進行模擬。我的 .bochsrc 文件與書中的配置有所不同，除了掛載 boot.img 軟碟外，還使用 ata0 和 ata1 來模擬硬碟，最後切換至 vvfat 模式來模擬 FAT32 文件系統，避免傳統 Bochs 硬碟映像文件佔用過多空間（2GB 起）。  
此外，書中的目標是實現支援多核的作業系統，因此在 .bochsrc 文件中，我將處理器數量設置為 4 核，以便進行多核測試。
此外，這本書的目標是實現支援多核的作業系統，因此在我的 .bochsrc 文件中，我將處理器的數量設置為 4 核，以便進行多核功能的測試。  
Bochs 的完整配置請參考[.bochsrc文件](./.bochsrc)。    
這裡提供的所有程式碼都已經過測試，並在我目前的環境設置下能夠正常執行並顯示預期效果。run.sh 是我編寫的腳本，用來一鍵編譯所有檔案並自動複製到 Bochs 資料夾中。我的 Bochs 資料夾位於用戶主目錄下，如您的路徑不同，請自行修改相應的路徑設置。  
boot.img 為已掛載好作業系統的映像檔可在 Bochs 虛擬機中直接執行。  