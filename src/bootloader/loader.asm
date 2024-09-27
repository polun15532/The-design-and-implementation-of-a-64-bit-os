;/***************************************************
;       版权声明
;
;   本操作系统名为：MINE
;   该操作系统未经授权不得以盈利或非盈利为目的进行开发，
;   只允许个人学习以及公开交流使用
;
;   代码最终所有权及解释权归田宇所有；
;
;   本模块作者： 田宇
;   EMail:  345538255@qq.com
;
;
;***************************************************/
; 以下程式碼僅作為學習使用，僅在田宇先生的程式碼上增添一些註釋


org     10000h
    jmp     Label_Start

%include    "fat12.inc"

BaseOfKernelFile            equ    0x00
OffsetOfKernelFile          equ    0x100000

BaseTmpOfKernelAddr         equ    0x00
OffsetTmpOfKernelFile       equ    0x7E00

MemoryStructBufferAddr      equ    0x7E00

[SECTION gdt]

LABEL_GDT:    dd      0,    0
LABEL_DESC_CODE32:    dd    0x0000FFFF,    0x00CF9A00
LABEL_DESC_DATA32:    dd    0x0000FFFF,    0x00CF9200

GdtLen    equ    $ - LABEL_GDT
GdtPtr    dw     GdtLen - 1
    dd    LABEL_GDT

SelectorCode32    equ    LABEL_DESC_CODE32 - LABEL_GDT
SelectorData32    equ    LABEL_DESC_DATA32 - LABEL_GDT

[SECTION gdt64]

LABEL_GDT64:        dq    0x0000000000000000
LABEL_DESC_CODE64:  dq    0x0020980000000000
LABEL_DESC_DATA64:  dq    0x0000920000000000

GdtLen64    equ $ - LABEL_GDT64
GdtPtr64    dw GdtLen64 - 1
    dd      LABEL_GDT64

SelectorCode64    equ    LABEL_DESC_CODE64 - LABEL_GDT64
SelectorData64    equ    LABEL_DESC_DATA64 - LABEL_GDT64

[SECTION .s16]
[BITS 16]

Label_Start:

    mov     ax,     cs
    mov     ds,     ax
    mov     es,     ax
    mov     ax,     0x00
    mov     ss,     ax
    mov     sp,     0x7c00      ; boot的工作做完了此時可以把sp設回0x7c00捨棄boot的數據

;=======    display on screen：Start Loader......

    mov     ax,     1301h
    mov     bx,     000fh
    mov     dx,     0200h       ; row 2
    mov     cx,     12
    push    ax
    mov     ax,     ds          ; 其實可以把這兩條指令放在mov ax, 1301h前面，這樣可以省下phsh與pop指令。
    mov     es,     ax
    pop     ax
    mov     bp,     StartLoaderMessage
    int     10h

;======= open address A20
    push    ax
    in      al,     92h            ; 從端口 0x92 讀取值
    or      al,     00000010b      ; 端口 0x92的bit1可控制A20 gate (0為關閉，1為開啟)，早期是透過鍵盤控制器激活，需使用2端口0x64與0x60
    out     92h,    al             ; 開啟A20 gate
    pop     ax

    cli                            ; 禁用CPU中斷，防止進入保護模式實受到干擾。

    db     0x66                    ; 表示接下來指令是32位操作。
    lgdt    [GdtPtr]               ; 加載GDT

    mov     eax,    cr0
    or     eax,    1               ; 將cr0的bit0設為1代表要切換到保護模式。
    mov     cr0,    eax

    mov     ax,     SelectorData32
    mov     fs,     ax
    mov     eax,    cr0
    and     al,     11111110b
    mov     cr0,    eax

    sti

;======= reset floppy

    xor     ah,     ah ; ah = 0; 復位磁碟機
    xor     dl,     dl
    int     13h

;======= search kernel.bin
    mov     word    [SectorNo],    SectorNumOfRootDirStart

