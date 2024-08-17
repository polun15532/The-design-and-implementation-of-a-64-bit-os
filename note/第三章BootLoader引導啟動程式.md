# <<一個64位操作系統的設計與實現>> 第三章 Bootloader 學習筆記
這份筆記用於紀錄我自己學習書籍《一个64位操作系统的设计与实现》作者為田宇，這裡的內容多由書籍中摘錄而來，並加上我的一些說明與解釋。

# 3. Bootloader引導啟動程式
Boot負責開機啟動與加載loader，而loader則負責完成硬體工作環境配置，引導加載核心。

## Boot引導程式
計算機啟動後，首先經過BIOS的自檢，他會檢查硬體設備是否有問題，如無誤將根據BIOS的啟動項配置選擇引導設備，目前BIOS支持的啟動設備有軟碟、USB、硬碟與網路啟動。通常狀況下，BIOS選擇硬碟做為默認啟動項。在這裡我們先以軟碟驅動開始。
如果軟盤的第0磁頭第0磁道的第一扇區以0x55與0xaa作為結尾，那BIOS就會認為這個扇區是引導扇區(Boot Sector)，並將此扇區的數據複製到0x7c00處，隨後將處理器的執行權限交給這段程序。一個扇區的容量為 512 byte 而BIOS只負責加載一個扇區，在這個容量限制下，Boot只能做為一級的助推器將功能更為強大的loader加載到內存中，可看作是硬體設備項軟體移交控制權，一旦loader開始執行，一切都交由軟體所控制。
在BIOS項引導程式轉交控制權前，會先對處理器初始化，比如將CS設為0x0000並將IP設為0x7c00。請注意這裡尚未進入保護模式而是實模式，使用的是物理內存必須透過CS與IP轉換得到，寫法為[CS:IP] 及 (CS << 4) + IP。在實模式下最多可以使用的物理內存為 10^20 byte = 1 MiB 。
引導程式去除標示符0x55 0xaa只有 510 byte 可使用，但是以甚麼形式儲存與加載loader是一個麻煩的問題。如果以寫入固定扇區的方或那以後的核心程式也需要指定固定扇區加載。這種方法的好處為Boot的加載程式碼容易實現，只需要指定加載程式的磁頭、磁道、扇區、所占扇區大小等等，就可以把程式碼成功加載到內存中，即使這些扇區不連續的我們依然可以透過指定的方式完成。不過隨著程式碼數量不斷增加此法也變的不方便，因為每次向儲存介質寫入Loader與核心都需要重新計算起始扇區與佔用扇區數量。這是必須要大量修改Boot與Loader程式碼。而軟碟創建文件系統可以解決這個問題。在這裡我們以FAT12文件系統做為軟碟文件系統與後續USB文件系統使用。
以下為boot.asm的內容
```
    org    0x7c00

BaseOfStack    equ    0x7c00

Label_Start:
    mov    ax,    cs
    mov    ds,    ax
    mov    es,    ax
    mov    ss,    ax
    mov    sp,    BaseOfStack

```
程式依照慣例會加載到0x7c00，此外NASM可支援0x0000也可支援0000h這種16進制寫法。在這裡用equ定義標示符BaseOfStack為0x7c00，需要注意的是這個標示符不可以與其他符號同名，此外這個equ可以代表常量、表達式、字符串與一些註記符。而段暫存器無法直接賦值所以需要透過通用暫存器用mov指令賦值。
```
;=======    clear screen

    mov    ax,    0600h
    mov    bx,    0700h
    mov    cx,    0
    mov    dx,    0184fh
    int    10h
;=======    set focus

    mov    ax,    0200h
    mov    bx,    0000h
    mov    dx,    0000h
    int    10h
;=======    display on screen: Start Booting

    mov    ax,    1301h
    mov    bx,    000fh
    mov    dx,    0000h
    mov    cx,    10
    push   ax
    mov    ax,    ds
    mov    es,    ax
    pop    ax
    mov    bp,    StartBootMessage
    INT    10h
```
這裡使用BIOS中斷服務調用INT 10h的主功能編號 06h、02h、13h。
呼叫BIOS中斷服務前必須設置齊功能編號讓處理器知道要做什麼功能，會設置在AH暫存器，在這裡作者使用`mov ax, 0200h`就是在設定AH=02h，也可以直接設定`mov ah, 02h`。以下為一些功能號的說明。

INT 10h AH=02h的功能為設定游標位置。

DH = 游標的列數
DL = 游標的行數
BH = 頁碼。
在這裡我們設定DH = DL = 00h 表示將游標顯示在螢幕左上角(0,0)位置。

INT 10h AH=06h可實現依照指定範圍滾動窗口的功能，同時也具備清屏功能。
AL = 滾動的列數，設為0則清屏
BH = 滾動後空出位置放入的屬性
CH = 滾動範圍的左上角座標列號
CL = 滾動範圍的左上角座標行號
DH = 滾動範圍的右上角座標列號
DL = 滾動範圍的右上角座標行號
BH = 顏色屬性
bit 0 - 2表示8種(0 - 7)字體顏色，依序為黑、藍、綠、青、紅、紫、棕、白
bit 3為字體亮度(0:正常，1:高亮度)
bit 4-6表示背景顏色，依序為黑、藍、綠、青、紅、紫、棕、白
bit 7字體閃爍(0:不閃爍，1:閃爍)

假設AL設為0時則自動視為清屏，其他BX、CX、DX暫存器都不起作用。

INT 10h AH=13h的功能可以顯示字符串。
AL表示寫入模式
AL = 00h 字符串屬性由BL提供，CX則提供字符串常度(以byte為單位)，不改變顯示游標位置。
AL = 01h 同AL = 00h，但是移動游標位置到字符串尾端。
AL = 02h 字符串屬性由每個紫符後緊跟的byte提供，cx所提供的字符串常度改以word為單位，不改變顯示游標位置。
AL = 03h 同AL = 02h，但是移動游標位置到字符串尾端。
CX = 字符串常度
DH = 游標的座標行號
DL = 游標的座標列號
ES:BP = 顯示自符串的內存起始地址
BH = 頁碼
BL = 字符屬性與顏色屬性。
bit 0-2表示8種(0-7)字體顏色，依序為黑、藍、綠、青、紅、紫、棕、白
bit 3為字體亮度(0:正常，1:高亮度)
bit 4-6表示背景顏色，依序為黑、藍、綠、青、紅、紫、棕、白
bit 7字體閃爍(0:不閃爍，1:閃爍)

上述程式完成了引導程式的log信息顯示工作，接著要讓BIOS中斷服務程式操作磁碟驅動器
```
;=======    reset floppy
    xor    ah,    ah
    xor    dl,    dl
    int    13h

    jmp    $
```
這裡用`xor ah, ah`代替`mov ah, 0h`是因為xor指令較mov短且值值速度也快，可以減少開銷。

INT 13h AH=00h的功能為重置磁碟驅動器，為下一次讀寫作準備。
DL = 驅動器號碼，00H-7FH:軟碟，80H-FFH為硬碟
DL = 00h表示第一個軟碟驅動器(drive A)
DL = 01h表示第二個軟碟驅動器(drive B)
DL = 80h表示第一個硬碟驅動器
DL = 81h表示第二個硬碟驅動器

```
StartBootMessage:    db    "Start Boot"

;=======    fill zero until whole sector

    times    510 - ($ - $$)    db    0
    dw    0xaa55
```
這裡的功能很簡單就是把第1個扇區剩下的部分填充0並在最尾端的結束位置填上0xaa55作為結尾，用於標示這是引導扇區。

## 建立虛擬軟碟鏡像文件

bximage可用於建立虛擬磁碟鏡像文件。
於命令行輸入'apt install bximage'即可安裝，根據指示建立鏡像文件完成後會顯示以下提示
```
floppya: image="boot.img", status=inserted
```
這一行提示信息告訴用戶如何把鏡像文件加入虛擬基環境配置信息中，STATUS表示虛擬軟碟鏡像的狀態，inserted表示已插入。

