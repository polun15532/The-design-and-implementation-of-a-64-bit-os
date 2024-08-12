;/***************************************************
;		版权声明
;
;	本操作系统名为：MINE
;	该操作系统未经授权不得以盈利或非盈利为目的进行开发，
;	只允许个人学习以及公开交流使用
;
;	代码最终所有权及解释权归田宇所有；
;
;	本模块作者：	田宇
;	EMail:		345538255@qq.com
;
;
;***************************************************/
; 以下程式碼僅作為學習使用，僅在田宇先生的程式碼上增添一些註釋

    org    0x7c00

BaseOfStack        equ    0x7c00
BaseOfLoader       equ    0x1000
OffsetOfLoader     equ    0x00

RootDirSectors             equ    14
SectorNumOfRootDirStart    equ    19
SectorNumOfFAT1Start       equ    1
SectorBalance              equ    17

    jmp    short    Label_Start
    nop
    BS_OEMName          db      'MINEboot'
    BPB_BytesPerSec     dw      512
    BPB_SecPerClus      db      1
    BPB_RsvdSecCnt      dw      1
    BPB_NumFATs         db      2
    bpb_rOOTeNTcNT      dw      224
    BPB_TotSec16        dw      2880
    BPB_Media           db      0xf0
    BPB_FATSz16         dw      9
    BPB_SecPerTrk       dw      18
    BPB_NumHeads        dw      2
    BPB_hiddSec         dd      0
    BPB_TotSec32        dd      0
    BS_DrvNum           db      0
    BS_Reserved1        db      0
    BS_BootSig          db      29h
    BS_VolID            dd      0
    BS_VolLab           db      'boot loader'
    BS_FileSysType      db      'FAT12   '

Label_Start:
    mov     ax,     cs
    mov     ds,     ax
    mov     es,     ax
    mov     ss,     ax
    mov     sp,     BaseOfStack

;=======    clear screen

    mov     ax,     0600h
    mov     bx,     0700h
    mov     cx,     0
    mov     dx,     0184fh
    int     10h

;=======    set focus

    mov     ax,     0200h
    mov     bx,     0000h
    mov     dx,     0000h
    int     10h

;=======    display on screen: Start Booting

    mov     ax,     1301h
    mov     bx,     000fh
    mov     dx,     0000h
    mov     cx,     10
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,      StartBootMessage
    INT     10h

;=======    reset floppy
    xor     ah,     ah
    xor     dl,     dl
    int     13h

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
    add	    bx,	    [BPB_BytesPerSec]       ; 加上512 byte避免資料被覆蓋。
    jmp	    Label_Go_On_Loading_File

Label_File_Loaded:

    jmp     BaseOfLoader:OffsetOfLoader     ; 跳轉至loader。

;=======    read one sector from floppy

Func_ReadOneSector:
	
    push    bp
    mov	    bp,	    sp
    sub 	esp,    2
    mov	    byte    [bp - 2],	cl
    push	bx
    mov	    bl,	    [BPB_SecPerTrk]
    div	    bl
    inc	    ah
    mov	    cl,	    ah
    mov	    dh,	    al
    shr	    al,	    1
    mov	    ch,	    al
    and	    dh,	    1
    pop	    bx
    mov	    dl,	    [BS_DrvNum]

Label_Go_On_Reading:

    mov	    ah,	    2
    mov	    al,	    byte	[bp - 2]
    int	    13h
    jc	    Label_Go_On_Reading
    add	    esp,	2
    pop	    bp
    ret

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

;=======    tmp variable

RootDirSizeForLoop      dw      RootDirSectors
SectorNo                dw      0
Odd                     db      0

;=======    display messages

StartBootMessage:   db      "Start Boot"
NoLoaderMessage:    db      "ERROR:No LOADER Found"
LoaderFileName:	    db      "LOADER  BIN",0

;=======    fill zero until whole sector

    times   510 - ($ - $$)      db      0
    dw      0xaa55