Lable_Search_In_Root_Dir_Begin:

    cmp    word    [RootDirSizeForLoop],    0    ; 檢查標籤RootDirSizeForLoop地址的值是否為0
    jz     Label_No_LoaderBin                    ; 若為0代表根目錄扇區讀取完畢，跳轉到Label_No_KernelBin
    dec    word    [RootDirSizeForLoop]          ; 讀取新的扇區，把未讀取的扇區數量減一
    mov    ax,     00h
    mov    es,     ax                            ; 把es段暫存器歸0
    mov    bx,     8000h
    mov    ax,     [SectorNo]                    ; 將SectorNo存放的值移到AX
    mov    cl,     1                             ; 表示讀取1個扇區(這裡用cl作為函式的入參，當調用int 13h會把值放入al)
    call   Func_ReadOneSector
    mov    si,     KernelFileName                ; 把標籤KernelFileName的地址放入si
    mov    di,     8000h
    cld                                          ; 清除DF，保證後續操作字串指針時自動遞增
    mov    dx,     10h                           ; 根目錄區每扇區可以存放0x10個目錄項

Label_Search_For_LoaderBin:

    cmp     dx,     0                            
    jz      Label_Goto_Next_Sector_In_Root_Dir   ; dx=0表示所有目錄項都查過了，前往下一個扇區查找
    dec     dx                                   ; 讀取新目錄項，dx--
    mov     cx,     11                           ; 設定cx = 11是因為文件名 + 擴展名 = 8 + 3 = 11 byte

Label_Cmp_FileName:

    cmp     cx,     0
    jz      Label_FileName_Found                 ; cx = 0時所有字符成功配對，找到檔案。
    dec     cx
    lodsb                                        ; 將si所指向地址的字符取出放入al (cld保證向地址高位遞增)
    cmp     al,     byte    [es:di]              ; 將al值與[es:di]比較
    jz      Label_Go_On
    jmp     Label_Different                      ; 不同時跳轉Label_Different，比較下一個目錄項
                  
Label_Go_On:
 
    inc     di
    jmp     Label_Cmp_FileName

Label_Different:

    and     di,     0FFE0h                       ; 因為一個目錄項 32 byte 這裡需要對齊回目錄項的起始地址
    add     di,     20h                          ; 移動到下一個目錄項
    mov     si,     KernelFileName               ; 重新設置配對地址
    jmp     Label_Search_For_LoaderBin

Label_Goto_Next_Sector_In_Root_Dir:

    add     word    [SectorNo],  1               ; 移動到下個扇區
    jmp     Lable_Search_In_Root_Dir_Begin       ; 開始查找
 
;======= display on screen : ERROR:No KERNEL Found

Label_No_LoaderBin:

    mov     ax,     1301h                ; ah=13h表示顯示字串，al=01h表示寫入字串後將由標移到字串尾端
    mov     bx,     008ch                ; bh=00h表示頁碼(0為當前頁面)，bl=8ch表示字串顯示為紅色
    mov     dx,     0300h                ; row 3
    mov     cx,     21                   ; 寫入字符串長度
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     NoLoaderMessage      ; 將bp用作字串的指針。
    int     10h
    jmp     $

;======= found loader.bin name in root director struct

Label_FileName_Found:
    mov     ax,    RootDirSectors
    and     di,    0FFE0h                ; 這裡用於對齊FAT表項
    add     di,    01Ah                  ; 偏移量0x1A紀錄文件的起始cluster編號。
    mov     cx,    word     [es:di]      ; 把cluster編號放入cx暫存器中
    push    cx
    add     cx,    ax
    add     cx,    SectorBalance         ; 加上根目錄、FAT表項、保留扇區後得到正確的扇區位置
    mov     eax,   BaseTmpOfKernelAddr
    mov     es,    eax
    mov     bx,    OffsetTmpOfKernelFile ; 定義kernel文件轉存的內存位置在0x7E00每次讀入一個cluster時都先放在這裡
    mov     ax,    cx