以下為我們建立的鏡像文件信息
disk image mode = 'flat'
hd_size: 1474560
geometry = 2/16/63 (1 MB)
其中磁碟鏡像文件類型為軟碟(flat)，文件大小為1474540 byte。1474540 = 1440 KiB - 1.44MB。我自己是建立1.44MB的文件沒錯但為什麼是數字還不清楚，我預期的容量: 1.44 MB = 1440000 byte 或是 1.44 MiB -= 1509950 byte。至於geometry為何顯示1MB作者是說bximage是以 1MB大小去解析的。我們建立的軟碟包含2個磁頭、80個磁道與18個扇區。
接著可把boot.asm進行編譯，格式為 nasm −f <format> <filename> [−o <output>]，-f用於指定編譯出的目標文件格式，-o則用於指定生成目標文件的文件名。
```
nasm boot.asm -o boot.bin
```
接著將二進制文件寫入虛擬軟碟鏡像文件，在linux上可使用dd指令將引導程式強制寫入到虛擬軟碟鏡像文件，這種方法可以跳過文件系統的管理與控制直接操作磁碟扇區。
```
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
```
將boot.bin內容寫入boot.img。if為輸入源文件名，of為輸出文件名，bs表是指定傳輸的chunk大小為512 byte，count = 1表是寫入一個chunk，而conv=notrunc規定寫入數據後不會截斷(改變)文件尺寸大小。

依據書籍的指示使用FAT12文件系統加載loader程式與核心程式。FAT文件會對軟碟的扇區做結構化處理，將其分為引導扇區、FAT表、根目錄、數據區等4個部分。下表為引導扇區結構。


| 名稱              | 偏移  | 長度 | 內容                 | 本系統引導程序數據        |
| ---------------- | ---- | ---- | -------------------- | ------------------------- |
| BS_jmpBoot       | 0    | 3    | 跳轉指令              | jmp short Label_Start nop |
| BS_OEMName       | 3    | 8    | 生產廠商名            | MINEboot                  |
| BPB_BytesPerSec  | 11   | 2    | 扇區容量              | 512 Byte                  |
| BPB_BytesPerClus | 13   | 1    | 每簇扇區數量          | 1                         |
| BPB_RsvdSecCnt   | 14   | 2    | 保留扇區數量          | 1                         |
| BPB_NumFATs      | 16   | 1    | FAT表的份數          | 2                         |
| BPB_RootEntCnt   | 17   | 2    | 根目錄可容納目錄項數   | 224                       |
| BPB_RootEntCnt   | 19   | 2    | 總扇區數             | 2880                      |
| BPB_Media        | 21   | 1    | 介質描述符           |  0xF0                      |
| BPB_FATSz16      | 22   | 2    | 每FAT扇區數          | 9                         |
| BPB_SecPerTrk    | 24   | 2    | 每磁道扇區數量        |      18                   |
| BPB_NumHeads     | 26   | 2    | 磁頭數               |   2                       |
| BPB_HiddSec      | 28   | 4    | 隱藏扇區數            |   0                        |
| BPB_TotSec32     | 32   | 4    | 若BPB_TotSec16=0，則由這裡紀錄扇區數量| 0             |
| BS_DrvNum        | 36   | 1    | int 13h的驅動器號      |  0                        |
| BS_Reserved      | 37   | 1    | 未使用                |  0                        |
| BS_BootSig       | 38   | 1    | 擴展引導標記(29h)      |  0x29                     |
| BS_VollD         | 39   | 4    | 捲序列號              |  0                        |
| BS_VolLab        | 43   | 11   | 捲標                  | boot loader              |
| BS_FileSysType   | 54   | 8    | 文件系統類型           | FAT12                     |
| 引導程式碼         | 62   | 448  | 引導程式碼、數據與其他信息|                           |
| 結束標誌           | 510 | 2    | 結束標誌 0xAA55        | 0xAA55                    |