Label_Go_On_Loading_File:
    push    ax
    push    bx
    mov     ah,    0Eh
    mov     al,    '.'                   ; 有幾個.代表讀取了多少cluster
    mov     bl,    0Fh
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
    ; 上面兩行的作用為將[ds:esi]的內容移動到[fs:edi]，開啟A20 gate後只讓fs暫存器可訪問0~4GB的內存空間，訪問地址超過0x100000就要用fs
    inc     esi
    inc     edi

    loop    Label_Mov_Kernel                           ; 用loop指令重複操作 (操作次數存在cx暫存器，每經過一次循環cx-=1)

    mov     eax,    0x1000
    mov     ds,     eax

    mov     dword   [OffsetOfKernelFileCount],  edi

    pop     esi
    pop     ds
    pop     edi
    pop     fs
    pop     eax
    pop     cx


    call    Func_GetFATEntry
    cmp     ax,  0FFFh
    jz      Label_File_Loaded
    push    ax
    mov     dx,     RootDirSectors
    add     ax,     dx
    add     ax,     SectorBalance

    jmp     Label_Go_On_Loading_File

Label_File_Loaded:
  
    mov     ax,     0B800h
    mov     gs,     ax
    mov     ah,     0Fh    ; 0000: 黑底    1111: 白字
    mov     al,     'G'
    mov     [gs:((80 * 0 + 39) * 2)],   ax ; 螢幕第0行第39列。

KillMotor:

    push    dx
    mov     dx,     03F2h
    mov     al,     0 
    out     dx,     al
    pop     dx

;=======    get memory address size type

    mov     ax,     1301h
    mov     bx,     000Fh       ; 黑底白字
    mov     dx,     0400h  ; row 4
    mov     cx,     24          ; 顯示24個字符
    push    ax                  ; 我很好奇作者位何不先設定sreg的值在做功能號的設定，這樣可以省下push pop操作。
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     StartGetMemStructMessage
    int     10h                ; 這一段用於顯示StartGetMemStructMessage

    mov     ebx,    0          ; 歸零暫存器，使用int 15h E820時，第一次調用時必須把這個值設為0
    mov     ax,     0x00       ;
    mov     es,     ax
    mov     di,     MemoryStructBufferAddr ; 地址為0x7E00

Label_Get_Mem_Struct:

    mov     eax,    0x0E820    ; 在int 15h中ah=E8h al=20h表示查詢系統地址對應,可獲得內存布局
    mov     ecx,    20         ; buffer的大小。返回的結構體大小為20 byte。
    mov     edx,    0x534D4150 ; 這一串數字由ascii表轉換可得到字串"SMAP"。BIOS用這個驗證是否請求system map資訊
    int     15h
    jc      Label_Get_Mem_Fail
    add     di,     20         ; +20是因為填入了20 byte的結構體。

    cmp     ebx,    0          ; 第一次呼叫或是內存掃描完畢這個值為0，如果不是就放入上次調用後的計數值。
    jne     Label_Get_Mem_Struct ; ebx不為0代表記憶體結構的條目尚未讀取完畢。
    jmp     Label_Get_Mem_OK

Label_Get_Mem_Fail:            ; 如果讀取失敗時才會填入信息

    mov     ax,     1301h
    mov     bx,     008Ch
    mov     dx,     0500h  ;row 5
    mov     cx,     23
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetMemStructErrMessage
    int     10h
    jmp     $

Label_Get_Mem_OK:              ; 成功讀取時
 
    mov     ax,     1301h
    mov     bx,     000Fh
    mov     dx,     0600h ;row 6
    mov     cx,     29
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetMemStructOKMessage
    int     10h 

;======= get SVGA information

    mov     ax,     1301h
    mov     bx,     000Fh
    mov     dx,     0800h  ;row 8
    mov     cx,     23
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     StartGetSVGAVBEInfoMessage
    int     10h

    mov     ax,     0x00
    mov     es,     ax
    mov     di,     0x8000
    mov     ax,     4F00h

    int     10h

    cmp     ax,     004Fh

    jz      .KO
 
;=======    Fail

    mov     ax,     1301h
    mov     bx,     008Ch
    mov     dx,     0900h  ;row 9
    mov     cx,     23
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetSVGAVBEInfoErrMessage
    int     10h

    jmp     $

.KO:

    mov     ax,     1301h
    mov     bx,     000Fh
    mov     dx,     0A00h       ;row 10
    mov     cx,     29
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetSVGAVBEInfoOKMessage
    int     10h

;======= Get SVGA Mode Info

    mov     ax,     1301h
    mov     bx,     000Fh
    mov     dx,     0C00h       ;row 12
    mov     cx,     24
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     StartGetSVGAModeInfoMessage
    int     10h


    mov     ax,     0x00
    mov     es,     ax
    mov     si,     0x800e

    mov     esi,    dword   [es:si]
    mov     edi,    0x8200

Label_SVGA_Mode_Info_Get:

    mov     cx,     word    [es:esi]

;=======    display SVGA mode information

    push    ax

    mov     ax,     00h
    mov     al,     ch
    call    Label_DispAL

    mov     ax,     00h
    mov     al,     cl 
    call    Label_DispAL
 
    pop     ax

;=======

    cmp     cx,     0FFFFh
    jz      Label_SVGA_Mode_Info_Finish

    mov     ax,     4F01h
    int     10h

    cmp     ax,     004Fh

    jnz     Label_SVGA_Mode_Info_FAIL 

    add     esi,    2
    add     edi,    0x100

    jmp     Label_SVGA_Mode_Info_Get
  
Label_SVGA_Mode_Info_FAIL:

    mov     ax,     1301h
    mov     bx,     008Ch
    mov     dx,     0D00h       ;row 13
    mov     cx,     24
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetSVGAModeInfoErrMessage
    int     10h

Label_SET_SVGA_Mode_VESA_VBE_FAIL:

    jmp     $

Label_SVGA_Mode_Info_Finish:

    mov     ax,     1301h
    mov     bx,     000Fh
    mov     dx,     0E00h       ;row 14
    mov     cx,     30
    push    ax
    mov     ax,     ds
    mov     es,     ax
    pop     ax
    mov     bp,     GetSVGAModeInfoOKMessage
    int     10h

;=======    set the SVGA mode(VESA VBE)

    mov     ax,     4F02h; 設定VBE mode
    mov     bx,     4180h;
    int     10h

    cmp     ax,     004Fh ; 確認操作是否成功
    jnz     Label_SET_SVGA_Mode_VESA_VBE_FAIL

;=======    init IDT GDT goto protect mode 

    cli         ;======close interrupt

    db      0x66
    lgdt    [GdtPtr]

    mov     eax,    cr0
    or      eax,    1       ; 這裡把PE設為1表是進入保護模式
    mov     cr0,    eax 

    jmp     dword SelectorCode32:GO_TO_TMP_Protect ; 切換到保護模式的程式碼段

[SECTION .s32]
[BITS 32]

GO_TO_TMP_Protect:

;=======    go to tmp long mode

    mov     ax,     0x10
    mov     ds,     ax
    mov     es,     ax
    mov     fs,     ax
    mov     ss,     ax
    mov     esp,    7E00h

    call    support_long_mode
    test    eax,    eax

    jz      no_support

;=======    init temporary page table 0x90000

    mov     dword   [0x90000],  0x91007
    mov     dword   [0x90800],  0x91007  

    mov     dword   [0x91000],  0x92007

    mov     dword   [0x92000],  0x000083

    mov     dword   [0x92008],  0x200083

    mov     dword   [0x92010],  0x400083

    mov     dword   [0x92018],  0x600083

    mov     dword   [0x92020],  0x800083

    mov     dword   [0x92028],  0xa00083

;=======    load GDTR

    db      0x66
    lgdt    [GdtPtr64]
    mov     ax,     0x10
    mov     ds,     ax
    mov     es,     ax
    mov     fs,     ax
    mov     gs,     ax
    mov     ss,     ax

    mov     esp,    7E00h

;======= open PAE

    mov     eax,    cr4
    bts     eax,    5
    mov     cr4,    eax

;=======    load    cr3

    mov     eax,    0x90000
    mov     cr3,    eax

;======= enable long-mode

    mov     ecx,    0C0000080h  ;IA32_EFER
    rdmsr

    bts     eax,    8
    wrmsr

;======= open PE and paging

    mov     eax,    cr0
    bts     eax,    0
    bts     eax,    31
    mov     cr0,    eax

    jmp SelectorCode64:OffsetOfKernelFile

;=======    test support long mode or not