在這裡偏移offset指的是引導扇區的第幾個byte，另外長度定義了每個名稱信息的大小。在開始處的是跳轉程式碼BS_jmpBoot，這是因為緊接在後面的是FAT12的文件信息，而非可執行程式碼。jmp short Label_Start 即跳到組合語言程式定義的標籤Label_Start的位置，這條指令的長度為2 byte，nop指令為1 byte。
BPB_SecPerClus 紀錄了每個cluster的扇區數量，由於扇區的容量只有512 Byte，如果每次讀寫都是一個扇區會使軟碟的讀取次數太多而拖慢速度，因此引入 cluster 的概念cluster必須為2的冪，作為一個最小的數據操作單元與最小儲存單位，舉例來說假設一個cluster有4個扇區，每次操作這個FAT文件時最少都會加載 4*512=2KiB 大小的數據。至於讀取次數增加為什麼會拖慢時間這是因為時間大部分都花在尋道與旋轉，一般磁碟的尋道時間為3-9ms左右，7500 RPM的轉速對於隨機存取而言每次查找一個扇區大約要經過半個磁道花費1*60/7500=8ms，而讀取一個扇區的時間約為1ms，因此若資料是連續儲存，一次讀取多個扇區較為省時。
BPB_RsvdSecCnt 為保留扇區數量，這個值必須大於0，FAT12文件中此位必須為1，因為引導扇區在保留扇區內，FAT表是從第二個扇區開始。
BPB_NumFATs 為FAT表的備份數量，這些表的內容是一樣的，FAT類文件建議這裡設為2做為備份使用。
BPB_RootEntCnt 根目錄可容納的目錄項數，這個值成32必須為扇區容量(512 byte)的偶數倍。
BPB_TotSec16 記錄總使用扇區數量，如果這個值為零，將換成紀錄到 PB_Tot常用Sec32 中。
BPB_Media 描述儲存介質類型，若為不可移動的標準值為0xF8，可移動的常用0xF0表示，合法值為0xF0、0xF8-0xFF。此外這裡的值也必須寫入FAT[0]的低位。
BPB_FATSz16 表示FAT表所佔用的扇區數，兩個相同的FAT表容量為這個值。
BS_VolLab 這是Windows或Linux顯示的磁碟名。
BS_FileSysType 描述文件系統類型，這個值指示字串，作業系統不會使用這個值來鑑別FAT文件類型。
![軟碟文件系統分配圖](https://hackmd.io/_uploads/H1UD4YKu0.png)
<p class="text-center">
軟碟文件系統分配圖
</p>
由於FAT文件系統以cluster為最小操作單位，就算文件只使用1 byte的空間，FAT文件系統也會分配一個cluster的空間。這種設計方法可以讓磁碟存儲空間依照固定的儲存頁管理，並且可以照文件偏移量，分段的訪問文件內容，不必一次將文件中的所有數據讀取出來。
FAT表的位寬與類型有關，例如FAT12的位寬為12 bit，FAT16為16bit，FAT32則為32bit。當存放文件體積增加時，很難確保文件中的數據都儲存在連續空間內，文件往往會根據大小分成多個cluster，可以依據FAT表將不連續的文件片段依照cluster的編號串接起來。接著根據上表的內容將數據輸入boot.asm以完成引導扇區的配置。填入方式就是用db、dw、dd指令將數據填入對應的位置。比如BPB_BytesPerSec長度為2使用dw，BPB_BytesPerClus長度為1使用db，BPB_HiddSec長度為4使用dd。


| FAT項  | 實例值 | 描述                                                      |
| ------ | ------ | ------------------------------------------------------- |
| 0      | 0xFF0  | 磁碟標示字，尾端F0表示為可移動儲存介質                        |
| 1      | 0xFFF  | 第一個cluster以被佔用                                     |
| 2      | 0x003  | 0x000可用cluster                                         |
| 3      | 0x004  | 0x002 - 0xFEF，為以使用的cluster，標示文件的下一個cluster編號 |
| ...... | ...... | FF0-FF6為保留cluster                                     |
| N      | 0xFFF  | 0xFF7損壞的cluster                                       |
| N      |        | 0xFF8-0xFFF表是文件結尾                                   |

FAT[0]的最低一個byte與BPB_Media相同其餘位元設為1，此外FAT[0]與FAT[1]不會做為數據區的索引使用。系統會在初始化期間將FAT[1]設為0xFFF。另外現在大部分的作業系統訪問FAT表時會直接跳過這兩項，使他們不參與索引值計算。

### 根目錄與數據區
根目錄區只能存放目錄項信息，而數據區則可存放目錄項信息與文件內的數據。目錄項是一個32 byte組成的結構體，可以表示文件、目錄，紀錄名稱、長度、與數據起始cluster編號等信息,可以用以下結構體來表示。
```
struct FILEINFO {
    unsigned char name[8], ext[3], type;
    char reserve[10];
    unsigned short time, date, clustno;
    unsigned int size;
};
```

| 名稱          | 偏移  | 長度 |           描述           |
| ------------ | ---- | ---- |:-----------------------:|
| DIR_Name     | 0x00 | 11   | 文件名8 byte，擴展名3 byte |
| DIR_Attr     | 0x0B | 1    |          文件屬性         |
| 保留位        | 0x0C | 10   |           保留位          |
| DIR_WrtTime  | 0x16 | 2    |      最後一次寫入時間      |
| DIR_WrtDate  | 0x18 | 2    |      最後一次寫入日期      |
| DIR_FstClus  | 0x1A | 2    |    文件起始cluster編號    |
| DIR_FileSize | 0x1C | 4    |          文件大小        |

這個格式是由微軟所定義的，DIR_WrtTime、DIR_WrtDate、DIR_FstClus都必須經過公式轉換。DIR_Attr這個文件屬性最低5位元都一些意義。如第0位的bit表是指讀文件(0x01)，第1位表是隱藏文件(0x02)，第2位表使系統文件(0x04)，第3位表示非文件信息如磁碟名稱等(0x08)，第4位表示目錄(0x10)。如果一個文件有多種屬性只要把這些位元做或運算或是相加即可，比如一個文件為只能讀的隱藏文件那他的文件屬性就是0x02 | 0x01 = 0x03。一般的文件齊屬性大多為0x20或是0x00。
以下為引導扇區的配置。
```
    org    0x7c00

BaseOfStack        equ    0x7c00
BaseOfLoader       equ    0x1000
OffsetOfLoader     equ    0x00

RootDirSectors             equ    14
SectorNumOfRootDirStart    equ    19
SectorNumOfFAT1StarT       equ    1
SectorBalance              equ    17

    jmp    short    Label_Start
    nop
    BS_OEMName            db    'MINEboot'
    BPB_BytesPerSec       dw    512
    BPB_SecPerClus        db    1
    BPB_RsvdSecCnt        dw    1
    BPB_NumFATs           db    2
    bpb_rOOTeNTcNT        dw    224
    BPB_TotSec16          dw    2880
    BPB_Media             db    0xf0
    BPB_FATSz16           dw    9
    BPB_SecPerTrk         dw    18
    BPB_NumHeads          dw    2
    BPB_hiddSec           dd    0
    BPB_TotSec32          dd    0
    BS_DrvNum             db    0
    BS_Reserved1          db    0
    BS_BootSig            db    29h
    BS_VolID              dd    0
    BS_VolLab             db    'boot loader'
    BS_FileSysType        db    'FAT12   '
```
在進入BIOS模式時處於實模式而非保護模式，系統必須使用CS與IP暫存器去訪問程式碼的實體地址，這兩個暫存器為16位元，對應地址為(CS << 4) + IP。這樣的架構最多可以表示20 bit的地址，因此可以訪問的內存大小為1 MB。因此Loader程式的起始地址為(BaseOfLoader << 4) + OffsetOfLoader = 0x10000。RootDirSectors equ 14表示根目錄佔用14個扇區，計算方法為 (BPB_RootEntCnt * 32 + BPB_BytesPerSec – 1) / BPB_BytesPerSec = 14，算是中之所以加上 BPB_BytesPerSec – 1 是為了向上取整。SectorNumOfRootDirStart equ 19表示根目錄的起始扇區號碼，計算方式為保留扇區 + FAT扇區 * FAT副本數 = 1 + 2 * 9 = 19。SectorNumOfFAT1表示FAT1表的起始扇區號，由於編號0為保留扇區，所以1為FAT1表的開始位置。
SectorBalance equ 17用於平衡文件的起始cluster編號，由於FAT[0]與FAT[1]並不做為索引使用實際上FAT[2]後才為數據區的有效目錄項，為了平衡這個值，讓索引值好似從0開始，先將19 - 2 = 17，如此可以直接對應所在的cluster。另外這只在cluster對應1個扇區才成立。
以下為書中提供軟碟讀取功能的程式。
```
;=======       read one sector from floppy
Func_ReadOneSector:

    push    bp                            ; 保存bp以便後須恢復
    mov     bp,     sp
    sub     esp,    2                     ; 增加stack 2 byte空間
    mov     byte    [bp - 2],   cl        ; 將cl 存入 [bp-2]這個位置
    push    bx
    mov     bl,     [BPB_SecPerTrk]       ; 將磁道扇區數量輸入bl暫存器
    div     bl                            ; 除法(被除數為ax除數為bl) al放商，ah放餘數
    inc     ah                            ; ah += 1磁道內的扇區從1號開始
    mov     cl,     ah                    ; 目標磁道的起始扇區編號
    mov     dh,     al                    ; 
    shr     al,     1                     ; 磁頭有正反兩個方向，所以右移一位
    mov     ch,     al                    ; 確認在第幾個磁道
    and     dh,     1                     ; 讀取磁頭方向
    pop     bx
    mov     dl,     [BS_DrvNum]           ; 把驅動器號碼存入dl

Label_Go_On_Reading:

    mov     ah,     2
    mov     al,    byte    [bp - 2]        ; 讀入[bp - 2]個扇區
    int     13h                            ; 讀取磁碟扇區
    jc Label_Go_On_Reading
    add esp,    2                          ; 平衡stack指針
    pop bp
    ret
```
上面這段程式碼用來完成讀取軟碟功能。
INT 13h, AH=02h 讀取磁碟扇區。
AL=讀入的扇區數(不可為0)
CH=磁道號(柱面號)的低8位
CL=扇區號1-63用5個bit表示，磁道號碼(柱面號)的高兩位(bit 6-7，只對硬碟有效)。
DH=磁頭號。
DL=驅動器號，如果操作硬碟驅動器，bit 7要置位。
ES:BX=數據緩衝區。

Func_ReadOneSector傳入的扇區號為LBA(Logiacal Block Address)，而INT 13h, AH=02只能接受CHS(Cylinder/Head/Sector)格式，所以在這裡我們透過下面的公式轉換。此外Func_ReadOneSector接收的參數分別為AX=待讀取的磁碟起始扇區號，CL=讀入扇區數量，ES:BX=數據緩衝區起始地址。
![image](https://hackmd.io/_uploads/SytSK8qd0.png)
首先修改SP的值空出空間以存取CL(要讀取的扇區數量)，接著將AX(待讀取起始扇區號) / BL(每磁道/柱面扇區數)，商被存在AL中可用於計算柱面號與磁頭號，而AH則存放餘數，用以表示目標磁道的起始扇區位置。另外由於扇區編號從1開始而非0，所以用inc ah將這個值+1。接著將計算結果輸入對應的暫存器，呼叫INT 13h假仔軟碟扇區數據到內存中。

```
;=======   search loader.bin

    mov    word    [SectorNo],    SectorNumOfRootDirStart    ; 把SectorNumOfRootDirStart放入標籤SectorNo的地址

Lable_Search_In_Root_Dir_Begin:

    cmp    word    [RootDirSizeForLoop],    0    ; 檢查標籤RootDirSizeForLoop地址的值是否為0
    jz     Label_No_LoaderBin                    ; 若為0代表根目錄扇區讀取完畢，跳轉到Label_No_LoaderBin
    dec    word    [RootDirSizeForLoop]          ; 讀取新的扇區，把未讀取的扇區數量減一
    mov    ax,     00h
    mov    es,     ax                            ; 把es段暫存器歸0
    mov    bx,     8000h
    mov    ax,     [SectorNo]                    ; 將SectorNo存放的值移到AX
    mov    cl,     1                             ; 表示讀取1個扇區(這裡用cl作為函式的入參，當調用int 13h會把值放入al)
    call   Func_ReadOneSector
    mov    si,     LoaderFileName                ; 把標籤LoaderFileName的地址放入si
    mov    di,     8000h
    cld                                          ; 清除DF，保證後續操作字串指針時自動遞增
    mov    dx,     10h                           ; 根目錄區每扇區可以存放0x10個目錄項

Label_Search_For_LoaderBin:

    cmp     dx,     0                            
    jz      Label_Goto_Next_Sector_In_Root_Dir   ; dx=0表示所有目錄項都查過了，前往下一個扇區查找
    dec     dx                                   ; 讀取新目錄項，dx--
    mov     cx,     11                           ; 設定cx = 11是因為文件名 + 擴展名 = 8 + 3 = 11 byte

Label_Cmp_FileName:

    cmp	    cx,	    0
    jz	    Label_FileName_Found                 ; cx = 0時所有字符成功配對，找到檔案。
    dec	    cx
    lodsb                                        ; 將si所指向地址的字符取出放入al (cld保證向地址高位遞增)
    cmp     al,     byte    [es:di]              ; 將al值與[es:di]比較
    jz	    Label_Go_On
    jmp     Label_Different                      ; 不同時跳轉Label_Different，比較下一個目錄項
                  
Label_Go_On:
	
	inc	    di
	jmp	    Label_Cmp_FileName

Label_Different:

    and	    di,	    0ffe0h                       ; 因為一個目錄項 32 byte 這裡需要對齊回目錄項的起始地址
    add	    di,	    20h                          ; 移動到下一個目錄項
    mov	    si,	    LoaderFileName               ; 重新設置配對地址
    jmp	    Label_Search_For_LoaderBin

Label_Goto_Next_Sector_In_Root_Dir:

    add	    word    [SectorNo],  1               ; 移動到下個扇區
    jmp	    Lable_Search_In_Root_Dir_Begin       ; 開始查找
```

程式碼將根目錄區的扇區讀入內存中，並將裡面的目錄項逐一比較，值至找到LoaderFileName對應的文件名。查找過程中每次讀取一個扇區，每個扇區有16個目錄項。載入字符時使用指令lodsb，此指令可以把地址ds:di存放的 1 byte數據放入al中並且把di依據DF的值做增減，為了保證di地址的增減往高位運行，使用指令cld將DF設為0。另外FAT12格式的文件名只有大小，即使將小寫命民的文件複製到FAT12中，文件系統也會建立大寫字母的目錄項。比如loader.bin其FAT12中的文件名為"LOADER  BIN"。

接著放入找不到loader的處理，透過int 10h將字串ERROR:No LOADER Found顯示在螢幕的第1行第0列上
```
;=======	display on screen : ERROR:No LOADER Found

Label_No_LoaderBin:

    mov	    ax,     1301h                ; ah=13h表示顯示字串，al=01h表示寫入字串後將由標移到字串尾端
    mov	    bx,     008ch                ; bh=00h表示頁碼(0為當前頁面)，bl=8ch表示字串顯示為紅色
    mov	    dx,     0100h                ; dh=01表示游標在第1列，dl=00表示第0列
    mov	    cx,	    21                   ; 寫入字符串長度
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    NoLoaderMessage      ; 將bp用作字串的指針。
    int	    10h
    jmp	    $

```



找到loader.bin的目錄項後將依據FAT表所記錄的cluster編號將loader.bin加載到內存中。另外FAT12用於紀錄文件分割資訊的FAT項不是直接紀錄cluster編號，需要經過轉換才能指向實際的cluster編號。FAT項必須以3 byte為一組進行轉換，轉換後會得到兩個數字，每一個數字都代表當前文件下一個銜接的cluster編號。假設我現在有16進位數字0x123456，其轉換方法如下所示。
> vw  Zu  XY  ->  uvw  XYZ <br>
> 其中x、y、z、U、V、W為16進制的位，在little endian系統中。假設取前2byte可以得到vw Zu這等於數字0xZuvw。<br>
> 取右12位即可得到數字uvw，在取後2byte可以得到Zu XY這相當於0xXYZu，右移4位即可獲得數字0xXYZ。<br>
> 假設這3 byte分別表示FAT表0、1。這表示0號cluster後面銜接的是0xuvw的cluster，而1號cluster後面銜接的是0xXYZ。<br>
> FAT[0]和FAT[1]不是數據保留區，不與其他cluster相關，這裡僅作舉例用。

這裡是作者給予用於計算的程式碼。
```
;=======	get FAT Entry

Func_GetFATEntry:

    push    es
    push    bx
    push    ax                    ; 把FAT項的索引存到STACK上
    mov	    ax,	    00            ; 段暫存器必須透過ax賦值 
    mov	    es,	    ax
    pop	    ax
    mov	    byte    [Odd],    0   ; 將標籤odd的值設為0
    mov	    bx,	    3
    mul	    bx                    ; ax *= 3
    mov	    bx,	    2
    div	    bx                    ; ax /= 2 一個FAT項佔據 12bit 共計1.5 byte
    cmp	    dx,	    0             ; 餘數放在ax，餘數為0代表在偶數項的FAT中
    jz	    Label_Even
    mov	    byte    [Odd],    1   ; 將標籤odd的值設為1

Label_Even:

    xor	    dx,	    dx            ; 將dx歸零
    mov	    bx,	    [BPB_BytesPerSec]
    div     bx                    ; ax /= 512 這是因為要找到目標FAT表項是哪個扇區和偏移量
    push    dx                    ; dx為餘數表示偏移量
    mov	    bx,	    8000h         ; 這裡用來定義讀入的扇區要放在內存的哪個位置 (es:bx)
    add	    ax,	    SectorNumOfFAT1Start    ; 計算在哪個扇區。
    mov	    cl,	    2             ; 讀取2個扇區
    call    Func_ReadOneSector    ; 讀取從ax和ax+1兩個扇區

    pop	    dx                    ; 恢復dx(偏移量)
    add	    bx,	    dx            ; 此時es:bx指向要讀取的FAT表項
    mov	    ax,	    [es:bx]       ; 從[es:bx]開始讀取 2byte 數據 (因為FAT表項有12bit)
    cmp	    byte    [Odd],	1     ; 檢查FAT表項的索引值的奇偶性決定解讀方式
    jnz	    Label_Even_2
    shr	    ax,	    4             ; 如果是奇數右移四位

Label_Even_2:

    and	    ax, 	0fffh         ; 偶數就取最右邊12位
    pop	    bx
    pop	    es
    ret
```
Func_GetFATEntry 功能為輸入一個FAT表項並查找下一個FAT表項(FAT表項的意思是這一個cluter後續的資料方在哪個cluster)。由於一個FAT表項有1.5 byte所以須將索引值乘上1.5來確定目標FAT表項的偏移量。考慮到這個偏移量有可能超過一個扇區，將這個值除上512由商決定要讀取哪個扇區。此外FAT表項可能恰好放置在2個扇區的交界處，因此讀取時一次讀取兩個扇區。解讀FAT表項的數據只需從奇偶性來判斷數據的解讀操作，如果是偶數數據放在bit0 - bit11只需要和0xfff做與運算即可，如果是奇數項數據存放在bit4 - bit15則需右移4位。

接著透過Func_GetFATEntry與unc_ReadOneSector將loader讀入內存。
```
;=======    found loader.bin name in root director struct

Label_FileName_Found:

    mov	    ax,	    RootDirSectors
    and     di,     0ffe0h                  ; 根目錄所有目錄項的長度都是32byte這裡確保di可以對齊目標目錄項的開頭
    add     di,     01ah                    ; 在根目錄下文件起始cluster號碼的偏移量為0x1a
    mov	    cx,     word    [es:di]         ; 這裡用di是因為這個暫存器用於指針操作，而bx是默認用於向內存傳輸數據時用。
    push	cx
    add	    cx,	    ax                      ; cluster編號只是代表文件內容的相對位置，需加上起始扇區、FAT表項與根目錄所占去的扇區
    add	    cx,	    SectorBalance
    mov	    ax,	    BaseOfLoader
    mov	    es,	    ax
    mov	    bx,     OffsetOfLoader
    mov	    ax,     cx

Label_Go_On_Loading_File:

    push	ax
    push	bx
    mov	    ah,	    0eh
    mov	    al,	    '.'                     ; 這裡的.只是用來顯示在畫面上表示進度而已
    mov	    bl,	    0fh
    int	    10h                             ; int 10h ah = 0xe 這個功能號就是在螢幕輸出一個字符
    pop	    bx
    pop	    ax

    mov	    cl,	    1
    call	Func_ReadOneSector
    pop	    ax                              ; 第一次pop的值來自於push cx剩下的來自於puah ax指令
    call    Func_GetFATEntry
    cmp	    ax,	    0fffh                   ; 0xfff代表文件的結尾
    jz	    Label_File_Loaded
    push	ax                              ; 把Func_GetFATEntry返回的FAT表項存放到stack
    mov	    dx,	    RootDirSectors
    add	    ax,	    dx
    add	    ax,	    SectorBalance
    add	    bx,	    [BPB_BytesPerSec]       ; 加上512byte避免資料被覆蓋。
    jmp	    Label_Go_On_Loading_File

Label_File_Loaded:

    jmp	$                                   ; 由於此時尚未撰寫loader程式以$代替

```
在這段程式碼中我們先從根目錄項取得loader.bin程式的內容被放在哪個cluster編號，接著使用Func_GetFATEntry與Func_ReadOneSector將loader.bin讀入內存，而資料讀入內存時會被放置到es:bx所指定的內存地址。每次讀入一個扇區後會將bx增加512 byte。此外若Func_GetFATEntry返回的FAT表項數據為0xfff則代表讀取到文件的結尾可開始執行loader.bin程式了。

```
;=======    tmp variable

RootDirSizeForLoop      dw      RootDirSectors
SectorNo                dw      0
Odd                     db      0

;=======    display messages

StartBootMessage:   db      "Start Boot"
NoLoaderMessage:    db      "ERROR:No LOADER Found"
LoaderFileName:	    db      "LOADER  BIN",0
```
這裡用於存放一些被定義的臨時數據。另外在nasm中""字符串操作並不會加上'\0'，如有需要必須自己手動加上。

## Loader
```
Label_File_Loaded:

    jmp     BaseOfLoader:OffsetOfLoader     ; 跳轉至loader。
```
我們把loader放置在 BaseOfLoader:OffsetOfLoader 的內存位置，執行這條指令後會把cs設為BaseOfLoader，ip設為OffsetOfLoader。在實模式(real mode) 下的寄存器只能使用 16 bit，每個段可訪問的地址空間為64 KB如果要訪問的空間超過不在這個範圍內就必須調整段暫存器。

Loader主要負責檢測硬體信息、處理器模式切換(實模式到保護模式再到長模式)、向內核傳遞參數。
由於BIOS自檢的大部分信息只可以在實模式下獲取，因此再進入核心程式前必須取得這些信息並做為參數提供核心使用。這些硬體訊息中最重要的是物理地址空間訊息。唯有解析物理地址相關信息，才能知道ROM、RAM、寄存器設備空間、內存空洞的物理地址範圍，才能交由內存管理單元維護。為執行內核程序Loader須將CPU模式由實模式一路切換到64位作業系統的IA-32e模式(長模式)。再切換的過程中，Loader必須創建各模式運行的臨時數據，並依照標準流程執行模式跳轉。此外Loader將兩類主要參數傳遞給內核：控制信息和硬體數據。控制信息指導內核的執行流程或限制某些功能，例如啟動模式。硬體數據則包括系統內存佈局和硬體設備信息等。
```
org     10000h
    jmp     Label_Start

%include    "fat12.inc"

BaseOfKernelFile            equ    0x00
OffsetOfKernelFile          equ    0x100000
BaseTmpOfKernelAddr         equ    0x00
OffsetTmpOfKernelFile       equ    0x7E00
MemoryStructBufferAddr      equ    0x7E00
```
核心程式的起始位置被定義在0x100000 (1MB處)，這是因為1MB以下的空間並不全是可用的內存空間，他們會被劃分成多個子空間，這些空間都有各自的用途，比如存放BIOS程式的0xF0000 - 0xFFFFF這一部份的空間是BIOS ROM組成。這裡定義的0x7E00是核心程式的臨時轉存空間，這是因為核心程式的讀取操作是透過BIOS INT 13h讀取磁碟實現的，在實模式下只有1 MB (16 + 4 bit)的地址空間可以被使用，所以必須先將核心程式讀入這個存空間，之後在搬運到1 MB以上的內存空間。之後這個轉存空間就可以供其他數據結構使用。

![image](https://hackmd.io/_uploads/Skxhy7CdC.png)
```
[SECTION .s16]
[BITS 16]
Label_Start:
    ……
    mov bp,    StartLoaderMessage    int 10h
```
在這裡定義了.s16的段，並且使用BITS 16通知NASM生成的指令將運行在16位寬的處理器。當NASM編譯處於BITS 16狀態下時，使用32位寬的數據指令就需加入前綴0x66，而使用32位寬的地址指令需要加入0x67。同樣在32位寬的模式下使用16位寬指令也需要加入指令前綴。在正常狀況下實模式只能只用1 MB以內的地址空間，位突破這個限制就必須打開A20 gate，這可開啟實模式下的4 GB尋址功能。
```
;=======	open address A20
    push    ax
    in      al,     92h            ; 從端口 0x92 讀取值
    or      al,     00000010b      ; 端口 0x92的bit1可控制A20 gate (0為關閉，1為開啟)，早期需透過鍵盤控制器激活
    out     92h,    al             ; 開啟A20 gate
    pop     ax

    cli                            ; 禁用CPU中斷，防止進入保護模式實受到干擾

    db      0x66                   ; 表示接下來指令是32位操作
    lgdt    [GdtPtr]               ; 加載GDT

    mov     eax,    cr0
    or      eax,    1              ; 將cr0的bit0設為1代表要切換到保護模式
    mov     cr0,    eax

    mov     ax,     SelectorData32
    mov     fs,     ax
    mov     eax,    cr0
    and     al,     11111110b
    mov     cr0,    eax
    sti                            ; 恢復中斷
```

接著根據書上的指示將boot.bin用於尋找loader.bin的程式碼移植過來，但是我們將要匹配的名稱由"LOADER  BIN"改成"KERNEL  BIN"，
```
;=======    search kernel.bin
    mov     word    [SectorNo],    SectorNumOfRootDirStart

    Lable_Search_In_Root_Dir_Begin:
    ……
 
    mov	    bp,	    NoLoaderMessage
    int	    10h
    jmp	    $
```
隨後先將kernel.bin的內容轉存到0x7E00中，為避免轉存發生錯誤使用LOOP指另一個byte一個byte複製。此外由於核心程式龐大，橫跨多個cluster，每次轉存核心程式片段時都要保存目標的偏移量，利用edi暫存器保存臨時變量OffsetOfKernelFileCount。
```
Label_FileName_Found:
    mov     ax,    RootDirSectors
    and	    di,    0FFE0h                ; 這裡用於對齊FAT表項
    add     di,    01Ah                  ; 偏移量0x1A紀錄文件的起始cluster編號。
    mov     cx,    word     [es:di]      ; 把cluster編號放入cx暫存器中
    push    cx
    add     cx,    ax
    add	    cx,    SectorBalance         ; 加上根目錄、FAT表項、保留扇區後得到正確的扇區位置
    mov     eax,   BaseTmpOfKernelAddr
    mov     es,    eax
    mov     bx,    OffsetTmpOfKernelFile ; 定義kernel文件轉存的內存位置在0x7E00每次讀入一個cluster時都先放在這裡
    mov     ax,    cx

Label_Go_On_Loading_File:
    push    ax
    push    bx
    mov 	ah,	   0Eh
    mov	    al,    '.'                   ; 有幾個.代表讀取了多少cluster
    mov	    bl,	   0Fh
    int     10h                          ; 用int 10h ah=0eh把文字印到螢幕上
    pop     bx
    pop     ax

    mov     cl,    1
    call    Func_ReadOneSector           ; 讀取一個扇區
    pop     ax

;=======
    push    cx
    push    eax
    push    fs
    push    edi
    push    ds
    push    esi

    mov     cx,    200h                                ; 一個扇區大小為512 = 0x200 使用loop指令時用cx指定循環次數
    mov     ax,    BaseOfKernelFile
    mov     fs,    ax
    mov     edi,   dword    [OffsetOfKernelFileCount]  ; OffsetOfKernelFileCount用來表示讀取文件應放入內存的哪個位置

    mov     ax,    BaseTmpOfKernelAddr
    mov     ds,    ax
    mov     esi,   OffsetTmpOfKernelFile               ; 這裡是轉存的地址

Label_Mov_Kernel:

    mov     al,    byte     [ds:esi]                   ; esi 為 source index
	mov     byte   [fs:edi],    al                     ; edi 為 destination index
    ; 上面兩行的作用為將[ds:esi]的內容移動到[fs:edi]，開啟A20 gate後只讓fs暫存器可訪問0-4GB的內存空間，訪問地址超過0x100000就要用fs
    inc     esi
    inc     edi

    loop    Label_Mov_Kernel                           ; 用loop指令重複操作 (操作次數存在cx暫存器，每經過一次循環cx-=1)

    mov     eax,    0x1000
    mov     ds,     eax

    mov     dword   [OffsetOfKernelFileCount],  edi    ; 把偏移量存回OffsetOfKernelFileCount

    pop     esi
    pop     ds
    pop     edi
    pop     fs
    pop     eax
    pop     cx
    
    call    Func_GetFATEntry
    ......
    jmp	    Label_Go_On_Loading_File
```
這部分的程式會先將核心的文件放到轉存地址0x7E00，隨後使用fs暫存器將核心的程式放置到1 MB以上的物理地址空間。(開啟A20後只有FS可訪問0-0xFFFFFFFF共4 GB的內存空間)，每次讀取一個cluster(在這裡我們定義其大小與一個扇區相同)大小的核心文件，讀取方法與boot.asm中函式Func_GetFATEntry相同。為避免轉存發生錯誤，使用mov byte每次只搬運1 byte，使用Loop(cx暫存器定義重複操作次數)重複操作直到此cluster全數複製完成。使用臨時變量OffsetOfKernelFileCount保存偏移量，這個值用於指定kernel文件要放置在哪個地址。
另外作者提到，這裡關於fs暫存器操作在bochs虛擬機中有效果，但是移植到實體平台中就會出問題。這是因為如果重新向FS賦值在實體平臺中將會從32為元的尋址能力會恢復到實模式的20為元。而這個問題會在這本書的第7章被解決。

```
Label_File_Loaded:
		
    mov     ax,     0B800h
    mov     gs,     ax
    mov     ah,     0Fh				; 0000: 黑底    1111: 白字
    mov     al,     'G'
    mov     [gs:((80 * 0 + 39) * 2)],   ax	; 螢幕第0行第39列。
```
這段程式碼具體的作用為將字符G放置到內存空間中，並在螢幕中顯示這個字符。0B800h這個地址是文本模式下顯卡內存的起始地址。改變這一段內存地址就可以改變螢幕上顯示的內容。在這個空間內每個字符暫據2 byte空間，低地址空間用於保存字符，高地址空間則保存顏色，ah = 0Fh表示白字黑底。而80 * 0 + 39表示把這個字符放到第0行39列，一行為80個字符。
當loader加載完核心程式時，就不需要再使用軟跌了，此時可以關閉軟碟。
```
KillMotor:

    push    dx
    mov	    dx,	    03F2h
    mov	    al,	    0	
    out	    dx,	    al
    pop	    dx
```
通過向I/O端口0x3F2寫入0來關閉軟碟驅動馬達。輸入0代表關閉所有的軟碟驅動器。
另外OUT指令可以根據端口的位寬選用AL/AX/EAX暫存器，目的操作數可以是立即數或是DX暫存器，立即數位寬是8位(0-0xFF)，而DX則可使用16位(0-0xFFFF)。

| 位  | 名稱     | 說明                                          |
| --- | -------- | ------------------------------------------- |
| 7   | MOT_EN3  | 控制軟驅馬達D 1:啟動 0:關閉                   |
| 6   | MOT_EN2  | 控制軟驅馬達C 1:啟動 0:關閉                   |
| 5   | MOT_EN1  | 控制軟驅馬達B 1:啟動 0:關閉                   |
| 4   | MOT_EN0  | 控制軟驅馬達A 1:啟動 0:關閉                   |
| 3   | DMA_INT  | DMA與中斷請求 1:允許 0:禁止                   |
| 2   | RESET    | 1:允許軟碟控制器發送控制信息 0:復位軟碟驅動器     |
| 1   | DRV_SEL1 | 00-11用於選擇軟碟驅動器A-D                    |
| 0   | DRV_SEL0 |                                            |

由於內核文件以全數搬運完成物理地址0x7E00將用於保存物理地址空間信息。接下來的程式碼用於保存物理地址空間信息。

```
;=======    get memory address size type

    mov	    ax,     1301h
    mov	    bx,	    000Fh       ; 黑底白字
    mov	    dx,	    0400h		; row 4
    mov	    cx,	    24          ; 顯示24個字符
    push	ax                  ; 我很好奇作者位何不先設定sreg的值在做功能號的設定，這樣可以省下push pop操作。
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    StartGetMemStructMessage
    int	    10h                ; 這一段用於顯示StartGetMemStructMessage

    mov	    ebx,    0          ; 歸零暫存器，使用int 15h E820時，第一次調用時必須把這個值設為0
    mov	    ax,	    0x00       ;
    mov	    es,	    ax
    mov	    di,	    MemoryStructBufferAddr ; 地址為0x7E00

Label_Get_Mem_Struct:

    mov	    eax,    0x0E820    ; 在int 15h中ah=E8h al=20h表示查詢系統地址對應,可獲得內存布局
    mov	    ecx,    20         ; buffer的大小。返回的結構體大小為20 byte。
    mov	    edx,    0x534D4150 ; 這一串數字由ascii表轉換可得到字串"SMAP"。BIOS用這個驗證是否請求system map資訊
    int	    15h
    jc      Label_Get_Mem_Fail
    add	    di,     20         ; +20是因為填入了20 byte的結構體。

    cmp	    ebx,    0          ; 第一次呼叫或是內存掃描完畢這個值為0，如果不是就放入上次調用後的計數值。
    jne	    Label_Get_Mem_Struct ; ebx不為0代表記憶體結構的條目尚未讀取完畢。
    jmp	    Label_Get_Mem_OK

Label_Get_Mem_Fail:            ; 如果讀取失敗時才會填入信息

    mov	    ax,	    1301h
    mov	    bx,	    008Ch
    mov	    dx,	    0500h		;row 5
    mov	    cx,	    23
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    GetMemStructErrMessage
    int	    10h
    jmp	    $

Label_Get_Mem_OK:              ; 成功讀取時
	
    mov	    ax,	    1301h
    mov	    bx,	    000Fh
    mov	    dx,	    0600h		;row 6
    mov     cx,	    29
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    GetMemStructOKMessage
    int	    10h	

;=======	get SVGA information

    mov	    ax,	    1301h
    mov	    bx,	    000Fh
    mov	    dx,	    0800h		;row 8
    mov	    cx,	    23
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,     StartGetSVGAVBEInfoMessage
    int	    10h

    mov	    ax,	    0x00
    mov	    es,	    ax
    mov	    di,	    0x8000
    mov	    ax,	    4F00h

    int	    10h

    cmp	    ax,	    004Fh

    jz      .KO
	
;=======    Fail

    mov 	ax,	    1301h
    mov	    bx,	    008Ch
    mov	    dx,	    0900h		;row 9
    mov	    cx,	    23
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    GetSVGAVBEInfoErrMessage
    int	    10h

    jmp	    $

.KO:

    mov	    ax,	    1301h
    mov	    bx,	    000Fh
    mov	    dx,	    0A00h       ;row 10
    mov	    cx,	    29
    push    ax
    mov	    ax,	    ds
    mov	    es,	    ax
    pop	    ax
    mov	    bp,	    GetSVGAVBEInfoOKMessage
    int	    10h
```
物理地址空間由一個結構數組組成，計算機的地址空間劃分可透過查找這個結構體得到，他所記錄的空間類型包括，可用物理內存、設備暫存器地址、內存空洞等，這部分的內容將在這本書的第7章詳細解釋。這一段程式透過BIOS INT 15h獲取物理地址空間信息，並保存在0x7E00，作業系統將在初始化內存管理時解析他。下表為BIOS INT 15h E820h輸入的說明。詳細資料可參考此連結 [x86 Memory Map](https://waynestalk.com/x86-memory-map/)

| 暫存器 | 功能           | 描述                                              |
|:------ |:-------------- |:------------------------------------------------- |
| EAX    | Function Code  | E820h                                             |
| EBX    | Continuation   | 用於指向內存區域，第一次讀取或是讀取完成這個值為0 |
| ES:DI  | Buffer Pointer | Address Range Descriptor會填到這個地址            |
| ECX    | Buffer Size    | Buffer大小                                        |
| EDX    | Signature      | ‘SMAP’（0x534D4150）這表示請求 system map信息     |

下表則是BIOS int 15h E820h的輸出。

| 暫存器 | 功能           | 描述                                                             |
|:------ |:-------------- |:---------------------------------------------------------------- |
| CF     | Carry Flag     | 沒有發生錯誤時CF = 0，若有CF = 1                                 |
| EAX    | Signature      | ‘SMAP’（0x534D4150）。                                           |
| ES:DI  | Buffer Pointer | Address Range Descriptor的回傳地址                               |
| ECX    | Buffer Size    | BIOS回傳填入的Buffer大小                                         |
| EBX    | Continuation   | 以此值取得下一個 Address Range Descriptor。若為0表示這是最後一個 |

下表則為Address Range Descriptor的信息，這個描述符可能為20 byte或是24 byte這取決於是否有Extended attribute。

| offset | 名稱                | 描述           |
|:------ |:------------------- |:-------------- |
| 0      | BaseAddrLow         | 基地址的低32位 |
| 4      | BaseAddrHigh        | 基地址的高32位 |
| 8      | LengthLow           | 長度的低32位   |
| 12     | LengthHigh          | 長度的高32位   |
| 16     | Type                | 內存區域的類型 |
| 20     | Extended Attributes |              |

下表為關於type的描述


| 值  | 名稱                  | 是否可被OS使用 | 描述                                        |
| --- | --------------------- |:-------------- | ----------------------------------------- |
| 1   | AddressRangeMemory    | 是             | 可用的RAM                                   |
| 2   | AddressRangeReserved  | 否             | 保留給系統用，OS不可使用                    |
| 3   | AddressRangeACPI      | 是             | ACPI Reclaim Memory，讀取ACPI table後OS可用 |
| 4   | AddressRangeNVS       | 否             | ACPI NVS Memory，保留給系統，OS不可使用     |
| 5   | AddressRange Unusable | 否             | 包含偵測到壞掉的記憶體                      |

接著我們希望可以調出SVGA晶片的顯示模式。
```
;=======    set the SVGA mode(VESA VBE)

    mov	    ax,	    4F02h ; 設定VBE mode
    mov	    bx,     4180h ; mode : 0x180 or 0x143
    int     10h

    cmp	    ax,     004Fh ; 確認操作是否成功
    jnz     Label_SET_SVGA_Mode_VESA_VBE_FAIL
```
我們可調用INT 10h 並設置AX = 4F02h以設置SVGA顯示晶片的顯示模式。
![image](https://hackmd.io/_uploads/rJvTUaeYA.png)
![image](https://hackmd.io/_uploads/Hke0U6xtC.png)
![image](https://hackmd.io/_uploads/r1peD6xKA.png)
這幾張圖是手冊上有關INT 10h AX = 4F02h的說明。AX = 4F02h這個功能號用於設定VBE模式。
因此設定bx = 4180h實際上就是指 don't clear display memory bit， windowed frame buffer model，而模式號為0x180。接著確認ax暫存器的返回值是否為004Fh來判斷是否操作成功。下表為Bochs虛擬平台SVGA顯示晶片的信息。


| 模式  | 列   | 行  | 物理地址  | 相素點位寬 |
| ----- | ---- | --- | --------- |:---------- |
| 0x180 | 1440 | 900 | e0000000h | 32 bit     |
| 0x143 | 800  | 600 | e0000000h | 32 bit     |

## 從實模式進入保護模式在到IA-32e模式
在保護模式裡，處理器依照權限將程式的執行級別劃分為4個等級，從最高的系統權限ring 0 - 到最低的ring 3。ring 0應被系統核心所使用，而最低等級ring 3應提供給應用程式使用(書上說Linux目前只使用0和3兩種等級)。而ring 1、ring 2則通常做為系統應用服務程式所使用。保護模式除了引入程序的權限控制外，還增添了分頁功能。分頁功能將龐大的地址空間劃分成固定大小的內存頁面，這樣不僅便於管理，還減少了應用程序的內存浪費。然而，段結構的複雜性、段間權限檢測的繁瑣性，使這些措施顯得笨重且限制了編程的靈活性，並且由於引入了頁管理單元，段變的的多餘。隨著硬體速度的提升和對大容量內存需求的增加，IA-32e模式便因應而生。IA-32e模式簡化了段保護的複雜性，並提升了內存尋址能力並擴展頁管理單元的結構和頁面大小，並引入了新的系統調用方式和高級可編程中斷控制器。

### 進入保護模式
為了進入保護模式，處理器必須在切換模式前在內存中建立一段可在保護模式下執行的程式碼與數據結構。其中相關的數據結構包含LDT、GDT、LDT(LDT可選)、任務狀態段TSS結構、至少一個頁目錄和頁表(如果有開啟分頁機制)、與至少一個異常/中斷處理模組。此外讓處理器切換到保護模式前，還需要初始化GDTR、IDTR暫存器(可推遲到進入保護模式後，但必須在進入第一個中斷前完成)、控制暫存器CR1-CR4、MTTEs內存範圍類型暫存器。

系統數據結構:
在進入保護模式前需要建立一個具有程式碼段與數據段的GDT（Global Descriptor Table）。GDT是一個全局數據結構，用於定義系統中各個段的屬性與邊界。建立GDT後，必須使用LGDT指令將其載入GDTR暫存器中，LGDT指令接受一個內存操作數，這個操作數指向GDT的基地址與長度的結構體。加載後CPU就知道如何選擇段選擇子，可在保護模式下控制段的訪問。GDT最多保存8192個描述符，前三個描述符有特殊的定義。GDT的第一項必須定義為NULL，用於觸發general protection exception，防止訪問無效的段。
intel Volume 3A: System Programming Guide 3.4.2節寫到
>The first entry of the GDT is not used by the processor. A segment selector that points to this entry of the GDT (that is, a segment selector with an index of 0 and the TI flag set to 0) is used as a “null segment selector.” The processor does not generate an exception when a segment register (other than the CS or SS registers) is loaded with a null selector. It does, however, generate an exception when a segment register holding a null selector is used to access memory. A null selector can be used to initialize unused segment registers. Loading the CS or SS register with a null segment selector causes a general-protection exception (#GP) to be generated.
第2、第3項則用於定義作業系統的數據段與程式碼段。另外保護模式下的SS(Stack Segment)只需使用可讀寫的數據段即可，無須建立專用的描述符。
。另外可採用LDT(Local Descriptor Table)來管理應用程式的段，他與GDT類似但他是位特定任務服務的，我們無法在其他的段中直接訪問LGDT。LGDT必須保存在GDT中，若希望開啟分頁則需準備頁目錄與頁表項。

中斷和異常:
在保護模式下，中斷和異常處理程序由中斷描述符表（Interrupt Descriptor Table，IDT）管理。IDT由若干個門描述符組成，如果使用中斷門或陷阱門描述符，它們可以直接指向異常處理程序。如果使用任務門描述符，則必須為程序準備TSS（任務狀態段）描述符、額外的程序碼段、數據段與任務段描述符等結構。如果處理器允許接收外部中斷請求，則IDT還必須為每個中斷處理程序建立門描述符。在使用IDT之前，必須使用LIDT彙編指令將其加載到IDTR寄存器中，通常在處理器切換到保護模式前進行加載。IDT最多可有256個描述符。

分頁機制:
CR0控制暫存器的PG標誌位用於控制分頁機制的開啟和關閉，開啟PG標至位前，必須在內存至中建立一個頁目錄與頁表，並將頁目錄的物理地址載入CR3控制暫存器(也稱PDBR暫存器)。

多任務機制:
如果希望使用多任務機制或允許改變特權權級，則必須創建至少一個任務狀態段TSS結構與TSS段的描述符。在使用TSS結構之前，必須使用LTR指令將其加載至TR暫存器中，這個過程只能在進入保護模式後執行。另外這個表也必須保存在GDT中。當發生任務切換時，CPU會將當前暫存器的值存入TSS結構中，等待任務被切會回來時恢復。以下是TSS32的結構架構與tss。
```
struct TSS32{
        int backlink,esp0,ss0,esp1,ss1,esp2,ss2,cr3;
        int eip,eflags,edx,ecx,edx,ebx,esp,ebp,esi,edi;
        int es,cs,ss,ds,fs,gs;
        int ldtr,iomap;
};
```
![image](https://hackmd.io/_uploads/r1WgVgWt0.png)

接著我們來建立一個臨時的GDT表。
```
LABEL_GDT:    dd      0,    0							; 0 是因為第一個GDT描述符必須為NULL
LABEL_DESC_CODE32:    dd    0x0000FFFF,    0x00CF9A00
LABEL_DESC_DATA32:    dd    0x0000FFFF,    0x00CF9200

GdtLen    equ    $ - LABEL_GDT	; 這裡計算GDT長度
GdtPtr    dw     GdtLen - 1		; GDTR載入6 byte資料,前2 byte為limit
    dd    LABEL_GDT				; 後4 byte為GDT的起始地址

SelectorCode32    equ    LABEL_DESC_CODE32 - LABEL_GDT	
SelectorData32    equ    LABEL_DESC_DATA32 - LABEL_GDT
```
作者說藉由定義程式碼段與數據段到地址為0的地方可以避免保護模式段結構的複雜性。他將段基址設為0x00000000，段限長設為0xffffffff，讓段可以索引0-4GB的地址空間。GDTR暫存器是一個6byte的結構必須使用助LGDT指令才可把GDT表的基地址與長度放入GDTR暫存器，其中低位的2 byte用於保存表的長度(就是這裡限定描述符最多有8192個，因為每個描述符為8 byte，8192 * 8 = 2 ^ (13 + 3) = 2 ^ 16)，高的4byte (可表示4GB的內存)用於保存表的基地址，標示符GdtPtr為此結構的起始地址。另外標示符SelectorCode32與SelectorData32是兩個段選擇子，他們用於描述，GDT表中的索引號。
以下的程式碼用於建立IDT的內存空間。
```
;=======	tmp IDT

IDT:
    times   0x50    dq  0
IDT_END:

IDT_POINTER:
        dw  IDT_END - IDT - 1
        dd  IDT
```
在進入保護模式前使用指令CLI禁止外部中斷發生，因此切換至保護模式的過程中不會發生任何中斷和異常，因此不需要完整的初始化IDT，只需要有相應的結構體就好。
以下的步驟可進入保護模式。
> 1.執行CLI指令可屏蔽外部中斷，對於不可屏蔽中斷NMI必須借助外部電路禁止。(模式切換不可以有異常和中斷發生)<br>
> 2.執行LGDT址另將GDT的基地址與長度載入GDTR暫存器。<br>
> 3.執行MOV CR0指令控制暫存器的PE(表示保護模式)標誌位，可同時設定PG標誌位(可開啟分頁)。<br>
> 4.MOV CR0指令結束後，必須緊隨far JMP或far CALL指令，跳到保護模式的程式碼段執行。<br>
> 5.通過執行JMP或CALL指令，可改變處理器的執行流水線(pipeline)，使處理器加載值型保護模式的程式碼段。<br>
> 6.如果開啟分頁機制，far JMP/ far CALL指令和MOV CR0必須位於同一個地址映射的頁中，而far JMP/ far CALL跳轉後的目標地址則無需同一性的地址映射，線性地址(虛擬地址)不需要與物理地址重合。<br>
> 7.若使用IDT，必須借助LLDT指令將GDT內的LDT段選擇子加載到LDTR暫存器。<br>
> 8.執行LTTR指令將一個TSS段描述符的段選擇子加載到TR任務暫存器，處理器對TSS碟購的位置沒有要求，只要是可以讀寫的內存區域皆可。<br>
> 9.進入保護模式後，數據段暫存器仍然保留時模式下的段數據，必須重新加載段選擇子或是使用JMP/CALL指令執行新任務，便可將其更新為保護模式。(步驟4已將CS程式碼暫存器更新為保護模式)。對於不使用的數據段暫存器(DS與SS例外)可以設定為0將NULL段選擇子載入其中。<br>
> 10.執行LIDT指令，將保護模式下的IDT表的基地址與長度載入LDTR暫存器。<br>
> 11.執行STI指令可恢復中斷。

```
;=======    init IDT GDT goto protect mode 

    cli         ;======close interrupt

    db      0x66
    lgdt    [GdtPtr]

;	db	0x66
;	lidt	[IDT_POINTER]

    mov     eax,    cr0
    or      eax,    1       ; 這裡把PE設為1表是進入保護模式
    mov     cr0,    eax	

    jmp     dword SelectorCode32:GO_TO_TMP_Protect ; 切換到保護模式的程式碼段
```
插入db 0x66是為了修飾當前指令的操作數的位寬是32位元。而SelectorCode32為跳轉後目標程式碼的段選擇子，GO_TO_TMP_Protect則為段內偏移地址。

### 進入IA-32e模式
開啟IA-32e模式後，存放個描述符表的暫存器仍然沿用保護模式的描述符表，如:GDTR、LDTR、IDTR、TR。但是這些暫存器必須重新加載為提供IA-32e模式使用的64為元描述符表，可透過LGDT、LLDT、LIDT、LTR指令完成。另外IDTR在更新為64位中斷描述符前不可觸發中斷或是異常，否則處理器會將32位元兼容模式的中斷門解釋成64位中斷門。
IA32_EFER暫存器（在MSR暫存器组内）的LME標誌位控制IA-32e模式的開啟與關閉。IA-32e模式將物理地址擴展為4層頁表結構 (這跟Linux系統page table是4層有關嗎?)(另外好像linux好像在4.14版本後支援5層，這是因為有處理器支援5層頁表結構)。處於保護模式時CR3暫存其只有前32位可以寫入數據，而開啟IA-32e模式後則可重定位頁表，到物理內存空間的任何地方。以下為IA-32e模式的標準初始化工作。
![image](https://hackmd.io/_uploads/SyVlyXGYC.png)
這張圖片摘錄自CSAPP中文版圖9-18


>1.復位CR0控制暫存器的PG(paging)標誌位，關閉分頁機制。此後的指令必須位於同一性地址映射的頁面中。 <br/>
>2.設定CR4暫存器的PAE(Physical Address Extension)標誌位。若在IA-32e模式初始化過程中失敗，會觸發保護性異常(#GP)。<br/>
>3.將頁目錄的物理地址加載到CR3暫存器中。<br/>
>4.設定IA32_EFER暫存器的LME標誌位開啟IA-32e模式。<br/>
>5.開啟CR0控制暫存器的PG標誌位，開啟分頁機制，此時處理器位自動置位IA32_ERER暫存器的LME標誌位。此後在進入IA-32e模式前都必須在同一性地址映射的頁面內。<br/>

如果嘗試改變一些會影響IA-32e模式開啟的標誌位如IA32_EFER.LME、CR0.PG、CR4.PAE等，處理器會進行64位的一致性檢測，確保處理器不會進到位定義的模式。假設檢測失敗就會觸發通用保護性異常，以下的操作將會導致一致性檢測失敗。
>1.沒有關閉分頁機制就開啟或是禁止IA-32e模式。<br/>
>2.啟動IA-32e模式後，沒有開啟物理地址擴展功能PAE，就試圖開啟分頁機制。<br/>
>3.啟動IA-32e模式後，關閉PAE功能。<br/>
>4.當CS段暫存器的L被置位時，啟動IA-32e模式。<br/>
>5.TR暫存器載入的是16位元TSS結構。<br/>

```
[SECTION gdt64]

LABEL_GDT64:        dq    0x0000000000000000
LABEL_DESC_CODE64:  dq    0x0020980000000000
LABEL_DESC_DATA64:  dq    0x0000920000000000

GdtLen64    equ	$ - LABEL_GDT64
GdtPtr64    dw	GdtLen64 - 1
    dd      LABEL_GDT64

SelectorCode64    equ    LABEL_DESC_CODE64 - LABEL_GDT64
SelectorData64    equ    LABEL_DESC_DATA64 - LABEL_GDT64
```
這裡是書中提供的用於切換至IA-32e模式所使用的臨時GDT表數據。書上說IA-32e簡化保護模式的段結構，刪除冗餘的段基地址和段限長，讓段直接覆蓋整個限性地址空間，進而變成平坦地址空間。(在64位元架構下CS、DS、ES、SS 會被設為0將不用於記憶體尋址的工作)
接著得檢驗CPU是否支援IA-32e模式，cpuid指令的擴展功能項，0x80000001的第29位，只是處理器是否支援IA-32e模式。所以需要檢查處理器對於cpuid指令的支援狀況，只有當這個擴展功號大於0x80000000時，才有可能支持64位的長模式。
```
support_long_mode:

    mov	    eax,    0x80000000 ; 設定這個值時cpuid會返回最大的支持功能號
    cpuid
    cmp	    eax,    0x80000001 ; cmp 相當於把兩值相減。
    setnb   al				   ; set if above or equal
    jb      support_long_mode_done
    mov	    eax,    0x80000001
    cpuid
    bt      edx,    29		   ; 檢查返回值的第29位如果這一位為1表示支援IA-32e
    setc    al
support_long_mode_done:

    movzx   eax,    al
    ret
	
```
下面是書中關於轉換至IA-32e模式的設定，流程就如標準程序一般。
```

;=======    init temporary page table 0x90000

    mov	    dword   [0x90000],  0x91007
    mov	    dword   [0x90800],  0x91007		

    mov	    dword   [0x91000],  0x92007

    mov	    dword   [0x92000],  0x000083

    mov	    dword   [0x92008],  0x200083

    mov	    dword   [0x92010],  0x400083

    mov	    dword   [0x92018],  0x600083

    mov	    dword   [0x92020],  0x800083

    mov	    dword   [0x92028],  0xa00083

;=======    load GDTR

    db      0x66			; 32位元指令前綴
    lgdt    [GdtPtr64]
    mov	    ax,     0x10
    mov	    ds,	    ax		; 這些暫存器會在開啟IA-32e模式後失效(全部歸0)，只有CS運行在保護模式下。
    mov	    es,	    ax
    mov	    fs,	    ax
    mov	    gs,	    ax
    mov	    ss,	    ax

    mov	    esp,    7E00h

;=======	open PAE

    mov	    eax,    cr4
    bts	    eax,    5		; 設定第5位(這一位表示PAE)
    mov	    cr4,    eax

;=======    load    cr3

    mov	    eax,    0x90000 ; 這是頁目錄的物理地址。
    mov	    cr3,    eax

;=======	enable long-mode

    mov	    ecx,    0C0000080h		; IA32_EFER (位於MSR暫存器組)的地址
    rdmsr							; 可用於訪問64位元MSR暫存器

    bts	    eax,    8
    wrmsr							; 將eax寫入MSR暫存器

;=======	open PE and paging

    mov     eax,    cr0
    bts	    eax,    0
    bts	    eax,    31				; 第31位用於控制開啟分頁功能
    mov	    cr0,    eax

    jmp	SelectorCode64:OffsetOfKernelFile
```
到這裡處理器已經進入IA-32e模式，但是處理器仍然在處理保護模式的程式，也就是在64位元架構下執行32位元模式的程式，需要透過遠跳轉或是遠調用指令將CS暫存器的值改成IA-32e程式碼段的描述符，至此才真正進入64位元架構。下圖為在bochs虛擬平台上執行結果。
![image](https://hackmd.io/_uploads/BkdpxDWF0.png)

    