support_long_mode:

    mov     eax,    0x80000000
    cpuid
    cmp     eax,    0x80000001
    setnb   al 
    jb      support_long_mode_done
    mov     eax,    0x80000001
    cpuid
    bt      edx,    29
    setc    al
support_long_mode_done:

    movzx   eax,    al
    ret

;=======    no support

no_support:
    jmp $

;=======    read one sector from floppy

[SECTION .s16lib]
[BITS 16]

Func_ReadOneSector:
 
    push    bp
    mov     bp,     sp
    sub     esp,    2
    mov     byte    [bp - 2],   cl
    push    bx
    mov     bl,     [BPB_SecPerTrk]
    div     bl
    inc     ah
    mov     cl,     ah
    mov     dh,     al
    shr     al,     1
    mov     ch,     al
    and     dh,     1
    pop     bx
    mov     dl,     [BS_DrvNum]
Label_Go_On_Reading:
    mov     ah,     2
    mov     al,     byte    [bp - 2]
    int     13h
    jc      Label_Go_On_Reading
    add     esp,    2
    pop     bp
    ret

;=======    get FAT Entry

Func_GetFATEntry:

    push    es
    push    bx
    push    ax
    mov     ax,     00
    mov     es,     ax
    pop     ax
    mov     byte    [Odd],  0
    mov     bx,     3
    mul     bx
    mov     bx,     2
    div     bx
    cmp     dx,     0
    jz      Label_Even
    mov     byte    [Odd],  1

Label_Even:

    xor     dx,     dx
    mov     bx,     [BPB_BytesPerSec]
    div     bx
    push    dx
    mov     bx,     8000h
    add     ax,     SectorNumOfFAT1Start
    mov     cl,     2
    call    Func_ReadOneSector
 
    pop     dx
    add     bx,     dx
    mov     ax,     [es:bx]
    cmp     byte    [Odd],  1
    jnz     Label_Even_2
    shr     ax,     4

Label_Even_2:
    and     ax,     0FFFh
    pop     bx
    pop     es
    ret

;======= display num in al

Label_DispAL:

    push    ecx
    push    edx
    push    edi

    mov     edi,    [DisplayPosition]
    mov     ah,     0Fh
    mov     dl,     al
    shr     al,     4
    mov     ecx,    2
.begin:

    and     al,     0Fh
    cmp     al,     9
    ja     .1
    add     al,     '0'
    jmp     .2
.1:

    sub     al,     0Ah
    add     al,     'A'
.2:

    mov     [gs:edi],   ax
    add     edi,    2
 
    mov     al,     dl
    loop .begin

    mov     [DisplayPosition],  edi

    pop     edi
    pop     edx
    pop     ecx

    ret


;=======    tmp IDT

IDT:
    times   0x50    dq  0
IDT_END:

IDT_POINTER:
        dw  IDT_END - IDT - 1
        dd  IDT

;=======    tmp variable

RootDirSizeForLoop  dw  RootDirSectors
SectorNo        dw  0
Odd             db  0
OffsetOfKernelFileCount dd  OffsetOfKernelFile

DisplayPosition     dd  0

;=======    display messages

StartLoaderMessage: db  "Start Loader"
NoLoaderMessage:    db  "ERROR:No KERNEL Found"
KernelFileName:     db  "KERNEL  BIN",0
StartGetMemStructMessage:   db  "Start Get Memory Struct."
GetMemStructErrMessage: db  "Get Memory Struct ERROR"
GetMemStructOKMessage:  db  "Get Memory Struct SUCCESSFUL!"

StartGetSVGAVBEInfoMessage: db  "Start Get SVGA VBE Info"
GetSVGAVBEInfoErrMessage:   db  "Get SVGA VBE Info ERROR"
GetSVGAVBEInfoOKMessage:    db  "Get SVGA VBE Info SUCCESSFUL!"

StartGetSVGAModeInfoMessage:    db  "Start Get SVGA Mode Info"
GetSVGAModeInfoErrMessage:  db  "Get SVGA Mode Info ERROR"
GetSVGAModeInfoOKMessage:   db  "Get SVGA Mode Info SUCCESSFUL!"
