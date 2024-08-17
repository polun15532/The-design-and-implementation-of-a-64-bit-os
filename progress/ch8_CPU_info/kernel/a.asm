
system:     file format elf64-x86-64


Disassembly of section .text:

ffff800000100000 <_start>:
ffff800000100000:	66 b8 10 00          	mov    $0x10,%ax
ffff800000100004:	8e d8                	mov    %eax,%ds
ffff800000100006:	8e c0                	mov    %eax,%es
ffff800000100008:	8e e0                	mov    %eax,%fs
ffff80000010000a:	8e d0                	mov    %eax,%ss
ffff80000010000c:	bc 00 7e 00 00       	mov    $0x7e00,%esp
ffff800000100011:	0f 01 15 20 af 00 00 	lgdt   0xaf20(%rip)        # ffff80000010af38 <GDT_END>
ffff800000100018:	0f 01 1d 23 bf 00 00 	lidt   0xbf23(%rip)        # ffff80000010bf42 <IDT_END>
ffff80000010001f:	66 b8 10 00          	mov    $0x10,%ax
ffff800000100023:	8e d8                	mov    %eax,%ds
ffff800000100025:	8e c0                	mov    %eax,%es
ffff800000100027:	8e e0                	mov    %eax,%fs
ffff800000100029:	8e e8                	mov    %eax,%gs
ffff80000010002b:	8e d0                	mov    %eax,%ss
ffff80000010002d:	48 c7 c4 00 7e 00 00 	mov    $0x7e00,%rsp
ffff800000100034:	48 c7 c0 00 10 10 00 	mov    $0x101000,%rax
ffff80000010003b:	0f 22 d8             	mov    %rax,%cr3
ffff80000010003e:	48 8b 05 05 00 00 00 	mov    0x5(%rip),%rax        # ffff80000010004a <switch_seg>
ffff800000100045:	6a 08                	push   $0x8
ffff800000100047:	50                   	push   %rax
ffff800000100048:	48 cb                	lretq  

ffff80000010004a <switch_seg>:
ffff80000010004a:	52                   	push   %rdx
ffff80000010004b:	00 10                	add    %dl,(%rax)
ffff80000010004d:	00 00                	add    %al,(%rax)
ffff80000010004f:	80 ff ff             	cmp    $0xff,%bh

ffff800000100052 <entry64>:
ffff800000100052:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
ffff800000100059:	48 8e d8             	mov    %rax,%ds
ffff80000010005c:	48 8e c0             	mov    %rax,%es
ffff80000010005f:	48 8e e8             	mov    %rax,%gs
ffff800000100062:	48 8e d0             	mov    %rax,%ss
ffff800000100065:	48 8b 25 49 01 00 00 	mov    0x149(%rip),%rsp        # ffff8000001001b5 <_stack_start>

ffff80000010006c <setup_IDT>:
ffff80000010006c:	48 8d 15 a6 00 00 00 	lea    0xa6(%rip),%rdx        # ffff800000100119 <ignore_int>
ffff800000100073:	48 c7 c0 00 00 08 00 	mov    $0x80000,%rax
ffff80000010007a:	66 89 d0             	mov    %dx,%ax
ffff80000010007d:	48 b9 00 00 00 00 00 	movabs $0x8e0000000000,%rcx
ffff800000100084:	8e 00 00 
ffff800000100087:	48 01 c8             	add    %rcx,%rax
ffff80000010008a:	89 d1                	mov    %edx,%ecx
ffff80000010008c:	c1 e9 10             	shr    $0x10,%ecx
ffff80000010008f:	48 c1 e1 30          	shl    $0x30,%rcx
ffff800000100093:	48 01 c8             	add    %rcx,%rax
ffff800000100096:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010009a:	48 8d 3d a1 ae 00 00 	lea    0xaea1(%rip),%rdi        # ffff80000010af42 <IDT_Table>
ffff8000001000a1:	48 c7 c1 00 01 00 00 	mov    $0x100,%rcx

ffff8000001000a8 <rp_sidt>:
ffff8000001000a8:	48 89 07             	mov    %rax,(%rdi)
ffff8000001000ab:	48 89 57 08          	mov    %rdx,0x8(%rdi)
ffff8000001000af:	48 83 c7 10          	add    $0x10,%rdi
ffff8000001000b3:	48 ff c9             	dec    %rcx
ffff8000001000b6:	75 f0                	jne    ffff8000001000a8 <rp_sidt>

ffff8000001000b8 <setup_TSS64>:
ffff8000001000b8:	48 8d 15 8d be 00 00 	lea    0xbe8d(%rip),%rdx        # ffff80000010bf4c <TSS64_Table>
ffff8000001000bf:	48 31 c0             	xor    %rax,%rax
ffff8000001000c2:	48 31 c9             	xor    %rcx,%rcx
ffff8000001000c5:	48 c7 c0 89 00 00 00 	mov    $0x89,%rax
ffff8000001000cc:	48 c1 e0 28          	shl    $0x28,%rax
ffff8000001000d0:	89 d1                	mov    %edx,%ecx
ffff8000001000d2:	c1 e9 18             	shr    $0x18,%ecx
ffff8000001000d5:	48 c1 e1 38          	shl    $0x38,%rcx
ffff8000001000d9:	48 01 c8             	add    %rcx,%rax
ffff8000001000dc:	48 31 c9             	xor    %rcx,%rcx
ffff8000001000df:	89 d1                	mov    %edx,%ecx
ffff8000001000e1:	81 e1 ff ff ff 00    	and    $0xffffff,%ecx
ffff8000001000e7:	48 c1 e1 10          	shl    $0x10,%rcx
ffff8000001000eb:	48 01 c8             	add    %rcx,%rax
ffff8000001000ee:	48 83 c0 67          	add    $0x67,%rax
ffff8000001000f2:	48 8d 3d a7 ad 00 00 	lea    0xada7(%rip),%rdi        # ffff80000010aea0 <GDT_Table>
ffff8000001000f9:	48 89 47 50          	mov    %rax,0x50(%rdi)
ffff8000001000fd:	48 c1 ea 20          	shr    $0x20,%rdx
ffff800000100101:	48 89 57 58          	mov    %rdx,0x58(%rdi)
ffff800000100105:	48 8b 05 05 00 00 00 	mov    0x5(%rip),%rax        # ffff800000100111 <go_to_kernel>
ffff80000010010c:	6a 08                	push   $0x8
ffff80000010010e:	50                   	push   %rax
ffff80000010010f:	48 cb                	lretq  

ffff800000100111 <go_to_kernel>:
ffff800000100111:	b0 44                	mov    $0x44,%al
ffff800000100113:	10 00                	adc    %al,(%rax)
ffff800000100115:	00                   	.byte 0x0
ffff800000100116:	80 ff ff             	cmp    $0xff,%bh

ffff800000100119 <ignore_int>:
ffff800000100119:	fc                   	cld    
ffff80000010011a:	50                   	push   %rax
ffff80000010011b:	53                   	push   %rbx
ffff80000010011c:	51                   	push   %rcx
ffff80000010011d:	52                   	push   %rdx
ffff80000010011e:	55                   	push   %rbp
ffff80000010011f:	57                   	push   %rdi
ffff800000100120:	56                   	push   %rsi
ffff800000100121:	41 50                	push   %r8
ffff800000100123:	41 51                	push   %r9
ffff800000100125:	41 52                	push   %r10
ffff800000100127:	41 53                	push   %r11
ffff800000100129:	41 54                	push   %r12
ffff80000010012b:	41 55                	push   %r13
ffff80000010012d:	41 56                	push   %r14
ffff80000010012f:	41 57                	push   %r15
ffff800000100131:	48 8c c0             	mov    %es,%rax
ffff800000100134:	50                   	push   %rax
ffff800000100135:	48 8c d8             	mov    %ds,%rax
ffff800000100138:	50                   	push   %rax
ffff800000100139:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
ffff800000100140:	48 8e d8             	mov    %rax,%ds
ffff800000100143:	48 8e c0             	mov    %rax,%es
ffff800000100146:	48 8d 05 45 00 00 00 	lea    0x45(%rip),%rax        # ffff800000100192 <int_msg>
ffff80000010014d:	50                   	push   %rax
ffff80000010014e:	48 89 c2             	mov    %rax,%rdx
ffff800000100151:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
ffff800000100158:	48 c7 c7 00 00 ff 00 	mov    $0xff0000,%rdi
ffff80000010015f:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax
ffff800000100166:	e8 a2 46 00 00       	call   ffff80000010480d <color_printk>
ffff80000010016b:	48 83 c4 08          	add    $0x8,%rsp

ffff80000010016f <Loop>:
ffff80000010016f:	eb fe                	jmp    ffff80000010016f <Loop>
ffff800000100171:	58                   	pop    %rax
ffff800000100172:	48 8e d8             	mov    %rax,%ds
ffff800000100175:	58                   	pop    %rax
ffff800000100176:	48 8e c0             	mov    %rax,%es
ffff800000100179:	41 5f                	pop    %r15
ffff80000010017b:	41 5e                	pop    %r14
ffff80000010017d:	41 5d                	pop    %r13
ffff80000010017f:	41 5c                	pop    %r12
ffff800000100181:	41 5b                	pop    %r11
ffff800000100183:	41 5a                	pop    %r10
ffff800000100185:	41 59                	pop    %r9
ffff800000100187:	41 58                	pop    %r8
ffff800000100189:	5e                   	pop    %rsi
ffff80000010018a:	5f                   	pop    %rdi
ffff80000010018b:	5d                   	pop    %rbp
ffff80000010018c:	5a                   	pop    %rdx
ffff80000010018d:	59                   	pop    %rcx
ffff80000010018e:	5b                   	pop    %rbx
ffff80000010018f:	58                   	pop    %rax
ffff800000100190:	48 cf                	iretq  

ffff800000100192 <int_msg>:
ffff800000100192:	55                   	push   %rbp
ffff800000100193:	6e                   	outsb  %ds:(%rsi),(%dx)
ffff800000100194:	6b 6e 6f 77          	imul   $0x77,0x6f(%rsi),%ebp
ffff800000100198:	6e                   	outsb  %ds:(%rsi),(%dx)
ffff800000100199:	20 69 6e             	and    %ch,0x6e(%rcx)
ffff80000010019c:	74 65                	je     ffff800000100203 <_stack_start+0x4e>
ffff80000010019e:	72 72                	jb     ffff800000100212 <_stack_start+0x5d>
ffff8000001001a0:	75 70                	jne    ffff800000100212 <_stack_start+0x5d>
ffff8000001001a2:	74 20                	je     ffff8000001001c4 <_stack_start+0xf>
ffff8000001001a4:	6f                   	outsl  %ds:(%rsi),(%dx)
ffff8000001001a5:	72 20                	jb     ffff8000001001c7 <_stack_start+0x12>
ffff8000001001a7:	66 61                	data16 (bad) 
ffff8000001001a9:	75 6c                	jne    ffff800000100217 <_stack_start+0x62>
ffff8000001001ab:	74 20                	je     ffff8000001001cd <_stack_start+0x18>
ffff8000001001ad:	61                   	(bad)  
ffff8000001001ae:	74 20                	je     ffff8000001001d0 <_stack_start+0x1b>
ffff8000001001b0:	52                   	push   %rdx
ffff8000001001b1:	49 50                	rex.WB push %r8
ffff8000001001b3:	0a 00                	or     (%rax),%al

ffff8000001001b5 <_stack_start>:
ffff8000001001b5:	00 00                	add    %al,(%rax)
ffff8000001001b7:	12 00                	adc    (%rax),%al
ffff8000001001b9:	00 80 ff ff 0f 1f    	add    %al,0x1f0fffff(%rax)
	...

ffff800000101000 <__PML4E>:
ffff800000101000:	07                   	(bad)  
ffff800000101001:	20 10                	and    %dl,(%rax)
	...
ffff8000001017ff:	00 07                	add    %al,(%rdi)
ffff800000101801:	20 10                	and    %dl,(%rax)
	...

ffff800000102000 <__PDPTE>:
ffff800000102000:	07                   	(bad)  
ffff800000102001:	30 10                	xor    %dl,(%rax)
	...

ffff800000103000 <__PDE>:
ffff800000103000:	87 00                	xchg   %eax,(%rax)
ffff800000103002:	00 00                	add    %al,(%rax)
ffff800000103004:	00 00                	add    %al,(%rax)
ffff800000103006:	00 00                	add    %al,(%rax)
ffff800000103008:	87 00                	xchg   %eax,(%rax)
ffff80000010300a:	20 00                	and    %al,(%rax)
ffff80000010300c:	00 00                	add    %al,(%rax)
ffff80000010300e:	00 00                	add    %al,(%rax)
ffff800000103010:	87 00                	xchg   %eax,(%rax)
ffff800000103012:	40 00 00             	rex add %al,(%rax)
ffff800000103015:	00 00                	add    %al,(%rax)
ffff800000103017:	00 87 00 60 00 00    	add    %al,0x6000(%rdi)
ffff80000010301d:	00 00                	add    %al,(%rax)
ffff80000010301f:	00 87 00 80 00 00    	add    %al,0x8000(%rdi)
ffff800000103025:	00 00                	add    %al,(%rax)
ffff800000103027:	00 87 00 00 e0 00    	add    %al,0xe00000(%rdi)
ffff80000010302d:	00 00                	add    %al,(%rax)
ffff80000010302f:	00 87 00 20 e0 00    	add    %al,0xe02000(%rdi)
ffff800000103035:	00 00                	add    %al,(%rax)
ffff800000103037:	00 87 00 40 e0 00    	add    %al,0xe04000(%rdi)
ffff80000010303d:	00 00                	add    %al,(%rax)
ffff80000010303f:	00 87 00 60 e0 00    	add    %al,0xe06000(%rdi)
ffff800000103045:	00 00                	add    %al,(%rax)
ffff800000103047:	00 87 00 80 e0 00    	add    %al,0xe08000(%rdi)
ffff80000010304d:	00 00                	add    %al,(%rax)
ffff80000010304f:	00 87 00 a0 e0 00    	add    %al,0xe0a000(%rdi)
ffff800000103055:	00 00                	add    %al,(%rax)
ffff800000103057:	00 87 00 c0 e0 00    	add    %al,0xe0c000(%rdi)
ffff80000010305d:	00 00                	add    %al,(%rax)
ffff80000010305f:	00 87 00 e0 e0 00    	add    %al,0xe0e000(%rdi)
	...

ffff800000104000 <RESTORE_ALL>:
ffff800000104000:	41 5f                	pop    %r15
ffff800000104002:	41 5e                	pop    %r14
ffff800000104004:	41 5d                	pop    %r13
ffff800000104006:	41 5c                	pop    %r12
ffff800000104008:	41 5b                	pop    %r11
ffff80000010400a:	41 5a                	pop    %r10
ffff80000010400c:	41 59                	pop    %r9
ffff80000010400e:	41 58                	pop    %r8
ffff800000104010:	5b                   	pop    %rbx
ffff800000104011:	59                   	pop    %rcx
ffff800000104012:	5a                   	pop    %rdx
ffff800000104013:	5e                   	pop    %rsi
ffff800000104014:	5f                   	pop    %rdi
ffff800000104015:	5d                   	pop    %rbp
ffff800000104016:	58                   	pop    %rax
ffff800000104017:	48 8e d8             	mov    %rax,%ds
ffff80000010401a:	58                   	pop    %rax
ffff80000010401b:	48 8e c0             	mov    %rax,%es
ffff80000010401e:	58                   	pop    %rax
ffff80000010401f:	48 83 c4 10          	add    $0x10,%rsp
ffff800000104023:	48 cf                	iretq  

ffff800000104025 <ret_from_intr>:
ffff800000104025:	eb d9                	jmp    ffff800000104000 <RESTORE_ALL>

ffff800000104027 <system_call>:
ffff800000104027:	fb                   	sti    
ffff800000104028:	48 83 ec 38          	sub    $0x38,%rsp
ffff80000010402c:	fc                   	cld    
ffff80000010402d:	50                   	push   %rax
ffff80000010402e:	48 8c c0             	mov    %es,%rax
ffff800000104031:	50                   	push   %rax
ffff800000104032:	48 8c d8             	mov    %ds,%rax
ffff800000104035:	50                   	push   %rax
ffff800000104036:	48 31 c0             	xor    %rax,%rax
ffff800000104039:	55                   	push   %rbp
ffff80000010403a:	57                   	push   %rdi
ffff80000010403b:	56                   	push   %rsi
ffff80000010403c:	52                   	push   %rdx
ffff80000010403d:	51                   	push   %rcx
ffff80000010403e:	53                   	push   %rbx
ffff80000010403f:	41 50                	push   %r8
ffff800000104041:	41 51                	push   %r9
ffff800000104043:	41 52                	push   %r10
ffff800000104045:	41 53                	push   %r11
ffff800000104047:	41 54                	push   %r12
ffff800000104049:	41 55                	push   %r13
ffff80000010404b:	41 56                	push   %r14
ffff80000010404d:	41 57                	push   %r15
ffff80000010404f:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000104056:	48 8e da             	mov    %rdx,%ds
ffff800000104059:	48 8e c2             	mov    %rdx,%es
ffff80000010405c:	48 89 e7             	mov    %rsp,%rdi
ffff80000010405f:	e8 d0 63 00 00       	call   ffff80000010a434 <system_call_function>

ffff800000104064 <ret_system_call>:
ffff800000104064:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
ffff80000010406b:	00 
ffff80000010406c:	41 5f                	pop    %r15
ffff80000010406e:	41 5e                	pop    %r14
ffff800000104070:	41 5d                	pop    %r13
ffff800000104072:	41 5c                	pop    %r12
ffff800000104074:	41 5b                	pop    %r11
ffff800000104076:	41 5a                	pop    %r10
ffff800000104078:	41 59                	pop    %r9
ffff80000010407a:	41 58                	pop    %r8
ffff80000010407c:	5b                   	pop    %rbx
ffff80000010407d:	59                   	pop    %rcx
ffff80000010407e:	5a                   	pop    %rdx
ffff80000010407f:	5e                   	pop    %rsi
ffff800000104080:	5f                   	pop    %rdi
ffff800000104081:	5d                   	pop    %rbp
ffff800000104082:	58                   	pop    %rax
ffff800000104083:	48 8e d8             	mov    %rax,%ds
ffff800000104086:	58                   	pop    %rax
ffff800000104087:	48 8e c0             	mov    %rax,%es
ffff80000010408a:	58                   	pop    %rax
ffff80000010408b:	48 83 c4 38          	add    $0x38,%rsp
ffff80000010408f:	48 0f 35             	sysexitq 

ffff800000104092 <divide_error>:
ffff800000104092:	6a 00                	push   $0x0
ffff800000104094:	50                   	push   %rax
ffff800000104095:	48 8d 05 39 21 00 00 	lea    0x2139(%rip),%rax        # ffff8000001061d5 <do_divide_error>
ffff80000010409c:	48 87 04 24          	xchg   %rax,(%rsp)

ffff8000001040a0 <error_code>:
ffff8000001040a0:	50                   	push   %rax
ffff8000001040a1:	48 8c c0             	mov    %es,%rax
ffff8000001040a4:	50                   	push   %rax
ffff8000001040a5:	48 8c d8             	mov    %ds,%rax
ffff8000001040a8:	50                   	push   %rax
ffff8000001040a9:	48 31 c0             	xor    %rax,%rax
ffff8000001040ac:	55                   	push   %rbp
ffff8000001040ad:	57                   	push   %rdi
ffff8000001040ae:	56                   	push   %rsi
ffff8000001040af:	52                   	push   %rdx
ffff8000001040b0:	51                   	push   %rcx
ffff8000001040b1:	53                   	push   %rbx
ffff8000001040b2:	41 50                	push   %r8
ffff8000001040b4:	41 51                	push   %r9
ffff8000001040b6:	41 52                	push   %r10
ffff8000001040b8:	41 53                	push   %r11
ffff8000001040ba:	41 54                	push   %r12
ffff8000001040bc:	41 55                	push   %r13
ffff8000001040be:	41 56                	push   %r14
ffff8000001040c0:	41 57                	push   %r15
ffff8000001040c2:	fc                   	cld    
ffff8000001040c3:	48 8b b4 24 90 00 00 	mov    0x90(%rsp),%rsi
ffff8000001040ca:	00 
ffff8000001040cb:	48 8b 94 24 88 00 00 	mov    0x88(%rsp),%rdx
ffff8000001040d2:	00 
ffff8000001040d3:	48 c7 c7 10 00 00 00 	mov    $0x10,%rdi
ffff8000001040da:	48 8e df             	mov    %rdi,%ds
ffff8000001040dd:	48 8e c7             	mov    %rdi,%es
ffff8000001040e0:	48 89 e7             	mov    %rsp,%rdi
ffff8000001040e3:	ff d2                	call   *%rdx
ffff8000001040e5:	e9 3b ff ff ff       	jmp    ffff800000104025 <ret_from_intr>

ffff8000001040ea <debug>:
ffff8000001040ea:	6a 00                	push   $0x0
ffff8000001040ec:	50                   	push   %rax
ffff8000001040ed:	48 8d 05 6e 21 00 00 	lea    0x216e(%rip),%rax        # ffff800000106262 <do_debug>
ffff8000001040f4:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001040f8:	eb a6                	jmp    ffff8000001040a0 <error_code>

ffff8000001040fa <nmi>:
ffff8000001040fa:	50                   	push   %rax
ffff8000001040fb:	fc                   	cld    
ffff8000001040fc:	50                   	push   %rax
ffff8000001040fd:	50                   	push   %rax
ffff8000001040fe:	48 8c c0             	mov    %es,%rax
ffff800000104101:	50                   	push   %rax
ffff800000104102:	48 8c d8             	mov    %ds,%rax
ffff800000104105:	50                   	push   %rax
ffff800000104106:	48 31 c0             	xor    %rax,%rax
ffff800000104109:	55                   	push   %rbp
ffff80000010410a:	57                   	push   %rdi
ffff80000010410b:	56                   	push   %rsi
ffff80000010410c:	52                   	push   %rdx
ffff80000010410d:	51                   	push   %rcx
ffff80000010410e:	53                   	push   %rbx
ffff80000010410f:	41 50                	push   %r8
ffff800000104111:	41 51                	push   %r9
ffff800000104113:	41 52                	push   %r10
ffff800000104115:	41 53                	push   %r11
ffff800000104117:	41 54                	push   %r12
ffff800000104119:	41 55                	push   %r13
ffff80000010411b:	41 56                	push   %r14
ffff80000010411d:	41 57                	push   %r15
ffff80000010411f:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000104126:	48 8e da             	mov    %rdx,%ds
ffff800000104129:	48 8e c2             	mov    %rdx,%es
ffff80000010412c:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
ffff800000104133:	48 89 e7             	mov    %rsp,%rdi
ffff800000104136:	e8 b4 21 00 00       	call   ffff8000001062ef <do_nmi>
ffff80000010413b:	e9 c0 fe ff ff       	jmp    ffff800000104000 <RESTORE_ALL>

ffff800000104140 <int3>:
ffff800000104140:	6a 00                	push   $0x0
ffff800000104142:	50                   	push   %rax
ffff800000104143:	48 8d 05 32 22 00 00 	lea    0x2232(%rip),%rax        # ffff80000010637c <do_int3>
ffff80000010414a:	48 87 04 24          	xchg   %rax,(%rsp)
ffff80000010414e:	e9 4d ff ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104153 <overflow>:
ffff800000104153:	6a 00                	push   $0x0
ffff800000104155:	50                   	push   %rax
ffff800000104156:	48 8d 05 ac 22 00 00 	lea    0x22ac(%rip),%rax        # ffff800000106409 <do_overflow>
ffff80000010415d:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104161:	e9 3a ff ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104166 <bounds>:
ffff800000104166:	6a 00                	push   $0x0
ffff800000104168:	50                   	push   %rax
ffff800000104169:	48 8d 05 26 23 00 00 	lea    0x2326(%rip),%rax        # ffff800000106496 <do_bounds>
ffff800000104170:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104174:	e9 27 ff ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104179 <undefined_opcode>:
ffff800000104179:	6a 00                	push   $0x0
ffff80000010417b:	50                   	push   %rax
ffff80000010417c:	48 8d 05 a0 23 00 00 	lea    0x23a0(%rip),%rax        # ffff800000106523 <do_undefined_opcode>
ffff800000104183:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104187:	e9 14 ff ff ff       	jmp    ffff8000001040a0 <error_code>

ffff80000010418c <dev_not_available>:
ffff80000010418c:	6a 00                	push   $0x0
ffff80000010418e:	50                   	push   %rax
ffff80000010418f:	48 8d 05 1a 24 00 00 	lea    0x241a(%rip),%rax        # ffff8000001065b0 <do_dev_not_available>
ffff800000104196:	48 87 04 24          	xchg   %rax,(%rsp)
ffff80000010419a:	e9 01 ff ff ff       	jmp    ffff8000001040a0 <error_code>

ffff80000010419f <double_fault>:
ffff80000010419f:	50                   	push   %rax
ffff8000001041a0:	48 8d 05 96 24 00 00 	lea    0x2496(%rip),%rax        # ffff80000010663d <do_double_fault>
ffff8000001041a7:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001041ab:	e9 f0 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff8000001041b0 <coprocessor_segment_overrun>:
ffff8000001041b0:	6a 00                	push   $0x0
ffff8000001041b2:	50                   	push   %rax
ffff8000001041b3:	48 8d 05 10 25 00 00 	lea    0x2510(%rip),%rax        # ffff8000001066ca <do_coprocessor_segment_overrun>
ffff8000001041ba:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001041be:	e9 dd fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff8000001041c3 <invalid_TSS>:
ffff8000001041c3:	50                   	push   %rax
ffff8000001041c4:	48 8d 05 8c 25 00 00 	lea    0x258c(%rip),%rax        # ffff800000106757 <do_invalid_TSS>
ffff8000001041cb:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001041cf:	e9 cc fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff8000001041d4 <segment_not_present>:
ffff8000001041d4:	50                   	push   %rax
ffff8000001041d5:	48 8d 05 76 27 00 00 	lea    0x2776(%rip),%rax        # ffff800000106952 <do_segment_not_present>
ffff8000001041dc:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001041e0:	e9 bb fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff8000001041e5 <stack_segment_fault>:
ffff8000001041e5:	50                   	push   %rax
ffff8000001041e6:	48 8d 05 60 29 00 00 	lea    0x2960(%rip),%rax        # ffff800000106b4d <do_stack_segment_fault>
ffff8000001041ed:	48 87 04 24          	xchg   %rax,(%rsp)
ffff8000001041f1:	e9 aa fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff8000001041f6 <general_protection>:
ffff8000001041f6:	50                   	push   %rax
ffff8000001041f7:	48 8d 05 4a 2b 00 00 	lea    0x2b4a(%rip),%rax        # ffff800000106d48 <do_general_protection>
ffff8000001041fe:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104202:	e9 99 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104207 <page_fault>:
ffff800000104207:	50                   	push   %rax
ffff800000104208:	48 8d 05 34 2d 00 00 	lea    0x2d34(%rip),%rax        # ffff800000106f43 <do_page_fault>
ffff80000010420f:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104213:	e9 88 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104218 <x87_FPU_error>:
ffff800000104218:	6a 00                	push   $0x0
ffff80000010421a:	50                   	push   %rax
ffff80000010421b:	48 8d 05 c8 2f 00 00 	lea    0x2fc8(%rip),%rax        # ffff8000001071ea <do_x87_FPU_error>
ffff800000104222:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104226:	e9 75 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff80000010422b <alignment_check>:
ffff80000010422b:	50                   	push   %rax
ffff80000010422c:	48 8d 05 44 30 00 00 	lea    0x3044(%rip),%rax        # ffff800000107277 <do_alignment_check>
ffff800000104233:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104237:	e9 64 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff80000010423c <machine_check>:
ffff80000010423c:	6a 00                	push   $0x0
ffff80000010423e:	50                   	push   %rax
ffff80000010423f:	48 8d 05 be 30 00 00 	lea    0x30be(%rip),%rax        # ffff800000107304 <do_machine_check>
ffff800000104246:	48 87 04 24          	xchg   %rax,(%rsp)
ffff80000010424a:	e9 51 fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff80000010424f <SIMD_exception>:
ffff80000010424f:	6a 00                	push   $0x0
ffff800000104251:	50                   	push   %rax
ffff800000104252:	48 8d 05 38 31 00 00 	lea    0x3138(%rip),%rax        # ffff800000107391 <do_SIMD_exception>
ffff800000104259:	48 87 04 24          	xchg   %rax,(%rsp)
ffff80000010425d:	e9 3e fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104262 <virtualization_exception>:
ffff800000104262:	6a 00                	push   $0x0
ffff800000104264:	50                   	push   %rax
ffff800000104265:	48 8d 05 b2 31 00 00 	lea    0x31b2(%rip),%rax        # ffff80000010741e <do_virtualization_exception>
ffff80000010426c:	48 87 04 24          	xchg   %rax,(%rsp)
ffff800000104270:	e9 2b fe ff ff       	jmp    ffff8000001040a0 <error_code>

ffff800000104275 <set_tss64>:
ffff800000104275:	f3 0f 1e fa          	endbr64 
ffff800000104279:	55                   	push   %rbp
ffff80000010427a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010427d:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010427d <set_tss64+0x8>
ffff800000104284:	49 bb 53 ee 00 00 00 	movabs $0xee53,%r11
ffff80000010428b:	00 00 00 
ffff80000010428e:	4c 01 d8             	add    %r11,%rax
ffff800000104291:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000104295:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000104299:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff80000010429d:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
ffff8000001042a1:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
ffff8000001042a5:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
ffff8000001042a9:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff8000001042b0:	ff ff ff 
ffff8000001042b3:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff8000001042b7:	48 8d 52 04          	lea    0x4(%rdx),%rdx
ffff8000001042bb:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001042bf:	48 89 0a             	mov    %rcx,(%rdx)
ffff8000001042c2:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff8000001042c9:	ff ff ff 
ffff8000001042cc:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff8000001042d0:	48 8d 52 0c          	lea    0xc(%rdx),%rdx
ffff8000001042d4:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001042d8:	48 89 0a             	mov    %rcx,(%rdx)
ffff8000001042db:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff8000001042e2:	ff ff ff 
ffff8000001042e5:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff8000001042e9:	48 8d 52 14          	lea    0x14(%rdx),%rdx
ffff8000001042ed:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001042f1:	48 89 0a             	mov    %rcx,(%rdx)
ffff8000001042f4:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff8000001042fb:	ff ff ff 
ffff8000001042fe:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000104302:	48 8d 52 24          	lea    0x24(%rdx),%rdx
ffff800000104306:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010430a:	48 89 0a             	mov    %rcx,(%rdx)
ffff80000010430d:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000104314:	ff ff ff 
ffff800000104317:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff80000010431b:	48 8d 52 2c          	lea    0x2c(%rdx),%rdx
ffff80000010431f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000104323:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000104326:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff80000010432d:	ff ff ff 
ffff800000104330:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000104334:	48 8d 52 34          	lea    0x34(%rdx),%rdx
ffff800000104338:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff80000010433c:	48 89 0a             	mov    %rcx,(%rdx)
ffff80000010433f:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000104346:	ff ff ff 
ffff800000104349:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff80000010434d:	48 8d 52 3c          	lea    0x3c(%rdx),%rdx
ffff800000104351:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
ffff800000104355:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000104358:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff80000010435f:	ff ff ff 
ffff800000104362:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000104366:	48 8d 52 44          	lea    0x44(%rdx),%rdx
ffff80000010436a:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
ffff80000010436e:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000104371:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000104378:	ff ff ff 
ffff80000010437b:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff80000010437f:	48 8d 52 4c          	lea    0x4c(%rdx),%rdx
ffff800000104383:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
ffff800000104387:	48 89 0a             	mov    %rcx,(%rdx)
ffff80000010438a:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000104391:	ff ff ff 
ffff800000104394:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000104398:	48 8d 40 54          	lea    0x54(%rax),%rax
ffff80000010439c:	48 8b 55 28          	mov    0x28(%rbp),%rdx
ffff8000001043a0:	48 89 10             	mov    %rdx,(%rax)
ffff8000001043a3:	90                   	nop
ffff8000001043a4:	5d                   	pop    %rbp
ffff8000001043a5:	c3                   	ret    

ffff8000001043a6 <get_current>:
ffff8000001043a6:	f3 0f 1e fa          	endbr64 
ffff8000001043aa:	55                   	push   %rbp
ffff8000001043ab:	48 89 e5             	mov    %rsp,%rbp
ffff8000001043ae:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001043ae <get_current+0x8>
ffff8000001043b5:	49 bb 22 ed 00 00 00 	movabs $0xed22,%r11
ffff8000001043bc:	00 00 00 
ffff8000001043bf:	4c 01 d8             	add    %r11,%rax
ffff8000001043c2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff8000001043c9:	00 
ffff8000001043ca:	48 c7 c0 00 80 ff ff 	mov    $0xffffffffffff8000,%rax
ffff8000001043d1:	48 21 e0             	and    %rsp,%rax
ffff8000001043d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001043d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001043dc:	5d                   	pop    %rbp
ffff8000001043dd:	c3                   	ret    

ffff8000001043de <no_system_call>:
ffff8000001043de:	f3 0f 1e fa          	endbr64 
ffff8000001043e2:	55                   	push   %rbp
ffff8000001043e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001043e6:	41 57                	push   %r15
ffff8000001043e8:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001043ec:	4c 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%r8        # ffff8000001043ec <no_system_call+0xe>
ffff8000001043f3:	49 bb e4 ec 00 00 00 	movabs $0xece4,%r11
ffff8000001043fa:	00 00 00 
ffff8000001043fd:	4d 01 d8             	add    %r11,%r8
ffff800000104400:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000104404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104408:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
ffff80000010440f:	48 89 c1             	mov    %rax,%rcx
ffff800000104412:	48 b8 70 10 00 00 00 	movabs $0x1070,%rax
ffff800000104419:	00 00 00 
ffff80000010441c:	49 8d 04 00          	lea    (%r8,%rax,1),%rax
ffff800000104420:	48 89 c2             	mov    %rax,%rdx
ffff800000104423:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104428:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010442d:	4d 89 c7             	mov    %r8,%r15
ffff800000104430:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104435:	49 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r9
ffff80000010443c:	ff ff ff 
ffff80000010443f:	4d 01 c1             	add    %r8,%r9
ffff800000104442:	41 ff d1             	call   *%r9
ffff800000104445:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff80000010444c:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
ffff800000104450:	c9                   	leave  
ffff800000104451:	c3                   	ret    

ffff800000104452 <sys_printf>:
ffff800000104452:	f3 0f 1e fa          	endbr64 
ffff800000104456:	55                   	push   %rbp
ffff800000104457:	48 89 e5             	mov    %rsp,%rbp
ffff80000010445a:	41 57                	push   %r15
ffff80000010445c:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104460:	48 8d 0d f9 ff ff ff 	lea    -0x7(%rip),%rcx        # ffff800000104460 <sys_printf+0xe>
ffff800000104467:	49 bb 70 ec 00 00 00 	movabs $0xec70,%r11
ffff80000010446e:	00 00 00 
ffff800000104471:	4c 01 d9             	add    %r11,%rcx
ffff800000104474:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000104478:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010447c:	48 8b 40 60          	mov    0x60(%rax),%rax
ffff800000104480:	48 89 c2             	mov    %rax,%rdx
ffff800000104483:	be ff ff ff 00       	mov    $0xffffff,%esi
ffff800000104488:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010448d:	49 89 cf             	mov    %rcx,%r15
ffff800000104490:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104495:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010449c:	ff ff ff 
ffff80000010449f:	49 01 c8             	add    %rcx,%r8
ffff8000001044a2:	41 ff d0             	call   *%r8
ffff8000001044a5:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001044aa:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
ffff8000001044ae:	c9                   	leave  
ffff8000001044af:	c3                   	ret    

ffff8000001044b0 <Start_Kernel>:
ffff8000001044b0:	f3 0f 1e fa          	endbr64 
ffff8000001044b4:	55                   	push   %rbp
ffff8000001044b5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044b8:	41 57                	push   %r15
ffff8000001044ba:	53                   	push   %rbx
ffff8000001044bb:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001044bf:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff8000001044bf <Start_Kernel+0xf>
ffff8000001044c6:	49 bb 11 ec 00 00 00 	movabs $0xec11,%r11
ffff8000001044cd:	00 00 00 
ffff8000001044d0:	4c 01 db             	add    %r11,%rbx
ffff8000001044d3:	48 be 00 00 a0 00 00 	movabs $0xffff800000a00000,%rsi
ffff8000001044da:	80 ff ff 
ffff8000001044dd:	48 89 75 e8          	mov    %rsi,-0x18(%rbp)
ffff8000001044e1:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001044e8:	00 00 00 
ffff8000001044eb:	c7 04 03 a0 05 00 00 	movl   $0x5a0,(%rbx,%rax,1)
ffff8000001044f2:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001044f9:	00 00 00 
ffff8000001044fc:	c7 44 03 04 84 03 00 	movl   $0x384,0x4(%rbx,%rax,1)
ffff800000104503:	00 
ffff800000104504:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010450b:	00 00 00 
ffff80000010450e:	c7 44 03 08 00 00 00 	movl   $0x0,0x8(%rbx,%rax,1)
ffff800000104515:	00 
ffff800000104516:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010451d:	00 00 00 
ffff800000104520:	c7 44 03 0c 00 00 00 	movl   $0x0,0xc(%rbx,%rax,1)
ffff800000104527:	00 
ffff800000104528:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010452f:	00 00 00 
ffff800000104532:	c7 44 03 10 08 00 00 	movl   $0x8,0x10(%rbx,%rax,1)
ffff800000104539:	00 
ffff80000010453a:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104541:	00 00 00 
ffff800000104544:	c7 44 03 14 10 00 00 	movl   $0x10,0x14(%rbx,%rax,1)
ffff80000010454b:	00 
ffff80000010454c:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104553:	00 00 00 
ffff800000104556:	48 89 74 03 18       	mov    %rsi,0x18(%rbx,%rax,1)
ffff80000010455b:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104562:	00 00 00 
ffff800000104565:	8b 14 03             	mov    (%rbx,%rax,1),%edx
ffff800000104568:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010456f:	00 00 00 
ffff800000104572:	8b 44 03 04          	mov    0x4(%rbx,%rax,1),%eax
ffff800000104576:	0f af c2             	imul   %edx,%eax
ffff800000104579:	c1 e0 02             	shl    $0x2,%eax
ffff80000010457c:	48 98                	cltq   
ffff80000010457e:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000104584:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010458a:	48 89 c2             	mov    %rax,%rdx
ffff80000010458d:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104594:	00 00 00 
ffff800000104597:	48 89 54 03 20       	mov    %rdx,0x20(%rbx,%rax,1)
ffff80000010459c:	b8 50 00 00 00       	mov    $0x50,%eax
ffff8000001045a1:	0f 00 d8             	ltr    %ax
ffff8000001045a4:	68 00 7c 00 00       	push   $0x7c00
ffff8000001045a9:	c7 44 24 04 00 80 ff 	movl   $0xffff8000,0x4(%rsp)
ffff8000001045b0:	ff 
ffff8000001045b1:	68 00 7c 00 00       	push   $0x7c00
ffff8000001045b6:	c7 44 24 04 00 80 ff 	movl   $0xffff8000,0x4(%rsp)
ffff8000001045bd:	ff 
ffff8000001045be:	68 00 7c 00 00       	push   $0x7c00
ffff8000001045c3:	c7 44 24 04 00 80 ff 	movl   $0xffff8000,0x4(%rsp)
ffff8000001045ca:	ff 
ffff8000001045cb:	68 00 7c 00 00       	push   $0x7c00
ffff8000001045d0:	c7 44 24 04 00 80 ff 	movl   $0xffff8000,0x4(%rsp)
ffff8000001045d7:	ff 
ffff8000001045d8:	49 b9 00 7c 00 00 00 	movabs $0xffff800000007c00,%r9
ffff8000001045df:	80 ff ff 
ffff8000001045e2:	49 b8 00 7c 00 00 00 	movabs $0xffff800000007c00,%r8
ffff8000001045e9:	80 ff ff 
ffff8000001045ec:	48 b8 00 7c 00 00 00 	movabs $0xffff800000007c00,%rax
ffff8000001045f3:	80 ff ff 
ffff8000001045f6:	48 89 c1             	mov    %rax,%rcx
ffff8000001045f9:	48 b8 00 7c 00 00 00 	movabs $0xffff800000007c00,%rax
ffff800000104600:	80 ff ff 
ffff800000104603:	48 89 c2             	mov    %rax,%rdx
ffff800000104606:	48 b8 00 7c 00 00 00 	movabs $0xffff800000007c00,%rax
ffff80000010460d:	80 ff ff 
ffff800000104610:	48 89 c6             	mov    %rax,%rsi
ffff800000104613:	48 b8 00 7c 00 00 00 	movabs $0xffff800000007c00,%rax
ffff80000010461a:	80 ff ff 
ffff80000010461d:	48 89 c7             	mov    %rax,%rdi
ffff800000104620:	48 b8 a5 11 ff ff ff 	movabs $0xffffffffffff11a5,%rax
ffff800000104627:	ff ff ff 
ffff80000010462a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010462e:	ff d0                	call   *%rax
ffff800000104630:	48 83 c4 20          	add    $0x20,%rsp
ffff800000104634:	49 89 df             	mov    %rbx,%r15
ffff800000104637:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010463c:	48 ba 85 2d ff ff ff 	movabs $0xffffffffffff2d85,%rdx
ffff800000104643:	ff ff ff 
ffff800000104646:	48 01 da             	add    %rbx,%rdx
ffff800000104649:	ff d2                	call   *%rdx
ffff80000010464b:	49 89 df             	mov    %rbx,%r15
ffff80000010464e:	48 b8 ba 79 ff ff ff 	movabs $0xffffffffffff79ba,%rax
ffff800000104655:	ff ff ff 
ffff800000104658:	48 01 d8             	add    %rbx,%rax
ffff80000010465b:	ff d0                	call   *%rax
ffff80000010465d:	48 b8 60 ff ff ff ff 	movabs $0xffffffffffffff60,%rax
ffff800000104664:	ff ff ff 
ffff800000104667:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010466b:	48 89 c2             	mov    %rax,%rdx
ffff80000010466e:	48 b8 d0 5f 01 00 00 	movabs $0x15fd0,%rax
ffff800000104675:	00 00 00 
ffff800000104678:	48 89 94 03 d0 02 00 	mov    %rdx,0x2d0(%rbx,%rax,1)
ffff80000010467f:	00 
ffff800000104680:	48 b8 00 ff ff ff ff 	movabs $0xffffffffffffff00,%rax
ffff800000104687:	ff ff ff 
ffff80000010468a:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010468e:	48 89 c2             	mov    %rax,%rdx
ffff800000104691:	48 b8 d0 5f 01 00 00 	movabs $0x15fd0,%rax
ffff800000104698:	00 00 00 
ffff80000010469b:	48 89 94 03 d8 02 00 	mov    %rdx,0x2d8(%rbx,%rax,1)
ffff8000001046a2:	00 
ffff8000001046a3:	48 b8 a8 ff ff ff ff 	movabs $0xffffffffffffffa8,%rax
ffff8000001046aa:	ff ff ff 
ffff8000001046ad:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001046b1:	48 89 c2             	mov    %rax,%rdx
ffff8000001046b4:	48 b8 d0 5f 01 00 00 	movabs $0x15fd0,%rax
ffff8000001046bb:	00 00 00 
ffff8000001046be:	48 89 94 03 e0 02 00 	mov    %rdx,0x2e0(%rbx,%rax,1)
ffff8000001046c5:	00 
ffff8000001046c6:	48 b8 b8 ff ff ff ff 	movabs $0xffffffffffffffb8,%rax
ffff8000001046cd:	ff ff ff 
ffff8000001046d0:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001046d4:	48 89 c2             	mov    %rax,%rdx
ffff8000001046d7:	48 b8 d0 5f 01 00 00 	movabs $0x15fd0,%rax
ffff8000001046de:	00 00 00 
ffff8000001046e1:	48 89 94 03 e8 02 00 	mov    %rdx,0x2e8(%rbx,%rax,1)
ffff8000001046e8:	00 
ffff8000001046e9:	48 b8 94 10 00 00 00 	movabs $0x1094,%rax
ffff8000001046f0:	00 00 00 
ffff8000001046f3:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001046f7:	48 89 c2             	mov    %rax,%rdx
ffff8000001046fa:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001046ff:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000104704:	49 89 df             	mov    %rbx,%r15
ffff800000104707:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010470c:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000104713:	ff ff ff 
ffff800000104716:	48 01 d9             	add    %rbx,%rcx
ffff800000104719:	ff d1                	call   *%rcx
ffff80000010471b:	49 89 df             	mov    %rbx,%r15
ffff80000010471e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104723:	48 ba 92 44 ff ff ff 	movabs $0xffffffffffff4492,%rdx
ffff80000010472a:	ff ff ff 
ffff80000010472d:	48 01 da             	add    %rbx,%rdx
ffff800000104730:	ff d2                	call   *%rdx
ffff800000104732:	48 b8 a2 10 00 00 00 	movabs $0x10a2,%rax
ffff800000104739:	00 00 00 
ffff80000010473c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104740:	48 89 c2             	mov    %rax,%rdx
ffff800000104743:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104748:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010474d:	49 89 df             	mov    %rbx,%r15
ffff800000104750:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104755:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff80000010475c:	ff ff ff 
ffff80000010475f:	48 01 d9             	add    %rbx,%rcx
ffff800000104762:	ff d1                	call   *%rcx
ffff800000104764:	49 89 df             	mov    %rbx,%r15
ffff800000104767:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010476c:	48 ba 8e 65 ff ff ff 	movabs $0xffffffffffff658e,%rdx
ffff800000104773:	ff ff ff 
ffff800000104776:	48 01 da             	add    %rbx,%rdx
ffff800000104779:	ff d2                	call   *%rdx
ffff80000010477b:	48 b8 b3 10 00 00 00 	movabs $0x10b3,%rax
ffff800000104782:	00 00 00 
ffff800000104785:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104789:	48 89 c2             	mov    %rax,%rdx
ffff80000010478c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104791:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000104796:	49 89 df             	mov    %rbx,%r15
ffff800000104799:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010479e:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001047a5:	ff ff ff 
ffff8000001047a8:	48 01 d9             	add    %rbx,%rcx
ffff8000001047ab:	ff d1                	call   *%rcx
ffff8000001047ad:	49 89 df             	mov    %rbx,%r15
ffff8000001047b0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001047b5:	48 ba 7a 75 ff ff ff 	movabs $0xffffffffffff757a,%rdx
ffff8000001047bc:	ff ff ff 
ffff8000001047bf:	48 01 da             	add    %rbx,%rdx
ffff8000001047c2:	ff d2                	call   *%rdx
ffff8000001047c4:	eb fe                	jmp    ffff8000001047c4 <Start_Kernel+0x314>

ffff8000001047c6 <strlen>:
ffff8000001047c6:	f3 0f 1e fa          	endbr64 
ffff8000001047ca:	55                   	push   %rbp
ffff8000001047cb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001047ce:	53                   	push   %rbx
ffff8000001047cf:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001047cf <strlen+0x9>
ffff8000001047d6:	49 bb 01 e9 00 00 00 	movabs $0xe901,%r11
ffff8000001047dd:	00 00 00 
ffff8000001047e0:	4c 01 d8             	add    %r11,%rax
ffff8000001047e3:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
ffff8000001047e7:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
ffff8000001047eb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001047f0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
ffff8000001047f5:	89 d1                	mov    %edx,%ecx
ffff8000001047f7:	48 89 f7             	mov    %rsi,%rdi
ffff8000001047fa:	fc                   	cld    
ffff8000001047fb:	f2 ae                	repnz scas %es:(%rdi),%al
ffff8000001047fd:	f7 d1                	not    %ecx
ffff8000001047ff:	ff c9                	dec    %ecx
ffff800000104801:	89 ca                	mov    %ecx,%edx
ffff800000104803:	89 d3                	mov    %edx,%ebx
ffff800000104805:	89 d8                	mov    %ebx,%eax
ffff800000104807:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010480b:	c9                   	leave  
ffff80000010480c:	c3                   	ret    

ffff80000010480d <color_printk>:
ffff80000010480d:	f3 0f 1e fa          	endbr64 
ffff800000104811:	55                   	push   %rbp
ffff800000104812:	48 89 e5             	mov    %rsp,%rbp
ffff800000104815:	53                   	push   %rbx
ffff800000104816:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
ffff80000010481d:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010481d <color_printk+0x10>
ffff800000104824:	49 bb b3 e8 00 00 00 	movabs $0xe8b3,%r11
ffff80000010482b:	00 00 00 
ffff80000010482e:	4c 01 db             	add    %r11,%rbx
ffff800000104831:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%rbp)
ffff800000104837:	89 b5 08 ff ff ff    	mov    %esi,-0xf8(%rbp)
ffff80000010483d:	48 89 95 00 ff ff ff 	mov    %rdx,-0x100(%rbp)
ffff800000104844:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
ffff80000010484b:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
ffff800000104852:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
ffff800000104859:	84 c0                	test   %al,%al
ffff80000010485b:	74 23                	je     ffff800000104880 <color_printk+0x73>
ffff80000010485d:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
ffff800000104864:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
ffff800000104868:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
ffff80000010486c:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
ffff800000104870:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
ffff800000104874:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
ffff800000104878:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
ffff80000010487c:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
ffff800000104880:	c7 85 34 ff ff ff 00 	movl   $0x0,-0xcc(%rbp)
ffff800000104887:	00 00 00 
ffff80000010488a:	c7 85 3c ff ff ff 00 	movl   $0x0,-0xc4(%rbp)
ffff800000104891:	00 00 00 
ffff800000104894:	c7 85 38 ff ff ff 00 	movl   $0x0,-0xc8(%rbp)
ffff80000010489b:	00 00 00 
ffff80000010489e:	c7 85 18 ff ff ff 18 	movl   $0x18,-0xe8(%rbp)
ffff8000001048a5:	00 00 00 
ffff8000001048a8:	c7 85 1c ff ff ff 30 	movl   $0x30,-0xe4(%rbp)
ffff8000001048af:	00 00 00 
ffff8000001048b2:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffff8000001048b6:	48 89 85 20 ff ff ff 	mov    %rax,-0xe0(%rbp)
ffff8000001048bd:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
ffff8000001048c4:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffff8000001048cb:	48 8d 95 18 ff ff ff 	lea    -0xe8(%rbp),%rdx
ffff8000001048d2:	48 8b 85 00 ff ff ff 	mov    -0x100(%rbp),%rax
ffff8000001048d9:	48 89 c6             	mov    %rax,%rsi
ffff8000001048dc:	48 b8 30 4f 01 00 00 	movabs $0x14f30,%rax
ffff8000001048e3:	00 00 00 
ffff8000001048e6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001048ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001048ed:	48 b8 ce 1c ff ff ff 	movabs $0xffffffffffff1cce,%rax
ffff8000001048f4:	ff ff ff 
ffff8000001048f7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001048fb:	ff d0                	call   *%rax
ffff8000001048fd:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%rbp)
ffff800000104903:	c7 85 3c ff ff ff 00 	movl   $0x0,-0xc4(%rbp)
ffff80000010490a:	00 00 00 
ffff80000010490d:	e9 61 04 00 00       	jmp    ffff800000104d73 <color_printk+0x566>
ffff800000104912:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000104919:	7e 0c                	jle    ffff800000104927 <color_printk+0x11a>
ffff80000010491b:	83 ad 3c ff ff ff 01 	subl   $0x1,-0xc4(%rbp)
ffff800000104922:	e9 25 02 00 00       	jmp    ffff800000104b4c <color_printk+0x33f>
ffff800000104927:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
ffff80000010492d:	48 63 d0             	movslq %eax,%rdx
ffff800000104930:	48 b8 30 4f 01 00 00 	movabs $0x14f30,%rax
ffff800000104937:	00 00 00 
ffff80000010493a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010493e:	48 01 d0             	add    %rdx,%rax
ffff800000104941:	0f b6 00             	movzbl (%rax),%eax
ffff800000104944:	3c 0a                	cmp    $0xa,%al
ffff800000104946:	75 36                	jne    ffff80000010497e <color_printk+0x171>
ffff800000104948:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010494f:	00 00 00 
ffff800000104952:	8b 44 03 0c          	mov    0xc(%rbx,%rax,1),%eax
ffff800000104956:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104959:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104960:	00 00 00 
ffff800000104963:	89 54 03 0c          	mov    %edx,0xc(%rbx,%rax,1)
ffff800000104967:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff80000010496e:	00 00 00 
ffff800000104971:	c7 44 03 08 00 00 00 	movl   $0x0,0x8(%rbx,%rax,1)
ffff800000104978:	00 
ffff800000104979:	e9 4a 03 00 00       	jmp    ffff800000104cc8 <color_printk+0x4bb>
ffff80000010497e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
ffff800000104984:	48 63 d0             	movslq %eax,%rdx
ffff800000104987:	48 b8 30 4f 01 00 00 	movabs $0x14f30,%rax
ffff80000010498e:	00 00 00 
ffff800000104991:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104995:	48 01 d0             	add    %rdx,%rax
ffff800000104998:	0f b6 00             	movzbl (%rax),%eax
ffff80000010499b:	3c 08                	cmp    $0x8,%al
ffff80000010499d:	0f 85 56 01 00 00    	jne    ffff800000104af9 <color_printk+0x2ec>
ffff8000001049a3:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001049aa:	00 00 00 
ffff8000001049ad:	8b 44 03 08          	mov    0x8(%rbx,%rax,1),%eax
ffff8000001049b1:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001049b4:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001049bb:	00 00 00 
ffff8000001049be:	89 54 03 08          	mov    %edx,0x8(%rbx,%rax,1)
ffff8000001049c2:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001049c9:	00 00 00 
ffff8000001049cc:	8b 44 03 08          	mov    0x8(%rbx,%rax,1),%eax
ffff8000001049d0:	85 c0                	test   %eax,%eax
ffff8000001049d2:	0f 84 90 00 00 00    	je     ffff800000104a68 <color_printk+0x25b>
ffff8000001049d8:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff8000001049df:	00 00 00 
ffff8000001049e2:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff8000001049e5:	48 ba 30 5f 01 00 00 	movabs $0x15f30,%rdx
ffff8000001049ec:	00 00 00 
ffff8000001049ef:	8b 74 13 10          	mov    0x10(%rbx,%rdx,1),%esi
ffff8000001049f3:	99                   	cltd   
ffff8000001049f4:	f7 fe                	idiv   %esi
ffff8000001049f6:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001049f9:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a00:	00 00 00 
ffff800000104a03:	89 54 03 08          	mov    %edx,0x8(%rbx,%rax,1)
ffff800000104a07:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a0e:	00 00 00 
ffff800000104a11:	8b 44 03 0c          	mov    0xc(%rbx,%rax,1),%eax
ffff800000104a15:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000104a18:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a1f:	00 00 00 
ffff800000104a22:	89 54 03 0c          	mov    %edx,0xc(%rbx,%rax,1)
ffff800000104a26:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a2d:	00 00 00 
ffff800000104a30:	8b 44 03 0c          	mov    0xc(%rbx,%rax,1),%eax
ffff800000104a34:	85 c0                	test   %eax,%eax
ffff800000104a36:	79 30                	jns    ffff800000104a68 <color_printk+0x25b>
ffff800000104a38:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a3f:	00 00 00 
ffff800000104a42:	8b 44 03 04          	mov    0x4(%rbx,%rax,1),%eax
ffff800000104a46:	48 ba 30 5f 01 00 00 	movabs $0x15f30,%rdx
ffff800000104a4d:	00 00 00 
ffff800000104a50:	8b 7c 13 14          	mov    0x14(%rbx,%rdx,1),%edi
ffff800000104a54:	99                   	cltd   
ffff800000104a55:	f7 ff                	idiv   %edi
ffff800000104a57:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000104a5a:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a61:	00 00 00 
ffff800000104a64:	89 54 03 0c          	mov    %edx,0xc(%rbx,%rax,1)
ffff800000104a68:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a6f:	00 00 00 
ffff800000104a72:	8b 54 03 0c          	mov    0xc(%rbx,%rax,1),%edx
ffff800000104a76:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a7d:	00 00 00 
ffff800000104a80:	8b 44 03 14          	mov    0x14(%rbx,%rax,1),%eax
ffff800000104a84:	89 d1                	mov    %edx,%ecx
ffff800000104a86:	0f af c8             	imul   %eax,%ecx
ffff800000104a89:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a90:	00 00 00 
ffff800000104a93:	8b 54 03 08          	mov    0x8(%rbx,%rax,1),%edx
ffff800000104a97:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104a9e:	00 00 00 
ffff800000104aa1:	8b 44 03 10          	mov    0x10(%rbx,%rax,1),%eax
ffff800000104aa5:	0f af d0             	imul   %eax,%edx
ffff800000104aa8:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104aaf:	00 00 00 
ffff800000104ab2:	8b 34 03             	mov    (%rbx,%rax,1),%esi
ffff800000104ab5:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104abc:	00 00 00 
ffff800000104abf:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
ffff800000104ac4:	44 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%r8d
ffff800000104acb:	8b bd 0c ff ff ff    	mov    -0xf4(%rbp),%edi
ffff800000104ad1:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104ad5:	6a 20                	push   $0x20
ffff800000104ad7:	45 89 c1             	mov    %r8d,%r9d
ffff800000104ada:	41 89 f8             	mov    %edi,%r8d
ffff800000104add:	48 89 c7             	mov    %rax,%rdi
ffff800000104ae0:	48 b8 98 26 ff ff ff 	movabs $0xffffffffffff2698,%rax
ffff800000104ae7:	ff ff ff 
ffff800000104aea:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104aee:	ff d0                	call   *%rax
ffff800000104af0:	48 83 c4 10          	add    $0x10,%rsp
ffff800000104af4:	e9 cf 01 00 00       	jmp    ffff800000104cc8 <color_printk+0x4bb>
ffff800000104af9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
ffff800000104aff:	48 63 d0             	movslq %eax,%rdx
ffff800000104b02:	48 b8 30 4f 01 00 00 	movabs $0x14f30,%rax
ffff800000104b09:	00 00 00 
ffff800000104b0c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104b10:	48 01 d0             	add    %rdx,%rax
ffff800000104b13:	0f b6 00             	movzbl (%rax),%eax
ffff800000104b16:	3c 09                	cmp    $0x9,%al
ffff800000104b18:	0f 85 e5 00 00 00    	jne    ffff800000104c03 <color_printk+0x3f6>
ffff800000104b1e:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b25:	00 00 00 
ffff800000104b28:	8b 44 03 08          	mov    0x8(%rbx,%rax,1),%eax
ffff800000104b2c:	83 c0 08             	add    $0x8,%eax
ffff800000104b2f:	83 e0 f8             	and    $0xfffffff8,%eax
ffff800000104b32:	89 c2                	mov    %eax,%edx
ffff800000104b34:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b3b:	00 00 00 
ffff800000104b3e:	8b 4c 03 08          	mov    0x8(%rbx,%rax,1),%ecx
ffff800000104b42:	89 d0                	mov    %edx,%eax
ffff800000104b44:	29 c8                	sub    %ecx,%eax
ffff800000104b46:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffff800000104b4c:	83 ad 38 ff ff ff 01 	subl   $0x1,-0xc8(%rbp)
ffff800000104b53:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b5a:	00 00 00 
ffff800000104b5d:	8b 54 03 0c          	mov    0xc(%rbx,%rax,1),%edx
ffff800000104b61:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b68:	00 00 00 
ffff800000104b6b:	8b 44 03 14          	mov    0x14(%rbx,%rax,1),%eax
ffff800000104b6f:	89 d1                	mov    %edx,%ecx
ffff800000104b71:	0f af c8             	imul   %eax,%ecx
ffff800000104b74:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b7b:	00 00 00 
ffff800000104b7e:	8b 54 03 08          	mov    0x8(%rbx,%rax,1),%edx
ffff800000104b82:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b89:	00 00 00 
ffff800000104b8c:	8b 44 03 10          	mov    0x10(%rbx,%rax,1),%eax
ffff800000104b90:	0f af d0             	imul   %eax,%edx
ffff800000104b93:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104b9a:	00 00 00 
ffff800000104b9d:	8b 34 03             	mov    (%rbx,%rax,1),%esi
ffff800000104ba0:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104ba7:	00 00 00 
ffff800000104baa:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
ffff800000104baf:	44 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%r8d
ffff800000104bb6:	8b bd 0c ff ff ff    	mov    -0xf4(%rbp),%edi
ffff800000104bbc:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104bc0:	6a 20                	push   $0x20
ffff800000104bc2:	45 89 c1             	mov    %r8d,%r9d
ffff800000104bc5:	41 89 f8             	mov    %edi,%r8d
ffff800000104bc8:	48 89 c7             	mov    %rax,%rdi
ffff800000104bcb:	48 b8 98 26 ff ff ff 	movabs $0xffffffffffff2698,%rax
ffff800000104bd2:	ff ff ff 
ffff800000104bd5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104bd9:	ff d0                	call   *%rax
ffff800000104bdb:	48 83 c4 10          	add    $0x10,%rsp
ffff800000104bdf:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104be6:	00 00 00 
ffff800000104be9:	8b 44 03 08          	mov    0x8(%rbx,%rax,1),%eax
ffff800000104bed:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104bf0:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104bf7:	00 00 00 
ffff800000104bfa:	89 54 03 08          	mov    %edx,0x8(%rbx,%rax,1)
ffff800000104bfe:	e9 c5 00 00 00       	jmp    ffff800000104cc8 <color_printk+0x4bb>
ffff800000104c03:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
ffff800000104c09:	48 63 d0             	movslq %eax,%rdx
ffff800000104c0c:	48 b8 30 4f 01 00 00 	movabs $0x14f30,%rax
ffff800000104c13:	00 00 00 
ffff800000104c16:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104c1a:	48 01 d0             	add    %rdx,%rax
ffff800000104c1d:	0f b6 00             	movzbl (%rax),%eax
ffff800000104c20:	0f b6 f8             	movzbl %al,%edi
ffff800000104c23:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c2a:	00 00 00 
ffff800000104c2d:	8b 54 03 0c          	mov    0xc(%rbx,%rax,1),%edx
ffff800000104c31:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c38:	00 00 00 
ffff800000104c3b:	8b 44 03 14          	mov    0x14(%rbx,%rax,1),%eax
ffff800000104c3f:	89 d1                	mov    %edx,%ecx
ffff800000104c41:	0f af c8             	imul   %eax,%ecx
ffff800000104c44:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c4b:	00 00 00 
ffff800000104c4e:	8b 54 03 08          	mov    0x8(%rbx,%rax,1),%edx
ffff800000104c52:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c59:	00 00 00 
ffff800000104c5c:	8b 44 03 10          	mov    0x10(%rbx,%rax,1),%eax
ffff800000104c60:	0f af d0             	imul   %eax,%edx
ffff800000104c63:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c6a:	00 00 00 
ffff800000104c6d:	8b 34 03             	mov    (%rbx,%rax,1),%esi
ffff800000104c70:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104c77:	00 00 00 
ffff800000104c7a:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
ffff800000104c7f:	44 8b 8d 08 ff ff ff 	mov    -0xf8(%rbp),%r9d
ffff800000104c86:	44 8b 85 0c ff ff ff 	mov    -0xf4(%rbp),%r8d
ffff800000104c8d:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104c91:	57                   	push   %rdi
ffff800000104c92:	48 89 c7             	mov    %rax,%rdi
ffff800000104c95:	48 b8 98 26 ff ff ff 	movabs $0xffffffffffff2698,%rax
ffff800000104c9c:	ff ff ff 
ffff800000104c9f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104ca3:	ff d0                	call   *%rax
ffff800000104ca5:	48 83 c4 10          	add    $0x10,%rsp
ffff800000104ca9:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104cb0:	00 00 00 
ffff800000104cb3:	8b 44 03 08          	mov    0x8(%rbx,%rax,1),%eax
ffff800000104cb7:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104cba:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104cc1:	00 00 00 
ffff800000104cc4:	89 54 03 08          	mov    %edx,0x8(%rbx,%rax,1)
ffff800000104cc8:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104ccf:	00 00 00 
ffff800000104cd2:	8b 4c 03 08          	mov    0x8(%rbx,%rax,1),%ecx
ffff800000104cd6:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104cdd:	00 00 00 
ffff800000104ce0:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff800000104ce3:	48 ba 30 5f 01 00 00 	movabs $0x15f30,%rdx
ffff800000104cea:	00 00 00 
ffff800000104ced:	8b 74 13 10          	mov    0x10(%rbx,%rdx,1),%esi
ffff800000104cf1:	99                   	cltd   
ffff800000104cf2:	f7 fe                	idiv   %esi
ffff800000104cf4:	39 c1                	cmp    %eax,%ecx
ffff800000104cf6:	7c 31                	jl     ffff800000104d29 <color_printk+0x51c>
ffff800000104cf8:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104cff:	00 00 00 
ffff800000104d02:	8b 44 03 0c          	mov    0xc(%rbx,%rax,1),%eax
ffff800000104d06:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104d09:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104d10:	00 00 00 
ffff800000104d13:	89 54 03 0c          	mov    %edx,0xc(%rbx,%rax,1)
ffff800000104d17:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104d1e:	00 00 00 
ffff800000104d21:	c7 44 03 08 00 00 00 	movl   $0x0,0x8(%rbx,%rax,1)
ffff800000104d28:	00 
ffff800000104d29:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104d30:	00 00 00 
ffff800000104d33:	8b 4c 03 0c          	mov    0xc(%rbx,%rax,1),%ecx
ffff800000104d37:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104d3e:	00 00 00 
ffff800000104d41:	8b 44 03 04          	mov    0x4(%rbx,%rax,1),%eax
ffff800000104d45:	48 ba 30 5f 01 00 00 	movabs $0x15f30,%rdx
ffff800000104d4c:	00 00 00 
ffff800000104d4f:	8b 7c 13 14          	mov    0x14(%rbx,%rdx,1),%edi
ffff800000104d53:	99                   	cltd   
ffff800000104d54:	f7 ff                	idiv   %edi
ffff800000104d56:	39 c1                	cmp    %eax,%ecx
ffff800000104d58:	7c 12                	jl     ffff800000104d6c <color_printk+0x55f>
ffff800000104d5a:	48 b8 30 5f 01 00 00 	movabs $0x15f30,%rax
ffff800000104d61:	00 00 00 
ffff800000104d64:	c7 44 03 0c 00 00 00 	movl   $0x0,0xc(%rbx,%rax,1)
ffff800000104d6b:	00 
ffff800000104d6c:	83 85 3c ff ff ff 01 	addl   $0x1,-0xc4(%rbp)
ffff800000104d73:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
ffff800000104d79:	3b 85 34 ff ff ff    	cmp    -0xcc(%rbp),%eax
ffff800000104d7f:	0f 8c 8d fb ff ff    	jl     ffff800000104912 <color_printk+0x105>
ffff800000104d85:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000104d8c:	0f 85 80 fb ff ff    	jne    ffff800000104912 <color_printk+0x105>
ffff800000104d92:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
ffff800000104d98:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000104d9c:	c9                   	leave  
ffff800000104d9d:	c3                   	ret    

ffff800000104d9e <vsprintf>:
ffff800000104d9e:	f3 0f 1e fa          	endbr64 
ffff800000104da2:	55                   	push   %rbp
ffff800000104da3:	48 89 e5             	mov    %rsp,%rbp
ffff800000104da6:	53                   	push   %rbx
ffff800000104da7:	48 83 ec 68          	sub    $0x68,%rsp
ffff800000104dab:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000104dab <vsprintf+0xd>
ffff800000104db2:	49 bb 25 e3 00 00 00 	movabs $0xe325,%r11
ffff800000104db9:	00 00 00 
ffff800000104dbc:	4c 01 db             	add    %r11,%rbx
ffff800000104dbf:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
ffff800000104dc3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
ffff800000104dc7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
ffff800000104dcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000104dcf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000104dd3:	e9 f4 08 00 00       	jmp    ffff8000001056cc <vsprintf+0x92e>
ffff800000104dd8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104ddc:	0f b6 00             	movzbl (%rax),%eax
ffff800000104ddf:	3c 25                	cmp    $0x25,%al
ffff800000104de1:	74 1a                	je     ffff800000104dfd <vsprintf+0x5f>
ffff800000104de3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
ffff800000104de7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104deb:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000104def:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000104df3:	0f b6 12             	movzbl (%rdx),%edx
ffff800000104df6:	88 10                	mov    %dl,(%rax)
ffff800000104df8:	e9 c3 08 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff800000104dfd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
ffff800000104e04:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104e08:	48 83 c0 01          	add    $0x1,%rax
ffff800000104e0c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff800000104e10:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104e14:	0f b6 00             	movzbl (%rax),%eax
ffff800000104e17:	0f be c0             	movsbl %al,%eax
ffff800000104e1a:	83 e8 20             	sub    $0x20,%eax
ffff800000104e1d:	83 f8 10             	cmp    $0x10,%eax
ffff800000104e20:	77 40                	ja     ffff800000104e62 <vsprintf+0xc4>
ffff800000104e22:	89 c0                	mov    %eax,%eax
ffff800000104e24:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000104e2b:	00 
ffff800000104e2c:	48 8d 05 5d f3 00 00 	lea    0xf35d(%rip),%rax        # ffff800000114190 <.LC3+0xd>
ffff800000104e33:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
ffff800000104e37:	48 8d 15 52 f3 00 00 	lea    0xf352(%rip),%rdx        # ffff800000114190 <.LC3+0xd>
ffff800000104e3e:	48 01 d0             	add    %rdx,%rax
ffff800000104e41:	3e ff e0             	notrack jmp *%rax
ffff800000104e44:	83 4d dc 10          	orl    $0x10,-0x24(%rbp)
ffff800000104e48:	eb ba                	jmp    ffff800000104e04 <vsprintf+0x66>
ffff800000104e4a:	83 4d dc 04          	orl    $0x4,-0x24(%rbp)
ffff800000104e4e:	eb b4                	jmp    ffff800000104e04 <vsprintf+0x66>
ffff800000104e50:	83 4d dc 08          	orl    $0x8,-0x24(%rbp)
ffff800000104e54:	eb ae                	jmp    ffff800000104e04 <vsprintf+0x66>
ffff800000104e56:	83 4d dc 20          	orl    $0x20,-0x24(%rbp)
ffff800000104e5a:	eb a8                	jmp    ffff800000104e04 <vsprintf+0x66>
ffff800000104e5c:	83 4d dc 01          	orl    $0x1,-0x24(%rbp)
ffff800000104e60:	eb a2                	jmp    ffff800000104e04 <vsprintf+0x66>
ffff800000104e62:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
ffff800000104e69:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104e6d:	0f b6 00             	movzbl (%rax),%eax
ffff800000104e70:	3c 2f                	cmp    $0x2f,%al
ffff800000104e72:	7e 27                	jle    ffff800000104e9b <vsprintf+0xfd>
ffff800000104e74:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104e78:	0f b6 00             	movzbl (%rax),%eax
ffff800000104e7b:	3c 39                	cmp    $0x39,%al
ffff800000104e7d:	7f 1c                	jg     ffff800000104e9b <vsprintf+0xfd>
ffff800000104e7f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
ffff800000104e83:	48 89 c7             	mov    %rax,%rdi
ffff800000104e86:	48 b8 20 26 ff ff ff 	movabs $0xffffffffffff2620,%rax
ffff800000104e8d:	ff ff ff 
ffff800000104e90:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104e94:	ff d0                	call   *%rax
ffff800000104e96:	89 45 d8             	mov    %eax,-0x28(%rbp)
ffff800000104e99:	eb 6c                	jmp    ffff800000104f07 <vsprintf+0x169>
ffff800000104e9b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104e9f:	0f b6 00             	movzbl (%rax),%eax
ffff800000104ea2:	3c 2a                	cmp    $0x2a,%al
ffff800000104ea4:	75 61                	jne    ffff800000104f07 <vsprintf+0x169>
ffff800000104ea6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104eaa:	48 83 c0 01          	add    $0x1,%rax
ffff800000104eae:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff800000104eb2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104eb6:	8b 00                	mov    (%rax),%eax
ffff800000104eb8:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000104ebb:	77 24                	ja     ffff800000104ee1 <vsprintf+0x143>
ffff800000104ebd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104ec1:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000104ec5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104ec9:	8b 00                	mov    (%rax),%eax
ffff800000104ecb:	89 c0                	mov    %eax,%eax
ffff800000104ecd:	48 01 d0             	add    %rdx,%rax
ffff800000104ed0:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104ed4:	8b 12                	mov    (%rdx),%edx
ffff800000104ed6:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000104ed9:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104edd:	89 0a                	mov    %ecx,(%rdx)
ffff800000104edf:	eb 14                	jmp    ffff800000104ef5 <vsprintf+0x157>
ffff800000104ee1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104ee5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000104ee9:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000104eed:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104ef1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000104ef5:	8b 00                	mov    (%rax),%eax
ffff800000104ef7:	89 45 d8             	mov    %eax,-0x28(%rbp)
ffff800000104efa:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
ffff800000104efe:	79 07                	jns    ffff800000104f07 <vsprintf+0x169>
ffff800000104f00:	f7 5d d8             	negl   -0x28(%rbp)
ffff800000104f03:	83 4d dc 10          	orl    $0x10,-0x24(%rbp)
ffff800000104f07:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%rbp)
ffff800000104f0e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f12:	0f b6 00             	movzbl (%rax),%eax
ffff800000104f15:	3c 2e                	cmp    $0x2e,%al
ffff800000104f17:	0f 85 aa 00 00 00    	jne    ffff800000104fc7 <vsprintf+0x229>
ffff800000104f1d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f21:	48 83 c0 01          	add    $0x1,%rax
ffff800000104f25:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff800000104f29:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f2d:	0f b6 00             	movzbl (%rax),%eax
ffff800000104f30:	3c 2f                	cmp    $0x2f,%al
ffff800000104f32:	7e 27                	jle    ffff800000104f5b <vsprintf+0x1bd>
ffff800000104f34:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f38:	0f b6 00             	movzbl (%rax),%eax
ffff800000104f3b:	3c 39                	cmp    $0x39,%al
ffff800000104f3d:	7f 1c                	jg     ffff800000104f5b <vsprintf+0x1bd>
ffff800000104f3f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
ffff800000104f43:	48 89 c7             	mov    %rax,%rdi
ffff800000104f46:	48 b8 20 26 ff ff ff 	movabs $0xffffffffffff2620,%rax
ffff800000104f4d:	ff ff ff 
ffff800000104f50:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000104f54:	ff d0                	call   *%rax
ffff800000104f56:	89 45 d4             	mov    %eax,-0x2c(%rbp)
ffff800000104f59:	eb 5f                	jmp    ffff800000104fba <vsprintf+0x21c>
ffff800000104f5b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f5f:	0f b6 00             	movzbl (%rax),%eax
ffff800000104f62:	3c 2a                	cmp    $0x2a,%al
ffff800000104f64:	75 54                	jne    ffff800000104fba <vsprintf+0x21c>
ffff800000104f66:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104f6a:	48 83 c0 01          	add    $0x1,%rax
ffff800000104f6e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff800000104f72:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104f76:	8b 00                	mov    (%rax),%eax
ffff800000104f78:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000104f7b:	77 24                	ja     ffff800000104fa1 <vsprintf+0x203>
ffff800000104f7d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104f81:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000104f85:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104f89:	8b 00                	mov    (%rax),%eax
ffff800000104f8b:	89 c0                	mov    %eax,%eax
ffff800000104f8d:	48 01 d0             	add    %rdx,%rax
ffff800000104f90:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104f94:	8b 12                	mov    (%rdx),%edx
ffff800000104f96:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000104f99:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104f9d:	89 0a                	mov    %ecx,(%rdx)
ffff800000104f9f:	eb 14                	jmp    ffff800000104fb5 <vsprintf+0x217>
ffff800000104fa1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000104fa5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000104fa9:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000104fad:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000104fb1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000104fb5:	8b 00                	mov    (%rax),%eax
ffff800000104fb7:	89 45 d4             	mov    %eax,-0x2c(%rbp)
ffff800000104fba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffff800000104fbe:	79 07                	jns    ffff800000104fc7 <vsprintf+0x229>
ffff800000104fc0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
ffff800000104fc7:	c7 45 c8 ff ff ff ff 	movl   $0xffffffff,-0x38(%rbp)
ffff800000104fce:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104fd2:	0f b6 00             	movzbl (%rax),%eax
ffff800000104fd5:	3c 68                	cmp    $0x68,%al
ffff800000104fd7:	74 21                	je     ffff800000104ffa <vsprintf+0x25c>
ffff800000104fd9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104fdd:	0f b6 00             	movzbl (%rax),%eax
ffff800000104fe0:	3c 6c                	cmp    $0x6c,%al
ffff800000104fe2:	74 16                	je     ffff800000104ffa <vsprintf+0x25c>
ffff800000104fe4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104fe8:	0f b6 00             	movzbl (%rax),%eax
ffff800000104feb:	3c 4c                	cmp    $0x4c,%al
ffff800000104fed:	74 0b                	je     ffff800000104ffa <vsprintf+0x25c>
ffff800000104fef:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104ff3:	0f b6 00             	movzbl (%rax),%eax
ffff800000104ff6:	3c 5a                	cmp    $0x5a,%al
ffff800000104ff8:	75 19                	jne    ffff800000105013 <vsprintf+0x275>
ffff800000104ffa:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000104ffe:	0f b6 00             	movzbl (%rax),%eax
ffff800000105001:	0f be c0             	movsbl %al,%eax
ffff800000105004:	89 45 c8             	mov    %eax,-0x38(%rbp)
ffff800000105007:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff80000010500b:	48 83 c0 01          	add    $0x1,%rax
ffff80000010500f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff800000105013:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000105017:	0f b6 00             	movzbl (%rax),%eax
ffff80000010501a:	0f be c0             	movsbl %al,%eax
ffff80000010501d:	83 e8 25             	sub    $0x25,%eax
ffff800000105020:	83 f8 53             	cmp    $0x53,%eax
ffff800000105023:	0f 87 59 06 00 00    	ja     ffff800000105682 <vsprintf+0x8e4>
ffff800000105029:	89 c0                	mov    %eax,%eax
ffff80000010502b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000105032:	00 
ffff800000105033:	48 8d 05 de f1 00 00 	lea    0xf1de(%rip),%rax        # ffff800000114218 <.LC3+0x95>
ffff80000010503a:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
ffff80000010503e:	48 8d 15 d3 f1 00 00 	lea    0xf1d3(%rip),%rdx        # ffff800000114218 <.LC3+0x95>
ffff800000105045:	48 01 d0             	add    %rdx,%rax
ffff800000105048:	3e ff e0             	notrack jmp *%rax
ffff80000010504b:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010504e:	83 e0 10             	and    $0x10,%eax
ffff800000105051:	85 c0                	test   %eax,%eax
ffff800000105053:	75 1b                	jne    ffff800000105070 <vsprintf+0x2d2>
ffff800000105055:	eb 0f                	jmp    ffff800000105066 <vsprintf+0x2c8>
ffff800000105057:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010505b:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff80000010505f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000105063:	c6 00 20             	movb   $0x20,(%rax)
ffff800000105066:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
ffff80000010506a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
ffff80000010506e:	7f e7                	jg     ffff800000105057 <vsprintf+0x2b9>
ffff800000105070:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105074:	8b 00                	mov    (%rax),%eax
ffff800000105076:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105079:	77 24                	ja     ffff80000010509f <vsprintf+0x301>
ffff80000010507b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010507f:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000105083:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105087:	8b 00                	mov    (%rax),%eax
ffff800000105089:	89 c0                	mov    %eax,%eax
ffff80000010508b:	48 01 d0             	add    %rdx,%rax
ffff80000010508e:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105092:	8b 12                	mov    (%rdx),%edx
ffff800000105094:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000105097:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010509b:	89 0a                	mov    %ecx,(%rdx)
ffff80000010509d:	eb 14                	jmp    ffff8000001050b3 <vsprintf+0x315>
ffff80000010509f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001050a3:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001050a7:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff8000001050ab:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001050af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff8000001050b3:	8b 08                	mov    (%rax),%ecx
ffff8000001050b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001050b9:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001050bd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff8000001050c1:	89 ca                	mov    %ecx,%edx
ffff8000001050c3:	88 10                	mov    %dl,(%rax)
ffff8000001050c5:	eb 0f                	jmp    ffff8000001050d6 <vsprintf+0x338>
ffff8000001050c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001050cb:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001050cf:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff8000001050d3:	c6 00 20             	movb   $0x20,(%rax)
ffff8000001050d6:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
ffff8000001050da:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
ffff8000001050de:	7f e7                	jg     ffff8000001050c7 <vsprintf+0x329>
ffff8000001050e0:	e9 db 05 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff8000001050e5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001050e9:	8b 00                	mov    (%rax),%eax
ffff8000001050eb:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001050ee:	77 24                	ja     ffff800000105114 <vsprintf+0x376>
ffff8000001050f0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001050f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001050f8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001050fc:	8b 00                	mov    (%rax),%eax
ffff8000001050fe:	89 c0                	mov    %eax,%eax
ffff800000105100:	48 01 d0             	add    %rdx,%rax
ffff800000105103:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105107:	8b 12                	mov    (%rdx),%edx
ffff800000105109:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff80000010510c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105110:	89 0a                	mov    %ecx,(%rdx)
ffff800000105112:	eb 14                	jmp    ffff800000105128 <vsprintf+0x38a>
ffff800000105114:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105118:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010511c:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105120:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105124:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000105128:	48 8b 00             	mov    (%rax),%rax
ffff80000010512b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010512f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000105134:	75 08                	jne    ffff80000010513e <vsprintf+0x3a0>
ffff800000105136:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff80000010513d:	00 
ffff80000010513e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105142:	48 89 c7             	mov    %rax,%rdi
ffff800000105145:	48 b8 f6 16 ff ff ff 	movabs $0xffffffffffff16f6,%rax
ffff80000010514c:	ff ff ff 
ffff80000010514f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105153:	ff d0                	call   *%rax
ffff800000105155:	89 45 d0             	mov    %eax,-0x30(%rbp)
ffff800000105158:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffff80000010515c:	79 08                	jns    ffff800000105166 <vsprintf+0x3c8>
ffff80000010515e:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff800000105161:	89 45 d4             	mov    %eax,-0x2c(%rbp)
ffff800000105164:	eb 0e                	jmp    ffff800000105174 <vsprintf+0x3d6>
ffff800000105166:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff800000105169:	3b 45 d4             	cmp    -0x2c(%rbp),%eax
ffff80000010516c:	7e 06                	jle    ffff800000105174 <vsprintf+0x3d6>
ffff80000010516e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000105171:	89 45 d0             	mov    %eax,-0x30(%rbp)
ffff800000105174:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000105177:	83 e0 10             	and    $0x10,%eax
ffff80000010517a:	85 c0                	test   %eax,%eax
ffff80000010517c:	75 1d                	jne    ffff80000010519b <vsprintf+0x3fd>
ffff80000010517e:	eb 0f                	jmp    ffff80000010518f <vsprintf+0x3f1>
ffff800000105180:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105184:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105188:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff80000010518c:	c6 00 20             	movb   $0x20,(%rax)
ffff80000010518f:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
ffff800000105193:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffff800000105196:	3b 45 d0             	cmp    -0x30(%rbp),%eax
ffff800000105199:	7f e5                	jg     ffff800000105180 <vsprintf+0x3e2>
ffff80000010519b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
ffff8000001051a2:	eb 21                	jmp    ffff8000001051c5 <vsprintf+0x427>
ffff8000001051a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001051a8:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff8000001051ac:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff8000001051b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051b4:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff8000001051b8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff8000001051bc:	0f b6 12             	movzbl (%rdx),%edx
ffff8000001051bf:	88 10                	mov    %dl,(%rax)
ffff8000001051c1:	83 45 cc 01          	addl   $0x1,-0x34(%rbp)
ffff8000001051c5:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001051c8:	3b 45 d0             	cmp    -0x30(%rbp),%eax
ffff8000001051cb:	7c d7                	jl     ffff8000001051a4 <vsprintf+0x406>
ffff8000001051cd:	eb 0f                	jmp    ffff8000001051de <vsprintf+0x440>
ffff8000001051cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051d3:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001051d7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff8000001051db:	c6 00 20             	movb   $0x20,(%rax)
ffff8000001051de:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
ffff8000001051e2:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffff8000001051e5:	3b 45 d0             	cmp    -0x30(%rbp),%eax
ffff8000001051e8:	7f e5                	jg     ffff8000001051cf <vsprintf+0x431>
ffff8000001051ea:	e9 d1 04 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff8000001051ef:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
ffff8000001051f3:	0f 85 82 00 00 00    	jne    ffff80000010527b <vsprintf+0x4dd>
ffff8000001051f9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001051fd:	8b 00                	mov    (%rax),%eax
ffff8000001051ff:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105202:	77 24                	ja     ffff800000105228 <vsprintf+0x48a>
ffff800000105204:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105208:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff80000010520c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105210:	8b 00                	mov    (%rax),%eax
ffff800000105212:	89 c0                	mov    %eax,%eax
ffff800000105214:	48 01 d0             	add    %rdx,%rax
ffff800000105217:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010521b:	8b 12                	mov    (%rdx),%edx
ffff80000010521d:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000105220:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105224:	89 0a                	mov    %ecx,(%rdx)
ffff800000105226:	eb 14                	jmp    ffff80000010523c <vsprintf+0x49e>
ffff800000105228:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010522c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000105230:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105234:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105238:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff80000010523c:	48 8b 00             	mov    (%rax),%rax
ffff80000010523f:	48 89 c7             	mov    %rax,%rdi
ffff800000105242:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff800000105245:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff800000105248:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010524b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010524f:	41 89 f1             	mov    %esi,%r9d
ffff800000105252:	41 89 c8             	mov    %ecx,%r8d
ffff800000105255:	89 d1                	mov    %edx,%ecx
ffff800000105257:	ba 08 00 00 00       	mov    $0x8,%edx
ffff80000010525c:	48 89 fe             	mov    %rdi,%rsi
ffff80000010525f:	48 89 c7             	mov    %rax,%rdi
ffff800000105262:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff800000105269:	ff ff ff 
ffff80000010526c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105270:	ff d0                	call   *%rax
ffff800000105272:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105276:	e9 45 04 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff80000010527b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010527f:	8b 00                	mov    (%rax),%eax
ffff800000105281:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105284:	77 24                	ja     ffff8000001052aa <vsprintf+0x50c>
ffff800000105286:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010528a:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff80000010528e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105292:	8b 00                	mov    (%rax),%eax
ffff800000105294:	89 c0                	mov    %eax,%eax
ffff800000105296:	48 01 d0             	add    %rdx,%rax
ffff800000105299:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010529d:	8b 12                	mov    (%rdx),%edx
ffff80000010529f:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff8000001052a2:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001052a6:	89 0a                	mov    %ecx,(%rdx)
ffff8000001052a8:	eb 14                	jmp    ffff8000001052be <vsprintf+0x520>
ffff8000001052aa:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001052ae:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001052b2:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff8000001052b6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001052ba:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff8000001052be:	8b 00                	mov    (%rax),%eax
ffff8000001052c0:	89 c7                	mov    %eax,%edi
ffff8000001052c2:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff8000001052c5:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff8000001052c8:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff8000001052cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001052cf:	41 89 f1             	mov    %esi,%r9d
ffff8000001052d2:	41 89 c8             	mov    %ecx,%r8d
ffff8000001052d5:	89 d1                	mov    %edx,%ecx
ffff8000001052d7:	ba 08 00 00 00       	mov    $0x8,%edx
ffff8000001052dc:	48 89 fe             	mov    %rdi,%rsi
ffff8000001052df:	48 89 c7             	mov    %rax,%rdi
ffff8000001052e2:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff8000001052e9:	ff ff ff 
ffff8000001052ec:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001052f0:	ff d0                	call   *%rax
ffff8000001052f2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001052f6:	e9 c5 03 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff8000001052fb:	83 7d d8 ff          	cmpl   $0xffffffff,-0x28(%rbp)
ffff8000001052ff:	75 0b                	jne    ffff80000010530c <vsprintf+0x56e>
ffff800000105301:	c7 45 d8 10 00 00 00 	movl   $0x10,-0x28(%rbp)
ffff800000105308:	83 4d dc 01          	orl    $0x1,-0x24(%rbp)
ffff80000010530c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105310:	8b 00                	mov    (%rax),%eax
ffff800000105312:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105315:	77 24                	ja     ffff80000010533b <vsprintf+0x59d>
ffff800000105317:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010531b:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff80000010531f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105323:	8b 00                	mov    (%rax),%eax
ffff800000105325:	89 c0                	mov    %eax,%eax
ffff800000105327:	48 01 d0             	add    %rdx,%rax
ffff80000010532a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010532e:	8b 12                	mov    (%rdx),%edx
ffff800000105330:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000105333:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105337:	89 0a                	mov    %ecx,(%rdx)
ffff800000105339:	eb 14                	jmp    ffff80000010534f <vsprintf+0x5b1>
ffff80000010533b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010533f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000105343:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105347:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010534b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff80000010534f:	48 8b 00             	mov    (%rax),%rax
ffff800000105352:	48 89 c7             	mov    %rax,%rdi
ffff800000105355:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff800000105358:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff80000010535b:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010535e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105362:	41 89 f1             	mov    %esi,%r9d
ffff800000105365:	41 89 c8             	mov    %ecx,%r8d
ffff800000105368:	89 d1                	mov    %edx,%ecx
ffff80000010536a:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010536f:	48 89 fe             	mov    %rdi,%rsi
ffff800000105372:	48 89 c7             	mov    %rax,%rdi
ffff800000105375:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff80000010537c:	ff ff ff 
ffff80000010537f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105383:	ff d0                	call   *%rax
ffff800000105385:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105389:	e9 32 03 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff80000010538e:	83 4d dc 40          	orl    $0x40,-0x24(%rbp)
ffff800000105392:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
ffff800000105396:	0f 85 82 00 00 00    	jne    ffff80000010541e <vsprintf+0x680>
ffff80000010539c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001053a0:	8b 00                	mov    (%rax),%eax
ffff8000001053a2:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001053a5:	77 24                	ja     ffff8000001053cb <vsprintf+0x62d>
ffff8000001053a7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001053ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001053af:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001053b3:	8b 00                	mov    (%rax),%eax
ffff8000001053b5:	89 c0                	mov    %eax,%eax
ffff8000001053b7:	48 01 d0             	add    %rdx,%rax
ffff8000001053ba:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001053be:	8b 12                	mov    (%rdx),%edx
ffff8000001053c0:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff8000001053c3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001053c7:	89 0a                	mov    %ecx,(%rdx)
ffff8000001053c9:	eb 14                	jmp    ffff8000001053df <vsprintf+0x641>
ffff8000001053cb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001053cf:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001053d3:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff8000001053d7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001053db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff8000001053df:	48 8b 00             	mov    (%rax),%rax
ffff8000001053e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001053e5:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff8000001053e8:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff8000001053eb:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff8000001053ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053f2:	41 89 f1             	mov    %esi,%r9d
ffff8000001053f5:	41 89 c8             	mov    %ecx,%r8d
ffff8000001053f8:	89 d1                	mov    %edx,%ecx
ffff8000001053fa:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001053ff:	48 89 fe             	mov    %rdi,%rsi
ffff800000105402:	48 89 c7             	mov    %rax,%rdi
ffff800000105405:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff80000010540c:	ff ff ff 
ffff80000010540f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105413:	ff d0                	call   *%rax
ffff800000105415:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105419:	e9 a2 02 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff80000010541e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105422:	8b 00                	mov    (%rax),%eax
ffff800000105424:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105427:	77 24                	ja     ffff80000010544d <vsprintf+0x6af>
ffff800000105429:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010542d:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000105431:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105435:	8b 00                	mov    (%rax),%eax
ffff800000105437:	89 c0                	mov    %eax,%eax
ffff800000105439:	48 01 d0             	add    %rdx,%rax
ffff80000010543c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105440:	8b 12                	mov    (%rdx),%edx
ffff800000105442:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000105445:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105449:	89 0a                	mov    %ecx,(%rdx)
ffff80000010544b:	eb 14                	jmp    ffff800000105461 <vsprintf+0x6c3>
ffff80000010544d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105451:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000105455:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105459:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010545d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000105461:	8b 00                	mov    (%rax),%eax
ffff800000105463:	89 c7                	mov    %eax,%edi
ffff800000105465:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff800000105468:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff80000010546b:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010546e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105472:	41 89 f1             	mov    %esi,%r9d
ffff800000105475:	41 89 c8             	mov    %ecx,%r8d
ffff800000105478:	89 d1                	mov    %edx,%ecx
ffff80000010547a:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010547f:	48 89 fe             	mov    %rdi,%rsi
ffff800000105482:	48 89 c7             	mov    %rax,%rdi
ffff800000105485:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff80000010548c:	ff ff ff 
ffff80000010548f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105493:	ff d0                	call   *%rax
ffff800000105495:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105499:	e9 22 02 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff80000010549e:	83 4d dc 02          	orl    $0x2,-0x24(%rbp)
ffff8000001054a2:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
ffff8000001054a6:	0f 85 82 00 00 00    	jne    ffff80000010552e <vsprintf+0x790>
ffff8000001054ac:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001054b0:	8b 00                	mov    (%rax),%eax
ffff8000001054b2:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001054b5:	77 24                	ja     ffff8000001054db <vsprintf+0x73d>
ffff8000001054b7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001054bb:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001054bf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001054c3:	8b 00                	mov    (%rax),%eax
ffff8000001054c5:	89 c0                	mov    %eax,%eax
ffff8000001054c7:	48 01 d0             	add    %rdx,%rax
ffff8000001054ca:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001054ce:	8b 12                	mov    (%rdx),%edx
ffff8000001054d0:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff8000001054d3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001054d7:	89 0a                	mov    %ecx,(%rdx)
ffff8000001054d9:	eb 14                	jmp    ffff8000001054ef <vsprintf+0x751>
ffff8000001054db:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001054df:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001054e3:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff8000001054e7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001054eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff8000001054ef:	48 8b 00             	mov    (%rax),%rax
ffff8000001054f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001054f5:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff8000001054f8:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff8000001054fb:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff8000001054fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105502:	41 89 f1             	mov    %esi,%r9d
ffff800000105505:	41 89 c8             	mov    %ecx,%r8d
ffff800000105508:	89 d1                	mov    %edx,%ecx
ffff80000010550a:	ba 0a 00 00 00       	mov    $0xa,%edx
ffff80000010550f:	48 89 fe             	mov    %rdi,%rsi
ffff800000105512:	48 89 c7             	mov    %rax,%rdi
ffff800000105515:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff80000010551c:	ff ff ff 
ffff80000010551f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105523:	ff d0                	call   *%rax
ffff800000105525:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105529:	e9 92 01 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff80000010552e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105532:	8b 00                	mov    (%rax),%eax
ffff800000105534:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000105537:	77 24                	ja     ffff80000010555d <vsprintf+0x7bf>
ffff800000105539:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010553d:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000105541:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105545:	8b 00                	mov    (%rax),%eax
ffff800000105547:	89 c0                	mov    %eax,%eax
ffff800000105549:	48 01 d0             	add    %rdx,%rax
ffff80000010554c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105550:	8b 12                	mov    (%rdx),%edx
ffff800000105552:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff800000105555:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105559:	89 0a                	mov    %ecx,(%rdx)
ffff80000010555b:	eb 14                	jmp    ffff800000105571 <vsprintf+0x7d3>
ffff80000010555d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105561:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000105565:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105569:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff80000010556d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000105571:	8b 00                	mov    (%rax),%eax
ffff800000105573:	89 c7                	mov    %eax,%edi
ffff800000105575:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff800000105578:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff80000010557b:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010557e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105582:	41 89 f1             	mov    %esi,%r9d
ffff800000105585:	41 89 c8             	mov    %ecx,%r8d
ffff800000105588:	89 d1                	mov    %edx,%ecx
ffff80000010558a:	ba 0a 00 00 00       	mov    $0xa,%edx
ffff80000010558f:	48 89 fe             	mov    %rdi,%rsi
ffff800000105592:	48 89 c7             	mov    %rax,%rdi
ffff800000105595:	48 b8 a4 27 ff ff ff 	movabs $0xffffffffffff27a4,%rax
ffff80000010559c:	ff ff ff 
ffff80000010559f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001055a3:	ff d0                	call   *%rax
ffff8000001055a5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001055a9:	e9 12 01 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff8000001055ae:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
ffff8000001055b2:	75 61                	jne    ffff800000105615 <vsprintf+0x877>
ffff8000001055b4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001055b8:	8b 00                	mov    (%rax),%eax
ffff8000001055ba:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001055bd:	77 24                	ja     ffff8000001055e3 <vsprintf+0x845>
ffff8000001055bf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001055c3:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001055c7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001055cb:	8b 00                	mov    (%rax),%eax
ffff8000001055cd:	89 c0                	mov    %eax,%eax
ffff8000001055cf:	48 01 d0             	add    %rdx,%rax
ffff8000001055d2:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001055d6:	8b 12                	mov    (%rdx),%edx
ffff8000001055d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff8000001055db:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001055df:	89 0a                	mov    %ecx,(%rdx)
ffff8000001055e1:	eb 14                	jmp    ffff8000001055f7 <vsprintf+0x859>
ffff8000001055e3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001055e7:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001055eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff8000001055ef:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001055f3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff8000001055f7:	48 8b 00             	mov    (%rax),%rax
ffff8000001055fa:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
ffff8000001055fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105602:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
ffff800000105606:	48 89 c2             	mov    %rax,%rdx
ffff800000105609:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff80000010560d:	48 89 10             	mov    %rdx,(%rax)
ffff800000105610:	e9 ab 00 00 00       	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff800000105615:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105619:	8b 00                	mov    (%rax),%eax
ffff80000010561b:	83 f8 2f             	cmp    $0x2f,%eax
ffff80000010561e:	77 24                	ja     ffff800000105644 <vsprintf+0x8a6>
ffff800000105620:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105624:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000105628:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010562c:	8b 00                	mov    (%rax),%eax
ffff80000010562e:	89 c0                	mov    %eax,%eax
ffff800000105630:	48 01 d0             	add    %rdx,%rax
ffff800000105633:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105637:	8b 12                	mov    (%rdx),%edx
ffff800000105639:	8d 4a 08             	lea    0x8(%rdx),%ecx
ffff80000010563c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105640:	89 0a                	mov    %ecx,(%rdx)
ffff800000105642:	eb 14                	jmp    ffff800000105658 <vsprintf+0x8ba>
ffff800000105644:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000105648:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010564c:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff800000105650:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff800000105654:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
ffff800000105658:	48 8b 00             	mov    (%rax),%rax
ffff80000010565b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010565f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105663:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
ffff800000105667:	89 c2                	mov    %eax,%edx
ffff800000105669:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010566d:	89 10                	mov    %edx,(%rax)
ffff80000010566f:	eb 4f                	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff800000105671:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105675:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105679:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff80000010567d:	c6 00 25             	movb   $0x25,(%rax)
ffff800000105680:	eb 3e                	jmp    ffff8000001056c0 <vsprintf+0x922>
ffff800000105682:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105686:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff80000010568a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff80000010568e:	c6 00 25             	movb   $0x25,(%rax)
ffff800000105691:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000105695:	0f b6 00             	movzbl (%rax),%eax
ffff800000105698:	84 c0                	test   %al,%al
ffff80000010569a:	74 17                	je     ffff8000001056b3 <vsprintf+0x915>
ffff80000010569c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
ffff8000001056a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001056a4:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff8000001056a8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff8000001056ac:	0f b6 12             	movzbl (%rdx),%edx
ffff8000001056af:	88 10                	mov    %dl,(%rax)
ffff8000001056b1:	eb 0c                	jmp    ffff8000001056bf <vsprintf+0x921>
ffff8000001056b3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001056b7:	48 83 e8 01          	sub    $0x1,%rax
ffff8000001056bb:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff8000001056bf:	90                   	nop
ffff8000001056c0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001056c4:	48 83 c0 01          	add    $0x1,%rax
ffff8000001056c8:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff8000001056cc:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001056d0:	0f b6 00             	movzbl (%rax),%eax
ffff8000001056d3:	84 c0                	test   %al,%al
ffff8000001056d5:	0f 85 fd f6 ff ff    	jne    ffff800000104dd8 <vsprintf+0x3a>
ffff8000001056db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001056df:	c6 00 00             	movb   $0x0,(%rax)
ffff8000001056e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001056e6:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
ffff8000001056ea:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff8000001056ee:	c9                   	leave  
ffff8000001056ef:	c3                   	ret    

ffff8000001056f0 <skip_atoi>:
ffff8000001056f0:	f3 0f 1e fa          	endbr64 
ffff8000001056f4:	55                   	push   %rbp
ffff8000001056f5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001056f8:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001056f8 <skip_atoi+0x8>
ffff8000001056ff:	49 bb d8 d9 00 00 00 	movabs $0xd9d8,%r11
ffff800000105706:	00 00 00 
ffff800000105709:	4c 01 d8             	add    %r11,%rax
ffff80000010570c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105710:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105717:	eb 2e                	jmp    ffff800000105747 <skip_atoi+0x57>
ffff800000105719:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010571c:	89 d0                	mov    %edx,%eax
ffff80000010571e:	c1 e0 02             	shl    $0x2,%eax
ffff800000105721:	01 d0                	add    %edx,%eax
ffff800000105723:	01 c0                	add    %eax,%eax
ffff800000105725:	89 c6                	mov    %eax,%esi
ffff800000105727:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010572b:	48 8b 00             	mov    (%rax),%rax
ffff80000010572e:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000105732:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105736:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105739:	0f b6 00             	movzbl (%rax),%eax
ffff80000010573c:	0f be c0             	movsbl %al,%eax
ffff80000010573f:	01 f0                	add    %esi,%eax
ffff800000105741:	83 e8 30             	sub    $0x30,%eax
ffff800000105744:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000105747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010574b:	48 8b 00             	mov    (%rax),%rax
ffff80000010574e:	0f b6 00             	movzbl (%rax),%eax
ffff800000105751:	3c 2f                	cmp    $0x2f,%al
ffff800000105753:	7e 0e                	jle    ffff800000105763 <skip_atoi+0x73>
ffff800000105755:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105759:	48 8b 00             	mov    (%rax),%rax
ffff80000010575c:	0f b6 00             	movzbl (%rax),%eax
ffff80000010575f:	3c 39                	cmp    $0x39,%al
ffff800000105761:	7e b6                	jle    ffff800000105719 <skip_atoi+0x29>
ffff800000105763:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105766:	5d                   	pop    %rbp
ffff800000105767:	c3                   	ret    

ffff800000105768 <putchar>:
ffff800000105768:	f3 0f 1e fa          	endbr64 
ffff80000010576c:	55                   	push   %rbp
ffff80000010576d:	48 89 e5             	mov    %rsp,%rbp
ffff800000105770:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000105770 <putchar+0x8>
ffff800000105777:	49 bb 60 d9 00 00 00 	movabs $0xd960,%r11
ffff80000010577e:	00 00 00 
ffff800000105781:	4c 01 d8             	add    %r11,%rax
ffff800000105784:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000105788:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffff80000010578b:	89 55 d0             	mov    %edx,-0x30(%rbp)
ffff80000010578e:	89 4d cc             	mov    %ecx,-0x34(%rbp)
ffff800000105791:	44 89 45 c8          	mov    %r8d,-0x38(%rbp)
ffff800000105795:	44 89 4d c4          	mov    %r9d,-0x3c(%rbp)
ffff800000105799:	8b 55 10             	mov    0x10(%rbp),%edx
ffff80000010579c:	88 55 c0             	mov    %dl,-0x40(%rbp)
ffff80000010579f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001057a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001057ad:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff8000001057b4:	00 
ffff8000001057b5:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001057bc:	00 
ffff8000001057bd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
ffff8000001057c4:	0f b6 55 c0          	movzbl -0x40(%rbp),%edx
ffff8000001057c8:	48 63 d2             	movslq %edx,%rdx
ffff8000001057cb:	48 89 d1             	mov    %rdx,%rcx
ffff8000001057ce:	48 c1 e1 04          	shl    $0x4,%rcx
ffff8000001057d2:	48 ba f0 8e ff ff ff 	movabs $0xffffffffffff8ef0,%rdx
ffff8000001057d9:	ff ff ff 
ffff8000001057dc:	48 8d 04 10          	lea    (%rax,%rdx,1),%rax
ffff8000001057e0:	48 01 c8             	add    %rcx,%rax
ffff8000001057e3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001057e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001057ee:	eb 7a                	jmp    ffff80000010586a <putchar+0x102>
ffff8000001057f0:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001057f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001057f6:	01 d0                	add    %edx,%eax
ffff8000001057f8:	0f af 45 d4          	imul   -0x2c(%rbp),%eax
ffff8000001057fc:	48 63 d0             	movslq %eax,%rdx
ffff8000001057ff:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff800000105802:	48 98                	cltq   
ffff800000105804:	48 01 d0             	add    %rdx,%rax
ffff800000105807:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010580e:	00 
ffff80000010580f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105813:	48 01 d0             	add    %rdx,%rax
ffff800000105816:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010581a:	c7 45 e4 00 01 00 00 	movl   $0x100,-0x1c(%rbp)
ffff800000105821:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000105828:	eb 31                	jmp    ffff80000010585b <putchar+0xf3>
ffff80000010582a:	d1 7d e4             	sarl   -0x1c(%rbp)
ffff80000010582d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105831:	0f b6 00             	movzbl (%rax),%eax
ffff800000105834:	0f b6 c0             	movzbl %al,%eax
ffff800000105837:	23 45 e4             	and    -0x1c(%rbp),%eax
ffff80000010583a:	85 c0                	test   %eax,%eax
ffff80000010583c:	74 0b                	je     ffff800000105849 <putchar+0xe1>
ffff80000010583e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105842:	8b 55 c8             	mov    -0x38(%rbp),%edx
ffff800000105845:	89 10                	mov    %edx,(%rax)
ffff800000105847:	eb 09                	jmp    ffff800000105852 <putchar+0xea>
ffff800000105849:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010584d:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000105850:	89 10                	mov    %edx,(%rax)
ffff800000105852:	48 83 45 f0 04       	addq   $0x4,-0x10(%rbp)
ffff800000105857:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010585b:	83 7d f8 07          	cmpl   $0x7,-0x8(%rbp)
ffff80000010585f:	7e c9                	jle    ffff80000010582a <putchar+0xc2>
ffff800000105861:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
ffff800000105866:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010586a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff80000010586e:	7e 80                	jle    ffff8000001057f0 <putchar+0x88>
ffff800000105870:	90                   	nop
ffff800000105871:	90                   	nop
ffff800000105872:	5d                   	pop    %rbp
ffff800000105873:	c3                   	ret    

ffff800000105874 <number>:
ffff800000105874:	f3 0f 1e fa          	endbr64 
ffff800000105878:	55                   	push   %rbp
ffff800000105879:	48 89 e5             	mov    %rsp,%rbp
ffff80000010587c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010587c <number+0x8>
ffff800000105883:	49 bb 54 d8 00 00 00 	movabs $0xd854,%r11
ffff80000010588a:	00 00 00 
ffff80000010588d:	4c 01 d8             	add    %r11,%rax
ffff800000105890:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
ffff800000105894:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
ffff800000105898:	89 55 9c             	mov    %edx,-0x64(%rbp)
ffff80000010589b:	89 4d 98             	mov    %ecx,-0x68(%rbp)
ffff80000010589e:	44 89 45 94          	mov    %r8d,-0x6c(%rbp)
ffff8000001058a2:	44 89 4d 90          	mov    %r9d,-0x70(%rbp)
ffff8000001058a6:	48 ba e8 13 00 00 00 	movabs $0x13e8,%rdx
ffff8000001058ad:	00 00 00 
ffff8000001058b0:	48 8d 14 10          	lea    (%rax,%rdx,1),%rdx
ffff8000001058b4:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
ffff8000001058b8:	8b 55 90             	mov    -0x70(%rbp),%edx
ffff8000001058bb:	83 e2 40             	and    $0x40,%edx
ffff8000001058be:	85 d2                	test   %edx,%edx
ffff8000001058c0:	74 12                	je     ffff8000001058d4 <number+0x60>
ffff8000001058c2:	48 ba 10 14 00 00 00 	movabs $0x1410,%rdx
ffff8000001058c9:	00 00 00 
ffff8000001058cc:	48 8d 04 10          	lea    (%rax,%rdx,1),%rax
ffff8000001058d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001058d4:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001058d7:	83 e0 10             	and    $0x10,%eax
ffff8000001058da:	85 c0                	test   %eax,%eax
ffff8000001058dc:	74 04                	je     ffff8000001058e2 <number+0x6e>
ffff8000001058de:	83 65 90 fe          	andl   $0xfffffffe,-0x70(%rbp)
ffff8000001058e2:	83 7d 9c 01          	cmpl   $0x1,-0x64(%rbp)
ffff8000001058e6:	7e 06                	jle    ffff8000001058ee <number+0x7a>
ffff8000001058e8:	83 7d 9c 24          	cmpl   $0x24,-0x64(%rbp)
ffff8000001058ec:	7e 0a                	jle    ffff8000001058f8 <number+0x84>
ffff8000001058ee:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001058f3:	e9 17 02 00 00       	jmp    ffff800000105b0f <number+0x29b>
ffff8000001058f8:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001058fb:	83 e0 01             	and    $0x1,%eax
ffff8000001058fe:	85 c0                	test   %eax,%eax
ffff800000105900:	74 07                	je     ffff800000105909 <number+0x95>
ffff800000105902:	b8 30 00 00 00       	mov    $0x30,%eax
ffff800000105907:	eb 05                	jmp    ffff80000010590e <number+0x9a>
ffff800000105909:	b8 20 00 00 00       	mov    $0x20,%eax
ffff80000010590e:	88 45 eb             	mov    %al,-0x15(%rbp)
ffff800000105911:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
ffff800000105915:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000105918:	83 e0 02             	and    $0x2,%eax
ffff80000010591b:	85 c0                	test   %eax,%eax
ffff80000010591d:	74 11                	je     ffff800000105930 <number+0xbc>
ffff80000010591f:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
ffff800000105924:	79 0a                	jns    ffff800000105930 <number+0xbc>
ffff800000105926:	c6 45 ff 2d          	movb   $0x2d,-0x1(%rbp)
ffff80000010592a:	48 f7 5d a0          	negq   -0x60(%rbp)
ffff80000010592e:	eb 1d                	jmp    ffff80000010594d <number+0xd9>
ffff800000105930:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000105933:	83 e0 04             	and    $0x4,%eax
ffff800000105936:	85 c0                	test   %eax,%eax
ffff800000105938:	75 0b                	jne    ffff800000105945 <number+0xd1>
ffff80000010593a:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff80000010593d:	c1 e0 02             	shl    $0x2,%eax
ffff800000105940:	83 e0 20             	and    $0x20,%eax
ffff800000105943:	eb 05                	jmp    ffff80000010594a <number+0xd6>
ffff800000105945:	b8 2b 00 00 00       	mov    $0x2b,%eax
ffff80000010594a:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff80000010594d:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
ffff800000105951:	74 04                	je     ffff800000105957 <number+0xe3>
ffff800000105953:	83 6d 98 01          	subl   $0x1,-0x68(%rbp)
ffff800000105957:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff80000010595a:	83 e0 20             	and    $0x20,%eax
ffff80000010595d:	85 c0                	test   %eax,%eax
ffff80000010595f:	74 1a                	je     ffff80000010597b <number+0x107>
ffff800000105961:	83 7d 9c 10          	cmpl   $0x10,-0x64(%rbp)
ffff800000105965:	74 0c                	je     ffff800000105973 <number+0xff>
ffff800000105967:	83 7d 9c 08          	cmpl   $0x8,-0x64(%rbp)
ffff80000010596b:	0f 94 c0             	sete   %al
ffff80000010596e:	0f b6 c0             	movzbl %al,%eax
ffff800000105971:	eb 05                	jmp    ffff800000105978 <number+0x104>
ffff800000105973:	b8 02 00 00 00       	mov    $0x2,%eax
ffff800000105978:	29 45 98             	sub    %eax,-0x68(%rbp)
ffff80000010597b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff800000105982:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
ffff800000105987:	75 48                	jne    ffff8000001059d1 <number+0x15d>
ffff800000105989:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010598c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010598f:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff800000105992:	48 98                	cltq   
ffff800000105994:	c6 44 05 b0 30       	movb   $0x30,-0x50(%rbp,%rax,1)
ffff800000105999:	eb 3d                	jmp    ffff8000001059d8 <number+0x164>
ffff80000010599b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff80000010599f:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001059a4:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
ffff8000001059a7:	48 f7 f1             	div    %rcx
ffff8000001059aa:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff8000001059ae:	89 55 e4             	mov    %edx,-0x1c(%rbp)
ffff8000001059b1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff8000001059b4:	48 63 d0             	movslq %eax,%rdx
ffff8000001059b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059bb:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff8000001059bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001059c2:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001059c5:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff8000001059c8:	0f b6 11             	movzbl (%rcx),%edx
ffff8000001059cb:	48 98                	cltq   
ffff8000001059cd:	88 54 05 b0          	mov    %dl,-0x50(%rbp,%rax,1)
ffff8000001059d1:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
ffff8000001059d6:	75 c3                	jne    ffff80000010599b <number+0x127>
ffff8000001059d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001059db:	3b 45 94             	cmp    -0x6c(%rbp),%eax
ffff8000001059de:	7e 06                	jle    ffff8000001059e6 <number+0x172>
ffff8000001059e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001059e3:	89 45 94             	mov    %eax,-0x6c(%rbp)
ffff8000001059e6:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff8000001059e9:	29 45 98             	sub    %eax,-0x68(%rbp)
ffff8000001059ec:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001059ef:	83 e0 11             	and    $0x11,%eax
ffff8000001059f2:	85 c0                	test   %eax,%eax
ffff8000001059f4:	75 1e                	jne    ffff800000105a14 <number+0x1a0>
ffff8000001059f6:	eb 0f                	jmp    ffff800000105a07 <number+0x193>
ffff8000001059f8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff8000001059fc:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a00:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a04:	c6 00 20             	movb   $0x20,(%rax)
ffff800000105a07:	8b 45 98             	mov    -0x68(%rbp),%eax
ffff800000105a0a:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105a0d:	89 55 98             	mov    %edx,-0x68(%rbp)
ffff800000105a10:	85 c0                	test   %eax,%eax
ffff800000105a12:	7f e4                	jg     ffff8000001059f8 <number+0x184>
ffff800000105a14:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
ffff800000105a18:	74 12                	je     ffff800000105a2c <number+0x1b8>
ffff800000105a1a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105a1e:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a22:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a26:	0f b6 55 ff          	movzbl -0x1(%rbp),%edx
ffff800000105a2a:	88 10                	mov    %dl,(%rax)
ffff800000105a2c:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000105a2f:	83 e0 20             	and    $0x20,%eax
ffff800000105a32:	85 c0                	test   %eax,%eax
ffff800000105a34:	74 45                	je     ffff800000105a7b <number+0x207>
ffff800000105a36:	83 7d 9c 08          	cmpl   $0x8,-0x64(%rbp)
ffff800000105a3a:	75 11                	jne    ffff800000105a4d <number+0x1d9>
ffff800000105a3c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105a40:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a44:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a48:	c6 00 30             	movb   $0x30,(%rax)
ffff800000105a4b:	eb 2e                	jmp    ffff800000105a7b <number+0x207>
ffff800000105a4d:	83 7d 9c 10          	cmpl   $0x10,-0x64(%rbp)
ffff800000105a51:	75 28                	jne    ffff800000105a7b <number+0x207>
ffff800000105a53:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105a57:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a5b:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a5f:	c6 00 30             	movb   $0x30,(%rax)
ffff800000105a62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a66:	48 8d 48 21          	lea    0x21(%rax),%rcx
ffff800000105a6a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105a6e:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a72:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a76:	0f b6 11             	movzbl (%rcx),%edx
ffff800000105a79:	88 10                	mov    %dl,(%rax)
ffff800000105a7b:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000105a7e:	83 e0 10             	and    $0x10,%eax
ffff800000105a81:	85 c0                	test   %eax,%eax
ffff800000105a83:	75 32                	jne    ffff800000105ab7 <number+0x243>
ffff800000105a85:	eb 12                	jmp    ffff800000105a99 <number+0x225>
ffff800000105a87:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105a8b:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105a8f:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105a93:	0f b6 55 eb          	movzbl -0x15(%rbp),%edx
ffff800000105a97:	88 10                	mov    %dl,(%rax)
ffff800000105a99:	8b 45 98             	mov    -0x68(%rbp),%eax
ffff800000105a9c:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105a9f:	89 55 98             	mov    %edx,-0x68(%rbp)
ffff800000105aa2:	85 c0                	test   %eax,%eax
ffff800000105aa4:	7f e1                	jg     ffff800000105a87 <number+0x213>
ffff800000105aa6:	eb 0f                	jmp    ffff800000105ab7 <number+0x243>
ffff800000105aa8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105aac:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105ab0:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105ab4:	c6 00 30             	movb   $0x30,(%rax)
ffff800000105ab7:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff800000105aba:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105abd:	89 55 94             	mov    %edx,-0x6c(%rbp)
ffff800000105ac0:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000105ac3:	7c e3                	jl     ffff800000105aa8 <number+0x234>
ffff800000105ac5:	eb 19                	jmp    ffff800000105ae0 <number+0x26c>
ffff800000105ac7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105acb:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105acf:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105ad3:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105ad6:	48 63 d2             	movslq %edx,%rdx
ffff800000105ad9:	0f b6 54 15 b0       	movzbl -0x50(%rbp,%rdx,1),%edx
ffff800000105ade:	88 10                	mov    %dl,(%rax)
ffff800000105ae0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000105ae3:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105ae6:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff800000105ae9:	85 c0                	test   %eax,%eax
ffff800000105aeb:	7f da                	jg     ffff800000105ac7 <number+0x253>
ffff800000105aed:	eb 0f                	jmp    ffff800000105afe <number+0x28a>
ffff800000105aef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105af3:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000105af7:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
ffff800000105afb:	c6 00 20             	movb   $0x20,(%rax)
ffff800000105afe:	8b 45 98             	mov    -0x68(%rbp),%eax
ffff800000105b01:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105b04:	89 55 98             	mov    %edx,-0x68(%rbp)
ffff800000105b07:	85 c0                	test   %eax,%eax
ffff800000105b09:	7f e4                	jg     ffff800000105aef <number+0x27b>
ffff800000105b0b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000105b0f:	5d                   	pop    %rbp
ffff800000105b10:	c3                   	ret    

ffff800000105b11 <set_intr_gate>:
ffff800000105b11:	f3 0f 1e fa          	endbr64 
ffff800000105b15:	55                   	push   %rbp
ffff800000105b16:	48 89 e5             	mov    %rsp,%rbp
ffff800000105b19:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000105b19 <set_intr_gate+0x8>
ffff800000105b20:	49 bb b7 d5 00 00 00 	movabs $0xd5b7,%r11
ffff800000105b27:	00 00 00 
ffff800000105b2a:	4c 01 d8             	add    %r11,%rax
ffff800000105b2d:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000105b30:	89 f1                	mov    %esi,%ecx
ffff800000105b32:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000105b36:	89 ca                	mov    %ecx,%edx
ffff800000105b38:	88 55 e8             	mov    %dl,-0x18(%rbp)
ffff800000105b3b:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105b3e:	48 89 d1             	mov    %rdx,%rcx
ffff800000105b41:	48 c1 e1 04          	shl    $0x4,%rcx
ffff800000105b45:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105b4c:	ff ff ff 
ffff800000105b4f:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105b53:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
ffff800000105b57:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105b5a:	48 c1 e2 04          	shl    $0x4,%rdx
ffff800000105b5e:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000105b62:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105b69:	ff ff ff 
ffff800000105b6c:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000105b70:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
ffff800000105b74:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105b78:	41 b8 00 00 08 00    	mov    $0x80000,%r8d
ffff800000105b7e:	0f b6 4d e8          	movzbl -0x18(%rbp),%ecx
ffff800000105b82:	48 89 c2             	mov    %rax,%rdx
ffff800000105b85:	44 89 c0             	mov    %r8d,%eax
ffff800000105b88:	66 89 d0             	mov    %dx,%ax
ffff800000105b8b:	48 83 e1 07          	and    $0x7,%rcx
ffff800000105b8f:	48 81 c1 00 8e 00 00 	add    $0x8e00,%rcx
ffff800000105b96:	48 c1 e1 20          	shl    $0x20,%rcx
ffff800000105b9a:	48 01 c8             	add    %rcx,%rax
ffff800000105b9d:	48 31 c9             	xor    %rcx,%rcx
ffff800000105ba0:	89 d1                	mov    %edx,%ecx
ffff800000105ba2:	48 c1 e9 10          	shr    $0x10,%rcx
ffff800000105ba6:	48 c1 e1 30          	shl    $0x30,%rcx
ffff800000105baa:	48 01 c8             	add    %rcx,%rax
ffff800000105bad:	48 89 06             	mov    %rax,(%rsi)
ffff800000105bb0:	48 c1 ea 20          	shr    $0x20,%rdx
ffff800000105bb4:	48 89 17             	mov    %rdx,(%rdi)
ffff800000105bb7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105bbb:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
ffff800000105bbf:	90                   	nop
ffff800000105bc0:	5d                   	pop    %rbp
ffff800000105bc1:	c3                   	ret    

ffff800000105bc2 <set_trap_gate>:
ffff800000105bc2:	f3 0f 1e fa          	endbr64 
ffff800000105bc6:	55                   	push   %rbp
ffff800000105bc7:	48 89 e5             	mov    %rsp,%rbp
ffff800000105bca:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000105bca <set_trap_gate+0x8>
ffff800000105bd1:	49 bb 06 d5 00 00 00 	movabs $0xd506,%r11
ffff800000105bd8:	00 00 00 
ffff800000105bdb:	4c 01 d8             	add    %r11,%rax
ffff800000105bde:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000105be1:	89 f1                	mov    %esi,%ecx
ffff800000105be3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000105be7:	89 ca                	mov    %ecx,%edx
ffff800000105be9:	88 55 e8             	mov    %dl,-0x18(%rbp)
ffff800000105bec:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105bef:	48 89 d1             	mov    %rdx,%rcx
ffff800000105bf2:	48 c1 e1 04          	shl    $0x4,%rcx
ffff800000105bf6:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105bfd:	ff ff ff 
ffff800000105c00:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105c04:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
ffff800000105c08:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105c0b:	48 c1 e2 04          	shl    $0x4,%rdx
ffff800000105c0f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000105c13:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105c1a:	ff ff ff 
ffff800000105c1d:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000105c21:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
ffff800000105c25:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c29:	41 b8 00 00 08 00    	mov    $0x80000,%r8d
ffff800000105c2f:	0f b6 4d e8          	movzbl -0x18(%rbp),%ecx
ffff800000105c33:	48 89 c2             	mov    %rax,%rdx
ffff800000105c36:	44 89 c0             	mov    %r8d,%eax
ffff800000105c39:	66 89 d0             	mov    %dx,%ax
ffff800000105c3c:	48 83 e1 07          	and    $0x7,%rcx
ffff800000105c40:	48 81 c1 00 8f 00 00 	add    $0x8f00,%rcx
ffff800000105c47:	48 c1 e1 20          	shl    $0x20,%rcx
ffff800000105c4b:	48 01 c8             	add    %rcx,%rax
ffff800000105c4e:	48 31 c9             	xor    %rcx,%rcx
ffff800000105c51:	89 d1                	mov    %edx,%ecx
ffff800000105c53:	48 c1 e9 10          	shr    $0x10,%rcx
ffff800000105c57:	48 c1 e1 30          	shl    $0x30,%rcx
ffff800000105c5b:	48 01 c8             	add    %rcx,%rax
ffff800000105c5e:	48 89 06             	mov    %rax,(%rsi)
ffff800000105c61:	48 c1 ea 20          	shr    $0x20,%rdx
ffff800000105c65:	48 89 17             	mov    %rdx,(%rdi)
ffff800000105c68:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105c6c:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
ffff800000105c70:	90                   	nop
ffff800000105c71:	5d                   	pop    %rbp
ffff800000105c72:	c3                   	ret    

ffff800000105c73 <set_system_gate>:
ffff800000105c73:	f3 0f 1e fa          	endbr64 
ffff800000105c77:	55                   	push   %rbp
ffff800000105c78:	48 89 e5             	mov    %rsp,%rbp
ffff800000105c7b:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000105c7b <set_system_gate+0x8>
ffff800000105c82:	49 bb 55 d4 00 00 00 	movabs $0xd455,%r11
ffff800000105c89:	00 00 00 
ffff800000105c8c:	4c 01 d8             	add    %r11,%rax
ffff800000105c8f:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000105c92:	89 f1                	mov    %esi,%ecx
ffff800000105c94:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000105c98:	89 ca                	mov    %ecx,%edx
ffff800000105c9a:	88 55 e8             	mov    %dl,-0x18(%rbp)
ffff800000105c9d:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105ca0:	48 89 d1             	mov    %rdx,%rcx
ffff800000105ca3:	48 c1 e1 04          	shl    $0x4,%rcx
ffff800000105ca7:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105cae:	ff ff ff 
ffff800000105cb1:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105cb5:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
ffff800000105cb9:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000105cbc:	48 c1 e2 04          	shl    $0x4,%rdx
ffff800000105cc0:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000105cc4:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000105ccb:	ff ff ff 
ffff800000105cce:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000105cd2:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
ffff800000105cd6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105cda:	41 b8 00 00 08 00    	mov    $0x80000,%r8d
ffff800000105ce0:	0f b6 4d e8          	movzbl -0x18(%rbp),%ecx
ffff800000105ce4:	48 89 c2             	mov    %rax,%rdx
ffff800000105ce7:	44 89 c0             	mov    %r8d,%eax
ffff800000105cea:	66 89 d0             	mov    %dx,%ax
ffff800000105ced:	48 83 e1 07          	and    $0x7,%rcx
ffff800000105cf1:	48 81 c1 00 ef 00 00 	add    $0xef00,%rcx
ffff800000105cf8:	48 c1 e1 20          	shl    $0x20,%rcx
ffff800000105cfc:	48 01 c8             	add    %rcx,%rax
ffff800000105cff:	48 31 c9             	xor    %rcx,%rcx
ffff800000105d02:	89 d1                	mov    %edx,%ecx
ffff800000105d04:	48 c1 e9 10          	shr    $0x10,%rcx
ffff800000105d08:	48 c1 e1 30          	shl    $0x30,%rcx
ffff800000105d0c:	48 01 c8             	add    %rcx,%rax
ffff800000105d0f:	48 89 06             	mov    %rax,(%rsi)
ffff800000105d12:	48 c1 ea 20          	shr    $0x20,%rdx
ffff800000105d16:	48 89 17             	mov    %rdx,(%rdi)
ffff800000105d19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105d1d:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
ffff800000105d21:	90                   	nop
ffff800000105d22:	5d                   	pop    %rbp
ffff800000105d23:	c3                   	ret    
ffff800000105d24:	f3 0f 1e fa          	endbr64 
ffff800000105d28:	55                   	push   %rbp
ffff800000105d29:	48 89 e5             	mov    %rsp,%rbp
ffff800000105d2c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000105d2c <set_system_gate+0xb9>
ffff800000105d33:	49 bb a4 d3 00 00 00 	movabs $0xd3a4,%r11
ffff800000105d3a:	00 00 00 
ffff800000105d3d:	4c 01 d8             	add    %r11,%rax
ffff800000105d40:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105d44:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000105d48:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000105d4c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
ffff800000105d50:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
ffff800000105d54:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
ffff800000105d58:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105d5f:	ff ff ff 
ffff800000105d62:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105d66:	48 8d 52 04          	lea    0x4(%rdx),%rdx
ffff800000105d6a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000105d6e:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105d71:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105d78:	ff ff ff 
ffff800000105d7b:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105d7f:	48 8d 52 0c          	lea    0xc(%rdx),%rdx
ffff800000105d83:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000105d87:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105d8a:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105d91:	ff ff ff 
ffff800000105d94:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105d98:	48 8d 52 14          	lea    0x14(%rdx),%rdx
ffff800000105d9c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000105da0:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105da3:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105daa:	ff ff ff 
ffff800000105dad:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105db1:	48 8d 52 24          	lea    0x24(%rdx),%rdx
ffff800000105db5:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000105db9:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105dbc:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105dc3:	ff ff ff 
ffff800000105dc6:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105dca:	48 8d 52 2c          	lea    0x2c(%rdx),%rdx
ffff800000105dce:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000105dd2:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105dd5:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105ddc:	ff ff ff 
ffff800000105ddf:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105de3:	48 8d 52 34          	lea    0x34(%rdx),%rdx
ffff800000105de7:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000105deb:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105dee:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105df5:	ff ff ff 
ffff800000105df8:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105dfc:	48 8d 52 3c          	lea    0x3c(%rdx),%rdx
ffff800000105e00:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
ffff800000105e04:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105e07:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105e0e:	ff ff ff 
ffff800000105e11:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105e15:	48 8d 52 44          	lea    0x44(%rdx),%rdx
ffff800000105e19:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
ffff800000105e1d:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105e20:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105e27:	ff ff ff 
ffff800000105e2a:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000105e2e:	48 8d 52 4c          	lea    0x4c(%rdx),%rdx
ffff800000105e32:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
ffff800000105e36:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000105e39:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000105e40:	ff ff ff 
ffff800000105e43:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000105e47:	48 8d 40 54          	lea    0x54(%rax),%rax
ffff800000105e4b:	48 8b 55 28          	mov    0x28(%rbp),%rdx
ffff800000105e4f:	48 89 10             	mov    %rdx,(%rax)
ffff800000105e52:	90                   	nop
ffff800000105e53:	5d                   	pop    %rbp
ffff800000105e54:	c3                   	ret    

ffff800000105e55 <sys_vector_init>:
ffff800000105e55:	f3 0f 1e fa          	endbr64 
ffff800000105e59:	55                   	push   %rbp
ffff800000105e5a:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e5d:	53                   	push   %rbx
ffff800000105e5e:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000105e5e <sys_vector_init+0x9>
ffff800000105e65:	49 bb 72 d2 00 00 00 	movabs $0xd272,%r11
ffff800000105e6c:	00 00 00 
ffff800000105e6f:	4c 01 db             	add    %r11,%rbx
ffff800000105e72:	48 b8 f8 fe ff ff ff 	movabs $0xfffffffffffffef8,%rax
ffff800000105e79:	ff ff ff 
ffff800000105e7c:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105e80:	48 89 c2             	mov    %rax,%rdx
ffff800000105e83:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105e88:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000105e8d:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000105e94:	ff ff ff 
ffff800000105e97:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105e9b:	ff d0                	call   *%rax
ffff800000105e9d:	48 b8 18 ff ff ff ff 	movabs $0xffffffffffffff18,%rax
ffff800000105ea4:	ff ff ff 
ffff800000105ea7:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105eab:	48 89 c2             	mov    %rax,%rdx
ffff800000105eae:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105eb3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000105eb8:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000105ebf:	ff ff ff 
ffff800000105ec2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105ec6:	ff d0                	call   *%rax
ffff800000105ec8:	48 b8 e0 ff ff ff ff 	movabs $0xffffffffffffffe0,%rax
ffff800000105ecf:	ff ff ff 
ffff800000105ed2:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105ed6:	48 89 c2             	mov    %rax,%rdx
ffff800000105ed9:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105ede:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000105ee3:	48 b8 41 2a ff ff ff 	movabs $0xffffffffffff2a41,%rax
ffff800000105eea:	ff ff ff 
ffff800000105eed:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105ef1:	ff d0                	call   *%rax
ffff800000105ef3:	48 b8 f0 ff ff ff ff 	movabs $0xfffffffffffffff0,%rax
ffff800000105efa:	ff ff ff 
ffff800000105efd:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105f01:	48 89 c2             	mov    %rax,%rdx
ffff800000105f04:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105f09:	bf 03 00 00 00       	mov    $0x3,%edi
ffff800000105f0e:	48 b8 a3 2b ff ff ff 	movabs $0xffffffffffff2ba3,%rax
ffff800000105f15:	ff ff ff 
ffff800000105f18:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105f1c:	ff d0                	call   *%rax
ffff800000105f1e:	48 b8 10 ff ff ff ff 	movabs $0xffffffffffffff10,%rax
ffff800000105f25:	ff ff ff 
ffff800000105f28:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105f2c:	48 89 c2             	mov    %rax,%rdx
ffff800000105f2f:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105f34:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000105f39:	48 b8 a3 2b ff ff ff 	movabs $0xffffffffffff2ba3,%rax
ffff800000105f40:	ff ff ff 
ffff800000105f43:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105f47:	ff d0                	call   *%rax
ffff800000105f49:	48 b8 20 ff ff ff ff 	movabs $0xffffffffffffff20,%rax
ffff800000105f50:	ff ff ff 
ffff800000105f53:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105f57:	48 89 c2             	mov    %rax,%rdx
ffff800000105f5a:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105f5f:	bf 05 00 00 00       	mov    $0x5,%edi
ffff800000105f64:	48 b8 a3 2b ff ff ff 	movabs $0xffffffffffff2ba3,%rax
ffff800000105f6b:	ff ff ff 
ffff800000105f6e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105f72:	ff d0                	call   *%rax
ffff800000105f74:	48 b8 50 ff ff ff ff 	movabs $0xffffffffffffff50,%rax
ffff800000105f7b:	ff ff ff 
ffff800000105f7e:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105f82:	48 89 c2             	mov    %rax,%rdx
ffff800000105f85:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105f8a:	bf 06 00 00 00       	mov    $0x6,%edi
ffff800000105f8f:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000105f96:	ff ff ff 
ffff800000105f99:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105f9d:	ff d0                	call   *%rax
ffff800000105f9f:	48 b8 e8 ff ff ff ff 	movabs $0xffffffffffffffe8,%rax
ffff800000105fa6:	ff ff ff 
ffff800000105fa9:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105fad:	48 89 c2             	mov    %rax,%rdx
ffff800000105fb0:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105fb5:	bf 07 00 00 00       	mov    $0x7,%edi
ffff800000105fba:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000105fc1:	ff ff ff 
ffff800000105fc4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105fc8:	ff d0                	call   *%rax
ffff800000105fca:	48 b8 78 ff ff ff ff 	movabs $0xffffffffffffff78,%rax
ffff800000105fd1:	ff ff ff 
ffff800000105fd4:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000105fd8:	48 89 c2             	mov    %rax,%rdx
ffff800000105fdb:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105fe0:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000105fe5:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000105fec:	ff ff ff 
ffff800000105fef:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000105ff3:	ff d0                	call   *%rax
ffff800000105ff5:	48 b8 a0 ff ff ff ff 	movabs $0xffffffffffffffa0,%rax
ffff800000105ffc:	ff ff ff 
ffff800000105fff:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106003:	48 89 c2             	mov    %rax,%rdx
ffff800000106006:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010600b:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000106010:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000106017:	ff ff ff 
ffff80000010601a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010601e:	ff d0                	call   *%rax
ffff800000106020:	48 b8 28 ff ff ff ff 	movabs $0xffffffffffffff28,%rax
ffff800000106027:	ff ff ff 
ffff80000010602a:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010602e:	48 89 c2             	mov    %rax,%rdx
ffff800000106031:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000106036:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010603b:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000106042:	ff ff ff 
ffff800000106045:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106049:	ff d0                	call   *%rax
ffff80000010604b:	48 b8 30 ff ff ff ff 	movabs $0xffffffffffffff30,%rax
ffff800000106052:	ff ff ff 
ffff800000106055:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106059:	48 89 c2             	mov    %rax,%rdx
ffff80000010605c:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000106061:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000106066:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff80000010606d:	ff ff ff 
ffff800000106070:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106074:	ff d0                	call   *%rax
ffff800000106076:	48 b8 38 ff ff ff ff 	movabs $0xffffffffffffff38,%rax
ffff80000010607d:	ff ff ff 
ffff800000106080:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106084:	48 89 c2             	mov    %rax,%rdx
ffff800000106087:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010608c:	bf 0c 00 00 00       	mov    $0xc,%edi
ffff800000106091:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000106098:	ff ff ff 
ffff80000010609b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010609f:	ff d0                	call   *%rax
ffff8000001060a1:	48 b8 08 ff ff ff ff 	movabs $0xffffffffffffff08,%rax
ffff8000001060a8:	ff ff ff 
ffff8000001060ab:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001060af:	48 89 c2             	mov    %rax,%rdx
ffff8000001060b2:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001060b7:	bf 0d 00 00 00       	mov    $0xd,%edi
ffff8000001060bc:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff8000001060c3:	ff ff ff 
ffff8000001060c6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001060ca:	ff d0                	call   *%rax
ffff8000001060cc:	48 b8 b0 ff ff ff ff 	movabs $0xffffffffffffffb0,%rax
ffff8000001060d3:	ff ff ff 
ffff8000001060d6:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001060da:	48 89 c2             	mov    %rax,%rdx
ffff8000001060dd:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001060e2:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff8000001060e7:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff8000001060ee:	ff ff ff 
ffff8000001060f1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001060f5:	ff d0                	call   *%rax
ffff8000001060f7:	48 b8 70 ff ff ff ff 	movabs $0xffffffffffffff70,%rax
ffff8000001060fe:	ff ff ff 
ffff800000106101:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106105:	48 89 c2             	mov    %rax,%rdx
ffff800000106108:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010610d:	bf 10 00 00 00       	mov    $0x10,%edi
ffff800000106112:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000106119:	ff ff ff 
ffff80000010611c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106120:	ff d0                	call   *%rax
ffff800000106122:	48 b8 68 ff ff ff ff 	movabs $0xffffffffffffff68,%rax
ffff800000106129:	ff ff ff 
ffff80000010612c:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106130:	48 89 c2             	mov    %rax,%rdx
ffff800000106133:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000106138:	bf 11 00 00 00       	mov    $0x11,%edi
ffff80000010613d:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff800000106144:	ff ff ff 
ffff800000106147:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010614b:	ff d0                	call   *%rax
ffff80000010614d:	48 b8 c0 ff ff ff ff 	movabs $0xffffffffffffffc0,%rax
ffff800000106154:	ff ff ff 
ffff800000106157:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010615b:	48 89 c2             	mov    %rax,%rdx
ffff80000010615e:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000106163:	bf 12 00 00 00       	mov    $0x12,%edi
ffff800000106168:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff80000010616f:	ff ff ff 
ffff800000106172:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106176:	ff d0                	call   *%rax
ffff800000106178:	48 b8 d0 ff ff ff ff 	movabs $0xffffffffffffffd0,%rax
ffff80000010617f:	ff ff ff 
ffff800000106182:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000106186:	48 89 c2             	mov    %rax,%rdx
ffff800000106189:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010618e:	bf 13 00 00 00       	mov    $0x13,%edi
ffff800000106193:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff80000010619a:	ff ff ff 
ffff80000010619d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001061a1:	ff d0                	call   *%rax
ffff8000001061a3:	48 b8 88 ff ff ff ff 	movabs $0xffffffffffffff88,%rax
ffff8000001061aa:	ff ff ff 
ffff8000001061ad:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001061b1:	48 89 c2             	mov    %rax,%rdx
ffff8000001061b4:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001061b9:	bf 14 00 00 00       	mov    $0x14,%edi
ffff8000001061be:	48 b8 f2 2a ff ff ff 	movabs $0xffffffffffff2af2,%rax
ffff8000001061c5:	ff ff ff 
ffff8000001061c8:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001061cc:	ff d0                	call   *%rax
ffff8000001061ce:	90                   	nop
ffff8000001061cf:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff8000001061d3:	c9                   	leave  
ffff8000001061d4:	c3                   	ret    

ffff8000001061d5 <do_divide_error>:
ffff8000001061d5:	f3 0f 1e fa          	endbr64 
ffff8000001061d9:	55                   	push   %rbp
ffff8000001061da:	48 89 e5             	mov    %rsp,%rbp
ffff8000001061dd:	41 57                	push   %r15
ffff8000001061df:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001061e3:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001061e3 <do_divide_error+0xe>
ffff8000001061ea:	49 bb ed ce 00 00 00 	movabs $0xceed,%r11
ffff8000001061f1:	00 00 00 
ffff8000001061f4:	4d 01 da             	add    %r11,%r10
ffff8000001061f7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001061fb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001061ff:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106206:	00 
ffff800000106207:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010620b:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106211:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106215:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106219:	48 8b 08             	mov    (%rax),%rcx
ffff80000010621c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106220:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106224:	49 89 c9             	mov    %rcx,%r9
ffff800000106227:	49 89 d0             	mov    %rdx,%r8
ffff80000010622a:	48 89 c1             	mov    %rax,%rcx
ffff80000010622d:	48 b8 38 14 00 00 00 	movabs $0x1438,%rax
ffff800000106234:	00 00 00 
ffff800000106237:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff80000010623b:	48 89 c2             	mov    %rax,%rdx
ffff80000010623e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106243:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106248:	4d 89 d7             	mov    %r10,%r15
ffff80000010624b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106250:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000106257:	ff ff ff 
ffff80000010625a:	4d 01 d3             	add    %r10,%r11
ffff80000010625d:	41 ff d3             	call   *%r11
ffff800000106260:	eb fe                	jmp    ffff800000106260 <do_divide_error+0x8b>

ffff800000106262 <do_debug>:
ffff800000106262:	f3 0f 1e fa          	endbr64 
ffff800000106266:	55                   	push   %rbp
ffff800000106267:	48 89 e5             	mov    %rsp,%rbp
ffff80000010626a:	41 57                	push   %r15
ffff80000010626c:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000106270:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff800000106270 <do_debug+0xe>
ffff800000106277:	49 bb 60 ce 00 00 00 	movabs $0xce60,%r11
ffff80000010627e:	00 00 00 
ffff800000106281:	4d 01 da             	add    %r11,%r10
ffff800000106284:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106288:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010628c:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106293:	00 
ffff800000106294:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106298:	48 05 98 00 00 00    	add    $0x98,%rax
ffff80000010629e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001062a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062a6:	48 8b 08             	mov    (%rax),%rcx
ffff8000001062a9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001062ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001062b1:	49 89 c9             	mov    %rcx,%r9
ffff8000001062b4:	49 89 d0             	mov    %rdx,%r8
ffff8000001062b7:	48 89 c1             	mov    %rax,%rcx
ffff8000001062ba:	48 b8 78 14 00 00 00 	movabs $0x1478,%rax
ffff8000001062c1:	00 00 00 
ffff8000001062c4:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001062c8:	48 89 c2             	mov    %rax,%rdx
ffff8000001062cb:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001062d0:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001062d5:	4d 89 d7             	mov    %r10,%r15
ffff8000001062d8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001062dd:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001062e4:	ff ff ff 
ffff8000001062e7:	4d 01 d3             	add    %r10,%r11
ffff8000001062ea:	41 ff d3             	call   *%r11
ffff8000001062ed:	eb fe                	jmp    ffff8000001062ed <do_debug+0x8b>

ffff8000001062ef <do_nmi>:
ffff8000001062ef:	f3 0f 1e fa          	endbr64 
ffff8000001062f3:	55                   	push   %rbp
ffff8000001062f4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001062f7:	41 57                	push   %r15
ffff8000001062f9:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001062fd:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001062fd <do_nmi+0xe>
ffff800000106304:	49 bb d3 cd 00 00 00 	movabs $0xcdd3,%r11
ffff80000010630b:	00 00 00 
ffff80000010630e:	4d 01 da             	add    %r11,%r10
ffff800000106311:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106315:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106319:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106320:	00 
ffff800000106321:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106325:	48 05 98 00 00 00    	add    $0x98,%rax
ffff80000010632b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010632f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106333:	48 8b 08             	mov    (%rax),%rcx
ffff800000106336:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010633a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010633e:	49 89 c9             	mov    %rcx,%r9
ffff800000106341:	49 89 d0             	mov    %rdx,%r8
ffff800000106344:	48 89 c1             	mov    %rax,%rcx
ffff800000106347:	48 b8 b0 14 00 00 00 	movabs $0x14b0,%rax
ffff80000010634e:	00 00 00 
ffff800000106351:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000106355:	48 89 c2             	mov    %rax,%rdx
ffff800000106358:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010635d:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106362:	4d 89 d7             	mov    %r10,%r15
ffff800000106365:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010636a:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000106371:	ff ff ff 
ffff800000106374:	4d 01 d3             	add    %r10,%r11
ffff800000106377:	41 ff d3             	call   *%r11
ffff80000010637a:	eb fe                	jmp    ffff80000010637a <do_nmi+0x8b>

ffff80000010637c <do_int3>:
ffff80000010637c:	f3 0f 1e fa          	endbr64 
ffff800000106380:	55                   	push   %rbp
ffff800000106381:	48 89 e5             	mov    %rsp,%rbp
ffff800000106384:	41 57                	push   %r15
ffff800000106386:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010638a:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff80000010638a <do_int3+0xe>
ffff800000106391:	49 bb 46 cd 00 00 00 	movabs $0xcd46,%r11
ffff800000106398:	00 00 00 
ffff80000010639b:	4d 01 da             	add    %r11,%r10
ffff80000010639e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001063a2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001063a6:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001063ad:	00 
ffff8000001063ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001063b2:	48 05 98 00 00 00    	add    $0x98,%rax
ffff8000001063b8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001063bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001063c0:	48 8b 08             	mov    (%rax),%rcx
ffff8000001063c3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001063c7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001063cb:	49 89 c9             	mov    %rcx,%r9
ffff8000001063ce:	49 89 d0             	mov    %rdx,%r8
ffff8000001063d1:	48 89 c1             	mov    %rax,%rcx
ffff8000001063d4:	48 b8 e8 14 00 00 00 	movabs $0x14e8,%rax
ffff8000001063db:	00 00 00 
ffff8000001063de:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001063e2:	48 89 c2             	mov    %rax,%rdx
ffff8000001063e5:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001063ea:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001063ef:	4d 89 d7             	mov    %r10,%r15
ffff8000001063f2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001063f7:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001063fe:	ff ff ff 
ffff800000106401:	4d 01 d3             	add    %r10,%r11
ffff800000106404:	41 ff d3             	call   *%r11
ffff800000106407:	eb fe                	jmp    ffff800000106407 <do_int3+0x8b>

ffff800000106409 <do_overflow>:
ffff800000106409:	f3 0f 1e fa          	endbr64 
ffff80000010640d:	55                   	push   %rbp
ffff80000010640e:	48 89 e5             	mov    %rsp,%rbp
ffff800000106411:	41 57                	push   %r15
ffff800000106413:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000106417:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff800000106417 <do_overflow+0xe>
ffff80000010641e:	49 bb b9 cc 00 00 00 	movabs $0xccb9,%r11
ffff800000106425:	00 00 00 
ffff800000106428:	4d 01 da             	add    %r11,%r10
ffff80000010642b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010642f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106433:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff80000010643a:	00 
ffff80000010643b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010643f:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106445:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106449:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010644d:	48 8b 08             	mov    (%rax),%rcx
ffff800000106450:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106454:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106458:	49 89 c9             	mov    %rcx,%r9
ffff80000010645b:	49 89 d0             	mov    %rdx,%r8
ffff80000010645e:	48 89 c1             	mov    %rax,%rcx
ffff800000106461:	48 b8 20 15 00 00 00 	movabs $0x1520,%rax
ffff800000106468:	00 00 00 
ffff80000010646b:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff80000010646f:	48 89 c2             	mov    %rax,%rdx
ffff800000106472:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106477:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010647c:	4d 89 d7             	mov    %r10,%r15
ffff80000010647f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106484:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff80000010648b:	ff ff ff 
ffff80000010648e:	4d 01 d3             	add    %r10,%r11
ffff800000106491:	41 ff d3             	call   *%r11
ffff800000106494:	eb fe                	jmp    ffff800000106494 <do_overflow+0x8b>

ffff800000106496 <do_bounds>:
ffff800000106496:	f3 0f 1e fa          	endbr64 
ffff80000010649a:	55                   	push   %rbp
ffff80000010649b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010649e:	41 57                	push   %r15
ffff8000001064a0:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001064a4:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001064a4 <do_bounds+0xe>
ffff8000001064ab:	49 bb 2c cc 00 00 00 	movabs $0xcc2c,%r11
ffff8000001064b2:	00 00 00 
ffff8000001064b5:	4d 01 da             	add    %r11,%r10
ffff8000001064b8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001064bc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001064c0:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001064c7:	00 
ffff8000001064c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001064cc:	48 05 98 00 00 00    	add    $0x98,%rax
ffff8000001064d2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001064d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001064da:	48 8b 08             	mov    (%rax),%rcx
ffff8000001064dd:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001064e1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001064e5:	49 89 c9             	mov    %rcx,%r9
ffff8000001064e8:	49 89 d0             	mov    %rdx,%r8
ffff8000001064eb:	48 89 c1             	mov    %rax,%rcx
ffff8000001064ee:	48 b8 60 15 00 00 00 	movabs $0x1560,%rax
ffff8000001064f5:	00 00 00 
ffff8000001064f8:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001064fc:	48 89 c2             	mov    %rax,%rdx
ffff8000001064ff:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106504:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106509:	4d 89 d7             	mov    %r10,%r15
ffff80000010650c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106511:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000106518:	ff ff ff 
ffff80000010651b:	4d 01 d3             	add    %r10,%r11
ffff80000010651e:	41 ff d3             	call   *%r11
ffff800000106521:	eb fe                	jmp    ffff800000106521 <do_bounds+0x8b>

ffff800000106523 <do_undefined_opcode>:
ffff800000106523:	f3 0f 1e fa          	endbr64 
ffff800000106527:	55                   	push   %rbp
ffff800000106528:	48 89 e5             	mov    %rsp,%rbp
ffff80000010652b:	41 57                	push   %r15
ffff80000010652d:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000106531:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff800000106531 <do_undefined_opcode+0xe>
ffff800000106538:	49 bb 9f cb 00 00 00 	movabs $0xcb9f,%r11
ffff80000010653f:	00 00 00 
ffff800000106542:	4d 01 da             	add    %r11,%r10
ffff800000106545:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106549:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010654d:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106554:	00 
ffff800000106555:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106559:	48 05 98 00 00 00    	add    $0x98,%rax
ffff80000010655f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106563:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106567:	48 8b 08             	mov    (%rax),%rcx
ffff80000010656a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010656e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106572:	49 89 c9             	mov    %rcx,%r9
ffff800000106575:	49 89 d0             	mov    %rdx,%r8
ffff800000106578:	48 89 c1             	mov    %rax,%rcx
ffff80000010657b:	48 b8 a0 15 00 00 00 	movabs $0x15a0,%rax
ffff800000106582:	00 00 00 
ffff800000106585:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000106589:	48 89 c2             	mov    %rax,%rdx
ffff80000010658c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106591:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106596:	4d 89 d7             	mov    %r10,%r15
ffff800000106599:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010659e:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001065a5:	ff ff ff 
ffff8000001065a8:	4d 01 d3             	add    %r10,%r11
ffff8000001065ab:	41 ff d3             	call   *%r11
ffff8000001065ae:	eb fe                	jmp    ffff8000001065ae <do_undefined_opcode+0x8b>

ffff8000001065b0 <do_dev_not_available>:
ffff8000001065b0:	f3 0f 1e fa          	endbr64 
ffff8000001065b4:	55                   	push   %rbp
ffff8000001065b5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001065b8:	41 57                	push   %r15
ffff8000001065ba:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001065be:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001065be <do_dev_not_available+0xe>
ffff8000001065c5:	49 bb 12 cb 00 00 00 	movabs $0xcb12,%r11
ffff8000001065cc:	00 00 00 
ffff8000001065cf:	4d 01 da             	add    %r11,%r10
ffff8000001065d2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001065d6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001065da:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001065e1:	00 
ffff8000001065e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001065e6:	48 05 98 00 00 00    	add    $0x98,%rax
ffff8000001065ec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001065f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001065f4:	48 8b 08             	mov    (%rax),%rcx
ffff8000001065f7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001065fb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001065ff:	49 89 c9             	mov    %rcx,%r9
ffff800000106602:	49 89 d0             	mov    %rdx,%r8
ffff800000106605:	48 89 c1             	mov    %rax,%rcx
ffff800000106608:	48 b8 e8 15 00 00 00 	movabs $0x15e8,%rax
ffff80000010660f:	00 00 00 
ffff800000106612:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000106616:	48 89 c2             	mov    %rax,%rdx
ffff800000106619:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010661e:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106623:	4d 89 d7             	mov    %r10,%r15
ffff800000106626:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010662b:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000106632:	ff ff ff 
ffff800000106635:	4d 01 d3             	add    %r10,%r11
ffff800000106638:	41 ff d3             	call   *%r11
ffff80000010663b:	eb fe                	jmp    ffff80000010663b <do_dev_not_available+0x8b>

ffff80000010663d <do_double_fault>:
ffff80000010663d:	f3 0f 1e fa          	endbr64 
ffff800000106641:	55                   	push   %rbp
ffff800000106642:	48 89 e5             	mov    %rsp,%rbp
ffff800000106645:	41 57                	push   %r15
ffff800000106647:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010664b:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff80000010664b <do_double_fault+0xe>
ffff800000106652:	49 bb 85 ca 00 00 00 	movabs $0xca85,%r11
ffff800000106659:	00 00 00 
ffff80000010665c:	4d 01 da             	add    %r11,%r10
ffff80000010665f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106663:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106667:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff80000010666e:	00 
ffff80000010666f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106673:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106679:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010667d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106681:	48 8b 08             	mov    (%rax),%rcx
ffff800000106684:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106688:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010668c:	49 89 c9             	mov    %rcx,%r9
ffff80000010668f:	49 89 d0             	mov    %rdx,%r8
ffff800000106692:	48 89 c1             	mov    %rax,%rcx
ffff800000106695:	48 b8 30 16 00 00 00 	movabs $0x1630,%rax
ffff80000010669c:	00 00 00 
ffff80000010669f:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001066a3:	48 89 c2             	mov    %rax,%rdx
ffff8000001066a6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001066ab:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001066b0:	4d 89 d7             	mov    %r10,%r15
ffff8000001066b3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001066b8:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001066bf:	ff ff ff 
ffff8000001066c2:	4d 01 d3             	add    %r10,%r11
ffff8000001066c5:	41 ff d3             	call   *%r11
ffff8000001066c8:	eb fe                	jmp    ffff8000001066c8 <do_double_fault+0x8b>

ffff8000001066ca <do_coprocessor_segment_overrun>:
ffff8000001066ca:	f3 0f 1e fa          	endbr64 
ffff8000001066ce:	55                   	push   %rbp
ffff8000001066cf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001066d2:	41 57                	push   %r15
ffff8000001066d4:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001066d8:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001066d8 <do_coprocessor_segment_overrun+0xe>
ffff8000001066df:	49 bb f8 c9 00 00 00 	movabs $0xc9f8,%r11
ffff8000001066e6:	00 00 00 
ffff8000001066e9:	4d 01 da             	add    %r11,%r10
ffff8000001066ec:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001066f0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001066f4:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001066fb:	00 
ffff8000001066fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106700:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106706:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010670a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010670e:	48 8b 08             	mov    (%rax),%rcx
ffff800000106711:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106715:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106719:	49 89 c9             	mov    %rcx,%r9
ffff80000010671c:	49 89 d0             	mov    %rdx,%r8
ffff80000010671f:	48 89 c1             	mov    %rax,%rcx
ffff800000106722:	48 b8 70 16 00 00 00 	movabs $0x1670,%rax
ffff800000106729:	00 00 00 
ffff80000010672c:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000106730:	48 89 c2             	mov    %rax,%rdx
ffff800000106733:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106738:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010673d:	4d 89 d7             	mov    %r10,%r15
ffff800000106740:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106745:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff80000010674c:	ff ff ff 
ffff80000010674f:	4d 01 d3             	add    %r10,%r11
ffff800000106752:	41 ff d3             	call   *%r11
ffff800000106755:	eb fe                	jmp    ffff800000106755 <do_coprocessor_segment_overrun+0x8b>

ffff800000106757 <do_invalid_TSS>:
ffff800000106757:	f3 0f 1e fa          	endbr64 
ffff80000010675b:	55                   	push   %rbp
ffff80000010675c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010675f:	41 57                	push   %r15
ffff800000106761:	53                   	push   %rbx
ffff800000106762:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106766:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000106766 <do_invalid_TSS+0xf>
ffff80000010676d:	49 bb 6a c9 00 00 00 	movabs $0xc96a,%r11
ffff800000106774:	00 00 00 
ffff800000106777:	4c 01 db             	add    %r11,%rbx
ffff80000010677a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010677e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106782:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106789:	00 
ffff80000010678a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010678e:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106794:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106798:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010679c:	48 8b 08             	mov    (%rax),%rcx
ffff80000010679f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001067a3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001067a7:	49 89 c9             	mov    %rcx,%r9
ffff8000001067aa:	49 89 d0             	mov    %rdx,%r8
ffff8000001067ad:	48 89 c1             	mov    %rax,%rcx
ffff8000001067b0:	48 b8 c0 16 00 00 00 	movabs $0x16c0,%rax
ffff8000001067b7:	00 00 00 
ffff8000001067ba:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001067be:	48 89 c2             	mov    %rax,%rdx
ffff8000001067c1:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001067c6:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001067cb:	49 89 df             	mov    %rbx,%r15
ffff8000001067ce:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001067d3:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff8000001067da:	ff ff ff 
ffff8000001067dd:	49 01 da             	add    %rbx,%r10
ffff8000001067e0:	41 ff d2             	call   *%r10
ffff8000001067e3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001067e7:	83 e0 01             	and    $0x1,%eax
ffff8000001067ea:	48 85 c0             	test   %rax,%rax
ffff8000001067ed:	74 32                	je     ffff800000106821 <do_invalid_TSS+0xca>
ffff8000001067ef:	48 b8 00 17 00 00 00 	movabs $0x1700,%rax
ffff8000001067f6:	00 00 00 
ffff8000001067f9:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001067fd:	48 89 c2             	mov    %rax,%rdx
ffff800000106800:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106805:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010680a:	49 89 df             	mov    %rbx,%r15
ffff80000010680d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106812:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106819:	ff ff ff 
ffff80000010681c:	48 01 d9             	add    %rbx,%rcx
ffff80000010681f:	ff d1                	call   *%rcx
ffff800000106821:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106825:	83 e0 02             	and    $0x2,%eax
ffff800000106828:	48 85 c0             	test   %rax,%rax
ffff80000010682b:	74 34                	je     ffff800000106861 <do_invalid_TSS+0x10a>
ffff80000010682d:	48 b8 80 17 00 00 00 	movabs $0x1780,%rax
ffff800000106834:	00 00 00 
ffff800000106837:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010683b:	48 89 c2             	mov    %rax,%rdx
ffff80000010683e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106843:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106848:	49 89 df             	mov    %rbx,%r15
ffff80000010684b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106850:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106857:	ff ff ff 
ffff80000010685a:	48 01 d9             	add    %rbx,%rcx
ffff80000010685d:	ff d1                	call   *%rcx
ffff80000010685f:	eb 32                	jmp    ffff800000106893 <do_invalid_TSS+0x13c>
ffff800000106861:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
ffff800000106868:	00 00 00 
ffff80000010686b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010686f:	48 89 c2             	mov    %rax,%rdx
ffff800000106872:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106877:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010687c:	49 89 df             	mov    %rbx,%r15
ffff80000010687f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106884:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff80000010688b:	ff ff ff 
ffff80000010688e:	48 01 d9             	add    %rbx,%rcx
ffff800000106891:	ff d1                	call   *%rcx
ffff800000106893:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106897:	83 e0 02             	and    $0x2,%eax
ffff80000010689a:	48 85 c0             	test   %rax,%rax
ffff80000010689d:	75 72                	jne    ffff800000106911 <do_invalid_TSS+0x1ba>
ffff80000010689f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001068a3:	83 e0 04             	and    $0x4,%eax
ffff8000001068a6:	48 85 c0             	test   %rax,%rax
ffff8000001068a9:	74 34                	je     ffff8000001068df <do_invalid_TSS+0x188>
ffff8000001068ab:	48 b8 e8 17 00 00 00 	movabs $0x17e8,%rax
ffff8000001068b2:	00 00 00 
ffff8000001068b5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001068b9:	48 89 c2             	mov    %rax,%rdx
ffff8000001068bc:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001068c1:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001068c6:	49 89 df             	mov    %rbx,%r15
ffff8000001068c9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001068ce:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001068d5:	ff ff ff 
ffff8000001068d8:	48 01 d9             	add    %rbx,%rcx
ffff8000001068db:	ff d1                	call   *%rcx
ffff8000001068dd:	eb 32                	jmp    ffff800000106911 <do_invalid_TSS+0x1ba>
ffff8000001068df:	48 b8 20 18 00 00 00 	movabs $0x1820,%rax
ffff8000001068e6:	00 00 00 
ffff8000001068e9:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001068ed:	48 89 c2             	mov    %rax,%rdx
ffff8000001068f0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001068f5:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001068fa:	49 89 df             	mov    %rbx,%r15
ffff8000001068fd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106902:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106909:	ff ff ff 
ffff80000010690c:	48 01 d9             	add    %rbx,%rcx
ffff80000010690f:	ff d1                	call   *%rcx
ffff800000106911:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106915:	25 f8 ff 00 00       	and    $0xfff8,%eax
ffff80000010691a:	48 89 c1             	mov    %rax,%rcx
ffff80000010691d:	48 b8 50 18 00 00 00 	movabs $0x1850,%rax
ffff800000106924:	00 00 00 
ffff800000106927:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010692b:	48 89 c2             	mov    %rax,%rdx
ffff80000010692e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106933:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106938:	49 89 df             	mov    %rbx,%r15
ffff80000010693b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106940:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000106947:	ff ff ff 
ffff80000010694a:	49 01 d8             	add    %rbx,%r8
ffff80000010694d:	41 ff d0             	call   *%r8
ffff800000106950:	eb fe                	jmp    ffff800000106950 <do_invalid_TSS+0x1f9>

ffff800000106952 <do_segment_not_present>:
ffff800000106952:	f3 0f 1e fa          	endbr64 
ffff800000106956:	55                   	push   %rbp
ffff800000106957:	48 89 e5             	mov    %rsp,%rbp
ffff80000010695a:	41 57                	push   %r15
ffff80000010695c:	53                   	push   %rbx
ffff80000010695d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106961:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000106961 <do_segment_not_present+0xf>
ffff800000106968:	49 bb 6f c7 00 00 00 	movabs $0xc76f,%r11
ffff80000010696f:	00 00 00 
ffff800000106972:	4c 01 db             	add    %r11,%rbx
ffff800000106975:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106979:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010697d:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106984:	00 
ffff800000106985:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106989:	48 05 98 00 00 00    	add    $0x98,%rax
ffff80000010698f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106993:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106997:	48 8b 08             	mov    (%rax),%rcx
ffff80000010699a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010699e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001069a2:	49 89 c9             	mov    %rcx,%r9
ffff8000001069a5:	49 89 d0             	mov    %rdx,%r8
ffff8000001069a8:	48 89 c1             	mov    %rax,%rcx
ffff8000001069ab:	48 b8 70 18 00 00 00 	movabs $0x1870,%rax
ffff8000001069b2:	00 00 00 
ffff8000001069b5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001069b9:	48 89 c2             	mov    %rax,%rdx
ffff8000001069bc:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001069c1:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001069c6:	49 89 df             	mov    %rbx,%r15
ffff8000001069c9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001069ce:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff8000001069d5:	ff ff ff 
ffff8000001069d8:	49 01 da             	add    %rbx,%r10
ffff8000001069db:	41 ff d2             	call   *%r10
ffff8000001069de:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001069e2:	83 e0 01             	and    $0x1,%eax
ffff8000001069e5:	48 85 c0             	test   %rax,%rax
ffff8000001069e8:	74 32                	je     ffff800000106a1c <do_segment_not_present+0xca>
ffff8000001069ea:	48 b8 00 17 00 00 00 	movabs $0x1700,%rax
ffff8000001069f1:	00 00 00 
ffff8000001069f4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001069f8:	48 89 c2             	mov    %rax,%rdx
ffff8000001069fb:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106a00:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106a05:	49 89 df             	mov    %rbx,%r15
ffff800000106a08:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106a0d:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106a14:	ff ff ff 
ffff800000106a17:	48 01 d9             	add    %rbx,%rcx
ffff800000106a1a:	ff d1                	call   *%rcx
ffff800000106a1c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106a20:	83 e0 02             	and    $0x2,%eax
ffff800000106a23:	48 85 c0             	test   %rax,%rax
ffff800000106a26:	74 34                	je     ffff800000106a5c <do_segment_not_present+0x10a>
ffff800000106a28:	48 b8 80 17 00 00 00 	movabs $0x1780,%rax
ffff800000106a2f:	00 00 00 
ffff800000106a32:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106a36:	48 89 c2             	mov    %rax,%rdx
ffff800000106a39:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106a3e:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106a43:	49 89 df             	mov    %rbx,%r15
ffff800000106a46:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106a4b:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106a52:	ff ff ff 
ffff800000106a55:	48 01 d9             	add    %rbx,%rcx
ffff800000106a58:	ff d1                	call   *%rcx
ffff800000106a5a:	eb 32                	jmp    ffff800000106a8e <do_segment_not_present+0x13c>
ffff800000106a5c:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
ffff800000106a63:	00 00 00 
ffff800000106a66:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106a6a:	48 89 c2             	mov    %rax,%rdx
ffff800000106a6d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106a72:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106a77:	49 89 df             	mov    %rbx,%r15
ffff800000106a7a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106a7f:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106a86:	ff ff ff 
ffff800000106a89:	48 01 d9             	add    %rbx,%rcx
ffff800000106a8c:	ff d1                	call   *%rcx
ffff800000106a8e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106a92:	83 e0 02             	and    $0x2,%eax
ffff800000106a95:	48 85 c0             	test   %rax,%rax
ffff800000106a98:	75 72                	jne    ffff800000106b0c <do_segment_not_present+0x1ba>
ffff800000106a9a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106a9e:	83 e0 04             	and    $0x4,%eax
ffff800000106aa1:	48 85 c0             	test   %rax,%rax
ffff800000106aa4:	74 34                	je     ffff800000106ada <do_segment_not_present+0x188>
ffff800000106aa6:	48 b8 e8 17 00 00 00 	movabs $0x17e8,%rax
ffff800000106aad:	00 00 00 
ffff800000106ab0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106ab4:	48 89 c2             	mov    %rax,%rdx
ffff800000106ab7:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106abc:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106ac1:	49 89 df             	mov    %rbx,%r15
ffff800000106ac4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106ac9:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106ad0:	ff ff ff 
ffff800000106ad3:	48 01 d9             	add    %rbx,%rcx
ffff800000106ad6:	ff d1                	call   *%rcx
ffff800000106ad8:	eb 32                	jmp    ffff800000106b0c <do_segment_not_present+0x1ba>
ffff800000106ada:	48 b8 20 18 00 00 00 	movabs $0x1820,%rax
ffff800000106ae1:	00 00 00 
ffff800000106ae4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106ae8:	48 89 c2             	mov    %rax,%rdx
ffff800000106aeb:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106af0:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106af5:	49 89 df             	mov    %rbx,%r15
ffff800000106af8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106afd:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106b04:	ff ff ff 
ffff800000106b07:	48 01 d9             	add    %rbx,%rcx
ffff800000106b0a:	ff d1                	call   *%rcx
ffff800000106b0c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106b10:	25 f8 ff 00 00       	and    $0xfff8,%eax
ffff800000106b15:	48 89 c1             	mov    %rax,%rcx
ffff800000106b18:	48 b8 50 18 00 00 00 	movabs $0x1850,%rax
ffff800000106b1f:	00 00 00 
ffff800000106b22:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106b26:	48 89 c2             	mov    %rax,%rdx
ffff800000106b29:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106b2e:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106b33:	49 89 df             	mov    %rbx,%r15
ffff800000106b36:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106b3b:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000106b42:	ff ff ff 
ffff800000106b45:	49 01 d8             	add    %rbx,%r8
ffff800000106b48:	41 ff d0             	call   *%r8
ffff800000106b4b:	eb fe                	jmp    ffff800000106b4b <do_segment_not_present+0x1f9>

ffff800000106b4d <do_stack_segment_fault>:
ffff800000106b4d:	f3 0f 1e fa          	endbr64 
ffff800000106b51:	55                   	push   %rbp
ffff800000106b52:	48 89 e5             	mov    %rsp,%rbp
ffff800000106b55:	41 57                	push   %r15
ffff800000106b57:	53                   	push   %rbx
ffff800000106b58:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106b5c:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000106b5c <do_stack_segment_fault+0xf>
ffff800000106b63:	49 bb 74 c5 00 00 00 	movabs $0xc574,%r11
ffff800000106b6a:	00 00 00 
ffff800000106b6d:	4c 01 db             	add    %r11,%rbx
ffff800000106b70:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106b74:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106b78:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106b7f:	00 
ffff800000106b80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106b84:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106b8a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106b8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106b92:	48 8b 08             	mov    (%rax),%rcx
ffff800000106b95:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106b99:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106b9d:	49 89 c9             	mov    %rcx,%r9
ffff800000106ba0:	49 89 d0             	mov    %rdx,%r8
ffff800000106ba3:	48 89 c1             	mov    %rax,%rcx
ffff800000106ba6:	48 b8 b8 18 00 00 00 	movabs $0x18b8,%rax
ffff800000106bad:	00 00 00 
ffff800000106bb0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106bb4:	48 89 c2             	mov    %rax,%rdx
ffff800000106bb7:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106bbc:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106bc1:	49 89 df             	mov    %rbx,%r15
ffff800000106bc4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106bc9:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff800000106bd0:	ff ff ff 
ffff800000106bd3:	49 01 da             	add    %rbx,%r10
ffff800000106bd6:	41 ff d2             	call   *%r10
ffff800000106bd9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106bdd:	83 e0 01             	and    $0x1,%eax
ffff800000106be0:	48 85 c0             	test   %rax,%rax
ffff800000106be3:	74 32                	je     ffff800000106c17 <do_stack_segment_fault+0xca>
ffff800000106be5:	48 b8 00 17 00 00 00 	movabs $0x1700,%rax
ffff800000106bec:	00 00 00 
ffff800000106bef:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106bf3:	48 89 c2             	mov    %rax,%rdx
ffff800000106bf6:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106bfb:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106c00:	49 89 df             	mov    %rbx,%r15
ffff800000106c03:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106c08:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106c0f:	ff ff ff 
ffff800000106c12:	48 01 d9             	add    %rbx,%rcx
ffff800000106c15:	ff d1                	call   *%rcx
ffff800000106c17:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106c1b:	83 e0 02             	and    $0x2,%eax
ffff800000106c1e:	48 85 c0             	test   %rax,%rax
ffff800000106c21:	74 34                	je     ffff800000106c57 <do_stack_segment_fault+0x10a>
ffff800000106c23:	48 b8 80 17 00 00 00 	movabs $0x1780,%rax
ffff800000106c2a:	00 00 00 
ffff800000106c2d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106c31:	48 89 c2             	mov    %rax,%rdx
ffff800000106c34:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106c39:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106c3e:	49 89 df             	mov    %rbx,%r15
ffff800000106c41:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106c46:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106c4d:	ff ff ff 
ffff800000106c50:	48 01 d9             	add    %rbx,%rcx
ffff800000106c53:	ff d1                	call   *%rcx
ffff800000106c55:	eb 32                	jmp    ffff800000106c89 <do_stack_segment_fault+0x13c>
ffff800000106c57:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
ffff800000106c5e:	00 00 00 
ffff800000106c61:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106c65:	48 89 c2             	mov    %rax,%rdx
ffff800000106c68:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106c6d:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106c72:	49 89 df             	mov    %rbx,%r15
ffff800000106c75:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106c7a:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106c81:	ff ff ff 
ffff800000106c84:	48 01 d9             	add    %rbx,%rcx
ffff800000106c87:	ff d1                	call   *%rcx
ffff800000106c89:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106c8d:	83 e0 02             	and    $0x2,%eax
ffff800000106c90:	48 85 c0             	test   %rax,%rax
ffff800000106c93:	75 72                	jne    ffff800000106d07 <do_stack_segment_fault+0x1ba>
ffff800000106c95:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106c99:	83 e0 04             	and    $0x4,%eax
ffff800000106c9c:	48 85 c0             	test   %rax,%rax
ffff800000106c9f:	74 34                	je     ffff800000106cd5 <do_stack_segment_fault+0x188>
ffff800000106ca1:	48 b8 e8 17 00 00 00 	movabs $0x17e8,%rax
ffff800000106ca8:	00 00 00 
ffff800000106cab:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106caf:	48 89 c2             	mov    %rax,%rdx
ffff800000106cb2:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106cb7:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106cbc:	49 89 df             	mov    %rbx,%r15
ffff800000106cbf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106cc4:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106ccb:	ff ff ff 
ffff800000106cce:	48 01 d9             	add    %rbx,%rcx
ffff800000106cd1:	ff d1                	call   *%rcx
ffff800000106cd3:	eb 32                	jmp    ffff800000106d07 <do_stack_segment_fault+0x1ba>
ffff800000106cd5:	48 b8 20 18 00 00 00 	movabs $0x1820,%rax
ffff800000106cdc:	00 00 00 
ffff800000106cdf:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106ce3:	48 89 c2             	mov    %rax,%rdx
ffff800000106ce6:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106ceb:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106cf0:	49 89 df             	mov    %rbx,%r15
ffff800000106cf3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106cf8:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106cff:	ff ff ff 
ffff800000106d02:	48 01 d9             	add    %rbx,%rcx
ffff800000106d05:	ff d1                	call   *%rcx
ffff800000106d07:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106d0b:	25 f8 ff 00 00       	and    $0xfff8,%eax
ffff800000106d10:	48 89 c1             	mov    %rax,%rcx
ffff800000106d13:	48 b8 50 18 00 00 00 	movabs $0x1850,%rax
ffff800000106d1a:	00 00 00 
ffff800000106d1d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106d21:	48 89 c2             	mov    %rax,%rdx
ffff800000106d24:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106d29:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106d2e:	49 89 df             	mov    %rbx,%r15
ffff800000106d31:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106d36:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000106d3d:	ff ff ff 
ffff800000106d40:	49 01 d8             	add    %rbx,%r8
ffff800000106d43:	41 ff d0             	call   *%r8
ffff800000106d46:	eb fe                	jmp    ffff800000106d46 <do_stack_segment_fault+0x1f9>

ffff800000106d48 <do_general_protection>:
ffff800000106d48:	f3 0f 1e fa          	endbr64 
ffff800000106d4c:	55                   	push   %rbp
ffff800000106d4d:	48 89 e5             	mov    %rsp,%rbp
ffff800000106d50:	41 57                	push   %r15
ffff800000106d52:	53                   	push   %rbx
ffff800000106d53:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106d57:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000106d57 <do_general_protection+0xf>
ffff800000106d5e:	49 bb 79 c3 00 00 00 	movabs $0xc379,%r11
ffff800000106d65:	00 00 00 
ffff800000106d68:	4c 01 db             	add    %r11,%rbx
ffff800000106d6b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106d6f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106d73:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106d7a:	00 
ffff800000106d7b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106d7f:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106d85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106d89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106d8d:	48 8b 08             	mov    (%rax),%rcx
ffff800000106d90:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106d94:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106d98:	49 89 c9             	mov    %rcx,%r9
ffff800000106d9b:	49 89 d0             	mov    %rdx,%r8
ffff800000106d9e:	48 89 c1             	mov    %rax,%rcx
ffff800000106da1:	48 b8 00 19 00 00 00 	movabs $0x1900,%rax
ffff800000106da8:	00 00 00 
ffff800000106dab:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106daf:	48 89 c2             	mov    %rax,%rdx
ffff800000106db2:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106db7:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106dbc:	49 89 df             	mov    %rbx,%r15
ffff800000106dbf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106dc4:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff800000106dcb:	ff ff ff 
ffff800000106dce:	49 01 da             	add    %rbx,%r10
ffff800000106dd1:	41 ff d2             	call   *%r10
ffff800000106dd4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106dd8:	83 e0 01             	and    $0x1,%eax
ffff800000106ddb:	48 85 c0             	test   %rax,%rax
ffff800000106dde:	74 32                	je     ffff800000106e12 <do_general_protection+0xca>
ffff800000106de0:	48 b8 00 17 00 00 00 	movabs $0x1700,%rax
ffff800000106de7:	00 00 00 
ffff800000106dea:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106dee:	48 89 c2             	mov    %rax,%rdx
ffff800000106df1:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106df6:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106dfb:	49 89 df             	mov    %rbx,%r15
ffff800000106dfe:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106e03:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106e0a:	ff ff ff 
ffff800000106e0d:	48 01 d9             	add    %rbx,%rcx
ffff800000106e10:	ff d1                	call   *%rcx
ffff800000106e12:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106e16:	83 e0 02             	and    $0x2,%eax
ffff800000106e19:	48 85 c0             	test   %rax,%rax
ffff800000106e1c:	74 34                	je     ffff800000106e52 <do_general_protection+0x10a>
ffff800000106e1e:	48 b8 80 17 00 00 00 	movabs $0x1780,%rax
ffff800000106e25:	00 00 00 
ffff800000106e28:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106e2c:	48 89 c2             	mov    %rax,%rdx
ffff800000106e2f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106e34:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106e39:	49 89 df             	mov    %rbx,%r15
ffff800000106e3c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106e41:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106e48:	ff ff ff 
ffff800000106e4b:	48 01 d9             	add    %rbx,%rcx
ffff800000106e4e:	ff d1                	call   *%rcx
ffff800000106e50:	eb 32                	jmp    ffff800000106e84 <do_general_protection+0x13c>
ffff800000106e52:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
ffff800000106e59:	00 00 00 
ffff800000106e5c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106e60:	48 89 c2             	mov    %rax,%rdx
ffff800000106e63:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106e68:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106e6d:	49 89 df             	mov    %rbx,%r15
ffff800000106e70:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106e75:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106e7c:	ff ff ff 
ffff800000106e7f:	48 01 d9             	add    %rbx,%rcx
ffff800000106e82:	ff d1                	call   *%rcx
ffff800000106e84:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106e88:	83 e0 02             	and    $0x2,%eax
ffff800000106e8b:	48 85 c0             	test   %rax,%rax
ffff800000106e8e:	75 72                	jne    ffff800000106f02 <do_general_protection+0x1ba>
ffff800000106e90:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106e94:	83 e0 04             	and    $0x4,%eax
ffff800000106e97:	48 85 c0             	test   %rax,%rax
ffff800000106e9a:	74 34                	je     ffff800000106ed0 <do_general_protection+0x188>
ffff800000106e9c:	48 b8 e8 17 00 00 00 	movabs $0x17e8,%rax
ffff800000106ea3:	00 00 00 
ffff800000106ea6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106eaa:	48 89 c2             	mov    %rax,%rdx
ffff800000106ead:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106eb2:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106eb7:	49 89 df             	mov    %rbx,%r15
ffff800000106eba:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106ebf:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106ec6:	ff ff ff 
ffff800000106ec9:	48 01 d9             	add    %rbx,%rcx
ffff800000106ecc:	ff d1                	call   *%rcx
ffff800000106ece:	eb 32                	jmp    ffff800000106f02 <do_general_protection+0x1ba>
ffff800000106ed0:	48 b8 20 18 00 00 00 	movabs $0x1820,%rax
ffff800000106ed7:	00 00 00 
ffff800000106eda:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106ede:	48 89 c2             	mov    %rax,%rdx
ffff800000106ee1:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106ee6:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106eeb:	49 89 df             	mov    %rbx,%r15
ffff800000106eee:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106ef3:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000106efa:	ff ff ff 
ffff800000106efd:	48 01 d9             	add    %rbx,%rcx
ffff800000106f00:	ff d1                	call   *%rcx
ffff800000106f02:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106f06:	25 f8 ff 00 00       	and    $0xfff8,%eax
ffff800000106f0b:	48 89 c1             	mov    %rax,%rcx
ffff800000106f0e:	48 b8 50 18 00 00 00 	movabs $0x1850,%rax
ffff800000106f15:	00 00 00 
ffff800000106f18:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106f1c:	48 89 c2             	mov    %rax,%rdx
ffff800000106f1f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106f24:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106f29:	49 89 df             	mov    %rbx,%r15
ffff800000106f2c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106f31:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000106f38:	ff ff ff 
ffff800000106f3b:	49 01 d8             	add    %rbx,%r8
ffff800000106f3e:	41 ff d0             	call   *%r8
ffff800000106f41:	eb fe                	jmp    ffff800000106f41 <do_general_protection+0x1f9>

ffff800000106f43 <do_page_fault>:
ffff800000106f43:	f3 0f 1e fa          	endbr64 
ffff800000106f47:	55                   	push   %rbp
ffff800000106f48:	48 89 e5             	mov    %rsp,%rbp
ffff800000106f4b:	41 57                	push   %r15
ffff800000106f4d:	53                   	push   %rbx
ffff800000106f4e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106f52:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000106f52 <do_page_fault+0xf>
ffff800000106f59:	49 bb 7e c1 00 00 00 	movabs $0xc17e,%r11
ffff800000106f60:	00 00 00 
ffff800000106f63:	4c 01 db             	add    %r11,%rbx
ffff800000106f66:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000106f6a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000106f6e:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff800000106f75:	00 
ffff800000106f76:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000106f7d:	00 
ffff800000106f7e:	0f 20 d0             	mov    %cr2,%rax
ffff800000106f81:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000106f85:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000106f89:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000106f8f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000106f93:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106f97:	48 8b 08             	mov    (%rax),%rcx
ffff800000106f9a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000106f9e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106fa2:	49 89 c9             	mov    %rcx,%r9
ffff800000106fa5:	49 89 d0             	mov    %rdx,%r8
ffff800000106fa8:	48 89 c1             	mov    %rax,%rcx
ffff800000106fab:	48 b8 48 19 00 00 00 	movabs $0x1948,%rax
ffff800000106fb2:	00 00 00 
ffff800000106fb5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106fb9:	48 89 c2             	mov    %rax,%rdx
ffff800000106fbc:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106fc1:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000106fc6:	49 89 df             	mov    %rbx,%r15
ffff800000106fc9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106fce:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff800000106fd5:	ff ff ff 
ffff800000106fd8:	49 01 da             	add    %rbx,%r10
ffff800000106fdb:	41 ff d2             	call   *%r10
ffff800000106fde:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000106fe2:	83 e0 01             	and    $0x1,%eax
ffff800000106fe5:	48 85 c0             	test   %rax,%rax
ffff800000106fe8:	75 32                	jne    ffff80000010701c <do_page_fault+0xd9>
ffff800000106fea:	48 b8 86 19 00 00 00 	movabs $0x1986,%rax
ffff800000106ff1:	00 00 00 
ffff800000106ff4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000106ff8:	48 89 c2             	mov    %rax,%rdx
ffff800000106ffb:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107000:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107005:	49 89 df             	mov    %rbx,%r15
ffff800000107008:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010700d:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000107014:	ff ff ff 
ffff800000107017:	48 01 d9             	add    %rbx,%rcx
ffff80000010701a:	ff d1                	call   *%rcx
ffff80000010701c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107020:	83 e0 02             	and    $0x2,%eax
ffff800000107023:	48 85 c0             	test   %rax,%rax
ffff800000107026:	74 34                	je     ffff80000010705c <do_page_fault+0x119>
ffff800000107028:	48 b8 99 19 00 00 00 	movabs $0x1999,%rax
ffff80000010702f:	00 00 00 
ffff800000107032:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107036:	48 89 c2             	mov    %rax,%rdx
ffff800000107039:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010703e:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107043:	49 89 df             	mov    %rbx,%r15
ffff800000107046:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010704b:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000107052:	ff ff ff 
ffff800000107055:	48 01 d9             	add    %rbx,%rcx
ffff800000107058:	ff d1                	call   *%rcx
ffff80000010705a:	eb 32                	jmp    ffff80000010708e <do_page_fault+0x14b>
ffff80000010705c:	48 b8 ad 19 00 00 00 	movabs $0x19ad,%rax
ffff800000107063:	00 00 00 
ffff800000107066:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010706a:	48 89 c2             	mov    %rax,%rdx
ffff80000010706d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107072:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107077:	49 89 df             	mov    %rbx,%r15
ffff80000010707a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010707f:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000107086:	ff ff ff 
ffff800000107089:	48 01 d9             	add    %rbx,%rcx
ffff80000010708c:	ff d1                	call   *%rcx
ffff80000010708e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107092:	83 e0 04             	and    $0x4,%eax
ffff800000107095:	48 85 c0             	test   %rax,%rax
ffff800000107098:	74 34                	je     ffff8000001070ce <do_page_fault+0x18b>
ffff80000010709a:	48 b8 c0 19 00 00 00 	movabs $0x19c0,%rax
ffff8000001070a1:	00 00 00 
ffff8000001070a4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001070a8:	48 89 c2             	mov    %rax,%rdx
ffff8000001070ab:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001070b0:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001070b5:	49 89 df             	mov    %rbx,%r15
ffff8000001070b8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001070bd:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001070c4:	ff ff ff 
ffff8000001070c7:	48 01 d9             	add    %rbx,%rcx
ffff8000001070ca:	ff d1                	call   *%rcx
ffff8000001070cc:	eb 32                	jmp    ffff800000107100 <do_page_fault+0x1bd>
ffff8000001070ce:	48 b8 d2 19 00 00 00 	movabs $0x19d2,%rax
ffff8000001070d5:	00 00 00 
ffff8000001070d8:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001070dc:	48 89 c2             	mov    %rax,%rdx
ffff8000001070df:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001070e4:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001070e9:	49 89 df             	mov    %rbx,%r15
ffff8000001070ec:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001070f1:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001070f8:	ff ff ff 
ffff8000001070fb:	48 01 d9             	add    %rbx,%rcx
ffff8000001070fe:	ff d1                	call   *%rcx
ffff800000107100:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107104:	83 e0 08             	and    $0x8,%eax
ffff800000107107:	48 85 c0             	test   %rax,%rax
ffff80000010710a:	74 32                	je     ffff80000010713e <do_page_fault+0x1fb>
ffff80000010710c:	48 b8 ee 19 00 00 00 	movabs $0x19ee,%rax
ffff800000107113:	00 00 00 
ffff800000107116:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010711a:	48 89 c2             	mov    %rax,%rdx
ffff80000010711d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107122:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107127:	49 89 df             	mov    %rbx,%r15
ffff80000010712a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010712f:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000107136:	ff ff ff 
ffff800000107139:	48 01 d9             	add    %rbx,%rcx
ffff80000010713c:	ff d1                	call   *%rcx
ffff80000010713e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107142:	83 e0 10             	and    $0x10,%eax
ffff800000107145:	48 85 c0             	test   %rax,%rax
ffff800000107148:	74 32                	je     ffff80000010717c <do_page_fault+0x239>
ffff80000010714a:	48 b8 10 1a 00 00 00 	movabs $0x1a10,%rax
ffff800000107151:	00 00 00 
ffff800000107154:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107158:	48 89 c2             	mov    %rax,%rdx
ffff80000010715b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107160:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107165:	49 89 df             	mov    %rbx,%r15
ffff800000107168:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010716d:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000107174:	ff ff ff 
ffff800000107177:	48 01 d9             	add    %rbx,%rcx
ffff80000010717a:	ff d1                	call   *%rcx
ffff80000010717c:	48 b8 2f 1a 00 00 00 	movabs $0x1a2f,%rax
ffff800000107183:	00 00 00 
ffff800000107186:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010718a:	48 89 c2             	mov    %rax,%rdx
ffff80000010718d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107192:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107197:	49 89 df             	mov    %rbx,%r15
ffff80000010719a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010719f:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001071a6:	ff ff ff 
ffff8000001071a9:	48 01 d9             	add    %rbx,%rcx
ffff8000001071ac:	ff d1                	call   *%rcx
ffff8000001071ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001071b2:	48 89 c1             	mov    %rax,%rcx
ffff8000001071b5:	48 b8 31 1a 00 00 00 	movabs $0x1a31,%rax
ffff8000001071bc:	00 00 00 
ffff8000001071bf:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001071c3:	48 89 c2             	mov    %rax,%rdx
ffff8000001071c6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001071cb:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001071d0:	49 89 df             	mov    %rbx,%r15
ffff8000001071d3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001071d8:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff8000001071df:	ff ff ff 
ffff8000001071e2:	49 01 d8             	add    %rbx,%r8
ffff8000001071e5:	41 ff d0             	call   *%r8
ffff8000001071e8:	eb fe                	jmp    ffff8000001071e8 <do_page_fault+0x2a5>

ffff8000001071ea <do_x87_FPU_error>:
ffff8000001071ea:	f3 0f 1e fa          	endbr64 
ffff8000001071ee:	55                   	push   %rbp
ffff8000001071ef:	48 89 e5             	mov    %rsp,%rbp
ffff8000001071f2:	41 57                	push   %r15
ffff8000001071f4:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001071f8:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff8000001071f8 <do_x87_FPU_error+0xe>
ffff8000001071ff:	49 bb d8 be 00 00 00 	movabs $0xbed8,%r11
ffff800000107206:	00 00 00 
ffff800000107209:	4d 01 da             	add    %r11,%r10
ffff80000010720c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000107210:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000107214:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff80000010721b:	00 
ffff80000010721c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107220:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000107226:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010722a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010722e:	48 8b 08             	mov    (%rax),%rcx
ffff800000107231:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000107235:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107239:	49 89 c9             	mov    %rcx,%r9
ffff80000010723c:	49 89 d0             	mov    %rdx,%r8
ffff80000010723f:	48 89 c1             	mov    %rax,%rcx
ffff800000107242:	48 b8 40 1a 00 00 00 	movabs $0x1a40,%rax
ffff800000107249:	00 00 00 
ffff80000010724c:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000107250:	48 89 c2             	mov    %rax,%rdx
ffff800000107253:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107258:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010725d:	4d 89 d7             	mov    %r10,%r15
ffff800000107260:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107265:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff80000010726c:	ff ff ff 
ffff80000010726f:	4d 01 d3             	add    %r10,%r11
ffff800000107272:	41 ff d3             	call   *%r11
ffff800000107275:	eb fe                	jmp    ffff800000107275 <do_x87_FPU_error+0x8b>

ffff800000107277 <do_alignment_check>:
ffff800000107277:	f3 0f 1e fa          	endbr64 
ffff80000010727b:	55                   	push   %rbp
ffff80000010727c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010727f:	41 57                	push   %r15
ffff800000107281:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107285:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff800000107285 <do_alignment_check+0xe>
ffff80000010728c:	49 bb 4b be 00 00 00 	movabs $0xbe4b,%r11
ffff800000107293:	00 00 00 
ffff800000107296:	4d 01 da             	add    %r11,%r10
ffff800000107299:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010729d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001072a1:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001072a8:	00 
ffff8000001072a9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001072ad:	48 05 98 00 00 00    	add    $0x98,%rax
ffff8000001072b3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001072b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001072bb:	48 8b 08             	mov    (%rax),%rcx
ffff8000001072be:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001072c2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001072c6:	49 89 c9             	mov    %rcx,%r9
ffff8000001072c9:	49 89 d0             	mov    %rdx,%r8
ffff8000001072cc:	48 89 c1             	mov    %rax,%rcx
ffff8000001072cf:	48 b8 88 1a 00 00 00 	movabs $0x1a88,%rax
ffff8000001072d6:	00 00 00 
ffff8000001072d9:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001072dd:	48 89 c2             	mov    %rax,%rdx
ffff8000001072e0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001072e5:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001072ea:	4d 89 d7             	mov    %r10,%r15
ffff8000001072ed:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001072f2:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001072f9:	ff ff ff 
ffff8000001072fc:	4d 01 d3             	add    %r10,%r11
ffff8000001072ff:	41 ff d3             	call   *%r11
ffff800000107302:	eb fe                	jmp    ffff800000107302 <do_alignment_check+0x8b>

ffff800000107304 <do_machine_check>:
ffff800000107304:	f3 0f 1e fa          	endbr64 
ffff800000107308:	55                   	push   %rbp
ffff800000107309:	48 89 e5             	mov    %rsp,%rbp
ffff80000010730c:	41 57                	push   %r15
ffff80000010730e:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107312:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff800000107312 <do_machine_check+0xe>
ffff800000107319:	49 bb be bd 00 00 00 	movabs $0xbdbe,%r11
ffff800000107320:	00 00 00 
ffff800000107323:	4d 01 da             	add    %r11,%r10
ffff800000107326:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010732a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010732e:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000107335:	00 
ffff800000107336:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010733a:	48 05 98 00 00 00    	add    $0x98,%rax
ffff800000107340:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000107344:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107348:	48 8b 08             	mov    (%rax),%rcx
ffff80000010734b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010734f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107353:	49 89 c9             	mov    %rcx,%r9
ffff800000107356:	49 89 d0             	mov    %rdx,%r8
ffff800000107359:	48 89 c1             	mov    %rax,%rcx
ffff80000010735c:	48 b8 d0 1a 00 00 00 	movabs $0x1ad0,%rax
ffff800000107363:	00 00 00 
ffff800000107366:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff80000010736a:	48 89 c2             	mov    %rax,%rdx
ffff80000010736d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107372:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107377:	4d 89 d7             	mov    %r10,%r15
ffff80000010737a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010737f:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000107386:	ff ff ff 
ffff800000107389:	4d 01 d3             	add    %r10,%r11
ffff80000010738c:	41 ff d3             	call   *%r11
ffff80000010738f:	eb fe                	jmp    ffff80000010738f <do_machine_check+0x8b>

ffff800000107391 <do_SIMD_exception>:
ffff800000107391:	f3 0f 1e fa          	endbr64 
ffff800000107395:	55                   	push   %rbp
ffff800000107396:	48 89 e5             	mov    %rsp,%rbp
ffff800000107399:	41 57                	push   %r15
ffff80000010739b:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010739f:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff80000010739f <do_SIMD_exception+0xe>
ffff8000001073a6:	49 bb 31 bd 00 00 00 	movabs $0xbd31,%r11
ffff8000001073ad:	00 00 00 
ffff8000001073b0:	4d 01 da             	add    %r11,%r10
ffff8000001073b3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001073b7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001073bb:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001073c2:	00 
ffff8000001073c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001073c7:	48 05 98 00 00 00    	add    $0x98,%rax
ffff8000001073cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001073d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001073d5:	48 8b 08             	mov    (%rax),%rcx
ffff8000001073d8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001073dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001073e0:	49 89 c9             	mov    %rcx,%r9
ffff8000001073e3:	49 89 d0             	mov    %rdx,%r8
ffff8000001073e6:	48 89 c1             	mov    %rax,%rcx
ffff8000001073e9:	48 b8 18 1b 00 00 00 	movabs $0x1b18,%rax
ffff8000001073f0:	00 00 00 
ffff8000001073f3:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff8000001073f7:	48 89 c2             	mov    %rax,%rdx
ffff8000001073fa:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001073ff:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107404:	4d 89 d7             	mov    %r10,%r15
ffff800000107407:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010740c:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff800000107413:	ff ff ff 
ffff800000107416:	4d 01 d3             	add    %r10,%r11
ffff800000107419:	41 ff d3             	call   *%r11
ffff80000010741c:	eb fe                	jmp    ffff80000010741c <do_SIMD_exception+0x8b>

ffff80000010741e <do_virtualization_exception>:
ffff80000010741e:	f3 0f 1e fa          	endbr64 
ffff800000107422:	55                   	push   %rbp
ffff800000107423:	48 89 e5             	mov    %rsp,%rbp
ffff800000107426:	41 57                	push   %r15
ffff800000107428:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010742c:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # ffff80000010742c <do_virtualization_exception+0xe>
ffff800000107433:	49 bb a4 bc 00 00 00 	movabs $0xbca4,%r11
ffff80000010743a:	00 00 00 
ffff80000010743d:	4d 01 da             	add    %r11,%r10
ffff800000107440:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000107444:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000107448:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff80000010744f:	00 
ffff800000107450:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107454:	48 05 98 00 00 00    	add    $0x98,%rax
ffff80000010745a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010745e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107462:	48 8b 08             	mov    (%rax),%rcx
ffff800000107465:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000107469:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010746d:	49 89 c9             	mov    %rcx,%r9
ffff800000107470:	49 89 d0             	mov    %rdx,%r8
ffff800000107473:	48 89 c1             	mov    %rax,%rcx
ffff800000107476:	48 b8 60 1b 00 00 00 	movabs $0x1b60,%rax
ffff80000010747d:	00 00 00 
ffff800000107480:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
ffff800000107484:	48 89 c2             	mov    %rax,%rdx
ffff800000107487:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010748c:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000107491:	4d 89 d7             	mov    %r10,%r15
ffff800000107494:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107499:	49 bb 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r11
ffff8000001074a0:	ff ff ff 
ffff8000001074a3:	4d 01 d3             	add    %r10,%r11
ffff8000001074a6:	41 ff d3             	call   *%r11
ffff8000001074a9:	eb fe                	jmp    ffff8000001074a9 <do_virtualization_exception+0x8b>

ffff8000001074ab <memset>:
ffff8000001074ab:	f3 0f 1e fa          	endbr64 
ffff8000001074af:	55                   	push   %rbp
ffff8000001074b0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001074b3:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001074b3 <memset+0x8>
ffff8000001074ba:	49 bb 1d bc 00 00 00 	movabs $0xbc1d,%r11
ffff8000001074c1:	00 00 00 
ffff8000001074c4:	4c 01 d8             	add    %r11,%rax
ffff8000001074c7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001074cb:	89 f0                	mov    %esi,%eax
ffff8000001074cd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001074d1:	88 45 e4             	mov    %al,-0x1c(%rbp)
ffff8000001074d4:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
ffff8000001074d8:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
ffff8000001074df:	01 01 01 
ffff8000001074e2:	48 0f af c2          	imul   %rdx,%rax
ffff8000001074e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001074ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001074ee:	48 8d 50 07          	lea    0x7(%rax),%rdx
ffff8000001074f2:	48 85 c0             	test   %rax,%rax
ffff8000001074f5:	48 0f 48 c2          	cmovs  %rdx,%rax
ffff8000001074f9:	48 c1 f8 03          	sar    $0x3,%rax
ffff8000001074fd:	48 89 c1             	mov    %rax,%rcx
ffff800000107500:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107504:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
ffff800000107508:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010750c:	48 89 d7             	mov    %rdx,%rdi
ffff80000010750f:	fc                   	cld    
ffff800000107510:	f3 48 ab             	rep stos %rax,%es:(%rdi)
ffff800000107513:	40 f6 c6 04          	test   $0x4,%sil
ffff800000107517:	74 01                	je     ffff80000010751a <memset+0x6f>
ffff800000107519:	ab                   	stos   %eax,%es:(%rdi)
ffff80000010751a:	40 f6 c6 02          	test   $0x2,%sil
ffff80000010751e:	74 02                	je     ffff800000107522 <memset+0x77>
ffff800000107520:	66 ab                	stos   %ax,%es:(%rdi)
ffff800000107522:	40 f6 c6 01          	test   $0x1,%sil
ffff800000107526:	74 01                	je     ffff800000107529 <memset+0x7e>
ffff800000107528:	aa                   	stos   %al,%es:(%rdi)
ffff800000107529:	89 f8                	mov    %edi,%eax
ffff80000010752b:	89 ca                	mov    %ecx,%edx
ffff80000010752d:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107530:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000107533:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107537:	5d                   	pop    %rbp
ffff800000107538:	c3                   	ret    

ffff800000107539 <Get_gdt>:
ffff800000107539:	f3 0f 1e fa          	endbr64 
ffff80000010753d:	55                   	push   %rbp
ffff80000010753e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107541:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000107541 <Get_gdt+0x8>
ffff800000107548:	49 bb 8f bb 00 00 00 	movabs $0xbb8f,%r11
ffff80000010754f:	00 00 00 
ffff800000107552:	4c 01 d8             	add    %r11,%rax
ffff800000107555:	0f 20 d8             	mov    %cr3,%rax
ffff800000107558:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010755c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107560:	5d                   	pop    %rbp
ffff800000107561:	c3                   	ret    

ffff800000107562 <init_memory>:
ffff800000107562:	f3 0f 1e fa          	endbr64 
ffff800000107566:	55                   	push   %rbp
ffff800000107567:	48 89 e5             	mov    %rsp,%rbp
ffff80000010756a:	41 57                	push   %r15
ffff80000010756c:	53                   	push   %rbx
ffff80000010756d:	48 83 ec 60          	sub    $0x60,%rsp
ffff800000107571:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000107571 <init_memory+0xf>
ffff800000107578:	49 bb 5f bb 00 00 00 	movabs $0xbb5f,%r11
ffff80000010757f:	00 00 00 
ffff800000107582:	4c 01 db             	add    %r11,%rbx
ffff800000107585:	48 c7 45 98 00 00 00 	movq   $0x0,-0x68(%rbp)
ffff80000010758c:	00 
ffff80000010758d:	48 c7 45 a0 00 00 00 	movq   $0x0,-0x60(%rbp)
ffff800000107594:	00 
ffff800000107595:	48 b8 b0 1b 00 00 00 	movabs $0x1bb0,%rax
ffff80000010759c:	00 00 00 
ffff80000010759f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001075a3:	48 89 c2             	mov    %rax,%rdx
ffff8000001075a6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001075ab:	bf ff 00 00 00       	mov    $0xff,%edi
ffff8000001075b0:	49 89 df             	mov    %rbx,%r15
ffff8000001075b3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001075b8:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001075bf:	ff ff ff 
ffff8000001075c2:	48 01 d9             	add    %rbx,%rcx
ffff8000001075c5:	ff d1                	call   *%rcx
ffff8000001075c7:	48 b8 00 7e 00 00 00 	movabs $0xffff800000007e00,%rax
ffff8000001075ce:	80 ff ff 
ffff8000001075d1:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
ffff8000001075d5:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%rbp)
ffff8000001075dc:	e9 ab 01 00 00       	jmp    ffff80000010778c <init_memory+0x22a>
ffff8000001075e1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001075e5:	8b 48 10             	mov    0x10(%rax),%ecx
ffff8000001075e8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001075ec:	48 8b 50 08          	mov    0x8(%rax),%rdx
ffff8000001075f0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001075f4:	48 8b 00             	mov    (%rax),%rax
ffff8000001075f7:	41 89 c9             	mov    %ecx,%r9d
ffff8000001075fa:	49 89 d0             	mov    %rdx,%r8
ffff8000001075fd:	48 89 c1             	mov    %rax,%rcx
ffff800000107600:	48 b8 28 1c 00 00 00 	movabs $0x1c28,%rax
ffff800000107607:	00 00 00 
ffff80000010760a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010760e:	48 89 c2             	mov    %rax,%rdx
ffff800000107611:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107616:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff80000010761b:	49 89 df             	mov    %rbx,%r15
ffff80000010761e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107623:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff80000010762a:	ff ff ff 
ffff80000010762d:	49 01 da             	add    %rbx,%r10
ffff800000107630:	41 ff d2             	call   *%r10
ffff800000107633:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
ffff80000010763a:	00 
ffff80000010763b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff80000010763f:	8b 40 10             	mov    0x10(%rax),%eax
ffff800000107642:	83 f8 01             	cmp    $0x1,%eax
ffff800000107645:	75 0c                	jne    ffff800000107653 <init_memory+0xf1>
ffff800000107647:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff80000010764b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010764f:	48 01 45 98          	add    %rax,-0x68(%rbp)
ffff800000107653:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010765a:	ff ff ff 
ffff80000010765d:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff800000107661:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107664:	48 63 d0             	movslq %eax,%rdx
ffff800000107667:	48 89 d0             	mov    %rdx,%rax
ffff80000010766a:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010766e:	48 01 d0             	add    %rdx,%rax
ffff800000107671:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107675:	48 01 c8             	add    %rcx,%rax
ffff800000107678:	48 8b 10             	mov    (%rax),%rdx
ffff80000010767b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff80000010767f:	48 8b 00             	mov    (%rax),%rax
ffff800000107682:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000107686:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010768d:	ff ff ff 
ffff800000107690:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff800000107694:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107697:	48 63 d0             	movslq %eax,%rdx
ffff80000010769a:	48 89 d0             	mov    %rdx,%rax
ffff80000010769d:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001076a1:	48 01 d0             	add    %rdx,%rax
ffff8000001076a4:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001076a8:	48 01 f0             	add    %rsi,%rax
ffff8000001076ab:	48 89 08             	mov    %rcx,(%rax)
ffff8000001076ae:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001076b5:	ff ff ff 
ffff8000001076b8:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff8000001076bc:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001076bf:	48 63 d0             	movslq %eax,%rdx
ffff8000001076c2:	48 89 d0             	mov    %rdx,%rax
ffff8000001076c5:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001076c9:	48 01 d0             	add    %rdx,%rax
ffff8000001076cc:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001076d0:	48 01 c8             	add    %rcx,%rax
ffff8000001076d3:	48 83 c0 08          	add    $0x8,%rax
ffff8000001076d7:	48 8b 10             	mov    (%rax),%rdx
ffff8000001076da:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff8000001076de:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001076e2:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff8000001076e6:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001076ed:	ff ff ff 
ffff8000001076f0:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff8000001076f4:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001076f7:	48 63 d0             	movslq %eax,%rdx
ffff8000001076fa:	48 89 d0             	mov    %rdx,%rax
ffff8000001076fd:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107701:	48 01 d0             	add    %rdx,%rax
ffff800000107704:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107708:	48 01 f0             	add    %rsi,%rax
ffff80000010770b:	48 83 c0 08          	add    $0x8,%rax
ffff80000010770f:	48 89 08             	mov    %rcx,(%rax)
ffff800000107712:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000107716:	8b 50 10             	mov    0x10(%rax),%edx
ffff800000107719:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107720:	ff ff ff 
ffff800000107723:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff800000107727:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff80000010772a:	48 63 c8             	movslq %eax,%rcx
ffff80000010772d:	48 89 c8             	mov    %rcx,%rax
ffff800000107730:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107734:	48 01 c8             	add    %rcx,%rax
ffff800000107737:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010773b:	48 01 f0             	add    %rsi,%rax
ffff80000010773e:	48 83 c0 10          	add    $0x10,%rax
ffff800000107742:	89 10                	mov    %edx,(%rax)
ffff800000107744:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107747:	48 63 d0             	movslq %eax,%rdx
ffff80000010774a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107751:	ff ff ff 
ffff800000107754:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107758:	48 89 90 80 02 00 00 	mov    %rdx,0x280(%rax)
ffff80000010775f:	48 83 45 a0 14       	addq   $0x14,-0x60(%rbp)
ffff800000107764:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000107768:	8b 40 10             	mov    0x10(%rax),%eax
ffff80000010776b:	83 f8 04             	cmp    $0x4,%eax
ffff80000010776e:	77 26                	ja     ffff800000107796 <init_memory+0x234>
ffff800000107770:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000107774:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107778:	48 85 c0             	test   %rax,%rax
ffff80000010777b:	74 19                	je     ffff800000107796 <init_memory+0x234>
ffff80000010777d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000107781:	8b 40 10             	mov    0x10(%rax),%eax
ffff800000107784:	85 c0                	test   %eax,%eax
ffff800000107786:	74 0e                	je     ffff800000107796 <init_memory+0x234>
ffff800000107788:	83 45 90 01          	addl   $0x1,-0x70(%rbp)
ffff80000010778c:	83 7d 90 1f          	cmpl   $0x1f,-0x70(%rbp)
ffff800000107790:	0f 8e 4b fe ff ff    	jle    ffff8000001075e1 <init_memory+0x7f>
ffff800000107796:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff80000010779a:	48 89 c1             	mov    %rax,%rcx
ffff80000010779d:	48 b8 58 1c 00 00 00 	movabs $0x1c58,%rax
ffff8000001077a4:	00 00 00 
ffff8000001077a7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001077ab:	48 89 c2             	mov    %rax,%rdx
ffff8000001077ae:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001077b3:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff8000001077b8:	49 89 df             	mov    %rbx,%r15
ffff8000001077bb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001077c0:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff8000001077c7:	ff ff ff 
ffff8000001077ca:	49 01 d8             	add    %rbx,%r8
ffff8000001077cd:	41 ff d0             	call   *%r8
ffff8000001077d0:	48 c7 45 98 00 00 00 	movq   $0x0,-0x68(%rbp)
ffff8000001077d7:	00 
ffff8000001077d8:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%rbp)
ffff8000001077df:	e9 f1 00 00 00       	jmp    ffff8000001078d5 <init_memory+0x373>
ffff8000001077e4:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001077eb:	ff ff ff 
ffff8000001077ee:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff8000001077f2:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001077f5:	48 63 d0             	movslq %eax,%rdx
ffff8000001077f8:	48 89 d0             	mov    %rdx,%rax
ffff8000001077fb:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001077ff:	48 01 d0             	add    %rdx,%rax
ffff800000107802:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107806:	48 01 c8             	add    %rcx,%rax
ffff800000107809:	48 83 c0 10          	add    $0x10,%rax
ffff80000010780d:	8b 00                	mov    (%rax),%eax
ffff80000010780f:	83 f8 01             	cmp    $0x1,%eax
ffff800000107812:	0f 85 b5 00 00 00    	jne    ffff8000001078cd <init_memory+0x36b>
ffff800000107818:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010781f:	ff ff ff 
ffff800000107822:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff800000107826:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107829:	48 63 d0             	movslq %eax,%rdx
ffff80000010782c:	48 89 d0             	mov    %rdx,%rax
ffff80000010782f:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107833:	48 01 d0             	add    %rdx,%rax
ffff800000107836:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010783a:	48 01 c8             	add    %rcx,%rax
ffff80000010783d:	48 8b 00             	mov    (%rax),%rax
ffff800000107840:	48 05 ff ff 1f 00    	add    $0x1fffff,%rax
ffff800000107846:	48 25 00 00 e0 ff    	and    $0xffffffffffe00000,%rax
ffff80000010784c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107850:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107857:	ff ff ff 
ffff80000010785a:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff80000010785e:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107861:	48 63 d0             	movslq %eax,%rdx
ffff800000107864:	48 89 d0             	mov    %rdx,%rax
ffff800000107867:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010786b:	48 01 d0             	add    %rdx,%rax
ffff80000010786e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107872:	48 01 c8             	add    %rcx,%rax
ffff800000107875:	48 8b 08             	mov    (%rax),%rcx
ffff800000107878:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010787f:	ff ff ff 
ffff800000107882:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff800000107886:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107889:	48 63 d0             	movslq %eax,%rdx
ffff80000010788c:	48 89 d0             	mov    %rdx,%rax
ffff80000010788f:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107893:	48 01 d0             	add    %rdx,%rax
ffff800000107896:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010789a:	48 01 f0             	add    %rsi,%rax
ffff80000010789d:	48 83 c0 08          	add    $0x8,%rax
ffff8000001078a1:	48 8b 00             	mov    (%rax),%rax
ffff8000001078a4:	48 01 c8             	add    %rcx,%rax
ffff8000001078a7:	48 25 00 00 e0 ff    	and    $0xffffffffffe00000,%rax
ffff8000001078ad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001078b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001078b5:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff8000001078b9:	76 15                	jbe    ffff8000001078d0 <init_memory+0x36e>
ffff8000001078bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001078bf:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
ffff8000001078c3:	48 c1 e8 15          	shr    $0x15,%rax
ffff8000001078c7:	48 01 45 98          	add    %rax,-0x68(%rbp)
ffff8000001078cb:	eb 04                	jmp    ffff8000001078d1 <init_memory+0x36f>
ffff8000001078cd:	90                   	nop
ffff8000001078ce:	eb 01                	jmp    ffff8000001078d1 <init_memory+0x36f>
ffff8000001078d0:	90                   	nop
ffff8000001078d1:	83 45 90 01          	addl   $0x1,-0x70(%rbp)
ffff8000001078d5:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001078d8:	48 63 d0             	movslq %eax,%rdx
ffff8000001078db:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001078e2:	ff ff ff 
ffff8000001078e5:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001078e9:	48 8b 80 80 02 00 00 	mov    0x280(%rax),%rax
ffff8000001078f0:	48 39 c2             	cmp    %rax,%rdx
ffff8000001078f3:	0f 86 eb fe ff ff    	jbe    ffff8000001077e4 <init_memory+0x282>
ffff8000001078f9:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001078fd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000107901:	49 89 d0             	mov    %rdx,%r8
ffff800000107904:	48 89 c1             	mov    %rax,%rcx
ffff800000107907:	48 b8 78 1c 00 00 00 	movabs $0x1c78,%rax
ffff80000010790e:	00 00 00 
ffff800000107911:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107915:	48 89 c2             	mov    %rax,%rdx
ffff800000107918:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010791d:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff800000107922:	49 89 df             	mov    %rbx,%r15
ffff800000107925:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010792a:	49 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r9
ffff800000107931:	ff ff ff 
ffff800000107934:	49 01 d9             	add    %rbx,%r9
ffff800000107937:	41 ff d1             	call   *%r9
ffff80000010793a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107941:	ff ff ff 
ffff800000107944:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107948:	48 8b 90 80 02 00 00 	mov    0x280(%rax),%rdx
ffff80000010794f:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107956:	ff ff ff 
ffff800000107959:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff80000010795d:	48 89 d0             	mov    %rdx,%rax
ffff800000107960:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107964:	48 01 d0             	add    %rdx,%rax
ffff800000107967:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010796b:	48 01 c8             	add    %rcx,%rax
ffff80000010796e:	48 8b 08             	mov    (%rax),%rcx
ffff800000107971:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107978:	ff ff ff 
ffff80000010797b:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010797f:	48 8b 90 80 02 00 00 	mov    0x280(%rax),%rdx
ffff800000107986:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010798d:	ff ff ff 
ffff800000107990:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff800000107994:	48 89 d0             	mov    %rdx,%rax
ffff800000107997:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010799b:	48 01 d0             	add    %rdx,%rax
ffff80000010799e:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001079a2:	48 01 f0             	add    %rsi,%rax
ffff8000001079a5:	48 83 c0 08          	add    $0x8,%rax
ffff8000001079a9:	48 8b 00             	mov    (%rax),%rax
ffff8000001079ac:	48 01 c8             	add    %rcx,%rax
ffff8000001079af:	48 89 45 98          	mov    %rax,-0x68(%rbp)
ffff8000001079b3:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001079ba:	ff ff ff 
ffff8000001079bd:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001079c1:	48 8b 80 e8 02 00 00 	mov    0x2e8(%rax),%rax
ffff8000001079c8:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff8000001079ce:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff8000001079d4:	48 89 c2             	mov    %rax,%rdx
ffff8000001079d7:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001079de:	ff ff ff 
ffff8000001079e1:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001079e5:	48 89 90 88 02 00 00 	mov    %rdx,0x288(%rax)
ffff8000001079ec:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001079f0:	48 c1 e8 15          	shr    $0x15,%rax
ffff8000001079f4:	48 89 c2             	mov    %rax,%rdx
ffff8000001079f7:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001079fe:	ff ff ff 
ffff800000107a01:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107a05:	48 89 90 90 02 00 00 	mov    %rdx,0x290(%rax)
ffff800000107a0c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000107a10:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107a14:	48 83 c0 3f          	add    $0x3f,%rax
ffff800000107a18:	48 c1 e8 03          	shr    $0x3,%rax
ffff800000107a1c:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff800000107a20:	48 89 c2             	mov    %rax,%rdx
ffff800000107a23:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107a2a:	ff ff ff 
ffff800000107a2d:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107a31:	48 89 90 98 02 00 00 	mov    %rdx,0x298(%rax)
ffff800000107a38:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107a3f:	ff ff ff 
ffff800000107a42:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107a46:	48 8b 80 98 02 00 00 	mov    0x298(%rax),%rax
ffff800000107a4d:	48 89 c2             	mov    %rax,%rdx
ffff800000107a50:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107a57:	ff ff ff 
ffff800000107a5a:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107a5e:	48 8b 80 88 02 00 00 	mov    0x288(%rax),%rax
ffff800000107a65:	be ff 00 00 00       	mov    $0xff,%esi
ffff800000107a6a:	48 89 c7             	mov    %rax,%rdi
ffff800000107a6d:	48 b8 db 43 ff ff ff 	movabs $0xffffffffffff43db,%rax
ffff800000107a74:	ff ff ff 
ffff800000107a77:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107a7b:	ff d0                	call   *%rax
ffff800000107a7d:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107a84:	ff ff ff 
ffff800000107a87:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107a8b:	48 8b 80 88 02 00 00 	mov    0x288(%rax),%rax
ffff800000107a92:	48 89 c2             	mov    %rax,%rdx
ffff800000107a95:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107a9c:	ff ff ff 
ffff800000107a9f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107aa3:	48 8b 80 98 02 00 00 	mov    0x298(%rax),%rax
ffff800000107aaa:	48 01 d0             	add    %rdx,%rax
ffff800000107aad:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000107ab3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000107ab9:	48 89 c2             	mov    %rax,%rdx
ffff800000107abc:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107ac3:	ff ff ff 
ffff800000107ac6:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107aca:	48 89 90 a0 02 00 00 	mov    %rdx,0x2a0(%rax)
ffff800000107ad1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000107ad5:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107ad9:	48 89 c2             	mov    %rax,%rdx
ffff800000107adc:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107ae3:	ff ff ff 
ffff800000107ae6:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107aea:	48 89 90 a8 02 00 00 	mov    %rdx,0x2a8(%rax)
ffff800000107af1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000107af5:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107af9:	48 89 c2             	mov    %rax,%rdx
ffff800000107afc:	48 89 d0             	mov    %rdx,%rax
ffff800000107aff:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107b03:	48 01 d0             	add    %rdx,%rax
ffff800000107b06:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000107b0a:	48 83 c0 07          	add    $0x7,%rax
ffff800000107b0e:	48 83 e0 f6          	and    $0xfffffffffffffff6,%rax
ffff800000107b12:	48 89 c2             	mov    %rax,%rdx
ffff800000107b15:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107b1c:	ff ff ff 
ffff800000107b1f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107b23:	48 89 90 b0 02 00 00 	mov    %rdx,0x2b0(%rax)
ffff800000107b2a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107b31:	ff ff ff 
ffff800000107b34:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107b38:	48 8b 80 b0 02 00 00 	mov    0x2b0(%rax),%rax
ffff800000107b3f:	48 89 c2             	mov    %rax,%rdx
ffff800000107b42:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107b49:	ff ff ff 
ffff800000107b4c:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107b50:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107b57:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107b5c:	48 89 c7             	mov    %rax,%rdi
ffff800000107b5f:	48 b8 db 43 ff ff ff 	movabs $0xffffffffffff43db,%rax
ffff800000107b66:	ff ff ff 
ffff800000107b69:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107b6d:	ff d0                	call   *%rax
ffff800000107b6f:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107b76:	ff ff ff 
ffff800000107b79:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107b7d:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107b84:	48 89 c2             	mov    %rax,%rdx
ffff800000107b87:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107b8e:	ff ff ff 
ffff800000107b91:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107b95:	48 8b 80 b0 02 00 00 	mov    0x2b0(%rax),%rax
ffff800000107b9c:	48 01 d0             	add    %rdx,%rax
ffff800000107b9f:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000107ba5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000107bab:	48 89 c2             	mov    %rax,%rdx
ffff800000107bae:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107bb5:	ff ff ff 
ffff800000107bb8:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107bbc:	48 89 90 b8 02 00 00 	mov    %rdx,0x2b8(%rax)
ffff800000107bc3:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107bca:	ff ff ff 
ffff800000107bcd:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107bd1:	48 c7 80 c0 02 00 00 	movq   $0x0,0x2c0(%rax)
ffff800000107bd8:	00 00 00 00 
ffff800000107bdc:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107be3:	ff ff ff 
ffff800000107be6:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107bea:	48 c7 80 c8 02 00 00 	movq   $0x190,0x2c8(%rax)
ffff800000107bf1:	90 01 00 00 
ffff800000107bf5:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107bfc:	ff ff ff 
ffff800000107bff:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107c03:	48 8b 80 c8 02 00 00 	mov    0x2c8(%rax),%rax
ffff800000107c0a:	48 89 c2             	mov    %rax,%rdx
ffff800000107c0d:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107c14:	ff ff ff 
ffff800000107c17:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107c1b:	48 8b 80 b8 02 00 00 	mov    0x2b8(%rax),%rax
ffff800000107c22:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107c27:	48 89 c7             	mov    %rax,%rdi
ffff800000107c2a:	48 b8 db 43 ff ff ff 	movabs $0xffffffffffff43db,%rax
ffff800000107c31:	ff ff ff 
ffff800000107c34:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000107c38:	ff d0                	call   *%rax
ffff800000107c3a:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%rbp)
ffff800000107c41:	e9 11 03 00 00       	jmp    ffff800000107f57 <init_memory+0x9f5>
ffff800000107c46:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107c4d:	ff ff ff 
ffff800000107c50:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff800000107c54:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107c57:	48 63 d0             	movslq %eax,%rdx
ffff800000107c5a:	48 89 d0             	mov    %rdx,%rax
ffff800000107c5d:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107c61:	48 01 d0             	add    %rdx,%rax
ffff800000107c64:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107c68:	48 01 c8             	add    %rcx,%rax
ffff800000107c6b:	48 83 c0 10          	add    $0x10,%rax
ffff800000107c6f:	8b 00                	mov    (%rax),%eax
ffff800000107c71:	83 f8 01             	cmp    $0x1,%eax
ffff800000107c74:	0f 85 d5 02 00 00    	jne    ffff800000107f4f <init_memory+0x9ed>
ffff800000107c7a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107c81:	ff ff ff 
ffff800000107c84:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff800000107c88:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107c8b:	48 63 d0             	movslq %eax,%rdx
ffff800000107c8e:	48 89 d0             	mov    %rdx,%rax
ffff800000107c91:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107c95:	48 01 d0             	add    %rdx,%rax
ffff800000107c98:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107c9c:	48 01 c8             	add    %rcx,%rax
ffff800000107c9f:	48 8b 00             	mov    (%rax),%rax
ffff800000107ca2:	48 05 ff ff 1f 00    	add    $0x1fffff,%rax
ffff800000107ca8:	48 25 00 00 e0 ff    	and    $0xffffffffffe00000,%rax
ffff800000107cae:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff800000107cb2:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107cb9:	ff ff ff 
ffff800000107cbc:	48 8b 0c 03          	mov    (%rbx,%rax,1),%rcx
ffff800000107cc0:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107cc3:	48 63 d0             	movslq %eax,%rdx
ffff800000107cc6:	48 89 d0             	mov    %rdx,%rax
ffff800000107cc9:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107ccd:	48 01 d0             	add    %rdx,%rax
ffff800000107cd0:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107cd4:	48 01 c8             	add    %rcx,%rax
ffff800000107cd7:	48 8b 08             	mov    (%rax),%rcx
ffff800000107cda:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107ce1:	ff ff ff 
ffff800000107ce4:	48 8b 34 03          	mov    (%rbx,%rax,1),%rsi
ffff800000107ce8:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107ceb:	48 63 d0             	movslq %eax,%rdx
ffff800000107cee:	48 89 d0             	mov    %rdx,%rax
ffff800000107cf1:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107cf5:	48 01 d0             	add    %rdx,%rax
ffff800000107cf8:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107cfc:	48 01 f0             	add    %rsi,%rax
ffff800000107cff:	48 83 c0 08          	add    $0x8,%rax
ffff800000107d03:	48 8b 00             	mov    (%rax),%rax
ffff800000107d06:	48 01 c8             	add    %rcx,%rax
ffff800000107d09:	48 25 00 00 e0 ff    	and    $0xffffffffffe00000,%rax
ffff800000107d0f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff800000107d13:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107d17:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
ffff800000107d1b:	0f 86 31 02 00 00    	jbe    ffff800000107f52 <init_memory+0x9f0>
ffff800000107d21:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107d28:	ff ff ff 
ffff800000107d2b:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107d2f:	48 8b 88 b8 02 00 00 	mov    0x2b8(%rax),%rcx
ffff800000107d36:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107d3d:	ff ff ff 
ffff800000107d40:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107d44:	48 8b 90 c0 02 00 00 	mov    0x2c0(%rax),%rdx
ffff800000107d4b:	48 89 d0             	mov    %rdx,%rax
ffff800000107d4e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107d52:	48 01 d0             	add    %rdx,%rax
ffff800000107d55:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000107d59:	48 01 c8             	add    %rcx,%rax
ffff800000107d5c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff800000107d60:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107d67:	ff ff ff 
ffff800000107d6a:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107d6e:	48 8b 80 c0 02 00 00 	mov    0x2c0(%rax),%rax
ffff800000107d75:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107d79:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107d80:	ff ff ff 
ffff800000107d83:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107d87:	48 89 90 c0 02 00 00 	mov    %rdx,0x2c0(%rax)
ffff800000107d8e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107d92:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffff800000107d96:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000107d9a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107d9e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000107da2:	48 89 50 18          	mov    %rdx,0x18(%rax)
ffff800000107da6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107daa:	48 2b 45 c8          	sub    -0x38(%rbp),%rax
ffff800000107dae:	48 89 c2             	mov    %rax,%rdx
ffff800000107db1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107db5:	48 89 50 20          	mov    %rdx,0x20(%rax)
ffff800000107db9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107dbd:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000107dc4:	00 
ffff800000107dc5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107dc9:	48 2b 45 c8          	sub    -0x38(%rbp),%rax
ffff800000107dcd:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107dd1:	48 89 c2             	mov    %rax,%rdx
ffff800000107dd4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107dd8:	48 89 50 40          	mov    %rdx,0x40(%rax)
ffff800000107ddc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107de0:	48 c7 40 48 00 00 00 	movq   $0x0,0x48(%rax)
ffff800000107de7:	00 
ffff800000107de8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107dec:	48 c7 40 28 00 00 00 	movq   $0x0,0x28(%rax)
ffff800000107df3:	00 
ffff800000107df4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107df8:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000107dff:	ff ff ff 
ffff800000107e02:	48 8b 14 13          	mov    (%rbx,%rdx,1),%rdx
ffff800000107e06:	48 89 50 30          	mov    %rdx,0x30(%rax)
ffff800000107e0a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000107e0e:	48 2b 45 c8          	sub    -0x38(%rbp),%rax
ffff800000107e12:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107e16:	48 89 c2             	mov    %rax,%rdx
ffff800000107e19:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107e1d:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff800000107e21:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107e28:	ff ff ff 
ffff800000107e2b:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107e2f:	48 8b 88 a0 02 00 00 	mov    0x2a0(%rax),%rcx
ffff800000107e36:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000107e3a:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107e3e:	48 89 c2             	mov    %rax,%rdx
ffff800000107e41:	48 89 d0             	mov    %rdx,%rax
ffff800000107e44:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000107e48:	48 01 d0             	add    %rdx,%rax
ffff800000107e4b:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000107e4f:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
ffff800000107e53:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107e57:	48 89 10             	mov    %rdx,(%rax)
ffff800000107e5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107e5e:	48 8b 00             	mov    (%rax),%rax
ffff800000107e61:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
ffff800000107e65:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%rbp)
ffff800000107e6c:	e9 c5 00 00 00       	jmp    ffff800000107f36 <init_memory+0x9d4>
ffff800000107e71:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107e75:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000107e79:	48 89 10             	mov    %rdx,(%rax)
ffff800000107e7c:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff800000107e7f:	48 98                	cltq   
ffff800000107e81:	48 c1 e0 15          	shl    $0x15,%rax
ffff800000107e85:	48 89 c2             	mov    %rax,%rdx
ffff800000107e88:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000107e8c:	48 01 c2             	add    %rax,%rdx
ffff800000107e8f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107e93:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff800000107e97:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107e9b:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107ea2:	00 
ffff800000107ea3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107ea7:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107eae:	00 
ffff800000107eaf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107eb3:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000107eba:	00 
ffff800000107ebb:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107ec2:	ff ff ff 
ffff800000107ec5:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107ec9:	48 8b 90 88 02 00 00 	mov    0x288(%rax),%rdx
ffff800000107ed0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107ed4:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107ed8:	48 c1 e8 1b          	shr    $0x1b,%rax
ffff800000107edc:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000107ee0:	48 01 d0             	add    %rdx,%rax
ffff800000107ee3:	48 8b 10             	mov    (%rax),%rdx
ffff800000107ee6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107eea:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107eee:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000107ef2:	83 e0 3f             	and    $0x3f,%eax
ffff800000107ef5:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000107efa:	89 c1                	mov    %eax,%ecx
ffff800000107efc:	48 d3 e6             	shl    %cl,%rsi
ffff800000107eff:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107f06:	ff ff ff 
ffff800000107f09:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107f0d:	48 8b 88 88 02 00 00 	mov    0x288(%rax),%rcx
ffff800000107f14:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
ffff800000107f18:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107f1c:	48 c1 e8 1b          	shr    $0x1b,%rax
ffff800000107f20:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000107f24:	48 01 c8             	add    %rcx,%rax
ffff800000107f27:	48 31 f2             	xor    %rsi,%rdx
ffff800000107f2a:	48 89 10             	mov    %rdx,(%rax)
ffff800000107f2d:	83 45 94 01          	addl   $0x1,-0x6c(%rbp)
ffff800000107f31:	48 83 45 a8 28       	addq   $0x28,-0x58(%rbp)
ffff800000107f36:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff800000107f39:	48 63 d0             	movslq %eax,%rdx
ffff800000107f3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000107f40:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107f44:	48 39 c2             	cmp    %rax,%rdx
ffff800000107f47:	0f 82 24 ff ff ff    	jb     ffff800000107e71 <init_memory+0x90f>
ffff800000107f4d:	eb 04                	jmp    ffff800000107f53 <init_memory+0x9f1>
ffff800000107f4f:	90                   	nop
ffff800000107f50:	eb 01                	jmp    ffff800000107f53 <init_memory+0x9f1>
ffff800000107f52:	90                   	nop
ffff800000107f53:	83 45 90 01          	addl   $0x1,-0x70(%rbp)
ffff800000107f57:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000107f5a:	48 63 d0             	movslq %eax,%rdx
ffff800000107f5d:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107f64:	ff ff ff 
ffff800000107f67:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107f6b:	48 8b 80 80 02 00 00 	mov    0x280(%rax),%rax
ffff800000107f72:	48 39 c2             	cmp    %rax,%rdx
ffff800000107f75:	0f 82 cb fc ff ff    	jb     ffff800000107c46 <init_memory+0x6e4>
ffff800000107f7b:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107f82:	ff ff ff 
ffff800000107f85:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107f89:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107f90:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000107f97:	ff ff ff 
ffff800000107f9a:	48 8b 14 13          	mov    (%rbx,%rdx,1),%rdx
ffff800000107f9e:	48 8b 92 b8 02 00 00 	mov    0x2b8(%rdx),%rdx
ffff800000107fa5:	48 89 10             	mov    %rdx,(%rax)
ffff800000107fa8:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107faf:	ff ff ff 
ffff800000107fb2:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107fb6:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107fbd:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
ffff800000107fc4:	00 
ffff800000107fc5:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107fcc:	ff ff ff 
ffff800000107fcf:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107fd3:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107fda:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107fe1:	00 
ffff800000107fe2:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000107fe9:	ff ff ff 
ffff800000107fec:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000107ff0:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000107ff7:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107ffe:	00 
ffff800000107fff:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108006:	ff ff ff 
ffff800000108009:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010800d:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000108014:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff80000010801b:	00 
ffff80000010801c:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108023:	ff ff ff 
ffff800000108026:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010802a:	48 8b 90 c0 02 00 00 	mov    0x2c0(%rax),%rdx
ffff800000108031:	48 89 d0             	mov    %rdx,%rax
ffff800000108034:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000108038:	48 01 d0             	add    %rdx,%rax
ffff80000010803b:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010803f:	48 83 c0 07          	add    $0x7,%rax
ffff800000108043:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff800000108047:	48 89 c2             	mov    %rax,%rdx
ffff80000010804a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108051:	ff ff ff 
ffff800000108054:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108058:	48 89 90 c8 02 00 00 	mov    %rdx,0x2c8(%rax)
ffff80000010805f:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108066:	ff ff ff 
ffff800000108069:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010806d:	48 8b 88 98 02 00 00 	mov    0x298(%rax),%rcx
ffff800000108074:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010807b:	ff ff ff 
ffff80000010807e:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108082:	48 8b 90 90 02 00 00 	mov    0x290(%rax),%rdx
ffff800000108089:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108090:	ff ff ff 
ffff800000108093:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108097:	48 8b 80 88 02 00 00 	mov    0x288(%rax),%rax
ffff80000010809e:	49 89 c9             	mov    %rcx,%r9
ffff8000001080a1:	49 89 d0             	mov    %rdx,%r8
ffff8000001080a4:	48 89 c1             	mov    %rax,%rcx
ffff8000001080a7:	48 b8 a8 1c 00 00 00 	movabs $0x1ca8,%rax
ffff8000001080ae:	00 00 00 
ffff8000001080b1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001080b5:	48 89 c2             	mov    %rax,%rdx
ffff8000001080b8:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001080bd:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff8000001080c2:	49 89 df             	mov    %rbx,%r15
ffff8000001080c5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001080ca:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff8000001080d1:	ff ff ff 
ffff8000001080d4:	49 01 da             	add    %rbx,%r10
ffff8000001080d7:	41 ff d2             	call   *%r10
ffff8000001080da:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001080e1:	ff ff ff 
ffff8000001080e4:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001080e8:	48 8b 88 b0 02 00 00 	mov    0x2b0(%rax),%rcx
ffff8000001080ef:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001080f6:	ff ff ff 
ffff8000001080f9:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001080fd:	48 8b 90 a8 02 00 00 	mov    0x2a8(%rax),%rdx
ffff800000108104:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010810b:	ff ff ff 
ffff80000010810e:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108112:	48 8b 80 a0 02 00 00 	mov    0x2a0(%rax),%rax
ffff800000108119:	49 89 c9             	mov    %rcx,%r9
ffff80000010811c:	49 89 d0             	mov    %rdx,%r8
ffff80000010811f:	48 89 c1             	mov    %rax,%rcx
ffff800000108122:	48 b8 e0 1c 00 00 00 	movabs $0x1ce0,%rax
ffff800000108129:	00 00 00 
ffff80000010812c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000108130:	48 89 c2             	mov    %rax,%rdx
ffff800000108133:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108138:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff80000010813d:	49 89 df             	mov    %rbx,%r15
ffff800000108140:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108145:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff80000010814c:	ff ff ff 
ffff80000010814f:	49 01 da             	add    %rbx,%r10
ffff800000108152:	41 ff d2             	call   *%r10
ffff800000108155:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010815c:	ff ff ff 
ffff80000010815f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108163:	48 8b 88 c8 02 00 00 	mov    0x2c8(%rax),%rcx
ffff80000010816a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108171:	ff ff ff 
ffff800000108174:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108178:	48 8b 90 c0 02 00 00 	mov    0x2c0(%rax),%rdx
ffff80000010817f:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108186:	ff ff ff 
ffff800000108189:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010818d:	48 8b 80 b8 02 00 00 	mov    0x2b8(%rax),%rax
ffff800000108194:	49 89 c9             	mov    %rcx,%r9
ffff800000108197:	49 89 d0             	mov    %rdx,%r8
ffff80000010819a:	48 89 c1             	mov    %rax,%rcx
ffff80000010819d:	48 b8 20 1d 00 00 00 	movabs $0x1d20,%rax
ffff8000001081a4:	00 00 00 
ffff8000001081a7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001081ab:	48 89 c2             	mov    %rax,%rdx
ffff8000001081ae:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001081b3:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff8000001081b8:	49 89 df             	mov    %rbx,%r15
ffff8000001081bb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001081c0:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff8000001081c7:	ff ff ff 
ffff8000001081ca:	49 01 da             	add    %rbx,%r10
ffff8000001081cd:	41 ff d2             	call   *%r10
ffff8000001081d0:	48 b8 60 5f 01 00 00 	movabs $0x15f60,%rax
ffff8000001081d7:	00 00 00 
ffff8000001081da:	c7 04 03 00 00 00 00 	movl   $0x0,(%rbx,%rax,1)
ffff8000001081e1:	48 b8 64 5f 01 00 00 	movabs $0x15f64,%rax
ffff8000001081e8:	00 00 00 
ffff8000001081eb:	c7 04 03 00 00 00 00 	movl   $0x0,(%rbx,%rax,1)
ffff8000001081f2:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%rbp)
ffff8000001081f9:	e9 c4 00 00 00       	jmp    ffff8000001082c2 <init_memory+0xd60>
ffff8000001081fe:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108205:	ff ff ff 
ffff800000108208:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010820c:	48 8b 88 b8 02 00 00 	mov    0x2b8(%rax),%rcx
ffff800000108213:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff800000108216:	48 63 d0             	movslq %eax,%rdx
ffff800000108219:	48 89 d0             	mov    %rdx,%rax
ffff80000010821c:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000108220:	48 01 d0             	add    %rdx,%rax
ffff800000108223:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000108227:	48 01 c8             	add    %rcx,%rax
ffff80000010822a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010822e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000108232:	48 8b 48 08          	mov    0x8(%rax),%rcx
ffff800000108236:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010823a:	48 8b 10             	mov    (%rax),%rdx
ffff80000010823d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000108241:	48 8b 78 20          	mov    0x20(%rax),%rdi
ffff800000108245:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000108249:	48 8b 70 18          	mov    0x18(%rax),%rsi
ffff80000010824d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000108251:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000108255:	51                   	push   %rcx
ffff800000108256:	52                   	push   %rdx
ffff800000108257:	49 89 f9             	mov    %rdi,%r9
ffff80000010825a:	49 89 f0             	mov    %rsi,%r8
ffff80000010825d:	48 89 c1             	mov    %rax,%rcx
ffff800000108260:	48 b8 60 1d 00 00 00 	movabs $0x1d60,%rax
ffff800000108267:	00 00 00 
ffff80000010826a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010826e:	48 89 c2             	mov    %rax,%rdx
ffff800000108271:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108276:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff80000010827b:	49 89 df             	mov    %rbx,%r15
ffff80000010827e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108283:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff80000010828a:	ff ff ff 
ffff80000010828d:	49 01 da             	add    %rbx,%r10
ffff800000108290:	41 ff d2             	call   *%r10
ffff800000108293:	48 83 c4 10          	add    $0x10,%rsp
ffff800000108297:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010829b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010829f:	48 ba 00 00 00 00 01 	movabs $0x100000000,%rdx
ffff8000001082a6:	00 00 00 
ffff8000001082a9:	48 39 d0             	cmp    %rdx,%rax
ffff8000001082ac:	75 10                	jne    ffff8000001082be <init_memory+0xd5c>
ffff8000001082ae:	48 ba 68 5f 01 00 00 	movabs $0x15f68,%rdx
ffff8000001082b5:	00 00 00 
ffff8000001082b8:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001082bb:	89 04 13             	mov    %eax,(%rbx,%rdx,1)
ffff8000001082be:	83 45 90 01          	addl   $0x1,-0x70(%rbp)
ffff8000001082c2:	8b 45 90             	mov    -0x70(%rbp),%eax
ffff8000001082c5:	48 63 d0             	movslq %eax,%rdx
ffff8000001082c8:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001082cf:	ff ff ff 
ffff8000001082d2:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001082d6:	48 8b 80 c0 02 00 00 	mov    0x2c0(%rax),%rax
ffff8000001082dd:	48 39 c2             	cmp    %rax,%rdx
ffff8000001082e0:	0f 82 18 ff ff ff    	jb     ffff8000001081fe <init_memory+0xc9c>
ffff8000001082e6:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001082ed:	ff ff ff 
ffff8000001082f0:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001082f4:	48 8b 80 b8 02 00 00 	mov    0x2b8(%rax),%rax
ffff8000001082fb:	48 89 c2             	mov    %rax,%rdx
ffff8000001082fe:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108305:	ff ff ff 
ffff800000108308:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010830c:	48 8b 80 c8 02 00 00 	mov    0x2c8(%rax),%rax
ffff800000108313:	48 01 d0             	add    %rdx,%rax
ffff800000108316:	48 05 00 01 00 00    	add    $0x100,%rax
ffff80000010831c:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff800000108320:	48 89 c2             	mov    %rax,%rdx
ffff800000108323:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010832a:	ff ff ff 
ffff80000010832d:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108331:	48 89 90 f0 02 00 00 	mov    %rdx,0x2f0(%rax)
ffff800000108338:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010833f:	ff ff ff 
ffff800000108342:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108346:	48 8b 88 f0 02 00 00 	mov    0x2f0(%rax),%rcx
ffff80000010834d:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108354:	ff ff ff 
ffff800000108357:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010835b:	48 8b 90 e8 02 00 00 	mov    0x2e8(%rax),%rdx
ffff800000108362:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108369:	ff ff ff 
ffff80000010836c:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108370:	48 8b b8 e0 02 00 00 	mov    0x2e0(%rax),%rdi
ffff800000108377:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010837e:	ff ff ff 
ffff800000108381:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108385:	48 8b b0 d8 02 00 00 	mov    0x2d8(%rax),%rsi
ffff80000010838c:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108393:	ff ff ff 
ffff800000108396:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010839a:	48 8b 80 d0 02 00 00 	mov    0x2d0(%rax),%rax
ffff8000001083a1:	51                   	push   %rcx
ffff8000001083a2:	52                   	push   %rdx
ffff8000001083a3:	49 89 f9             	mov    %rdi,%r9
ffff8000001083a6:	49 89 f0             	mov    %rsi,%r8
ffff8000001083a9:	48 89 c1             	mov    %rax,%rcx
ffff8000001083ac:	48 b8 d8 1d 00 00 00 	movabs $0x1dd8,%rax
ffff8000001083b3:	00 00 00 
ffff8000001083b6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001083ba:	48 89 c2             	mov    %rax,%rdx
ffff8000001083bd:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001083c2:	bf 00 80 ff 00       	mov    $0xff8000,%edi
ffff8000001083c7:	49 89 df             	mov    %rbx,%r15
ffff8000001083ca:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001083cf:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff8000001083d6:	ff ff ff 
ffff8000001083d9:	49 01 da             	add    %rbx,%r10
ffff8000001083dc:	41 ff d2             	call   *%r10
ffff8000001083df:	48 83 c4 10          	add    $0x10,%rsp
ffff8000001083e3:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001083ea:	ff ff ff 
ffff8000001083ed:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001083f1:	48 8b 80 f0 02 00 00 	mov    0x2f0(%rax),%rax
ffff8000001083f8:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001083ff:	80 00 00 
ffff800000108402:	48 01 d0             	add    %rdx,%rax
ffff800000108405:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000108409:	89 45 90             	mov    %eax,-0x70(%rbp)
ffff80000010840c:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%rbp)
ffff800000108413:	eb 48                	jmp    ffff80000010845d <init_memory+0xefb>
ffff800000108415:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010841c:	ff ff ff 
ffff80000010841f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108423:	48 8b 88 a0 02 00 00 	mov    0x2a0(%rax),%rcx
ffff80000010842a:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff80000010842d:	48 63 d0             	movslq %eax,%rdx
ffff800000108430:	48 89 d0             	mov    %rdx,%rax
ffff800000108433:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000108437:	48 01 d0             	add    %rdx,%rax
ffff80000010843a:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010843e:	48 01 c8             	add    %rcx,%rax
ffff800000108441:	be 93 00 00 00       	mov    $0x93,%esi
ffff800000108446:	48 89 c7             	mov    %rax,%rdi
ffff800000108449:	48 b8 83 58 ff ff ff 	movabs $0xffffffffffff5883,%rax
ffff800000108450:	ff ff ff 
ffff800000108453:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000108457:	ff d0                	call   *%rax
ffff800000108459:	83 45 94 01          	addl   $0x1,-0x6c(%rbp)
ffff80000010845d:	8b 45 94             	mov    -0x6c(%rbp),%eax
ffff800000108460:	3b 45 90             	cmp    -0x70(%rbp),%eax
ffff800000108463:	7e b0                	jle    ffff800000108415 <init_memory+0xeb3>
ffff800000108465:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010846a:	48 ba 69 44 ff ff ff 	movabs $0xffffffffffff4469,%rdx
ffff800000108471:	ff ff ff 
ffff800000108474:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000108478:	ff d2                	call   *%rdx
ffff80000010847a:	48 ba 58 5f 01 00 00 	movabs $0x15f58,%rdx
ffff800000108481:	00 00 00 
ffff800000108484:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
ffff800000108488:	48 b8 58 5f 01 00 00 	movabs $0x15f58,%rax
ffff80000010848f:	00 00 00 
ffff800000108492:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108496:	48 89 c1             	mov    %rax,%rcx
ffff800000108499:	48 b8 34 1e 00 00 00 	movabs $0x1e34,%rax
ffff8000001084a0:	00 00 00 
ffff8000001084a3:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001084a7:	48 89 c2             	mov    %rax,%rdx
ffff8000001084aa:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001084af:	bf ff ff 00 00       	mov    $0xffff,%edi
ffff8000001084b4:	49 89 df             	mov    %rbx,%r15
ffff8000001084b7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001084bc:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff8000001084c3:	ff ff ff 
ffff8000001084c6:	49 01 d8             	add    %rbx,%r8
ffff8000001084c9:	41 ff d0             	call   *%r8
ffff8000001084cc:	48 b8 58 5f 01 00 00 	movabs $0x15f58,%rax
ffff8000001084d3:	00 00 00 
ffff8000001084d6:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001084da:	48 89 c2             	mov    %rax,%rdx
ffff8000001084dd:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff8000001084e4:	80 ff ff 
ffff8000001084e7:	48 01 d0             	add    %rdx,%rax
ffff8000001084ea:	48 8b 00             	mov    (%rax),%rax
ffff8000001084ed:	b0 00                	mov    $0x0,%al
ffff8000001084ef:	48 89 c1             	mov    %rax,%rcx
ffff8000001084f2:	48 b8 49 1e 00 00 00 	movabs $0x1e49,%rax
ffff8000001084f9:	00 00 00 
ffff8000001084fc:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000108500:	48 89 c2             	mov    %rax,%rdx
ffff800000108503:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108508:	bf ff ff 00 00       	mov    $0xffff,%edi
ffff80000010850d:	49 89 df             	mov    %rbx,%r15
ffff800000108510:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108515:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010851c:	ff ff ff 
ffff80000010851f:	49 01 d8             	add    %rbx,%r8
ffff800000108522:	41 ff d0             	call   *%r8
ffff800000108525:	48 b8 58 5f 01 00 00 	movabs $0x15f58,%rax
ffff80000010852c:	00 00 00 
ffff80000010852f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108533:	48 89 c2             	mov    %rax,%rdx
ffff800000108536:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010853d:	80 ff ff 
ffff800000108540:	48 01 d0             	add    %rdx,%rax
ffff800000108543:	48 8b 00             	mov    (%rax),%rax
ffff800000108546:	b0 00                	mov    $0x0,%al
ffff800000108548:	48 89 c2             	mov    %rax,%rdx
ffff80000010854b:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000108552:	80 ff ff 
ffff800000108555:	48 01 d0             	add    %rdx,%rax
ffff800000108558:	48 8b 00             	mov    (%rax),%rax
ffff80000010855b:	b0 00                	mov    $0x0,%al
ffff80000010855d:	48 89 c1             	mov    %rax,%rcx
ffff800000108560:	48 b8 5f 1e 00 00 00 	movabs $0x1e5f,%rax
ffff800000108567:	00 00 00 
ffff80000010856a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010856e:	48 89 c2             	mov    %rax,%rdx
ffff800000108571:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108576:	bf ff 00 80 00       	mov    $0x8000ff,%edi
ffff80000010857b:	49 89 df             	mov    %rbx,%r15
ffff80000010857e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108583:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010858a:	ff ff ff 
ffff80000010858d:	49 01 d8             	add    %rbx,%r8
ffff800000108590:	41 ff d0             	call   *%r8
ffff800000108593:	0f 20 d8             	mov    %cr3,%rax
ffff800000108596:	0f 22 d8             	mov    %rax,%cr3
ffff800000108599:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
ffff80000010859d:	90                   	nop
ffff80000010859e:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff8000001085a2:	5b                   	pop    %rbx
ffff8000001085a3:	41 5f                	pop    %r15
ffff8000001085a5:	5d                   	pop    %rbp
ffff8000001085a6:	c3                   	ret    

ffff8000001085a7 <alloc_pages>:
ffff8000001085a7:	f3 0f 1e fa          	endbr64 
ffff8000001085ab:	55                   	push   %rbp
ffff8000001085ac:	48 89 e5             	mov    %rsp,%rbp
ffff8000001085af:	41 57                	push   %r15
ffff8000001085b1:	53                   	push   %rbx
ffff8000001085b2:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
ffff8000001085b6:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff8000001085b6 <alloc_pages+0xf>
ffff8000001085bd:	49 bb 1a ab 00 00 00 	movabs $0xab1a,%r11
ffff8000001085c4:	00 00 00 
ffff8000001085c7:	4c 01 db             	add    %r11,%rbx
ffff8000001085ca:	89 bd 7c ff ff ff    	mov    %edi,-0x84(%rbp)
ffff8000001085d0:	89 b5 78 ff ff ff    	mov    %esi,-0x88(%rbp)
ffff8000001085d6:	48 89 95 70 ff ff ff 	mov    %rdx,-0x90(%rbp)
ffff8000001085dd:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
ffff8000001085e4:	00 
ffff8000001085e5:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%rbp)
ffff8000001085ec:	c7 45 8c 00 00 00 00 	movl   $0x0,-0x74(%rbp)
ffff8000001085f3:	83 bd 7c ff ff ff 04 	cmpl   $0x4,-0x84(%rbp)
ffff8000001085fa:	74 5b                	je     ffff800000108657 <alloc_pages+0xb0>
ffff8000001085fc:	83 bd 7c ff ff ff 04 	cmpl   $0x4,-0x84(%rbp)
ffff800000108603:	7f 7f                	jg     ffff800000108684 <alloc_pages+0xdd>
ffff800000108605:	83 bd 7c ff ff ff 01 	cmpl   $0x1,-0x84(%rbp)
ffff80000010860c:	74 0b                	je     ffff800000108619 <alloc_pages+0x72>
ffff80000010860e:	83 bd 7c ff ff ff 02 	cmpl   $0x2,-0x84(%rbp)
ffff800000108615:	74 1e                	je     ffff800000108635 <alloc_pages+0x8e>
ffff800000108617:	eb 6b                	jmp    ffff800000108684 <alloc_pages+0xdd>
ffff800000108619:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%rbp)
ffff800000108620:	48 b8 60 5f 01 00 00 	movabs $0x15f60,%rax
ffff800000108627:	00 00 00 
ffff80000010862a:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff80000010862d:	89 45 8c             	mov    %eax,-0x74(%rbp)
ffff800000108630:	e9 8b 00 00 00       	jmp    ffff8000001086c0 <alloc_pages+0x119>
ffff800000108635:	48 b8 60 5f 01 00 00 	movabs $0x15f60,%rax
ffff80000010863c:	00 00 00 
ffff80000010863f:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff800000108642:	89 45 88             	mov    %eax,-0x78(%rbp)
ffff800000108645:	48 b8 64 5f 01 00 00 	movabs $0x15f64,%rax
ffff80000010864c:	00 00 00 
ffff80000010864f:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff800000108652:	89 45 8c             	mov    %eax,-0x74(%rbp)
ffff800000108655:	eb 69                	jmp    ffff8000001086c0 <alloc_pages+0x119>
ffff800000108657:	48 b8 68 5f 01 00 00 	movabs $0x15f68,%rax
ffff80000010865e:	00 00 00 
ffff800000108661:	8b 04 03             	mov    (%rbx,%rax,1),%eax
ffff800000108664:	89 45 88             	mov    %eax,-0x78(%rbp)
ffff800000108667:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010866e:	ff ff ff 
ffff800000108671:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108675:	48 8b 80 c0 02 00 00 	mov    0x2c0(%rax),%rax
ffff80000010867c:	83 e8 01             	sub    $0x1,%eax
ffff80000010867f:	89 45 8c             	mov    %eax,-0x74(%rbp)
ffff800000108682:	eb 3c                	jmp    ffff8000001086c0 <alloc_pages+0x119>
ffff800000108684:	48 b8 78 1e 00 00 00 	movabs $0x1e78,%rax
ffff80000010868b:	00 00 00 
ffff80000010868e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000108692:	48 89 c2             	mov    %rax,%rdx
ffff800000108695:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010869a:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010869f:	49 89 df             	mov    %rbx,%r15
ffff8000001086a2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001086a7:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001086ae:	ff ff ff 
ffff8000001086b1:	48 01 d9             	add    %rbx,%rcx
ffff8000001086b4:	ff d1                	call   *%rcx
ffff8000001086b6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001086bb:	e9 8a 02 00 00       	jmp    ffff80000010894a <alloc_pages+0x3a3>
ffff8000001086c0:	8b 45 88             	mov    -0x78(%rbp),%eax
ffff8000001086c3:	89 45 84             	mov    %eax,-0x7c(%rbp)
ffff8000001086c6:	e9 42 02 00 00       	jmp    ffff80000010890d <alloc_pages+0x366>
ffff8000001086cb:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff8000001086d2:	ff ff ff 
ffff8000001086d5:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff8000001086d9:	48 8b 88 b8 02 00 00 	mov    0x2b8(%rax),%rcx
ffff8000001086e0:	8b 45 84             	mov    -0x7c(%rbp),%eax
ffff8000001086e3:	48 63 d0             	movslq %eax,%rdx
ffff8000001086e6:	48 89 d0             	mov    %rdx,%rax
ffff8000001086e9:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001086ed:	48 01 d0             	add    %rdx,%rax
ffff8000001086f0:	48 c1 e0 04          	shl    $0x4,%rax
ffff8000001086f4:	48 01 c8             	add    %rcx,%rax
ffff8000001086f7:	48 8b 50 40          	mov    0x40(%rax),%rdx
ffff8000001086fb:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
ffff800000108701:	48 98                	cltq   
ffff800000108703:	48 39 c2             	cmp    %rax,%rdx
ffff800000108706:	0f 82 fc 01 00 00    	jb     ffff800000108908 <alloc_pages+0x361>
ffff80000010870c:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108713:	ff ff ff 
ffff800000108716:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010871a:	48 8b 88 b8 02 00 00 	mov    0x2b8(%rax),%rcx
ffff800000108721:	8b 45 84             	mov    -0x7c(%rbp),%eax
ffff800000108724:	48 63 d0             	movslq %eax,%rdx
ffff800000108727:	48 89 d0             	mov    %rdx,%rax
ffff80000010872a:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010872e:	48 01 d0             	add    %rdx,%rax
ffff800000108731:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000108735:	48 01 c8             	add    %rcx,%rax
ffff800000108738:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
ffff80000010873c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
ffff800000108740:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000108744:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000108748:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
ffff80000010874c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
ffff800000108750:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108754:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000108758:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010875c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
ffff800000108760:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000108764:	48 c1 e8 15          	shr    $0x15,%rax
ffff800000108768:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff80000010876c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000108770:	83 e0 3f             	and    $0x3f,%eax
ffff800000108773:	48 89 c2             	mov    %rax,%rdx
ffff800000108776:	b8 40 00 00 00       	mov    $0x40,%eax
ffff80000010877b:	48 29 d0             	sub    %rdx,%rax
ffff80000010877e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff800000108782:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000108786:	48 89 45 90          	mov    %rax,-0x70(%rbp)
ffff80000010878a:	e9 69 01 00 00       	jmp    ffff8000001088f8 <alloc_pages+0x351>
ffff80000010878f:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108796:	ff ff ff 
ffff800000108799:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010879d:	48 8b 90 88 02 00 00 	mov    0x288(%rax),%rdx
ffff8000001087a4:	48 8b 45 90          	mov    -0x70(%rbp),%rax
ffff8000001087a8:	48 c1 e8 06          	shr    $0x6,%rax
ffff8000001087ac:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001087b0:	48 01 d0             	add    %rdx,%rax
ffff8000001087b3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001087b7:	48 8b 45 90          	mov    -0x70(%rbp),%rax
ffff8000001087bb:	83 e0 3f             	and    $0x3f,%eax
ffff8000001087be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff8000001087c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001087c6:	48 89 45 98          	mov    %rax,-0x68(%rbp)
ffff8000001087ca:	e9 fb 00 00 00       	jmp    ffff8000001088ca <alloc_pages+0x323>
ffff8000001087cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001087d3:	48 8b 00             	mov    (%rax),%rax
ffff8000001087d6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
ffff8000001087da:	89 d1                	mov    %edx,%ecx
ffff8000001087dc:	48 d3 e8             	shr    %cl,%rax
ffff8000001087df:	48 89 c6             	mov    %rax,%rsi
ffff8000001087e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001087e6:	48 83 c0 08          	add    $0x8,%rax
ffff8000001087ea:	48 8b 10             	mov    (%rax),%rdx
ffff8000001087ed:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff8000001087f1:	89 c1                	mov    %eax,%ecx
ffff8000001087f3:	b8 40 00 00 00       	mov    $0x40,%eax
ffff8000001087f8:	29 c8                	sub    %ecx,%eax
ffff8000001087fa:	89 c1                	mov    %eax,%ecx
ffff8000001087fc:	48 d3 e2             	shl    %cl,%rdx
ffff8000001087ff:	48 89 d0             	mov    %rdx,%rax
ffff800000108802:	48 09 c6             	or     %rax,%rsi
ffff800000108805:	48 89 f2             	mov    %rsi,%rdx
ffff800000108808:	83 bd 78 ff ff ff 40 	cmpl   $0x40,-0x88(%rbp)
ffff80000010880f:	74 19                	je     ffff80000010882a <alloc_pages+0x283>
ffff800000108811:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
ffff800000108817:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010881c:	89 c1                	mov    %eax,%ecx
ffff80000010881e:	48 d3 e6             	shl    %cl,%rsi
ffff800000108821:	48 89 f0             	mov    %rsi,%rax
ffff800000108824:	48 83 e8 01          	sub    $0x1,%rax
ffff800000108828:	eb 07                	jmp    ffff800000108831 <alloc_pages+0x28a>
ffff80000010882a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000108831:	48 21 d0             	and    %rdx,%rax
ffff800000108834:	48 85 c0             	test   %rax,%rax
ffff800000108837:	0f 85 88 00 00 00    	jne    ffff8000001088c5 <alloc_pages+0x31e>
ffff80000010883d:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
ffff800000108841:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000108845:	48 01 d0             	add    %rdx,%rax
ffff800000108848:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010884c:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
ffff800000108850:	48 c7 45 a0 00 00 00 	movq   $0x0,-0x60(%rbp)
ffff800000108857:	00 
ffff800000108858:	eb 5b                	jmp    ffff8000001088b5 <alloc_pages+0x30e>
ffff80000010885a:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108861:	ff ff ff 
ffff800000108864:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000108868:	48 8b 88 a0 02 00 00 	mov    0x2a0(%rax),%rcx
ffff80000010886f:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
ffff800000108873:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
ffff800000108877:	48 01 c2             	add    %rax,%rdx
ffff80000010887a:	48 89 d0             	mov    %rdx,%rax
ffff80000010887d:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000108881:	48 01 d0             	add    %rdx,%rax
ffff800000108884:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000108888:	48 01 c8             	add    %rcx,%rax
ffff80000010888b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010888f:	48 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%rdx
ffff800000108896:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010889a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010889d:	48 89 c7             	mov    %rax,%rdi
ffff8000001088a0:	48 b8 83 58 ff ff ff 	movabs $0xffffffffffff5883,%rax
ffff8000001088a7:	ff ff ff 
ffff8000001088aa:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001088ae:	ff d0                	call   *%rax
ffff8000001088b0:	48 83 45 a0 01       	addq   $0x1,-0x60(%rbp)
ffff8000001088b5:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
ffff8000001088bb:	48 98                	cltq   
ffff8000001088bd:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
ffff8000001088c1:	72 97                	jb     ffff80000010885a <alloc_pages+0x2b3>
ffff8000001088c3:	eb 5b                	jmp    ffff800000108920 <alloc_pages+0x379>
ffff8000001088c5:	48 83 45 98 01       	addq   $0x1,-0x68(%rbp)
ffff8000001088ca:	b8 40 00 00 00       	mov    $0x40,%eax
ffff8000001088cf:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
ffff8000001088d3:	48 39 45 98          	cmp    %rax,-0x68(%rbp)
ffff8000001088d7:	0f 82 f2 fe ff ff    	jb     ffff8000001087cf <alloc_pages+0x228>
ffff8000001088dd:	48 8b 45 90          	mov    -0x70(%rbp),%rax
ffff8000001088e1:	83 e0 3f             	and    $0x3f,%eax
ffff8000001088e4:	48 85 c0             	test   %rax,%rax
ffff8000001088e7:	74 06                	je     ffff8000001088ef <alloc_pages+0x348>
ffff8000001088e9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001088ed:	eb 05                	jmp    ffff8000001088f4 <alloc_pages+0x34d>
ffff8000001088ef:	b8 40 00 00 00       	mov    $0x40,%eax
ffff8000001088f4:	48 01 45 90          	add    %rax,-0x70(%rbp)
ffff8000001088f8:	48 8b 45 90          	mov    -0x70(%rbp),%rax
ffff8000001088fc:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
ffff800000108900:	0f 86 89 fe ff ff    	jbe    ffff80000010878f <alloc_pages+0x1e8>
ffff800000108906:	eb 01                	jmp    ffff800000108909 <alloc_pages+0x362>
ffff800000108908:	90                   	nop
ffff800000108909:	83 45 84 01          	addl   $0x1,-0x7c(%rbp)
ffff80000010890d:	8b 45 84             	mov    -0x7c(%rbp),%eax
ffff800000108910:	3b 45 8c             	cmp    -0x74(%rbp),%eax
ffff800000108913:	0f 8e b2 fd ff ff    	jle    ffff8000001086cb <alloc_pages+0x124>
ffff800000108919:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010891e:	eb 2a                	jmp    ffff80000010894a <alloc_pages+0x3a3>
ffff800000108920:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000108927:	ff ff ff 
ffff80000010892a:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010892e:	48 8b 88 a0 02 00 00 	mov    0x2a0(%rax),%rcx
ffff800000108935:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
ffff800000108939:	48 89 d0             	mov    %rdx,%rax
ffff80000010893c:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000108940:	48 01 d0             	add    %rdx,%rax
ffff800000108943:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000108947:	48 01 c8             	add    %rcx,%rax
ffff80000010894a:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
ffff80000010894e:	5b                   	pop    %rbx
ffff80000010894f:	41 5f                	pop    %r15
ffff800000108951:	5d                   	pop    %rbp
ffff800000108952:	c3                   	ret    

ffff800000108953 <page_init>:
ffff800000108953:	f3 0f 1e fa          	endbr64 
ffff800000108957:	55                   	push   %rbp
ffff800000108958:	48 89 e5             	mov    %rsp,%rbp
ffff80000010895b:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010895b <page_init+0x8>
ffff800000108962:	49 bb 75 a7 00 00 00 	movabs $0xa775,%r11
ffff800000108969:	00 00 00 
ffff80000010896c:	4c 01 d8             	add    %r11,%rax
ffff80000010896f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108973:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000108977:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010897b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff80000010897f:	48 85 d2             	test   %rdx,%rdx
ffff800000108982:	0f 85 d6 00 00 00    	jne    ffff800000108a5e <page_init+0x10b>
ffff800000108988:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff80000010898f:	ff ff ff 
ffff800000108992:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108996:	48 8b 8a 88 02 00 00 	mov    0x288(%rdx),%rcx
ffff80000010899d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001089a1:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff8000001089a5:	48 c1 ea 1b          	shr    $0x1b,%rdx
ffff8000001089a9:	48 c1 e2 03          	shl    $0x3,%rdx
ffff8000001089ad:	48 01 ca             	add    %rcx,%rdx
ffff8000001089b0:	48 8b 32             	mov    (%rdx),%rsi
ffff8000001089b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001089b7:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff8000001089bb:	48 c1 ea 15          	shr    $0x15,%rdx
ffff8000001089bf:	83 e2 3f             	and    $0x3f,%edx
ffff8000001089c2:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001089c7:	89 d1                	mov    %edx,%ecx
ffff8000001089c9:	48 d3 e7             	shl    %cl,%rdi
ffff8000001089cc:	48 89 f9             	mov    %rdi,%rcx
ffff8000001089cf:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff8000001089d6:	ff ff ff 
ffff8000001089d9:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff8000001089dd:	48 8b 90 88 02 00 00 	mov    0x288(%rax),%rdx
ffff8000001089e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001089e8:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001089ec:	48 c1 e8 1b          	shr    $0x1b,%rax
ffff8000001089f0:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001089f4:	48 01 d0             	add    %rdx,%rax
ffff8000001089f7:	48 09 ce             	or     %rcx,%rsi
ffff8000001089fa:	48 89 f2             	mov    %rsi,%rdx
ffff8000001089fd:	48 89 10             	mov    %rdx,(%rax)
ffff800000108a00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a04:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108a08:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000108a0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a10:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108a14:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000108a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a1c:	48 89 50 18          	mov    %rdx,0x18(%rax)
ffff800000108a20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a24:	48 8b 00             	mov    (%rax),%rax
ffff800000108a27:	48 8b 50 38          	mov    0x38(%rax),%rdx
ffff800000108a2b:	48 83 c2 01          	add    $0x1,%rdx
ffff800000108a2f:	48 89 50 38          	mov    %rdx,0x38(%rax)
ffff800000108a33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a37:	48 8b 00             	mov    (%rax),%rax
ffff800000108a3a:	48 8b 50 40          	mov    0x40(%rax),%rdx
ffff800000108a3e:	48 83 ea 01          	sub    $0x1,%rdx
ffff800000108a42:	48 89 50 40          	mov    %rdx,0x40(%rax)
ffff800000108a46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a4a:	48 8b 00             	mov    (%rax),%rax
ffff800000108a4d:	48 8b 50 48          	mov    0x48(%rax),%rdx
ffff800000108a51:	48 83 c2 01          	add    $0x1,%rdx
ffff800000108a55:	48 89 50 48          	mov    %rdx,0x48(%rax)
ffff800000108a59:	e9 10 01 00 00       	jmp    ffff800000108b6e <page_init+0x21b>
ffff800000108a5e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108a62:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff800000108a66:	83 e2 04             	and    $0x4,%edx
ffff800000108a69:	48 85 d2             	test   %rdx,%rdx
ffff800000108a6c:	75 2e                	jne    ffff800000108a9c <page_init+0x149>
ffff800000108a6e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108a72:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff800000108a76:	81 e2 00 01 00 00    	and    $0x100,%edx
ffff800000108a7c:	48 85 d2             	test   %rdx,%rdx
ffff800000108a7f:	75 1b                	jne    ffff800000108a9c <page_init+0x149>
ffff800000108a81:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108a85:	83 e2 04             	and    $0x4,%edx
ffff800000108a88:	48 85 d2             	test   %rdx,%rdx
ffff800000108a8b:	75 0f                	jne    ffff800000108a9c <page_init+0x149>
ffff800000108a8d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108a91:	81 e2 00 01 00 00    	and    $0x100,%edx
ffff800000108a97:	48 85 d2             	test   %rdx,%rdx
ffff800000108a9a:	74 43                	je     ffff800000108adf <page_init+0x18c>
ffff800000108a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108aa0:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000108aa4:	48 0b 45 f0          	or     -0x10(%rbp),%rax
ffff800000108aa8:	48 89 c2             	mov    %rax,%rdx
ffff800000108aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108aaf:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000108ab3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ab7:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108abb:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000108abf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ac3:	48 89 50 18          	mov    %rdx,0x18(%rax)
ffff800000108ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108acb:	48 8b 00             	mov    (%rax),%rax
ffff800000108ace:	48 8b 50 48          	mov    0x48(%rax),%rdx
ffff800000108ad2:	48 83 c2 01          	add    $0x1,%rdx
ffff800000108ad6:	48 89 50 48          	mov    %rdx,0x48(%rax)
ffff800000108ada:	e9 8f 00 00 00       	jmp    ffff800000108b6e <page_init+0x21b>
ffff800000108adf:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000108ae6:	ff ff ff 
ffff800000108ae9:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108aed:	48 8b 8a 88 02 00 00 	mov    0x288(%rdx),%rcx
ffff800000108af4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108af8:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff800000108afc:	48 c1 ea 1b          	shr    $0x1b,%rdx
ffff800000108b00:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000108b04:	48 01 ca             	add    %rcx,%rdx
ffff800000108b07:	48 8b 32             	mov    (%rdx),%rsi
ffff800000108b0a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108b0e:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff800000108b12:	48 c1 ea 15          	shr    $0x15,%rdx
ffff800000108b16:	83 e2 3f             	and    $0x3f,%edx
ffff800000108b19:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108b1e:	89 d1                	mov    %edx,%ecx
ffff800000108b20:	48 d3 e7             	shl    %cl,%rdi
ffff800000108b23:	48 89 f9             	mov    %rdi,%rcx
ffff800000108b26:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000108b2d:	ff ff ff 
ffff800000108b30:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000108b34:	48 8b 90 88 02 00 00 	mov    0x288(%rax),%rdx
ffff800000108b3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b3f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000108b43:	48 c1 e8 1b          	shr    $0x1b,%rax
ffff800000108b47:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000108b4b:	48 01 d0             	add    %rdx,%rax
ffff800000108b4e:	48 09 ce             	or     %rcx,%rsi
ffff800000108b51:	48 89 f2             	mov    %rsi,%rdx
ffff800000108b54:	48 89 10             	mov    %rdx,(%rax)
ffff800000108b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b5b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000108b5f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
ffff800000108b63:	48 89 c2             	mov    %rax,%rdx
ffff800000108b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b6a:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000108b6e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b73:	5d                   	pop    %rbp
ffff800000108b74:	c3                   	ret    

ffff800000108b75 <page_clean>:
ffff800000108b75:	f3 0f 1e fa          	endbr64 
ffff800000108b79:	55                   	push   %rbp
ffff800000108b7a:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b7d:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000108b7d <page_clean+0x8>
ffff800000108b84:	49 bb 53 a5 00 00 00 	movabs $0xa553,%r11
ffff800000108b8b:	00 00 00 
ffff800000108b8e:	4c 01 d8             	add    %r11,%rax
ffff800000108b91:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108b95:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108b99:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff800000108b9d:	48 85 d2             	test   %rdx,%rdx
ffff800000108ba0:	75 11                	jne    ffff800000108bb3 <page_clean+0x3e>
ffff800000108ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ba6:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000108bad:	00 
ffff800000108bae:	e9 61 01 00 00       	jmp    ffff800000108d14 <page_clean+0x19f>
ffff800000108bb3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108bb7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff800000108bbb:	83 e2 04             	and    $0x4,%edx
ffff800000108bbe:	48 85 d2             	test   %rdx,%rdx
ffff800000108bc1:	75 13                	jne    ffff800000108bd6 <page_clean+0x61>
ffff800000108bc3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108bc7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffff800000108bcb:	81 e2 00 01 00 00    	and    $0x100,%edx
ffff800000108bd1:	48 85 d2             	test   %rdx,%rdx
ffff800000108bd4:	74 6f                	je     ffff800000108c45 <page_clean+0xd0>
ffff800000108bd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bda:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108bde:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
ffff800000108be2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108be6:	48 89 50 18          	mov    %rdx,0x18(%rax)
ffff800000108bea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bee:	48 8b 00             	mov    (%rax),%rax
ffff800000108bf1:	48 8b 50 48          	mov    0x48(%rax),%rdx
ffff800000108bf5:	48 83 ea 01          	sub    $0x1,%rdx
ffff800000108bf9:	48 89 50 48          	mov    %rdx,0x48(%rax)
ffff800000108bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c01:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108c05:	48 85 c0             	test   %rax,%rax
ffff800000108c08:	0f 85 06 01 00 00    	jne    ffff800000108d14 <page_clean+0x19f>
ffff800000108c0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c12:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000108c19:	00 
ffff800000108c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c1e:	48 8b 00             	mov    (%rax),%rax
ffff800000108c21:	48 8b 50 38          	mov    0x38(%rax),%rdx
ffff800000108c25:	48 83 ea 01          	sub    $0x1,%rdx
ffff800000108c29:	48 89 50 38          	mov    %rdx,0x38(%rax)
ffff800000108c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c31:	48 8b 00             	mov    (%rax),%rax
ffff800000108c34:	48 8b 50 40          	mov    0x40(%rax),%rdx
ffff800000108c38:	48 83 c2 01          	add    $0x1,%rdx
ffff800000108c3c:	48 89 50 40          	mov    %rdx,0x40(%rax)
ffff800000108c40:	e9 cf 00 00 00       	jmp    ffff800000108d14 <page_clean+0x19f>
ffff800000108c45:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000108c4c:	ff ff ff 
ffff800000108c4f:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108c53:	48 8b 8a 88 02 00 00 	mov    0x288(%rdx),%rcx
ffff800000108c5a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108c5e:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff800000108c62:	48 c1 ea 1b          	shr    $0x1b,%rdx
ffff800000108c66:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000108c6a:	48 01 ca             	add    %rcx,%rdx
ffff800000108c6d:	48 8b 32             	mov    (%rdx),%rsi
ffff800000108c70:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108c74:	48 8b 52 08          	mov    0x8(%rdx),%rdx
ffff800000108c78:	48 c1 ea 15          	shr    $0x15,%rdx
ffff800000108c7c:	83 e2 3f             	and    $0x3f,%edx
ffff800000108c7f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108c84:	89 d1                	mov    %edx,%ecx
ffff800000108c86:	48 d3 e7             	shl    %cl,%rdi
ffff800000108c89:	48 89 fa             	mov    %rdi,%rdx
ffff800000108c8c:	48 89 d1             	mov    %rdx,%rcx
ffff800000108c8f:	48 f7 d1             	not    %rcx
ffff800000108c92:	48 ba 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rdx
ffff800000108c99:	ff ff ff 
ffff800000108c9c:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000108ca0:	48 8b 90 88 02 00 00 	mov    0x288(%rax),%rdx
ffff800000108ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cab:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000108caf:	48 c1 e8 1b          	shr    $0x1b,%rax
ffff800000108cb3:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000108cb7:	48 01 d0             	add    %rdx,%rax
ffff800000108cba:	48 21 ce             	and    %rcx,%rsi
ffff800000108cbd:	48 89 f2             	mov    %rsi,%rdx
ffff800000108cc0:	48 89 10             	mov    %rdx,(%rax)
ffff800000108cc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cc7:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000108cce:	00 
ffff800000108ccf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cd3:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000108cda:	00 
ffff800000108cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cdf:	48 8b 00             	mov    (%rax),%rax
ffff800000108ce2:	48 8b 50 38          	mov    0x38(%rax),%rdx
ffff800000108ce6:	48 83 ea 01          	sub    $0x1,%rdx
ffff800000108cea:	48 89 50 38          	mov    %rdx,0x38(%rax)
ffff800000108cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cf2:	48 8b 00             	mov    (%rax),%rax
ffff800000108cf5:	48 8b 50 40          	mov    0x40(%rax),%rdx
ffff800000108cf9:	48 83 c2 01          	add    $0x1,%rdx
ffff800000108cfd:	48 89 50 40          	mov    %rdx,0x40(%rax)
ffff800000108d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d05:	48 8b 00             	mov    (%rax),%rax
ffff800000108d08:	48 8b 50 48          	mov    0x48(%rax),%rdx
ffff800000108d0c:	48 83 ea 01          	sub    $0x1,%rdx
ffff800000108d10:	48 89 50 48          	mov    %rdx,0x48(%rax)
ffff800000108d14:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108d19:	5d                   	pop    %rbp
ffff800000108d1a:	c3                   	ret    

ffff800000108d1b <io_in8>:
ffff800000108d1b:	f3 0f 1e fa          	endbr64 
ffff800000108d1f:	55                   	push   %rbp
ffff800000108d20:	48 89 e5             	mov    %rsp,%rbp
ffff800000108d23:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000108d23 <io_in8+0x8>
ffff800000108d2a:	49 bb ad a3 00 00 00 	movabs $0xa3ad,%r11
ffff800000108d31:	00 00 00 
ffff800000108d34:	4c 01 d8             	add    %r11,%rax
ffff800000108d37:	89 f8                	mov    %edi,%eax
ffff800000108d39:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff800000108d3d:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
ffff800000108d41:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000108d45:	89 c2                	mov    %eax,%edx
ffff800000108d47:	ec                   	in     (%dx),%al
ffff800000108d48:	0f ae f0             	mfence 
ffff800000108d4b:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff800000108d4e:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff800000108d52:	5d                   	pop    %rbp
ffff800000108d53:	c3                   	ret    

ffff800000108d54 <io_out8>:
ffff800000108d54:	f3 0f 1e fa          	endbr64 
ffff800000108d58:	55                   	push   %rbp
ffff800000108d59:	48 89 e5             	mov    %rsp,%rbp
ffff800000108d5c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000108d5c <io_out8+0x8>
ffff800000108d63:	49 bb 74 a3 00 00 00 	movabs $0xa374,%r11
ffff800000108d6a:	00 00 00 
ffff800000108d6d:	4c 01 d8             	add    %r11,%rax
ffff800000108d70:	89 f8                	mov    %edi,%eax
ffff800000108d72:	89 f2                	mov    %esi,%edx
ffff800000108d74:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
ffff800000108d78:	89 d0                	mov    %edx,%eax
ffff800000108d7a:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff800000108d7d:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000108d81:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000108d85:	ee                   	out    %al,(%dx)
ffff800000108d86:	0f ae f0             	mfence 
ffff800000108d89:	90                   	nop
ffff800000108d8a:	5d                   	pop    %rbp
ffff800000108d8b:	c3                   	ret    

ffff800000108d8c <set_intr_gate>:
ffff800000108d8c:	f3 0f 1e fa          	endbr64 
ffff800000108d90:	55                   	push   %rbp
ffff800000108d91:	48 89 e5             	mov    %rsp,%rbp
ffff800000108d94:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000108d94 <set_intr_gate+0x8>
ffff800000108d9b:	49 bb 3c a3 00 00 00 	movabs $0xa33c,%r11
ffff800000108da2:	00 00 00 
ffff800000108da5:	4c 01 d8             	add    %r11,%rax
ffff800000108da8:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108dab:	89 f1                	mov    %esi,%ecx
ffff800000108dad:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000108db1:	89 ca                	mov    %ecx,%edx
ffff800000108db3:	88 55 e8             	mov    %dl,-0x18(%rbp)
ffff800000108db6:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000108db9:	48 89 d1             	mov    %rdx,%rcx
ffff800000108dbc:	48 c1 e1 04          	shl    $0x4,%rcx
ffff800000108dc0:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000108dc7:	ff ff ff 
ffff800000108dca:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108dce:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
ffff800000108dd2:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000108dd5:	48 c1 e2 04          	shl    $0x4,%rdx
ffff800000108dd9:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000108ddd:	48 ba 48 ff ff ff ff 	movabs $0xffffffffffffff48,%rdx
ffff800000108de4:	ff ff ff 
ffff800000108de7:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000108deb:	48 8d 3c 01          	lea    (%rcx,%rax,1),%rdi
ffff800000108def:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108df3:	41 b8 00 00 08 00    	mov    $0x80000,%r8d
ffff800000108df9:	0f b6 4d e8          	movzbl -0x18(%rbp),%ecx
ffff800000108dfd:	48 89 c2             	mov    %rax,%rdx
ffff800000108e00:	44 89 c0             	mov    %r8d,%eax
ffff800000108e03:	66 89 d0             	mov    %dx,%ax
ffff800000108e06:	48 83 e1 07          	and    $0x7,%rcx
ffff800000108e0a:	48 81 c1 00 8e 00 00 	add    $0x8e00,%rcx
ffff800000108e11:	48 c1 e1 20          	shl    $0x20,%rcx
ffff800000108e15:	48 01 c8             	add    %rcx,%rax
ffff800000108e18:	48 31 c9             	xor    %rcx,%rcx
ffff800000108e1b:	89 d1                	mov    %edx,%ecx
ffff800000108e1d:	48 c1 e9 10          	shr    $0x10,%rcx
ffff800000108e21:	48 c1 e1 30          	shl    $0x30,%rcx
ffff800000108e25:	48 01 c8             	add    %rcx,%rax
ffff800000108e28:	48 89 06             	mov    %rax,(%rsi)
ffff800000108e2b:	48 c1 ea 20          	shr    $0x20,%rdx
ffff800000108e2f:	48 89 17             	mov    %rdx,(%rdi)
ffff800000108e32:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108e36:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
ffff800000108e3a:	90                   	nop
ffff800000108e3b:	5d                   	pop    %rbp
ffff800000108e3c:	c3                   	ret    
ffff800000108e3d:	f3 0f 1e fa          	endbr64 
ffff800000108e41:	55                   	push   %rbp
ffff800000108e42:	48 89 e5             	mov    %rsp,%rbp
ffff800000108e45:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000108e45 <set_intr_gate+0xb9>
ffff800000108e4c:	49 bb 8b a2 00 00 00 	movabs $0xa28b,%r11
ffff800000108e53:	00 00 00 
ffff800000108e56:	4c 01 d8             	add    %r11,%rax
ffff800000108e59:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108e5d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000108e61:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000108e65:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
ffff800000108e69:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
ffff800000108e6d:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
ffff800000108e71:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108e78:	ff ff ff 
ffff800000108e7b:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108e7f:	48 8d 52 04          	lea    0x4(%rdx),%rdx
ffff800000108e83:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000108e87:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108e8a:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108e91:	ff ff ff 
ffff800000108e94:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108e98:	48 8d 52 0c          	lea    0xc(%rdx),%rdx
ffff800000108e9c:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000108ea0:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108ea3:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108eaa:	ff ff ff 
ffff800000108ead:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108eb1:	48 8d 52 14          	lea    0x14(%rdx),%rdx
ffff800000108eb5:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108eb9:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108ebc:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108ec3:	ff ff ff 
ffff800000108ec6:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108eca:	48 8d 52 24          	lea    0x24(%rdx),%rdx
ffff800000108ece:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000108ed2:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108ed5:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108edc:	ff ff ff 
ffff800000108edf:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108ee3:	48 8d 52 2c          	lea    0x2c(%rdx),%rdx
ffff800000108ee7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000108eeb:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108eee:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108ef5:	ff ff ff 
ffff800000108ef8:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108efc:	48 8d 52 34          	lea    0x34(%rdx),%rdx
ffff800000108f00:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000108f04:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108f07:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108f0e:	ff ff ff 
ffff800000108f11:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108f15:	48 8d 52 3c          	lea    0x3c(%rdx),%rdx
ffff800000108f19:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
ffff800000108f1d:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108f20:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108f27:	ff ff ff 
ffff800000108f2a:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108f2e:	48 8d 52 44          	lea    0x44(%rdx),%rdx
ffff800000108f32:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
ffff800000108f36:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108f39:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108f40:	ff ff ff 
ffff800000108f43:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000108f47:	48 8d 52 4c          	lea    0x4c(%rdx),%rdx
ffff800000108f4b:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
ffff800000108f4f:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000108f52:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000108f59:	ff ff ff 
ffff800000108f5c:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000108f60:	48 8d 40 54          	lea    0x54(%rax),%rax
ffff800000108f64:	48 8b 55 28          	mov    0x28(%rbp),%rdx
ffff800000108f68:	48 89 10             	mov    %rdx,(%rax)
ffff800000108f6b:	90                   	nop
ffff800000108f6c:	5d                   	pop    %rbp
ffff800000108f6d:	c3                   	ret    

ffff800000108f6e <IRQ0x20_interrupt>:
ffff800000108f6e:	6a 00                	push   $0x0
ffff800000108f70:	fc                   	cld    
ffff800000108f71:	50                   	push   %rax
ffff800000108f72:	50                   	push   %rax
ffff800000108f73:	48 8c c0             	mov    %es,%rax
ffff800000108f76:	50                   	push   %rax
ffff800000108f77:	48 8c d8             	mov    %ds,%rax
ffff800000108f7a:	50                   	push   %rax
ffff800000108f7b:	48 31 c0             	xor    %rax,%rax
ffff800000108f7e:	55                   	push   %rbp
ffff800000108f7f:	57                   	push   %rdi
ffff800000108f80:	56                   	push   %rsi
ffff800000108f81:	52                   	push   %rdx
ffff800000108f82:	51                   	push   %rcx
ffff800000108f83:	53                   	push   %rbx
ffff800000108f84:	41 50                	push   %r8
ffff800000108f86:	41 51                	push   %r9
ffff800000108f88:	41 52                	push   %r10
ffff800000108f8a:	41 53                	push   %r11
ffff800000108f8c:	41 54                	push   %r12
ffff800000108f8e:	41 55                	push   %r13
ffff800000108f90:	41 56                	push   %r14
ffff800000108f92:	41 57                	push   %r15
ffff800000108f94:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000108f9b:	48 8e da             	mov    %rdx,%ds
ffff800000108f9e:	48 8e c2             	mov    %rdx,%es
ffff800000108fa1:	48 89 e7             	mov    %rsp,%rdi
ffff800000108fa4:	48 8d 05 7a b0 ff ff 	lea    -0x4f86(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000108fab:	50                   	push   %rax
ffff800000108fac:	48 c7 c6 20 00 00 00 	mov    $0x20,%rsi
ffff800000108fb3:	e9 50 08 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000108fb8 <IRQ0x21_interrupt>:
ffff800000108fb8:	6a 00                	push   $0x0
ffff800000108fba:	fc                   	cld    
ffff800000108fbb:	50                   	push   %rax
ffff800000108fbc:	50                   	push   %rax
ffff800000108fbd:	48 8c c0             	mov    %es,%rax
ffff800000108fc0:	50                   	push   %rax
ffff800000108fc1:	48 8c d8             	mov    %ds,%rax
ffff800000108fc4:	50                   	push   %rax
ffff800000108fc5:	48 31 c0             	xor    %rax,%rax
ffff800000108fc8:	55                   	push   %rbp
ffff800000108fc9:	57                   	push   %rdi
ffff800000108fca:	56                   	push   %rsi
ffff800000108fcb:	52                   	push   %rdx
ffff800000108fcc:	51                   	push   %rcx
ffff800000108fcd:	53                   	push   %rbx
ffff800000108fce:	41 50                	push   %r8
ffff800000108fd0:	41 51                	push   %r9
ffff800000108fd2:	41 52                	push   %r10
ffff800000108fd4:	41 53                	push   %r11
ffff800000108fd6:	41 54                	push   %r12
ffff800000108fd8:	41 55                	push   %r13
ffff800000108fda:	41 56                	push   %r14
ffff800000108fdc:	41 57                	push   %r15
ffff800000108fde:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000108fe5:	48 8e da             	mov    %rdx,%ds
ffff800000108fe8:	48 8e c2             	mov    %rdx,%es
ffff800000108feb:	48 89 e7             	mov    %rsp,%rdi
ffff800000108fee:	48 8d 05 30 b0 ff ff 	lea    -0x4fd0(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000108ff5:	50                   	push   %rax
ffff800000108ff6:	48 c7 c6 21 00 00 00 	mov    $0x21,%rsi
ffff800000108ffd:	e9 06 08 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109002 <IRQ0x22_interrupt>:
ffff800000109002:	6a 00                	push   $0x0
ffff800000109004:	fc                   	cld    
ffff800000109005:	50                   	push   %rax
ffff800000109006:	50                   	push   %rax
ffff800000109007:	48 8c c0             	mov    %es,%rax
ffff80000010900a:	50                   	push   %rax
ffff80000010900b:	48 8c d8             	mov    %ds,%rax
ffff80000010900e:	50                   	push   %rax
ffff80000010900f:	48 31 c0             	xor    %rax,%rax
ffff800000109012:	55                   	push   %rbp
ffff800000109013:	57                   	push   %rdi
ffff800000109014:	56                   	push   %rsi
ffff800000109015:	52                   	push   %rdx
ffff800000109016:	51                   	push   %rcx
ffff800000109017:	53                   	push   %rbx
ffff800000109018:	41 50                	push   %r8
ffff80000010901a:	41 51                	push   %r9
ffff80000010901c:	41 52                	push   %r10
ffff80000010901e:	41 53                	push   %r11
ffff800000109020:	41 54                	push   %r12
ffff800000109022:	41 55                	push   %r13
ffff800000109024:	41 56                	push   %r14
ffff800000109026:	41 57                	push   %r15
ffff800000109028:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff80000010902f:	48 8e da             	mov    %rdx,%ds
ffff800000109032:	48 8e c2             	mov    %rdx,%es
ffff800000109035:	48 89 e7             	mov    %rsp,%rdi
ffff800000109038:	48 8d 05 e6 af ff ff 	lea    -0x501a(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff80000010903f:	50                   	push   %rax
ffff800000109040:	48 c7 c6 22 00 00 00 	mov    $0x22,%rsi
ffff800000109047:	e9 bc 07 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010904c <IRQ0x23_interrupt>:
ffff80000010904c:	6a 00                	push   $0x0
ffff80000010904e:	fc                   	cld    
ffff80000010904f:	50                   	push   %rax
ffff800000109050:	50                   	push   %rax
ffff800000109051:	48 8c c0             	mov    %es,%rax
ffff800000109054:	50                   	push   %rax
ffff800000109055:	48 8c d8             	mov    %ds,%rax
ffff800000109058:	50                   	push   %rax
ffff800000109059:	48 31 c0             	xor    %rax,%rax
ffff80000010905c:	55                   	push   %rbp
ffff80000010905d:	57                   	push   %rdi
ffff80000010905e:	56                   	push   %rsi
ffff80000010905f:	52                   	push   %rdx
ffff800000109060:	51                   	push   %rcx
ffff800000109061:	53                   	push   %rbx
ffff800000109062:	41 50                	push   %r8
ffff800000109064:	41 51                	push   %r9
ffff800000109066:	41 52                	push   %r10
ffff800000109068:	41 53                	push   %r11
ffff80000010906a:	41 54                	push   %r12
ffff80000010906c:	41 55                	push   %r13
ffff80000010906e:	41 56                	push   %r14
ffff800000109070:	41 57                	push   %r15
ffff800000109072:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109079:	48 8e da             	mov    %rdx,%ds
ffff80000010907c:	48 8e c2             	mov    %rdx,%es
ffff80000010907f:	48 89 e7             	mov    %rsp,%rdi
ffff800000109082:	48 8d 05 9c af ff ff 	lea    -0x5064(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109089:	50                   	push   %rax
ffff80000010908a:	48 c7 c6 23 00 00 00 	mov    $0x23,%rsi
ffff800000109091:	e9 72 07 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109096 <IRQ0x24_interrupt>:
ffff800000109096:	6a 00                	push   $0x0
ffff800000109098:	fc                   	cld    
ffff800000109099:	50                   	push   %rax
ffff80000010909a:	50                   	push   %rax
ffff80000010909b:	48 8c c0             	mov    %es,%rax
ffff80000010909e:	50                   	push   %rax
ffff80000010909f:	48 8c d8             	mov    %ds,%rax
ffff8000001090a2:	50                   	push   %rax
ffff8000001090a3:	48 31 c0             	xor    %rax,%rax
ffff8000001090a6:	55                   	push   %rbp
ffff8000001090a7:	57                   	push   %rdi
ffff8000001090a8:	56                   	push   %rsi
ffff8000001090a9:	52                   	push   %rdx
ffff8000001090aa:	51                   	push   %rcx
ffff8000001090ab:	53                   	push   %rbx
ffff8000001090ac:	41 50                	push   %r8
ffff8000001090ae:	41 51                	push   %r9
ffff8000001090b0:	41 52                	push   %r10
ffff8000001090b2:	41 53                	push   %r11
ffff8000001090b4:	41 54                	push   %r12
ffff8000001090b6:	41 55                	push   %r13
ffff8000001090b8:	41 56                	push   %r14
ffff8000001090ba:	41 57                	push   %r15
ffff8000001090bc:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001090c3:	48 8e da             	mov    %rdx,%ds
ffff8000001090c6:	48 8e c2             	mov    %rdx,%es
ffff8000001090c9:	48 89 e7             	mov    %rsp,%rdi
ffff8000001090cc:	48 8d 05 52 af ff ff 	lea    -0x50ae(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001090d3:	50                   	push   %rax
ffff8000001090d4:	48 c7 c6 24 00 00 00 	mov    $0x24,%rsi
ffff8000001090db:	e9 28 07 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001090e0 <IRQ0x25_interrupt>:
ffff8000001090e0:	6a 00                	push   $0x0
ffff8000001090e2:	fc                   	cld    
ffff8000001090e3:	50                   	push   %rax
ffff8000001090e4:	50                   	push   %rax
ffff8000001090e5:	48 8c c0             	mov    %es,%rax
ffff8000001090e8:	50                   	push   %rax
ffff8000001090e9:	48 8c d8             	mov    %ds,%rax
ffff8000001090ec:	50                   	push   %rax
ffff8000001090ed:	48 31 c0             	xor    %rax,%rax
ffff8000001090f0:	55                   	push   %rbp
ffff8000001090f1:	57                   	push   %rdi
ffff8000001090f2:	56                   	push   %rsi
ffff8000001090f3:	52                   	push   %rdx
ffff8000001090f4:	51                   	push   %rcx
ffff8000001090f5:	53                   	push   %rbx
ffff8000001090f6:	41 50                	push   %r8
ffff8000001090f8:	41 51                	push   %r9
ffff8000001090fa:	41 52                	push   %r10
ffff8000001090fc:	41 53                	push   %r11
ffff8000001090fe:	41 54                	push   %r12
ffff800000109100:	41 55                	push   %r13
ffff800000109102:	41 56                	push   %r14
ffff800000109104:	41 57                	push   %r15
ffff800000109106:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff80000010910d:	48 8e da             	mov    %rdx,%ds
ffff800000109110:	48 8e c2             	mov    %rdx,%es
ffff800000109113:	48 89 e7             	mov    %rsp,%rdi
ffff800000109116:	48 8d 05 08 af ff ff 	lea    -0x50f8(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff80000010911d:	50                   	push   %rax
ffff80000010911e:	48 c7 c6 25 00 00 00 	mov    $0x25,%rsi
ffff800000109125:	e9 de 06 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010912a <IRQ0x26_interrupt>:
ffff80000010912a:	6a 00                	push   $0x0
ffff80000010912c:	fc                   	cld    
ffff80000010912d:	50                   	push   %rax
ffff80000010912e:	50                   	push   %rax
ffff80000010912f:	48 8c c0             	mov    %es,%rax
ffff800000109132:	50                   	push   %rax
ffff800000109133:	48 8c d8             	mov    %ds,%rax
ffff800000109136:	50                   	push   %rax
ffff800000109137:	48 31 c0             	xor    %rax,%rax
ffff80000010913a:	55                   	push   %rbp
ffff80000010913b:	57                   	push   %rdi
ffff80000010913c:	56                   	push   %rsi
ffff80000010913d:	52                   	push   %rdx
ffff80000010913e:	51                   	push   %rcx
ffff80000010913f:	53                   	push   %rbx
ffff800000109140:	41 50                	push   %r8
ffff800000109142:	41 51                	push   %r9
ffff800000109144:	41 52                	push   %r10
ffff800000109146:	41 53                	push   %r11
ffff800000109148:	41 54                	push   %r12
ffff80000010914a:	41 55                	push   %r13
ffff80000010914c:	41 56                	push   %r14
ffff80000010914e:	41 57                	push   %r15
ffff800000109150:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109157:	48 8e da             	mov    %rdx,%ds
ffff80000010915a:	48 8e c2             	mov    %rdx,%es
ffff80000010915d:	48 89 e7             	mov    %rsp,%rdi
ffff800000109160:	48 8d 05 be ae ff ff 	lea    -0x5142(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109167:	50                   	push   %rax
ffff800000109168:	48 c7 c6 26 00 00 00 	mov    $0x26,%rsi
ffff80000010916f:	e9 94 06 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109174 <IRQ0x27_interrupt>:
ffff800000109174:	6a 00                	push   $0x0
ffff800000109176:	fc                   	cld    
ffff800000109177:	50                   	push   %rax
ffff800000109178:	50                   	push   %rax
ffff800000109179:	48 8c c0             	mov    %es,%rax
ffff80000010917c:	50                   	push   %rax
ffff80000010917d:	48 8c d8             	mov    %ds,%rax
ffff800000109180:	50                   	push   %rax
ffff800000109181:	48 31 c0             	xor    %rax,%rax
ffff800000109184:	55                   	push   %rbp
ffff800000109185:	57                   	push   %rdi
ffff800000109186:	56                   	push   %rsi
ffff800000109187:	52                   	push   %rdx
ffff800000109188:	51                   	push   %rcx
ffff800000109189:	53                   	push   %rbx
ffff80000010918a:	41 50                	push   %r8
ffff80000010918c:	41 51                	push   %r9
ffff80000010918e:	41 52                	push   %r10
ffff800000109190:	41 53                	push   %r11
ffff800000109192:	41 54                	push   %r12
ffff800000109194:	41 55                	push   %r13
ffff800000109196:	41 56                	push   %r14
ffff800000109198:	41 57                	push   %r15
ffff80000010919a:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001091a1:	48 8e da             	mov    %rdx,%ds
ffff8000001091a4:	48 8e c2             	mov    %rdx,%es
ffff8000001091a7:	48 89 e7             	mov    %rsp,%rdi
ffff8000001091aa:	48 8d 05 74 ae ff ff 	lea    -0x518c(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001091b1:	50                   	push   %rax
ffff8000001091b2:	48 c7 c6 27 00 00 00 	mov    $0x27,%rsi
ffff8000001091b9:	e9 4a 06 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001091be <IRQ0x28_interrupt>:
ffff8000001091be:	6a 00                	push   $0x0
ffff8000001091c0:	fc                   	cld    
ffff8000001091c1:	50                   	push   %rax
ffff8000001091c2:	50                   	push   %rax
ffff8000001091c3:	48 8c c0             	mov    %es,%rax
ffff8000001091c6:	50                   	push   %rax
ffff8000001091c7:	48 8c d8             	mov    %ds,%rax
ffff8000001091ca:	50                   	push   %rax
ffff8000001091cb:	48 31 c0             	xor    %rax,%rax
ffff8000001091ce:	55                   	push   %rbp
ffff8000001091cf:	57                   	push   %rdi
ffff8000001091d0:	56                   	push   %rsi
ffff8000001091d1:	52                   	push   %rdx
ffff8000001091d2:	51                   	push   %rcx
ffff8000001091d3:	53                   	push   %rbx
ffff8000001091d4:	41 50                	push   %r8
ffff8000001091d6:	41 51                	push   %r9
ffff8000001091d8:	41 52                	push   %r10
ffff8000001091da:	41 53                	push   %r11
ffff8000001091dc:	41 54                	push   %r12
ffff8000001091de:	41 55                	push   %r13
ffff8000001091e0:	41 56                	push   %r14
ffff8000001091e2:	41 57                	push   %r15
ffff8000001091e4:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001091eb:	48 8e da             	mov    %rdx,%ds
ffff8000001091ee:	48 8e c2             	mov    %rdx,%es
ffff8000001091f1:	48 89 e7             	mov    %rsp,%rdi
ffff8000001091f4:	48 8d 05 2a ae ff ff 	lea    -0x51d6(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001091fb:	50                   	push   %rax
ffff8000001091fc:	48 c7 c6 28 00 00 00 	mov    $0x28,%rsi
ffff800000109203:	e9 00 06 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109208 <IRQ0x29_interrupt>:
ffff800000109208:	6a 00                	push   $0x0
ffff80000010920a:	fc                   	cld    
ffff80000010920b:	50                   	push   %rax
ffff80000010920c:	50                   	push   %rax
ffff80000010920d:	48 8c c0             	mov    %es,%rax
ffff800000109210:	50                   	push   %rax
ffff800000109211:	48 8c d8             	mov    %ds,%rax
ffff800000109214:	50                   	push   %rax
ffff800000109215:	48 31 c0             	xor    %rax,%rax
ffff800000109218:	55                   	push   %rbp
ffff800000109219:	57                   	push   %rdi
ffff80000010921a:	56                   	push   %rsi
ffff80000010921b:	52                   	push   %rdx
ffff80000010921c:	51                   	push   %rcx
ffff80000010921d:	53                   	push   %rbx
ffff80000010921e:	41 50                	push   %r8
ffff800000109220:	41 51                	push   %r9
ffff800000109222:	41 52                	push   %r10
ffff800000109224:	41 53                	push   %r11
ffff800000109226:	41 54                	push   %r12
ffff800000109228:	41 55                	push   %r13
ffff80000010922a:	41 56                	push   %r14
ffff80000010922c:	41 57                	push   %r15
ffff80000010922e:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109235:	48 8e da             	mov    %rdx,%ds
ffff800000109238:	48 8e c2             	mov    %rdx,%es
ffff80000010923b:	48 89 e7             	mov    %rsp,%rdi
ffff80000010923e:	48 8d 05 e0 ad ff ff 	lea    -0x5220(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109245:	50                   	push   %rax
ffff800000109246:	48 c7 c6 29 00 00 00 	mov    $0x29,%rsi
ffff80000010924d:	e9 b6 05 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109252 <IRQ0x2a_interrupt>:
ffff800000109252:	6a 00                	push   $0x0
ffff800000109254:	fc                   	cld    
ffff800000109255:	50                   	push   %rax
ffff800000109256:	50                   	push   %rax
ffff800000109257:	48 8c c0             	mov    %es,%rax
ffff80000010925a:	50                   	push   %rax
ffff80000010925b:	48 8c d8             	mov    %ds,%rax
ffff80000010925e:	50                   	push   %rax
ffff80000010925f:	48 31 c0             	xor    %rax,%rax
ffff800000109262:	55                   	push   %rbp
ffff800000109263:	57                   	push   %rdi
ffff800000109264:	56                   	push   %rsi
ffff800000109265:	52                   	push   %rdx
ffff800000109266:	51                   	push   %rcx
ffff800000109267:	53                   	push   %rbx
ffff800000109268:	41 50                	push   %r8
ffff80000010926a:	41 51                	push   %r9
ffff80000010926c:	41 52                	push   %r10
ffff80000010926e:	41 53                	push   %r11
ffff800000109270:	41 54                	push   %r12
ffff800000109272:	41 55                	push   %r13
ffff800000109274:	41 56                	push   %r14
ffff800000109276:	41 57                	push   %r15
ffff800000109278:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff80000010927f:	48 8e da             	mov    %rdx,%ds
ffff800000109282:	48 8e c2             	mov    %rdx,%es
ffff800000109285:	48 89 e7             	mov    %rsp,%rdi
ffff800000109288:	48 8d 05 96 ad ff ff 	lea    -0x526a(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff80000010928f:	50                   	push   %rax
ffff800000109290:	48 c7 c6 2a 00 00 00 	mov    $0x2a,%rsi
ffff800000109297:	e9 6c 05 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010929c <IRQ0x2b_interrupt>:
ffff80000010929c:	6a 00                	push   $0x0
ffff80000010929e:	fc                   	cld    
ffff80000010929f:	50                   	push   %rax
ffff8000001092a0:	50                   	push   %rax
ffff8000001092a1:	48 8c c0             	mov    %es,%rax
ffff8000001092a4:	50                   	push   %rax
ffff8000001092a5:	48 8c d8             	mov    %ds,%rax
ffff8000001092a8:	50                   	push   %rax
ffff8000001092a9:	48 31 c0             	xor    %rax,%rax
ffff8000001092ac:	55                   	push   %rbp
ffff8000001092ad:	57                   	push   %rdi
ffff8000001092ae:	56                   	push   %rsi
ffff8000001092af:	52                   	push   %rdx
ffff8000001092b0:	51                   	push   %rcx
ffff8000001092b1:	53                   	push   %rbx
ffff8000001092b2:	41 50                	push   %r8
ffff8000001092b4:	41 51                	push   %r9
ffff8000001092b6:	41 52                	push   %r10
ffff8000001092b8:	41 53                	push   %r11
ffff8000001092ba:	41 54                	push   %r12
ffff8000001092bc:	41 55                	push   %r13
ffff8000001092be:	41 56                	push   %r14
ffff8000001092c0:	41 57                	push   %r15
ffff8000001092c2:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001092c9:	48 8e da             	mov    %rdx,%ds
ffff8000001092cc:	48 8e c2             	mov    %rdx,%es
ffff8000001092cf:	48 89 e7             	mov    %rsp,%rdi
ffff8000001092d2:	48 8d 05 4c ad ff ff 	lea    -0x52b4(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001092d9:	50                   	push   %rax
ffff8000001092da:	48 c7 c6 2b 00 00 00 	mov    $0x2b,%rsi
ffff8000001092e1:	e9 22 05 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001092e6 <IRQ0x2c_interrupt>:
ffff8000001092e6:	6a 00                	push   $0x0
ffff8000001092e8:	fc                   	cld    
ffff8000001092e9:	50                   	push   %rax
ffff8000001092ea:	50                   	push   %rax
ffff8000001092eb:	48 8c c0             	mov    %es,%rax
ffff8000001092ee:	50                   	push   %rax
ffff8000001092ef:	48 8c d8             	mov    %ds,%rax
ffff8000001092f2:	50                   	push   %rax
ffff8000001092f3:	48 31 c0             	xor    %rax,%rax
ffff8000001092f6:	55                   	push   %rbp
ffff8000001092f7:	57                   	push   %rdi
ffff8000001092f8:	56                   	push   %rsi
ffff8000001092f9:	52                   	push   %rdx
ffff8000001092fa:	51                   	push   %rcx
ffff8000001092fb:	53                   	push   %rbx
ffff8000001092fc:	41 50                	push   %r8
ffff8000001092fe:	41 51                	push   %r9
ffff800000109300:	41 52                	push   %r10
ffff800000109302:	41 53                	push   %r11
ffff800000109304:	41 54                	push   %r12
ffff800000109306:	41 55                	push   %r13
ffff800000109308:	41 56                	push   %r14
ffff80000010930a:	41 57                	push   %r15
ffff80000010930c:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109313:	48 8e da             	mov    %rdx,%ds
ffff800000109316:	48 8e c2             	mov    %rdx,%es
ffff800000109319:	48 89 e7             	mov    %rsp,%rdi
ffff80000010931c:	48 8d 05 02 ad ff ff 	lea    -0x52fe(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109323:	50                   	push   %rax
ffff800000109324:	48 c7 c6 2c 00 00 00 	mov    $0x2c,%rsi
ffff80000010932b:	e9 d8 04 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109330 <IRQ0x2d_interrupt>:
ffff800000109330:	6a 00                	push   $0x0
ffff800000109332:	fc                   	cld    
ffff800000109333:	50                   	push   %rax
ffff800000109334:	50                   	push   %rax
ffff800000109335:	48 8c c0             	mov    %es,%rax
ffff800000109338:	50                   	push   %rax
ffff800000109339:	48 8c d8             	mov    %ds,%rax
ffff80000010933c:	50                   	push   %rax
ffff80000010933d:	48 31 c0             	xor    %rax,%rax
ffff800000109340:	55                   	push   %rbp
ffff800000109341:	57                   	push   %rdi
ffff800000109342:	56                   	push   %rsi
ffff800000109343:	52                   	push   %rdx
ffff800000109344:	51                   	push   %rcx
ffff800000109345:	53                   	push   %rbx
ffff800000109346:	41 50                	push   %r8
ffff800000109348:	41 51                	push   %r9
ffff80000010934a:	41 52                	push   %r10
ffff80000010934c:	41 53                	push   %r11
ffff80000010934e:	41 54                	push   %r12
ffff800000109350:	41 55                	push   %r13
ffff800000109352:	41 56                	push   %r14
ffff800000109354:	41 57                	push   %r15
ffff800000109356:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff80000010935d:	48 8e da             	mov    %rdx,%ds
ffff800000109360:	48 8e c2             	mov    %rdx,%es
ffff800000109363:	48 89 e7             	mov    %rsp,%rdi
ffff800000109366:	48 8d 05 b8 ac ff ff 	lea    -0x5348(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff80000010936d:	50                   	push   %rax
ffff80000010936e:	48 c7 c6 2d 00 00 00 	mov    $0x2d,%rsi
ffff800000109375:	e9 8e 04 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010937a <IRQ0x2e_interrupt>:
ffff80000010937a:	6a 00                	push   $0x0
ffff80000010937c:	fc                   	cld    
ffff80000010937d:	50                   	push   %rax
ffff80000010937e:	50                   	push   %rax
ffff80000010937f:	48 8c c0             	mov    %es,%rax
ffff800000109382:	50                   	push   %rax
ffff800000109383:	48 8c d8             	mov    %ds,%rax
ffff800000109386:	50                   	push   %rax
ffff800000109387:	48 31 c0             	xor    %rax,%rax
ffff80000010938a:	55                   	push   %rbp
ffff80000010938b:	57                   	push   %rdi
ffff80000010938c:	56                   	push   %rsi
ffff80000010938d:	52                   	push   %rdx
ffff80000010938e:	51                   	push   %rcx
ffff80000010938f:	53                   	push   %rbx
ffff800000109390:	41 50                	push   %r8
ffff800000109392:	41 51                	push   %r9
ffff800000109394:	41 52                	push   %r10
ffff800000109396:	41 53                	push   %r11
ffff800000109398:	41 54                	push   %r12
ffff80000010939a:	41 55                	push   %r13
ffff80000010939c:	41 56                	push   %r14
ffff80000010939e:	41 57                	push   %r15
ffff8000001093a0:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001093a7:	48 8e da             	mov    %rdx,%ds
ffff8000001093aa:	48 8e c2             	mov    %rdx,%es
ffff8000001093ad:	48 89 e7             	mov    %rsp,%rdi
ffff8000001093b0:	48 8d 05 6e ac ff ff 	lea    -0x5392(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001093b7:	50                   	push   %rax
ffff8000001093b8:	48 c7 c6 2e 00 00 00 	mov    $0x2e,%rsi
ffff8000001093bf:	e9 44 04 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001093c4 <IRQ0x2f_interrupt>:
ffff8000001093c4:	6a 00                	push   $0x0
ffff8000001093c6:	fc                   	cld    
ffff8000001093c7:	50                   	push   %rax
ffff8000001093c8:	50                   	push   %rax
ffff8000001093c9:	48 8c c0             	mov    %es,%rax
ffff8000001093cc:	50                   	push   %rax
ffff8000001093cd:	48 8c d8             	mov    %ds,%rax
ffff8000001093d0:	50                   	push   %rax
ffff8000001093d1:	48 31 c0             	xor    %rax,%rax
ffff8000001093d4:	55                   	push   %rbp
ffff8000001093d5:	57                   	push   %rdi
ffff8000001093d6:	56                   	push   %rsi
ffff8000001093d7:	52                   	push   %rdx
ffff8000001093d8:	51                   	push   %rcx
ffff8000001093d9:	53                   	push   %rbx
ffff8000001093da:	41 50                	push   %r8
ffff8000001093dc:	41 51                	push   %r9
ffff8000001093de:	41 52                	push   %r10
ffff8000001093e0:	41 53                	push   %r11
ffff8000001093e2:	41 54                	push   %r12
ffff8000001093e4:	41 55                	push   %r13
ffff8000001093e6:	41 56                	push   %r14
ffff8000001093e8:	41 57                	push   %r15
ffff8000001093ea:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001093f1:	48 8e da             	mov    %rdx,%ds
ffff8000001093f4:	48 8e c2             	mov    %rdx,%es
ffff8000001093f7:	48 89 e7             	mov    %rsp,%rdi
ffff8000001093fa:	48 8d 05 24 ac ff ff 	lea    -0x53dc(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109401:	50                   	push   %rax
ffff800000109402:	48 c7 c6 2f 00 00 00 	mov    $0x2f,%rsi
ffff800000109409:	e9 fa 03 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010940e <IRQ0x30_interrupt>:
ffff80000010940e:	6a 00                	push   $0x0
ffff800000109410:	fc                   	cld    
ffff800000109411:	50                   	push   %rax
ffff800000109412:	50                   	push   %rax
ffff800000109413:	48 8c c0             	mov    %es,%rax
ffff800000109416:	50                   	push   %rax
ffff800000109417:	48 8c d8             	mov    %ds,%rax
ffff80000010941a:	50                   	push   %rax
ffff80000010941b:	48 31 c0             	xor    %rax,%rax
ffff80000010941e:	55                   	push   %rbp
ffff80000010941f:	57                   	push   %rdi
ffff800000109420:	56                   	push   %rsi
ffff800000109421:	52                   	push   %rdx
ffff800000109422:	51                   	push   %rcx
ffff800000109423:	53                   	push   %rbx
ffff800000109424:	41 50                	push   %r8
ffff800000109426:	41 51                	push   %r9
ffff800000109428:	41 52                	push   %r10
ffff80000010942a:	41 53                	push   %r11
ffff80000010942c:	41 54                	push   %r12
ffff80000010942e:	41 55                	push   %r13
ffff800000109430:	41 56                	push   %r14
ffff800000109432:	41 57                	push   %r15
ffff800000109434:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff80000010943b:	48 8e da             	mov    %rdx,%ds
ffff80000010943e:	48 8e c2             	mov    %rdx,%es
ffff800000109441:	48 89 e7             	mov    %rsp,%rdi
ffff800000109444:	48 8d 05 da ab ff ff 	lea    -0x5426(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff80000010944b:	50                   	push   %rax
ffff80000010944c:	48 c7 c6 30 00 00 00 	mov    $0x30,%rsi
ffff800000109453:	e9 b0 03 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109458 <IRQ0x31_interrupt>:
ffff800000109458:	6a 00                	push   $0x0
ffff80000010945a:	fc                   	cld    
ffff80000010945b:	50                   	push   %rax
ffff80000010945c:	50                   	push   %rax
ffff80000010945d:	48 8c c0             	mov    %es,%rax
ffff800000109460:	50                   	push   %rax
ffff800000109461:	48 8c d8             	mov    %ds,%rax
ffff800000109464:	50                   	push   %rax
ffff800000109465:	48 31 c0             	xor    %rax,%rax
ffff800000109468:	55                   	push   %rbp
ffff800000109469:	57                   	push   %rdi
ffff80000010946a:	56                   	push   %rsi
ffff80000010946b:	52                   	push   %rdx
ffff80000010946c:	51                   	push   %rcx
ffff80000010946d:	53                   	push   %rbx
ffff80000010946e:	41 50                	push   %r8
ffff800000109470:	41 51                	push   %r9
ffff800000109472:	41 52                	push   %r10
ffff800000109474:	41 53                	push   %r11
ffff800000109476:	41 54                	push   %r12
ffff800000109478:	41 55                	push   %r13
ffff80000010947a:	41 56                	push   %r14
ffff80000010947c:	41 57                	push   %r15
ffff80000010947e:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109485:	48 8e da             	mov    %rdx,%ds
ffff800000109488:	48 8e c2             	mov    %rdx,%es
ffff80000010948b:	48 89 e7             	mov    %rsp,%rdi
ffff80000010948e:	48 8d 05 90 ab ff ff 	lea    -0x5470(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109495:	50                   	push   %rax
ffff800000109496:	48 c7 c6 31 00 00 00 	mov    $0x31,%rsi
ffff80000010949d:	e9 66 03 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001094a2 <IRQ0x32_interrupt>:
ffff8000001094a2:	6a 00                	push   $0x0
ffff8000001094a4:	fc                   	cld    
ffff8000001094a5:	50                   	push   %rax
ffff8000001094a6:	50                   	push   %rax
ffff8000001094a7:	48 8c c0             	mov    %es,%rax
ffff8000001094aa:	50                   	push   %rax
ffff8000001094ab:	48 8c d8             	mov    %ds,%rax
ffff8000001094ae:	50                   	push   %rax
ffff8000001094af:	48 31 c0             	xor    %rax,%rax
ffff8000001094b2:	55                   	push   %rbp
ffff8000001094b3:	57                   	push   %rdi
ffff8000001094b4:	56                   	push   %rsi
ffff8000001094b5:	52                   	push   %rdx
ffff8000001094b6:	51                   	push   %rcx
ffff8000001094b7:	53                   	push   %rbx
ffff8000001094b8:	41 50                	push   %r8
ffff8000001094ba:	41 51                	push   %r9
ffff8000001094bc:	41 52                	push   %r10
ffff8000001094be:	41 53                	push   %r11
ffff8000001094c0:	41 54                	push   %r12
ffff8000001094c2:	41 55                	push   %r13
ffff8000001094c4:	41 56                	push   %r14
ffff8000001094c6:	41 57                	push   %r15
ffff8000001094c8:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001094cf:	48 8e da             	mov    %rdx,%ds
ffff8000001094d2:	48 8e c2             	mov    %rdx,%es
ffff8000001094d5:	48 89 e7             	mov    %rsp,%rdi
ffff8000001094d8:	48 8d 05 46 ab ff ff 	lea    -0x54ba(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001094df:	50                   	push   %rax
ffff8000001094e0:	48 c7 c6 32 00 00 00 	mov    $0x32,%rsi
ffff8000001094e7:	e9 1c 03 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001094ec <IRQ0x33_interrupt>:
ffff8000001094ec:	6a 00                	push   $0x0
ffff8000001094ee:	fc                   	cld    
ffff8000001094ef:	50                   	push   %rax
ffff8000001094f0:	50                   	push   %rax
ffff8000001094f1:	48 8c c0             	mov    %es,%rax
ffff8000001094f4:	50                   	push   %rax
ffff8000001094f5:	48 8c d8             	mov    %ds,%rax
ffff8000001094f8:	50                   	push   %rax
ffff8000001094f9:	48 31 c0             	xor    %rax,%rax
ffff8000001094fc:	55                   	push   %rbp
ffff8000001094fd:	57                   	push   %rdi
ffff8000001094fe:	56                   	push   %rsi
ffff8000001094ff:	52                   	push   %rdx
ffff800000109500:	51                   	push   %rcx
ffff800000109501:	53                   	push   %rbx
ffff800000109502:	41 50                	push   %r8
ffff800000109504:	41 51                	push   %r9
ffff800000109506:	41 52                	push   %r10
ffff800000109508:	41 53                	push   %r11
ffff80000010950a:	41 54                	push   %r12
ffff80000010950c:	41 55                	push   %r13
ffff80000010950e:	41 56                	push   %r14
ffff800000109510:	41 57                	push   %r15
ffff800000109512:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109519:	48 8e da             	mov    %rdx,%ds
ffff80000010951c:	48 8e c2             	mov    %rdx,%es
ffff80000010951f:	48 89 e7             	mov    %rsp,%rdi
ffff800000109522:	48 8d 05 fc aa ff ff 	lea    -0x5504(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109529:	50                   	push   %rax
ffff80000010952a:	48 c7 c6 33 00 00 00 	mov    $0x33,%rsi
ffff800000109531:	e9 d2 02 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109536 <IRQ0x34_interrupt>:
ffff800000109536:	6a 00                	push   $0x0
ffff800000109538:	fc                   	cld    
ffff800000109539:	50                   	push   %rax
ffff80000010953a:	50                   	push   %rax
ffff80000010953b:	48 8c c0             	mov    %es,%rax
ffff80000010953e:	50                   	push   %rax
ffff80000010953f:	48 8c d8             	mov    %ds,%rax
ffff800000109542:	50                   	push   %rax
ffff800000109543:	48 31 c0             	xor    %rax,%rax
ffff800000109546:	55                   	push   %rbp
ffff800000109547:	57                   	push   %rdi
ffff800000109548:	56                   	push   %rsi
ffff800000109549:	52                   	push   %rdx
ffff80000010954a:	51                   	push   %rcx
ffff80000010954b:	53                   	push   %rbx
ffff80000010954c:	41 50                	push   %r8
ffff80000010954e:	41 51                	push   %r9
ffff800000109550:	41 52                	push   %r10
ffff800000109552:	41 53                	push   %r11
ffff800000109554:	41 54                	push   %r12
ffff800000109556:	41 55                	push   %r13
ffff800000109558:	41 56                	push   %r14
ffff80000010955a:	41 57                	push   %r15
ffff80000010955c:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109563:	48 8e da             	mov    %rdx,%ds
ffff800000109566:	48 8e c2             	mov    %rdx,%es
ffff800000109569:	48 89 e7             	mov    %rsp,%rdi
ffff80000010956c:	48 8d 05 b2 aa ff ff 	lea    -0x554e(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109573:	50                   	push   %rax
ffff800000109574:	48 c7 c6 34 00 00 00 	mov    $0x34,%rsi
ffff80000010957b:	e9 88 02 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109580 <IRQ0x35_interrupt>:
ffff800000109580:	6a 00                	push   $0x0
ffff800000109582:	fc                   	cld    
ffff800000109583:	50                   	push   %rax
ffff800000109584:	50                   	push   %rax
ffff800000109585:	48 8c c0             	mov    %es,%rax
ffff800000109588:	50                   	push   %rax
ffff800000109589:	48 8c d8             	mov    %ds,%rax
ffff80000010958c:	50                   	push   %rax
ffff80000010958d:	48 31 c0             	xor    %rax,%rax
ffff800000109590:	55                   	push   %rbp
ffff800000109591:	57                   	push   %rdi
ffff800000109592:	56                   	push   %rsi
ffff800000109593:	52                   	push   %rdx
ffff800000109594:	51                   	push   %rcx
ffff800000109595:	53                   	push   %rbx
ffff800000109596:	41 50                	push   %r8
ffff800000109598:	41 51                	push   %r9
ffff80000010959a:	41 52                	push   %r10
ffff80000010959c:	41 53                	push   %r11
ffff80000010959e:	41 54                	push   %r12
ffff8000001095a0:	41 55                	push   %r13
ffff8000001095a2:	41 56                	push   %r14
ffff8000001095a4:	41 57                	push   %r15
ffff8000001095a6:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001095ad:	48 8e da             	mov    %rdx,%ds
ffff8000001095b0:	48 8e c2             	mov    %rdx,%es
ffff8000001095b3:	48 89 e7             	mov    %rsp,%rdi
ffff8000001095b6:	48 8d 05 68 aa ff ff 	lea    -0x5598(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff8000001095bd:	50                   	push   %rax
ffff8000001095be:	48 c7 c6 35 00 00 00 	mov    $0x35,%rsi
ffff8000001095c5:	e9 3e 02 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff8000001095ca <IRQ0x36_interrupt>:
ffff8000001095ca:	6a 00                	push   $0x0
ffff8000001095cc:	fc                   	cld    
ffff8000001095cd:	50                   	push   %rax
ffff8000001095ce:	50                   	push   %rax
ffff8000001095cf:	48 8c c0             	mov    %es,%rax
ffff8000001095d2:	50                   	push   %rax
ffff8000001095d3:	48 8c d8             	mov    %ds,%rax
ffff8000001095d6:	50                   	push   %rax
ffff8000001095d7:	48 31 c0             	xor    %rax,%rax
ffff8000001095da:	55                   	push   %rbp
ffff8000001095db:	57                   	push   %rdi
ffff8000001095dc:	56                   	push   %rsi
ffff8000001095dd:	52                   	push   %rdx
ffff8000001095de:	51                   	push   %rcx
ffff8000001095df:	53                   	push   %rbx
ffff8000001095e0:	41 50                	push   %r8
ffff8000001095e2:	41 51                	push   %r9
ffff8000001095e4:	41 52                	push   %r10
ffff8000001095e6:	41 53                	push   %r11
ffff8000001095e8:	41 54                	push   %r12
ffff8000001095ea:	41 55                	push   %r13
ffff8000001095ec:	41 56                	push   %r14
ffff8000001095ee:	41 57                	push   %r15
ffff8000001095f0:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff8000001095f7:	48 8e da             	mov    %rdx,%ds
ffff8000001095fa:	48 8e c2             	mov    %rdx,%es
ffff8000001095fd:	48 89 e7             	mov    %rsp,%rdi
ffff800000109600:	48 8d 05 1e aa ff ff 	lea    -0x55e2(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109607:	50                   	push   %rax
ffff800000109608:	48 c7 c6 36 00 00 00 	mov    $0x36,%rsi
ffff80000010960f:	e9 f4 01 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff800000109614 <IRQ0x37_interrupt>:
ffff800000109614:	6a 00                	push   $0x0
ffff800000109616:	fc                   	cld    
ffff800000109617:	50                   	push   %rax
ffff800000109618:	50                   	push   %rax
ffff800000109619:	48 8c c0             	mov    %es,%rax
ffff80000010961c:	50                   	push   %rax
ffff80000010961d:	48 8c d8             	mov    %ds,%rax
ffff800000109620:	50                   	push   %rax
ffff800000109621:	48 31 c0             	xor    %rax,%rax
ffff800000109624:	55                   	push   %rbp
ffff800000109625:	57                   	push   %rdi
ffff800000109626:	56                   	push   %rsi
ffff800000109627:	52                   	push   %rdx
ffff800000109628:	51                   	push   %rcx
ffff800000109629:	53                   	push   %rbx
ffff80000010962a:	41 50                	push   %r8
ffff80000010962c:	41 51                	push   %r9
ffff80000010962e:	41 52                	push   %r10
ffff800000109630:	41 53                	push   %r11
ffff800000109632:	41 54                	push   %r12
ffff800000109634:	41 55                	push   %r13
ffff800000109636:	41 56                	push   %r14
ffff800000109638:	41 57                	push   %r15
ffff80000010963a:	48 c7 c2 10 00 00 00 	mov    $0x10,%rdx
ffff800000109641:	48 8e da             	mov    %rdx,%ds
ffff800000109644:	48 8e c2             	mov    %rdx,%es
ffff800000109647:	48 89 e7             	mov    %rsp,%rdi
ffff80000010964a:	48 8d 05 d4 a9 ff ff 	lea    -0x562c(%rip),%rax        # ffff800000104025 <ret_from_intr>
ffff800000109651:	50                   	push   %rax
ffff800000109652:	48 c7 c6 37 00 00 00 	mov    $0x37,%rsi
ffff800000109659:	e9 aa 01 00 00       	jmp    ffff800000109808 <do_IRQ>

ffff80000010965e <init_interrupt>:
ffff80000010965e:	f3 0f 1e fa          	endbr64 
ffff800000109662:	55                   	push   %rbp
ffff800000109663:	48 89 e5             	mov    %rsp,%rbp
ffff800000109666:	41 57                	push   %r15
ffff800000109668:	53                   	push   %rbx
ffff800000109669:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010966d:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010966d <init_interrupt+0xf>
ffff800000109674:	49 bb 63 9a 00 00 00 	movabs $0x9a63,%r11
ffff80000010967b:	00 00 00 
ffff80000010967e:	4c 01 db             	add    %r11,%rbx
ffff800000109681:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
ffff800000109688:	eb 37                	jmp    ffff8000001096c1 <init_interrupt+0x63>
ffff80000010968a:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010968d:	83 e8 20             	sub    $0x20,%eax
ffff800000109690:	48 ba b0 0f 00 00 00 	movabs $0xfb0,%rdx
ffff800000109697:	00 00 00 
ffff80000010969a:	48 98                	cltq   
ffff80000010969c:	48 01 da             	add    %rbx,%rdx
ffff80000010969f:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff8000001096a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001096a6:	be 02 00 00 00       	mov    $0x2,%esi
ffff8000001096ab:	89 c7                	mov    %eax,%edi
ffff8000001096ad:	48 b8 bc 5c ff ff ff 	movabs $0xffffffffffff5cbc,%rax
ffff8000001096b4:	ff ff ff 
ffff8000001096b7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001096bb:	ff d0                	call   *%rax
ffff8000001096bd:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff8000001096c1:	83 7d ec 37          	cmpl   $0x37,-0x14(%rbp)
ffff8000001096c5:	7e c3                	jle    ffff80000010968a <init_interrupt+0x2c>
ffff8000001096c7:	48 b8 9d 1e 00 00 00 	movabs $0x1e9d,%rax
ffff8000001096ce:	00 00 00 
ffff8000001096d1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001096d5:	48 89 c2             	mov    %rax,%rdx
ffff8000001096d8:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001096dd:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001096e2:	49 89 df             	mov    %rbx,%r15
ffff8000001096e5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001096ea:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff8000001096f1:	ff ff ff 
ffff8000001096f4:	48 01 d9             	add    %rbx,%rcx
ffff8000001096f7:	ff d1                	call   *%rcx
ffff8000001096f9:	be 11 00 00 00       	mov    $0x11,%esi
ffff8000001096fe:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000109703:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff80000010970a:	ff ff ff 
ffff80000010970d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109711:	ff d0                	call   *%rax
ffff800000109713:	be 20 00 00 00       	mov    $0x20,%esi
ffff800000109718:	bf 21 00 00 00       	mov    $0x21,%edi
ffff80000010971d:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff800000109724:	ff ff ff 
ffff800000109727:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010972b:	ff d0                	call   *%rax
ffff80000010972d:	be 04 00 00 00       	mov    $0x4,%esi
ffff800000109732:	bf 21 00 00 00       	mov    $0x21,%edi
ffff800000109737:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff80000010973e:	ff ff ff 
ffff800000109741:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109745:	ff d0                	call   *%rax
ffff800000109747:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010974c:	bf 21 00 00 00       	mov    $0x21,%edi
ffff800000109751:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff800000109758:	ff ff ff 
ffff80000010975b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010975f:	ff d0                	call   *%rax
ffff800000109761:	be 11 00 00 00       	mov    $0x11,%esi
ffff800000109766:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff80000010976b:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff800000109772:	ff ff ff 
ffff800000109775:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109779:	ff d0                	call   *%rax
ffff80000010977b:	be 28 00 00 00       	mov    $0x28,%esi
ffff800000109780:	bf a1 00 00 00       	mov    $0xa1,%edi
ffff800000109785:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff80000010978c:	ff ff ff 
ffff80000010978f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109793:	ff d0                	call   *%rax
ffff800000109795:	be 02 00 00 00       	mov    $0x2,%esi
ffff80000010979a:	bf a1 00 00 00       	mov    $0xa1,%edi
ffff80000010979f:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff8000001097a6:	ff ff ff 
ffff8000001097a9:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001097ad:	ff d0                	call   *%rax
ffff8000001097af:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001097b4:	bf a1 00 00 00       	mov    $0xa1,%edi
ffff8000001097b9:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff8000001097c0:	ff ff ff 
ffff8000001097c3:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001097c7:	ff d0                	call   *%rax
ffff8000001097c9:	be fd 00 00 00       	mov    $0xfd,%esi
ffff8000001097ce:	bf 21 00 00 00       	mov    $0x21,%edi
ffff8000001097d3:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff8000001097da:	ff ff ff 
ffff8000001097dd:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001097e1:	ff d0                	call   *%rax
ffff8000001097e3:	be ff 00 00 00       	mov    $0xff,%esi
ffff8000001097e8:	bf a1 00 00 00       	mov    $0xa1,%edi
ffff8000001097ed:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff8000001097f4:	ff ff ff 
ffff8000001097f7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001097fb:	ff d0                	call   *%rax
ffff8000001097fd:	fb                   	sti    
ffff8000001097fe:	90                   	nop
ffff8000001097ff:	48 83 c4 10          	add    $0x10,%rsp
ffff800000109803:	5b                   	pop    %rbx
ffff800000109804:	41 5f                	pop    %r15
ffff800000109806:	5d                   	pop    %rbp
ffff800000109807:	c3                   	ret    

ffff800000109808 <do_IRQ>:
ffff800000109808:	f3 0f 1e fa          	endbr64 
ffff80000010980c:	55                   	push   %rbp
ffff80000010980d:	48 89 e5             	mov    %rsp,%rbp
ffff800000109810:	41 57                	push   %r15
ffff800000109812:	53                   	push   %rbx
ffff800000109813:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000109817:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000109817 <do_IRQ+0xf>
ffff80000010981e:	49 bb b9 98 00 00 00 	movabs $0x98b9,%r11
ffff800000109825:	00 00 00 
ffff800000109828:	4c 01 db             	add    %r11,%rbx
ffff80000010982b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010982f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000109833:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109837:	48 89 c1             	mov    %rax,%rcx
ffff80000010983a:	48 b8 aa 1e 00 00 00 	movabs $0x1eaa,%rax
ffff800000109841:	00 00 00 
ffff800000109844:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109848:	48 89 c2             	mov    %rax,%rdx
ffff80000010984b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109850:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000109855:	49 89 df             	mov    %rbx,%r15
ffff800000109858:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010985d:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000109864:	ff ff ff 
ffff800000109867:	49 01 d8             	add    %rbx,%r8
ffff80000010986a:	41 ff d0             	call   *%r8
ffff80000010986d:	bf 60 00 00 00       	mov    $0x60,%edi
ffff800000109872:	48 b8 4b 5c ff ff ff 	movabs $0xffffffffffff5c4b,%rax
ffff800000109879:	ff ff ff 
ffff80000010987c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109880:	ff d0                	call   *%rax
ffff800000109882:	88 45 ef             	mov    %al,-0x11(%rbp)
ffff800000109885:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
ffff800000109889:	89 c1                	mov    %eax,%ecx
ffff80000010988b:	48 b8 b8 1e 00 00 00 	movabs $0x1eb8,%rax
ffff800000109892:	00 00 00 
ffff800000109895:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109899:	48 89 c2             	mov    %rax,%rdx
ffff80000010989c:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001098a1:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff8000001098a6:	49 89 df             	mov    %rbx,%r15
ffff8000001098a9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001098ae:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff8000001098b5:	ff ff ff 
ffff8000001098b8:	49 01 d8             	add    %rbx,%r8
ffff8000001098bb:	41 ff d0             	call   *%r8
ffff8000001098be:	be 20 00 00 00       	mov    $0x20,%esi
ffff8000001098c3:	bf 20 00 00 00       	mov    $0x20,%edi
ffff8000001098c8:	48 b8 84 5c ff ff ff 	movabs $0xffffffffffff5c84,%rax
ffff8000001098cf:	ff ff ff 
ffff8000001098d2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff8000001098d6:	ff d0                	call   *%rax
ffff8000001098d8:	90                   	nop
ffff8000001098d9:	48 83 c4 20          	add    $0x20,%rsp
ffff8000001098dd:	5b                   	pop    %rbx
ffff8000001098de:	41 5f                	pop    %r15
ffff8000001098e0:	5d                   	pop    %rbp
ffff8000001098e1:	c3                   	ret    

ffff8000001098e2 <list_init>:
ffff8000001098e2:	f3 0f 1e fa          	endbr64 
ffff8000001098e6:	55                   	push   %rbp
ffff8000001098e7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001098ea:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001098ea <list_init+0x8>
ffff8000001098f1:	49 bb e6 97 00 00 00 	movabs $0x97e6,%r11
ffff8000001098f8:	00 00 00 
ffff8000001098fb:	4c 01 d8             	add    %r11,%rax
ffff8000001098fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000109902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109906:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010990a:	48 89 10             	mov    %rdx,(%rax)
ffff80000010990d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109911:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109915:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff800000109919:	90                   	nop
ffff80000010991a:	5d                   	pop    %rbp
ffff80000010991b:	c3                   	ret    

ffff80000010991c <list_add_to_before>:
ffff80000010991c:	f3 0f 1e fa          	endbr64 
ffff800000109920:	55                   	push   %rbp
ffff800000109921:	48 89 e5             	mov    %rsp,%rbp
ffff800000109924:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109924 <list_add_to_before+0x8>
ffff80000010992b:	49 bb ac 97 00 00 00 	movabs $0x97ac,%r11
ffff800000109932:	00 00 00 
ffff800000109935:	4c 01 d8             	add    %r11,%rax
ffff800000109938:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010993c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000109940:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109944:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109948:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff80000010994c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109950:	48 8b 00             	mov    (%rax),%rax
ffff800000109953:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000109957:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff80000010995b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010995f:	48 8b 10             	mov    (%rax),%rdx
ffff800000109962:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109966:	48 89 10             	mov    %rdx,(%rax)
ffff800000109969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010996d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000109971:	48 89 10             	mov    %rdx,(%rax)
ffff800000109974:	90                   	nop
ffff800000109975:	5d                   	pop    %rbp
ffff800000109976:	c3                   	ret    

ffff800000109977 <list_next>:
ffff800000109977:	f3 0f 1e fa          	endbr64 
ffff80000010997b:	55                   	push   %rbp
ffff80000010997c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010997f:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010997f <list_next+0x8>
ffff800000109986:	49 bb 51 97 00 00 00 	movabs $0x9751,%r11
ffff80000010998d:	00 00 00 
ffff800000109990:	4c 01 d8             	add    %r11,%rax
ffff800000109993:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000109997:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010999b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010999f:	48 85 c0             	test   %rax,%rax
ffff8000001099a2:	74 0a                	je     ffff8000001099ae <list_next+0x37>
ffff8000001099a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099a8:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001099ac:	eb 05                	jmp    ffff8000001099b3 <list_next+0x3c>
ffff8000001099ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001099b3:	5d                   	pop    %rbp
ffff8000001099b4:	c3                   	ret    

ffff8000001099b5 <memcpy>:
ffff8000001099b5:	f3 0f 1e fa          	endbr64 
ffff8000001099b9:	55                   	push   %rbp
ffff8000001099ba:	48 89 e5             	mov    %rsp,%rbp
ffff8000001099bd:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff8000001099bd <memcpy+0x8>
ffff8000001099c4:	49 bb 13 97 00 00 00 	movabs $0x9713,%r11
ffff8000001099cb:	00 00 00 
ffff8000001099ce:	4c 01 d8             	add    %r11,%rax
ffff8000001099d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001099d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001099d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001099dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001099e1:	48 8d 50 07          	lea    0x7(%rax),%rdx
ffff8000001099e5:	48 85 c0             	test   %rax,%rax
ffff8000001099e8:	48 0f 48 c2          	cmovs  %rdx,%rax
ffff8000001099ec:	48 c1 f8 03          	sar    $0x3,%rax
ffff8000001099f0:	48 89 c1             	mov    %rax,%rcx
ffff8000001099f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001099f7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001099fb:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
ffff8000001099ff:	48 89 d7             	mov    %rdx,%rdi
ffff800000109a02:	fc                   	cld    
ffff800000109a03:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
ffff800000109a06:	a8 04                	test   $0x4,%al
ffff800000109a08:	74 01                	je     ffff800000109a0b <memcpy+0x56>
ffff800000109a0a:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
ffff800000109a0b:	a8 02                	test   $0x2,%al
ffff800000109a0d:	74 02                	je     ffff800000109a11 <memcpy+0x5c>
ffff800000109a0f:	66 a5                	movsw  %ds:(%rsi),%es:(%rdi)
ffff800000109a11:	a8 01                	test   $0x1,%al
ffff800000109a13:	74 01                	je     ffff800000109a16 <memcpy+0x61>
ffff800000109a15:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
ffff800000109a16:	89 f2                	mov    %esi,%edx
ffff800000109a18:	89 4d fc             	mov    %ecx,-0x4(%rbp)
ffff800000109a1b:	89 7d f8             	mov    %edi,-0x8(%rbp)
ffff800000109a1e:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff800000109a21:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109a25:	5d                   	pop    %rbp
ffff800000109a26:	c3                   	ret    

ffff800000109a27 <memset>:
ffff800000109a27:	f3 0f 1e fa          	endbr64 
ffff800000109a2b:	55                   	push   %rbp
ffff800000109a2c:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a2f:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109a2f <memset+0x8>
ffff800000109a36:	49 bb a1 96 00 00 00 	movabs $0x96a1,%r11
ffff800000109a3d:	00 00 00 
ffff800000109a40:	4c 01 d8             	add    %r11,%rax
ffff800000109a43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109a47:	89 f0                	mov    %esi,%eax
ffff800000109a49:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000109a4d:	88 45 e4             	mov    %al,-0x1c(%rbp)
ffff800000109a50:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
ffff800000109a54:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
ffff800000109a5b:	01 01 01 
ffff800000109a5e:	48 0f af c2          	imul   %rdx,%rax
ffff800000109a62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109a66:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109a6a:	48 8d 50 07          	lea    0x7(%rax),%rdx
ffff800000109a6e:	48 85 c0             	test   %rax,%rax
ffff800000109a71:	48 0f 48 c2          	cmovs  %rdx,%rax
ffff800000109a75:	48 c1 f8 03          	sar    $0x3,%rax
ffff800000109a79:	48 89 c1             	mov    %rax,%rcx
ffff800000109a7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109a80:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
ffff800000109a84:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000109a88:	48 89 d7             	mov    %rdx,%rdi
ffff800000109a8b:	fc                   	cld    
ffff800000109a8c:	f3 48 ab             	rep stos %rax,%es:(%rdi)
ffff800000109a8f:	40 f6 c6 04          	test   $0x4,%sil
ffff800000109a93:	74 01                	je     ffff800000109a96 <memset+0x6f>
ffff800000109a95:	ab                   	stos   %eax,%es:(%rdi)
ffff800000109a96:	40 f6 c6 02          	test   $0x2,%sil
ffff800000109a9a:	74 02                	je     ffff800000109a9e <memset+0x77>
ffff800000109a9c:	66 ab                	stos   %ax,%es:(%rdi)
ffff800000109a9e:	40 f6 c6 01          	test   $0x1,%sil
ffff800000109aa2:	74 01                	je     ffff800000109aa5 <memset+0x7e>
ffff800000109aa4:	aa                   	stos   %al,%es:(%rdi)
ffff800000109aa5:	89 f8                	mov    %edi,%eax
ffff800000109aa7:	89 ca                	mov    %ecx,%edx
ffff800000109aa9:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff800000109aac:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000109aaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ab3:	5d                   	pop    %rbp
ffff800000109ab4:	c3                   	ret    

ffff800000109ab5 <wrmsr>:
ffff800000109ab5:	f3 0f 1e fa          	endbr64 
ffff800000109ab9:	55                   	push   %rbp
ffff800000109aba:	48 89 e5             	mov    %rsp,%rbp
ffff800000109abd:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109abd <wrmsr+0x8>
ffff800000109ac4:	49 bb 13 96 00 00 00 	movabs $0x9613,%r11
ffff800000109acb:	00 00 00 
ffff800000109ace:	4c 01 d8             	add    %r11,%rax
ffff800000109ad1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000109ad5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000109ad9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109add:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109ae1:	48 89 c2             	mov    %rax,%rdx
ffff800000109ae4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109ae8:	89 c0                	mov    %eax,%eax
ffff800000109aea:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000109aee:	0f 30                	wrmsr  
ffff800000109af0:	90                   	nop
ffff800000109af1:	5d                   	pop    %rbp
ffff800000109af2:	c3                   	ret    
ffff800000109af3:	f3 0f 1e fa          	endbr64 
ffff800000109af7:	55                   	push   %rbp
ffff800000109af8:	48 89 e5             	mov    %rsp,%rbp
ffff800000109afb:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109afb <wrmsr+0x46>
ffff800000109b02:	49 bb d5 95 00 00 00 	movabs $0x95d5,%r11
ffff800000109b09:	00 00 00 
ffff800000109b0c:	4c 01 d8             	add    %r11,%rax
ffff800000109b0f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000109b13:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000109b17:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000109b1b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
ffff800000109b1f:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
ffff800000109b23:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
ffff800000109b27:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109b2e:	ff ff ff 
ffff800000109b31:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109b35:	48 8d 52 04          	lea    0x4(%rdx),%rdx
ffff800000109b39:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000109b3d:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109b40:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109b47:	ff ff ff 
ffff800000109b4a:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109b4e:	48 8d 52 0c          	lea    0xc(%rdx),%rdx
ffff800000109b52:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000109b56:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109b59:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109b60:	ff ff ff 
ffff800000109b63:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109b67:	48 8d 52 14          	lea    0x14(%rdx),%rdx
ffff800000109b6b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000109b6f:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109b72:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109b79:	ff ff ff 
ffff800000109b7c:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109b80:	48 8d 52 24          	lea    0x24(%rdx),%rdx
ffff800000109b84:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000109b88:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109b8b:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109b92:	ff ff ff 
ffff800000109b95:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109b99:	48 8d 52 2c          	lea    0x2c(%rdx),%rdx
ffff800000109b9d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000109ba1:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109ba4:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109bab:	ff ff ff 
ffff800000109bae:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109bb2:	48 8d 52 34          	lea    0x34(%rdx),%rdx
ffff800000109bb6:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000109bba:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109bbd:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109bc4:	ff ff ff 
ffff800000109bc7:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109bcb:	48 8d 52 3c          	lea    0x3c(%rdx),%rdx
ffff800000109bcf:	48 8b 4d 10          	mov    0x10(%rbp),%rcx
ffff800000109bd3:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109bd6:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109bdd:	ff ff ff 
ffff800000109be0:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109be4:	48 8d 52 44          	lea    0x44(%rdx),%rdx
ffff800000109be8:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
ffff800000109bec:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109bef:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109bf6:	ff ff ff 
ffff800000109bf9:	48 8b 14 10          	mov    (%rax,%rdx,1),%rdx
ffff800000109bfd:	48 8d 52 4c          	lea    0x4c(%rdx),%rdx
ffff800000109c01:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
ffff800000109c05:	48 89 0a             	mov    %rcx,(%rdx)
ffff800000109c08:	48 ba 58 ff ff ff ff 	movabs $0xffffffffffffff58,%rdx
ffff800000109c0f:	ff ff ff 
ffff800000109c12:	48 8b 04 10          	mov    (%rax,%rdx,1),%rax
ffff800000109c16:	48 8d 40 54          	lea    0x54(%rax),%rax
ffff800000109c1a:	48 8b 55 28          	mov    0x28(%rbp),%rdx
ffff800000109c1e:	48 89 10             	mov    %rdx,(%rax)
ffff800000109c21:	90                   	nop
ffff800000109c22:	5d                   	pop    %rbp
ffff800000109c23:	c3                   	ret    
ffff800000109c24:	f3 0f 1e fa          	endbr64 
ffff800000109c28:	55                   	push   %rbp
ffff800000109c29:	48 89 e5             	mov    %rsp,%rbp
ffff800000109c2c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109c2c <wrmsr+0x177>
ffff800000109c33:	49 bb a4 94 00 00 00 	movabs $0x94a4,%r11
ffff800000109c3a:	00 00 00 
ffff800000109c3d:	4c 01 d8             	add    %r11,%rax
ffff800000109c40:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000109c47:	00 
ffff800000109c48:	48 c7 c0 00 80 ff ff 	mov    $0xffffffffffff8000,%rax
ffff800000109c4f:	48 21 e0             	and    %rsp,%rax
ffff800000109c52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c5a:	5d                   	pop    %rbp
ffff800000109c5b:	c3                   	ret    
ffff800000109c5c:	f3 0f 1e fa          	endbr64 
ffff800000109c60:	55                   	push   %rbp
ffff800000109c61:	48 89 e5             	mov    %rsp,%rbp
ffff800000109c64:	41 57                	push   %r15
ffff800000109c66:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109c6a:	4c 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%r8        # ffff800000109c6a <wrmsr+0x1b5>
ffff800000109c71:	49 bb 66 94 00 00 00 	movabs $0x9466,%r11
ffff800000109c78:	00 00 00 
ffff800000109c7b:	4d 01 d8             	add    %r11,%r8
ffff800000109c7e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109c82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109c86:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
ffff800000109c8d:	48 89 c1             	mov    %rax,%rcx
ffff800000109c90:	48 b8 c8 1e 00 00 00 	movabs $0x1ec8,%rax
ffff800000109c97:	00 00 00 
ffff800000109c9a:	49 8d 04 00          	lea    (%r8,%rax,1),%rax
ffff800000109c9e:	48 89 c2             	mov    %rax,%rdx
ffff800000109ca1:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109ca6:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000109cab:	4d 89 c7             	mov    %r8,%r15
ffff800000109cae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109cb3:	49 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r9
ffff800000109cba:	ff ff ff 
ffff800000109cbd:	4d 01 c1             	add    %r8,%r9
ffff800000109cc0:	41 ff d1             	call   *%r9
ffff800000109cc3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109cca:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
ffff800000109cce:	c9                   	leave  
ffff800000109ccf:	c3                   	ret    
ffff800000109cd0:	f3 0f 1e fa          	endbr64 
ffff800000109cd4:	55                   	push   %rbp
ffff800000109cd5:	48 89 e5             	mov    %rsp,%rbp
ffff800000109cd8:	41 57                	push   %r15
ffff800000109cda:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109cde:	48 8d 0d f9 ff ff ff 	lea    -0x7(%rip),%rcx        # ffff800000109cde <wrmsr+0x229>
ffff800000109ce5:	49 bb f2 93 00 00 00 	movabs $0x93f2,%r11
ffff800000109cec:	00 00 00 
ffff800000109cef:	4c 01 d9             	add    %r11,%rcx
ffff800000109cf2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109cf6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cfa:	48 8b 40 60          	mov    0x60(%rax),%rax
ffff800000109cfe:	48 89 c2             	mov    %rax,%rdx
ffff800000109d01:	be ff ff ff 00       	mov    $0xffffff,%esi
ffff800000109d06:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109d0b:	49 89 cf             	mov    %rcx,%r15
ffff800000109d0e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d13:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000109d1a:	ff ff ff 
ffff800000109d1d:	49 01 c8             	add    %rcx,%r8
ffff800000109d20:	41 ff d0             	call   *%r8
ffff800000109d23:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109d28:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
ffff800000109d2c:	c9                   	leave  
ffff800000109d2d:	c3                   	ret    

ffff800000109d2e <user_level_function>:
ffff800000109d2e:	f3 0f 1e fa          	endbr64 
ffff800000109d32:	55                   	push   %rbp
ffff800000109d33:	48 89 e5             	mov    %rsp,%rbp
ffff800000109d36:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff800000109d36 <user_level_function+0x8>
ffff800000109d3d:	49 bb 9a 93 00 00 00 	movabs $0x939a,%r11
ffff800000109d44:	00 00 00 
ffff800000109d47:	4c 01 d8             	add    %r11,%rax
ffff800000109d4a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000109d51:	00 
ffff800000109d52:	48 b8 48 65 6c 6c 6f 	movabs $0x6f57206f6c6c6548,%rax
ffff800000109d59:	20 57 6f 
ffff800000109d5c:	48 89 45 ea          	mov    %rax,-0x16(%rbp)
ffff800000109d60:	c7 45 f2 72 6c 64 21 	movl   $0x21646c72,-0xe(%rbp)
ffff800000109d67:	66 c7 45 f6 0a 00    	movw   $0xa,-0xa(%rbp)
ffff800000109d6d:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109d72:	48 8d 55 ea          	lea    -0x16(%rbp),%rdx
ffff800000109d76:	48 89 d7             	mov    %rdx,%rdi
ffff800000109d79:	48 8d 15 05 00 00 00 	lea    0x5(%rip),%rdx        # ffff800000109d85 <sysexit_return_address>
ffff800000109d80:	48 89 e1             	mov    %rsp,%rcx
ffff800000109d83:	0f 34                	sysenter 

ffff800000109d85 <sysexit_return_address>:
ffff800000109d85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109d89:	eb fe                	jmp    ffff800000109d89 <sysexit_return_address+0x4>

ffff800000109d8b <do_execve>:
ffff800000109d8b:	f3 0f 1e fa          	endbr64 
ffff800000109d8f:	55                   	push   %rbp
ffff800000109d90:	48 89 e5             	mov    %rsp,%rbp
ffff800000109d93:	41 57                	push   %r15
ffff800000109d95:	53                   	push   %rbx
ffff800000109d96:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109d9a:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000109d9a <do_execve+0xf>
ffff800000109da1:	49 bb 36 93 00 00 00 	movabs $0x9336,%r11
ffff800000109da8:	00 00 00 
ffff800000109dab:	4c 01 db             	add    %r11,%rbx
ffff800000109dae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109db2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109db6:	48 c7 40 50 00 00 80 	movq   $0x800000,0x50(%rax)
ffff800000109dbd:	00 
ffff800000109dbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109dc2:	48 c7 40 48 00 00 a0 	movq   $0xa00000,0x48(%rax)
ffff800000109dc9:	00 
ffff800000109dca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109dce:	48 c7 80 80 00 00 00 	movq   $0x1,0x80(%rax)
ffff800000109dd5:	01 00 00 00 
ffff800000109dd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ddd:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff800000109de4:	00 
ffff800000109de5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109de9:	48 c7 40 78 00 00 00 	movq   $0x0,0x78(%rax)
ffff800000109df0:	00 
ffff800000109df1:	48 b8 ec 1e 00 00 00 	movabs $0x1eec,%rax
ffff800000109df8:	00 00 00 
ffff800000109dfb:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109dff:	48 89 c2             	mov    %rax,%rdx
ffff800000109e02:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109e07:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000109e0c:	49 89 df             	mov    %rbx,%r15
ffff800000109e0f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e14:	48 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%rcx
ffff800000109e1b:	ff ff ff 
ffff800000109e1e:	48 01 d9             	add    %rbx,%rcx
ffff800000109e21:	ff d1                	call   *%rcx
ffff800000109e23:	ba 00 04 00 00       	mov    $0x400,%edx
ffff800000109e28:	be 00 00 80 00       	mov    $0x800000,%esi
ffff800000109e2d:	48 b8 5e 6c ff ff ff 	movabs $0xffffffffffff6c5e,%rax
ffff800000109e34:	ff ff ff 
ffff800000109e37:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109e3b:	48 89 c7             	mov    %rax,%rdi
ffff800000109e3e:	48 b8 e5 68 ff ff ff 	movabs $0xffffffffffff68e5,%rax
ffff800000109e45:	ff ff ff 
ffff800000109e48:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109e4c:	ff d0                	call   *%rax
ffff800000109e4e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e53:	48 83 c4 10          	add    $0x10,%rsp
ffff800000109e57:	5b                   	pop    %rbx
ffff800000109e58:	41 5f                	pop    %r15
ffff800000109e5a:	5d                   	pop    %rbp
ffff800000109e5b:	c3                   	ret    

ffff800000109e5c <init>:
ffff800000109e5c:	f3 0f 1e fa          	endbr64 
ffff800000109e60:	55                   	push   %rbp
ffff800000109e61:	48 89 e5             	mov    %rsp,%rbp
ffff800000109e64:	41 57                	push   %r15
ffff800000109e66:	41 54                	push   %r12
ffff800000109e68:	53                   	push   %rbx
ffff800000109e69:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000109e6d:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000109e6d <init+0x11>
ffff800000109e74:	49 bb 63 92 00 00 00 	movabs $0x9263,%r11
ffff800000109e7b:	00 00 00 
ffff800000109e7e:	4c 01 db             	add    %r11,%rbx
ffff800000109e81:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000109e85:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109e89:	48 89 c1             	mov    %rax,%rcx
ffff800000109e8c:	48 b8 08 1f 00 00 00 	movabs $0x1f08,%rax
ffff800000109e93:	00 00 00 
ffff800000109e96:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff800000109e9a:	48 89 c2             	mov    %rax,%rdx
ffff800000109e9d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109ea2:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff800000109ea7:	49 89 df             	mov    %rbx,%r15
ffff800000109eaa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109eaf:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff800000109eb6:	ff ff ff 
ffff800000109eb9:	49 01 d8             	add    %rbx,%r8
ffff800000109ebc:	41 ff d0             	call   *%r8
ffff800000109ebf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109ec4:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109ecb:	ff ff ff 
ffff800000109ece:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109ed2:	ff d2                	call   *%rdx
ffff800000109ed4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000109ed8:	48 ba f0 fe ff ff ff 	movabs $0xfffffffffffffef0,%rdx
ffff800000109edf:	ff ff ff 
ffff800000109ee2:	48 8b 14 13          	mov    (%rbx,%rdx,1),%rdx
ffff800000109ee6:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff800000109eea:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109eef:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109ef6:	ff ff ff 
ffff800000109ef9:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109efd:	ff d2                	call   *%rdx
ffff800000109eff:	49 89 c4             	mov    %rax,%r12
ffff800000109f02:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f07:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109f0e:	ff ff ff 
ffff800000109f11:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109f15:	ff d2                	call   *%rdx
ffff800000109f17:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000109f1b:	49 8d 94 24 40 7f 00 	lea    0x7f40(%r12),%rdx
ffff800000109f22:	00 
ffff800000109f23:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000109f27:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f2c:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109f33:	ff ff ff 
ffff800000109f36:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109f3a:	ff d2                	call   *%rdx
ffff800000109f3c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000109f40:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000109f44:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff800000109f48:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f4d:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109f54:	ff ff ff 
ffff800000109f57:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109f5b:	ff d2                	call   *%rdx
ffff800000109f5d:	4c 8b 60 28          	mov    0x28(%rax),%r12
ffff800000109f61:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f66:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff800000109f6d:	ff ff ff 
ffff800000109f70:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff800000109f74:	ff d2                	call   *%rdx
ffff800000109f76:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff800000109f7a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109f7e:	48 89 c7             	mov    %rax,%rdi
ffff800000109f81:	49 8b 64 24 10       	mov    0x10(%r12),%rsp
ffff800000109f86:	ff 72 08             	push   0x8(%rdx)
ffff800000109f89:	e9 fd fd ff ff       	jmp    ffff800000109d8b <do_execve>
ffff800000109f8e:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109f93:	48 83 c4 28          	add    $0x28,%rsp
ffff800000109f97:	5b                   	pop    %rbx
ffff800000109f98:	41 5c                	pop    %r12
ffff800000109f9a:	41 5f                	pop    %r15
ffff800000109f9c:	5d                   	pop    %rbp
ffff800000109f9d:	c3                   	ret    

ffff800000109f9e <do_fork>:
ffff800000109f9e:	f3 0f 1e fa          	endbr64 
ffff800000109fa2:	55                   	push   %rbp
ffff800000109fa3:	48 89 e5             	mov    %rsp,%rbp
ffff800000109fa6:	41 57                	push   %r15
ffff800000109fa8:	53                   	push   %rbx
ffff800000109fa9:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000109fad:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff800000109fad <do_fork+0xf>
ffff800000109fb4:	49 bb 23 91 00 00 00 	movabs $0x9123,%r11
ffff800000109fbb:	00 00 00 
ffff800000109fbe:	4c 01 db             	add    %r11,%rbx
ffff800000109fc1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000109fc5:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff800000109fc9:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
ffff800000109fcd:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
ffff800000109fd1:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff800000109fd8:	00 
ffff800000109fd9:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff800000109fe0:	00 
ffff800000109fe1:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
ffff800000109fe8:	00 
ffff800000109fe9:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff800000109ff0:	ff ff ff 
ffff800000109ff3:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff800000109ff7:	48 8b 80 88 02 00 00 	mov    0x288(%rax),%rax
ffff800000109ffe:	48 8b 00             	mov    (%rax),%rax
ffff80000010a001:	48 89 c1             	mov    %rax,%rcx
ffff80000010a004:	48 b8 2a 1f 00 00 00 	movabs $0x1f2a,%rax
ffff80000010a00b:	00 00 00 
ffff80000010a00e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a012:	48 89 c2             	mov    %rax,%rdx
ffff80000010a015:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a01a:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010a01f:	49 89 df             	mov    %rbx,%r15
ffff80000010a022:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a027:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010a02e:	ff ff ff 
ffff80000010a031:	49 01 d8             	add    %rbx,%r8
ffff80000010a034:	41 ff d0             	call   *%r8
ffff80000010a037:	ba 91 00 00 00       	mov    $0x91,%edx
ffff80000010a03c:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010a041:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010a046:	49 89 df             	mov    %rbx,%r15
ffff80000010a049:	48 b8 d7 54 ff ff ff 	movabs $0xffffffffffff54d7,%rax
ffff80000010a050:	ff ff ff 
ffff80000010a053:	48 01 d8             	add    %rbx,%rax
ffff80000010a056:	ff d0                	call   *%rax
ffff80000010a058:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010a05c:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010a063:	ff ff ff 
ffff80000010a066:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a06a:	48 8b 80 88 02 00 00 	mov    0x288(%rax),%rax
ffff80000010a071:	48 8b 00             	mov    (%rax),%rax
ffff80000010a074:	48 89 c1             	mov    %rax,%rcx
ffff80000010a077:	48 b8 2a 1f 00 00 00 	movabs $0x1f2a,%rax
ffff80000010a07e:	00 00 00 
ffff80000010a081:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a085:	48 89 c2             	mov    %rax,%rdx
ffff80000010a088:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a08d:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010a092:	49 89 df             	mov    %rbx,%r15
ffff80000010a095:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a09a:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010a0a1:	ff ff ff 
ffff80000010a0a4:	49 01 d8             	add    %rbx,%r8
ffff80000010a0a7:	41 ff d0             	call   *%r8
ffff80000010a0aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a0ae:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010a0b2:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010a0b9:	80 ff ff 
ffff80000010a0bc:	48 01 d0             	add    %rdx,%rax
ffff80000010a0bf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010a0c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a0c7:	48 89 c1             	mov    %rax,%rcx
ffff80000010a0ca:	48 b8 48 1f 00 00 00 	movabs $0x1f48,%rax
ffff80000010a0d1:	00 00 00 
ffff80000010a0d4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a0d8:	48 89 c2             	mov    %rax,%rdx
ffff80000010a0db:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a0e0:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010a0e5:	49 89 df             	mov    %rbx,%r15
ffff80000010a0e8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a0ed:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010a0f4:	ff ff ff 
ffff80000010a0f7:	49 01 d8             	add    %rbx,%r8
ffff80000010a0fa:	41 ff d0             	call   *%r8
ffff80000010a0fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a101:	ba 58 00 00 00       	mov    $0x58,%edx
ffff80000010a106:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a10b:	48 89 c7             	mov    %rax,%rdi
ffff80000010a10e:	48 b8 57 69 ff ff ff 	movabs $0xffffffffffff6957,%rax
ffff80000010a115:	ff ff ff 
ffff80000010a118:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a11c:	ff d0                	call   *%rax
ffff80000010a11e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a123:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a12a:	ff ff ff 
ffff80000010a12d:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a131:	ff d2                	call   *%rdx
ffff80000010a133:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010a137:	48 8b 30             	mov    (%rax),%rsi
ffff80000010a13a:	48 8b 78 08          	mov    0x8(%rax),%rdi
ffff80000010a13e:	48 89 32             	mov    %rsi,(%rdx)
ffff80000010a141:	48 89 7a 08          	mov    %rdi,0x8(%rdx)
ffff80000010a145:	48 8b 70 10          	mov    0x10(%rax),%rsi
ffff80000010a149:	48 8b 78 18          	mov    0x18(%rax),%rdi
ffff80000010a14d:	48 89 72 10          	mov    %rsi,0x10(%rdx)
ffff80000010a151:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
ffff80000010a155:	48 8b 70 20          	mov    0x20(%rax),%rsi
ffff80000010a159:	48 8b 78 28          	mov    0x28(%rax),%rdi
ffff80000010a15d:	48 89 72 20          	mov    %rsi,0x20(%rdx)
ffff80000010a161:	48 89 7a 28          	mov    %rdi,0x28(%rdx)
ffff80000010a165:	48 8b 70 30          	mov    0x30(%rax),%rsi
ffff80000010a169:	48 8b 78 38          	mov    0x38(%rax),%rdi
ffff80000010a16d:	48 89 72 30          	mov    %rsi,0x30(%rdx)
ffff80000010a171:	48 89 7a 38          	mov    %rdi,0x38(%rdx)
ffff80000010a175:	48 8b 70 40          	mov    0x40(%rax),%rsi
ffff80000010a179:	48 8b 78 48          	mov    0x48(%rax),%rdi
ffff80000010a17d:	48 89 72 40          	mov    %rsi,0x40(%rdx)
ffff80000010a181:	48 89 7a 48          	mov    %rdi,0x48(%rdx)
ffff80000010a185:	48 8b 40 50          	mov    0x50(%rax),%rax
ffff80000010a189:	48 89 42 50          	mov    %rax,0x50(%rdx)
ffff80000010a18d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a191:	48 89 c7             	mov    %rax,%rdi
ffff80000010a194:	48 b8 12 68 ff ff ff 	movabs $0xffffffffffff6812,%rax
ffff80000010a19b:	ff ff ff 
ffff80000010a19e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a1a2:	ff d0                	call   *%rax
ffff80000010a1a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1a8:	48 89 c6             	mov    %rax,%rsi
ffff80000010a1ab:	48 b8 30 4f 00 00 00 	movabs $0x4f30,%rax
ffff80000010a1b2:	00 00 00 
ffff80000010a1b5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a1b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010a1bc:	48 b8 4c 68 ff ff ff 	movabs $0xffffffffffff684c,%rax
ffff80000010a1c3:	ff ff ff 
ffff80000010a1c6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a1ca:	ff d0                	call   *%rax
ffff80000010a1cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1d0:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff80000010a1d4:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff80000010a1d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1dc:	48 89 50 38          	mov    %rdx,0x38(%rax)
ffff80000010a1e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1e4:	48 c7 40 10 04 00 00 	movq   $0x4,0x10(%rax)
ffff80000010a1eb:	00 
ffff80000010a1ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1f0:	48 83 c0 58          	add    $0x58,%rax
ffff80000010a1f4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010a1f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a1fc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010a200:	48 89 50 28          	mov    %rdx,0x28(%rax)
ffff80000010a204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a208:	48 05 40 7f 00 00    	add    $0x7f40,%rax
ffff80000010a20e:	48 89 c1             	mov    %rax,%rcx
ffff80000010a211:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a215:	ba c0 00 00 00       	mov    $0xc0,%edx
ffff80000010a21a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010a21d:	48 89 c7             	mov    %rax,%rdi
ffff80000010a220:	48 b8 e5 68 ff ff ff 	movabs $0xffffffffffff68e5,%rax
ffff80000010a227:	ff ff ff 
ffff80000010a22a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a22e:	ff d0                	call   *%rax
ffff80000010a230:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a234:	48 8d 90 00 80 00 00 	lea    0x8000(%rax),%rdx
ffff80000010a23b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a23f:	48 89 10             	mov    %rdx,(%rax)
ffff80000010a242:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a246:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
ffff80000010a24d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a251:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff80000010a255:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a259:	48 8d 90 40 7f 00 00 	lea    0x7f40(%rax),%rdx
ffff80000010a260:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a264:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff80000010a268:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a26c:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff80000010a270:	83 e0 01             	and    $0x1,%eax
ffff80000010a273:	48 85 c0             	test   %rax,%rax
ffff80000010a276:	75 2f                	jne    ffff80000010a2a7 <do_fork+0x309>
ffff80000010a278:	48 b8 f0 fe ff ff ff 	movabs $0xfffffffffffffef0,%rax
ffff80000010a27f:	ff ff ff 
ffff80000010a282:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a286:	48 89 c2             	mov    %rax,%rdx
ffff80000010a289:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a28d:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
ffff80000010a294:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a298:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
ffff80000010a29f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a2a3:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff80000010a2a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a2ab:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
ffff80000010a2b2:	00 
ffff80000010a2b3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a2b8:	48 83 c4 40          	add    $0x40,%rsp
ffff80000010a2bc:	5b                   	pop    %rbx
ffff80000010a2bd:	41 5f                	pop    %r15
ffff80000010a2bf:	5d                   	pop    %rbp
ffff80000010a2c0:	c3                   	ret    

ffff80000010a2c1 <kernel_thread_func>:
ffff80000010a2c1:	41 5f                	pop    %r15
ffff80000010a2c3:	41 5e                	pop    %r14
ffff80000010a2c5:	41 5d                	pop    %r13
ffff80000010a2c7:	41 5c                	pop    %r12
ffff80000010a2c9:	41 5b                	pop    %r11
ffff80000010a2cb:	41 5a                	pop    %r10
ffff80000010a2cd:	41 59                	pop    %r9
ffff80000010a2cf:	41 58                	pop    %r8
ffff80000010a2d1:	5b                   	pop    %rbx
ffff80000010a2d2:	59                   	pop    %rcx
ffff80000010a2d3:	5a                   	pop    %rdx
ffff80000010a2d4:	5e                   	pop    %rsi
ffff80000010a2d5:	5f                   	pop    %rdi
ffff80000010a2d6:	5d                   	pop    %rbp
ffff80000010a2d7:	58                   	pop    %rax
ffff80000010a2d8:	48 8e d8             	mov    %rax,%ds
ffff80000010a2db:	58                   	pop    %rax
ffff80000010a2dc:	48 8e c0             	mov    %rax,%es
ffff80000010a2df:	58                   	pop    %rax
ffff80000010a2e0:	48 83 c4 38          	add    $0x38,%rsp
ffff80000010a2e4:	48 89 d7             	mov    %rdx,%rdi
ffff80000010a2e7:	ff d3                	call   *%rbx
ffff80000010a2e9:	48 89 c7             	mov    %rax,%rdi
ffff80000010a2ec:	e8 e1 00 00 00       	call   ffff80000010a3d2 <do_exit>

ffff80000010a2f1 <kernel_thread>:
ffff80000010a2f1:	f3 0f 1e fa          	endbr64 
ffff80000010a2f5:	55                   	push   %rbp
ffff80000010a2f6:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a2f9:	53                   	push   %rbx
ffff80000010a2fa:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
ffff80000010a301:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010a301 <kernel_thread+0x10>
ffff80000010a308:	49 bb cf 8d 00 00 00 	movabs $0x8dcf,%r11
ffff80000010a30f:	00 00 00 
ffff80000010a312:	4c 01 db             	add    %r11,%rbx
ffff80000010a315:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
ffff80000010a31c:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
ffff80000010a323:	48 89 95 18 ff ff ff 	mov    %rdx,-0xe8(%rbp)
ffff80000010a32a:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
ffff80000010a331:	ba c0 00 00 00       	mov    $0xc0,%edx
ffff80000010a336:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a33b:	48 89 c7             	mov    %rax,%rdi
ffff80000010a33e:	48 b8 57 69 ff ff ff 	movabs $0xffffffffffff6957,%rax
ffff80000010a345:	ff ff ff 
ffff80000010a348:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a34c:	ff d0                	call   *%rax
ffff80000010a34e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff80000010a355:	48 89 85 70 ff ff ff 	mov    %rax,-0x90(%rbp)
ffff80000010a35c:	48 8b 85 20 ff ff ff 	mov    -0xe0(%rbp),%rax
ffff80000010a363:	48 89 45 80          	mov    %rax,-0x80(%rbp)
ffff80000010a367:	48 c7 45 a0 10 00 00 	movq   $0x10,-0x60(%rbp)
ffff80000010a36e:	00 
ffff80000010a36f:	48 c7 45 a8 10 00 00 	movq   $0x10,-0x58(%rbp)
ffff80000010a376:	00 
ffff80000010a377:	48 c7 45 d0 08 00 00 	movq   $0x8,-0x30(%rbp)
ffff80000010a37e:	00 
ffff80000010a37f:	48 c7 45 e8 10 00 00 	movq   $0x10,-0x18(%rbp)
ffff80000010a386:	00 
ffff80000010a387:	48 c7 45 d8 00 02 00 	movq   $0x200,-0x28(%rbp)
ffff80000010a38e:	00 
ffff80000010a38f:	48 b8 c8 ff ff ff ff 	movabs $0xffffffffffffffc8,%rax
ffff80000010a396:	ff ff ff 
ffff80000010a399:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a39d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff80000010a3a1:	48 8b b5 18 ff ff ff 	mov    -0xe8(%rbp),%rsi
ffff80000010a3a8:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
ffff80000010a3af:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff80000010a3b4:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010a3b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010a3bc:	48 b8 ce 6e ff ff ff 	movabs $0xffffffffffff6ece,%rax
ffff80000010a3c3:	ff ff ff 
ffff80000010a3c6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a3ca:	ff d0                	call   *%rax
ffff80000010a3cc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010a3d0:	c9                   	leave  
ffff80000010a3d1:	c3                   	ret    

ffff80000010a3d2 <do_exit>:
ffff80000010a3d2:	f3 0f 1e fa          	endbr64 
ffff80000010a3d6:	55                   	push   %rbp
ffff80000010a3d7:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a3da:	41 57                	push   %r15
ffff80000010a3dc:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010a3e0:	4c 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%r8        # ffff80000010a3e0 <do_exit+0xe>
ffff80000010a3e7:	49 bb f0 8c 00 00 00 	movabs $0x8cf0,%r11
ffff80000010a3ee:	00 00 00 
ffff80000010a3f1:	4d 01 d8             	add    %r11,%r8
ffff80000010a3f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010a3f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a3fc:	48 89 c1             	mov    %rax,%rcx
ffff80000010a3ff:	48 b8 70 1f 00 00 00 	movabs $0x1f70,%rax
ffff80000010a406:	00 00 00 
ffff80000010a409:	49 8d 04 00          	lea    (%r8,%rax,1),%rax
ffff80000010a40d:	48 89 c2             	mov    %rax,%rdx
ffff80000010a410:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a415:	bf 00 00 ff 00       	mov    $0xff0000,%edi
ffff80000010a41a:	4d 89 c7             	mov    %r8,%r15
ffff80000010a41d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a422:	49 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r9
ffff80000010a429:	ff ff ff 
ffff80000010a42c:	4d 01 c1             	add    %r8,%r9
ffff80000010a42f:	41 ff d1             	call   *%r9
ffff80000010a432:	eb fe                	jmp    ffff80000010a432 <do_exit+0x60>

ffff80000010a434 <system_call_function>:
ffff80000010a434:	f3 0f 1e fa          	endbr64 
ffff80000010a438:	55                   	push   %rbp
ffff80000010a439:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a43c:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010a440:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010a440 <system_call_function+0xc>
ffff80000010a447:	49 bb 90 8c 00 00 00 	movabs $0x8c90,%r11
ffff80000010a44e:	00 00 00 
ffff80000010a451:	4c 01 d8             	add    %r11,%rax
ffff80000010a454:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010a458:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010a45c:	48 8b 92 80 00 00 00 	mov    0x80(%rdx),%rdx
ffff80000010a463:	48 b9 f0 03 00 00 00 	movabs $0x3f0,%rcx
ffff80000010a46a:	00 00 00 
ffff80000010a46d:	48 01 c8             	add    %rcx,%rax
ffff80000010a470:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff80000010a474:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a478:	48 89 c7             	mov    %rax,%rdi
ffff80000010a47b:	ff d2                	call   *%rdx
ffff80000010a47d:	c9                   	leave  
ffff80000010a47e:	c3                   	ret    

ffff80000010a47f <__switch_to>:
ffff80000010a47f:	f3 0f 1e fa          	endbr64 
ffff80000010a483:	55                   	push   %rbp
ffff80000010a484:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a487:	41 57                	push   %r15
ffff80000010a489:	41 54                	push   %r12
ffff80000010a48b:	53                   	push   %rbx
ffff80000010a48c:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010a490:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010a490 <__switch_to+0x11>
ffff80000010a497:	49 bb 40 8c 00 00 00 	movabs $0x8c40,%r11
ffff80000010a49e:	00 00 00 
ffff80000010a4a1:	4c 01 db             	add    %r11,%rbx
ffff80000010a4a4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010a4a8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010a4ac:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010a4b0:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a4b4:	48 8b 00             	mov    (%rax),%rax
ffff80000010a4b7:	48 ba b0 00 00 00 00 	movabs $0xb0,%rdx
ffff80000010a4be:	00 00 00 
ffff80000010a4c1:	48 89 44 13 04       	mov    %rax,0x4(%rbx,%rdx,1)
ffff80000010a4c6:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a4cd:	00 00 00 
ffff80000010a4d0:	4c 8b 54 03 54       	mov    0x54(%rbx,%rax,1),%r10
ffff80000010a4d5:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a4dc:	00 00 00 
ffff80000010a4df:	4c 8b 4c 03 4c       	mov    0x4c(%rbx,%rax,1),%r9
ffff80000010a4e4:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a4eb:	00 00 00 
ffff80000010a4ee:	4c 8b 44 03 44       	mov    0x44(%rbx,%rax,1),%r8
ffff80000010a4f3:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a4fa:	00 00 00 
ffff80000010a4fd:	48 8b 7c 03 3c       	mov    0x3c(%rbx,%rax,1),%rdi
ffff80000010a502:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a509:	00 00 00 
ffff80000010a50c:	4c 8b 64 03 34       	mov    0x34(%rbx,%rax,1),%r12
ffff80000010a511:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a518:	00 00 00 
ffff80000010a51b:	4c 8b 5c 03 2c       	mov    0x2c(%rbx,%rax,1),%r11
ffff80000010a520:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a527:	00 00 00 
ffff80000010a52a:	48 8b 4c 03 24       	mov    0x24(%rbx,%rax,1),%rcx
ffff80000010a52f:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a536:	00 00 00 
ffff80000010a539:	48 8b 54 03 14       	mov    0x14(%rbx,%rax,1),%rdx
ffff80000010a53e:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a545:	00 00 00 
ffff80000010a548:	48 8b 74 03 0c       	mov    0xc(%rbx,%rax,1),%rsi
ffff80000010a54d:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a554:	00 00 00 
ffff80000010a557:	48 8b 44 03 04       	mov    0x4(%rbx,%rax,1),%rax
ffff80000010a55c:	41 52                	push   %r10
ffff80000010a55e:	41 51                	push   %r9
ffff80000010a560:	41 50                	push   %r8
ffff80000010a562:	57                   	push   %rdi
ffff80000010a563:	4d 89 e1             	mov    %r12,%r9
ffff80000010a566:	4d 89 d8             	mov    %r11,%r8
ffff80000010a569:	48 89 c7             	mov    %rax,%rdi
ffff80000010a56c:	48 b8 a5 11 ff ff ff 	movabs $0xffffffffffff11a5,%rax
ffff80000010a573:	ff ff ff 
ffff80000010a576:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a57a:	ff d0                	call   *%rax
ffff80000010a57c:	48 83 c4 20          	add    $0x20,%rsp
ffff80000010a580:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a584:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff80000010a588:	48 8c e0             	mov    %fs,%rax
ffff80000010a58b:	48 89 42 18          	mov    %rax,0x18(%rdx)
ffff80000010a58f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a593:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff80000010a597:	48 8c e8             	mov    %gs,%rax
ffff80000010a59a:	48 89 42 20          	mov    %rax,0x20(%rdx)
ffff80000010a59e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010a5a2:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a5a6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff80000010a5aa:	48 8e e0             	mov    %rax,%fs
ffff80000010a5ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010a5b1:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a5b5:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010a5b9:	48 8e e8             	mov    %rax,%gs
ffff80000010a5bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a5c0:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a5c4:	48 8b 00             	mov    (%rax),%rax
ffff80000010a5c7:	48 89 c1             	mov    %rax,%rcx
ffff80000010a5ca:	48 b8 92 1f 00 00 00 	movabs $0x1f92,%rax
ffff80000010a5d1:	00 00 00 
ffff80000010a5d4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a5d8:	48 89 c2             	mov    %rax,%rdx
ffff80000010a5db:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a5e0:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010a5e5:	49 89 df             	mov    %rbx,%r15
ffff80000010a5e8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a5ed:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010a5f4:	ff ff ff 
ffff80000010a5f7:	49 01 d8             	add    %rbx,%r8
ffff80000010a5fa:	41 ff d0             	call   *%r8
ffff80000010a5fd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010a601:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a605:	48 8b 00             	mov    (%rax),%rax
ffff80000010a608:	48 89 c1             	mov    %rax,%rcx
ffff80000010a60b:	48 b8 ae 1f 00 00 00 	movabs $0x1fae,%rax
ffff80000010a612:	00 00 00 
ffff80000010a615:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a619:	48 89 c2             	mov    %rax,%rdx
ffff80000010a61c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a621:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010a626:	49 89 df             	mov    %rbx,%r15
ffff80000010a629:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a62e:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010a635:	ff ff ff 
ffff80000010a638:	49 01 d8             	add    %rbx,%r8
ffff80000010a63b:	41 ff d0             	call   *%r8
ffff80000010a63e:	90                   	nop
ffff80000010a63f:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
ffff80000010a643:	5b                   	pop    %rbx
ffff80000010a644:	41 5c                	pop    %r12
ffff80000010a646:	41 5f                	pop    %r15
ffff80000010a648:	5d                   	pop    %rbp
ffff80000010a649:	c3                   	ret    

ffff80000010a64a <task_init>:
ffff80000010a64a:	f3 0f 1e fa          	endbr64 
ffff80000010a64e:	55                   	push   %rbp
ffff80000010a64f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a652:	41 57                	push   %r15
ffff80000010a654:	41 56                	push   %r14
ffff80000010a656:	41 55                	push   %r13
ffff80000010a658:	41 54                	push   %r12
ffff80000010a65a:	53                   	push   %rbx
ffff80000010a65b:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010a65f:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010a65f <task_init+0x15>
ffff80000010a666:	49 bb 71 8a 00 00 00 	movabs $0x8a71,%r11
ffff80000010a66d:	00 00 00 
ffff80000010a670:	4c 01 db             	add    %r11,%rbx
ffff80000010a673:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff80000010a67a:	00 
ffff80000010a67b:	48 b8 58 5f 01 00 00 	movabs $0x15f58,%rax
ffff80000010a682:	00 00 00 
ffff80000010a685:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a689:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a690:	00 00 00 
ffff80000010a693:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
ffff80000010a697:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010a69e:	ff ff ff 
ffff80000010a6a1:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a6a5:	48 8b 80 d0 02 00 00 	mov    0x2d0(%rax),%rax
ffff80000010a6ac:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a6b3:	00 00 00 
ffff80000010a6b6:	48 89 44 13 08       	mov    %rax,0x8(%rbx,%rdx,1)
ffff80000010a6bb:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010a6c2:	ff ff ff 
ffff80000010a6c5:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a6c9:	48 8b 80 d8 02 00 00 	mov    0x2d8(%rax),%rax
ffff80000010a6d0:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a6d7:	00 00 00 
ffff80000010a6da:	48 89 44 13 10       	mov    %rax,0x10(%rbx,%rdx,1)
ffff80000010a6df:	48 b8 90 ff ff ff ff 	movabs $0xffffffffffffff90,%rax
ffff80000010a6e6:	ff ff ff 
ffff80000010a6e9:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a6ed:	48 89 c2             	mov    %rax,%rdx
ffff80000010a6f0:	48 b8 70 5f 01 00 00 	movabs $0x15f70,%rax
ffff80000010a6f7:	00 00 00 
ffff80000010a6fa:	48 89 54 03 18       	mov    %rdx,0x18(%rbx,%rax,1)
ffff80000010a6ff:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010a706:	ff ff ff 
ffff80000010a709:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a70d:	48 8b 80 e0 02 00 00 	mov    0x2e0(%rax),%rax
ffff80000010a714:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a71b:	00 00 00 
ffff80000010a71e:	48 89 44 13 20       	mov    %rax,0x20(%rbx,%rdx,1)
ffff80000010a723:	48 b8 40 ff ff ff ff 	movabs $0xffffffffffffff40,%rax
ffff80000010a72a:	ff ff ff 
ffff80000010a72d:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a731:	48 89 c2             	mov    %rax,%rdx
ffff80000010a734:	48 b8 70 5f 01 00 00 	movabs $0x15f70,%rax
ffff80000010a73b:	00 00 00 
ffff80000010a73e:	48 89 54 03 28       	mov    %rdx,0x28(%rbx,%rax,1)
ffff80000010a743:	48 b8 f8 ff ff ff ff 	movabs $0xfffffffffffffff8,%rax
ffff80000010a74a:	ff ff ff 
ffff80000010a74d:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a751:	48 89 c2             	mov    %rax,%rdx
ffff80000010a754:	48 b8 70 5f 01 00 00 	movabs $0x15f70,%rax
ffff80000010a75b:	00 00 00 
ffff80000010a75e:	48 89 54 03 30       	mov    %rdx,0x30(%rbx,%rax,1)
ffff80000010a763:	48 b8 70 5f 01 00 00 	movabs $0x15f70,%rax
ffff80000010a76a:	00 00 00 
ffff80000010a76d:	48 c7 44 03 38 00 00 	movq   $0x0,0x38(%rbx,%rax,1)
ffff80000010a774:	00 00 
ffff80000010a776:	48 b8 98 ff ff ff ff 	movabs $0xffffffffffffff98,%rax
ffff80000010a77d:	ff ff ff 
ffff80000010a780:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a784:	48 8b 80 e8 02 00 00 	mov    0x2e8(%rax),%rax
ffff80000010a78b:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a792:	00 00 00 
ffff80000010a795:	48 89 44 13 40       	mov    %rax,0x40(%rbx,%rdx,1)
ffff80000010a79a:	48 b8 80 ff ff ff ff 	movabs $0xffffffffffffff80,%rax
ffff80000010a7a1:	ff ff ff 
ffff80000010a7a4:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a7a8:	48 8b 00             	mov    (%rax),%rax
ffff80000010a7ab:	48 ba 70 5f 01 00 00 	movabs $0x15f70,%rdx
ffff80000010a7b2:	00 00 00 
ffff80000010a7b5:	48 89 44 13 48       	mov    %rax,0x48(%rbx,%rdx,1)
ffff80000010a7ba:	be 08 00 00 00       	mov    $0x8,%esi
ffff80000010a7bf:	bf 74 01 00 00       	mov    $0x174,%edi
ffff80000010a7c4:	48 b8 e5 69 ff ff ff 	movabs $0xffffffffffff69e5,%rax
ffff80000010a7cb:	ff ff ff 
ffff80000010a7ce:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a7d2:	ff d0                	call   *%rax
ffff80000010a7d4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a7d9:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a7e0:	ff ff ff 
ffff80000010a7e3:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a7e7:	ff d2                	call   *%rdx
ffff80000010a7e9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010a7ed:	48 8b 00             	mov    (%rax),%rax
ffff80000010a7f0:	48 89 c6             	mov    %rax,%rsi
ffff80000010a7f3:	bf 75 01 00 00       	mov    $0x175,%edi
ffff80000010a7f8:	48 b8 e5 69 ff ff ff 	movabs $0xffffffffffff69e5,%rax
ffff80000010a7ff:	ff ff ff 
ffff80000010a802:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a806:	ff d0                	call   *%rax
ffff80000010a808:	48 b8 d8 ff ff ff ff 	movabs $0xffffffffffffffd8,%rax
ffff80000010a80f:	ff ff ff 
ffff80000010a812:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a816:	48 89 c6             	mov    %rax,%rsi
ffff80000010a819:	bf 76 01 00 00       	mov    $0x176,%edi
ffff80000010a81e:	48 b8 e5 69 ff ff ff 	movabs $0xffffffffffff69e5,%rax
ffff80000010a825:	ff ff ff 
ffff80000010a828:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a82c:	ff d0                	call   *%rax
ffff80000010a82e:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a835:	00 00 00 
ffff80000010a838:	4c 8b 54 03 54       	mov    0x54(%rbx,%rax,1),%r10
ffff80000010a83d:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a844:	00 00 00 
ffff80000010a847:	4c 8b 4c 03 4c       	mov    0x4c(%rbx,%rax,1),%r9
ffff80000010a84c:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a853:	00 00 00 
ffff80000010a856:	4c 8b 44 03 44       	mov    0x44(%rbx,%rax,1),%r8
ffff80000010a85b:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a862:	00 00 00 
ffff80000010a865:	48 8b 7c 03 3c       	mov    0x3c(%rbx,%rax,1),%rdi
ffff80000010a86a:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a871:	00 00 00 
ffff80000010a874:	4c 8b 64 03 34       	mov    0x34(%rbx,%rax,1),%r12
ffff80000010a879:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a880:	00 00 00 
ffff80000010a883:	4c 8b 5c 03 2c       	mov    0x2c(%rbx,%rax,1),%r11
ffff80000010a888:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a88f:	00 00 00 
ffff80000010a892:	48 8b 4c 03 24       	mov    0x24(%rbx,%rax,1),%rcx
ffff80000010a897:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a89e:	00 00 00 
ffff80000010a8a1:	48 8b 54 03 14       	mov    0x14(%rbx,%rax,1),%rdx
ffff80000010a8a6:	48 b8 b0 00 00 00 00 	movabs $0xb0,%rax
ffff80000010a8ad:	00 00 00 
ffff80000010a8b0:	48 8b 74 03 0c       	mov    0xc(%rbx,%rax,1),%rsi
ffff80000010a8b5:	48 b8 30 00 00 00 00 	movabs $0x30,%rax
ffff80000010a8bc:	00 00 00 
ffff80000010a8bf:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a8c3:	41 52                	push   %r10
ffff80000010a8c5:	41 51                	push   %r9
ffff80000010a8c7:	41 50                	push   %r8
ffff80000010a8c9:	57                   	push   %rdi
ffff80000010a8ca:	4d 89 e1             	mov    %r12,%r9
ffff80000010a8cd:	4d 89 d8             	mov    %r11,%r8
ffff80000010a8d0:	48 89 c7             	mov    %rax,%rdi
ffff80000010a8d3:	48 b8 a5 11 ff ff ff 	movabs $0xffffffffffff11a5,%rax
ffff80000010a8da:	ff ff ff 
ffff80000010a8dd:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a8e1:	ff d0                	call   *%rax
ffff80000010a8e3:	48 83 c4 20          	add    $0x20,%rsp
ffff80000010a8e7:	48 b8 30 00 00 00 00 	movabs $0x30,%rax
ffff80000010a8ee:	00 00 00 
ffff80000010a8f1:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
ffff80000010a8f5:	48 ba b0 00 00 00 00 	movabs $0xb0,%rdx
ffff80000010a8fc:	00 00 00 
ffff80000010a8ff:	48 89 44 13 04       	mov    %rax,0x4(%rbx,%rdx,1)
ffff80000010a904:	48 b8 30 4f 00 00 00 	movabs $0x4f30,%rax
ffff80000010a90b:	00 00 00 
ffff80000010a90e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a912:	48 89 c7             	mov    %rax,%rdi
ffff80000010a915:	48 b8 12 68 ff ff ff 	movabs $0xffffffffffff6812,%rax
ffff80000010a91c:	ff ff ff 
ffff80000010a91f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a923:	ff d0                	call   *%rax
ffff80000010a925:	ba 07 00 00 00       	mov    $0x7,%edx
ffff80000010a92a:	be 0a 00 00 00       	mov    $0xa,%esi
ffff80000010a92f:	48 b8 8c 6d ff ff ff 	movabs $0xffffffffffff6d8c,%rax
ffff80000010a936:	ff ff ff 
ffff80000010a939:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a93d:	48 89 c7             	mov    %rax,%rdi
ffff80000010a940:	48 b8 21 72 ff ff ff 	movabs $0xffffffffffff7221,%rax
ffff80000010a947:	ff ff ff 
ffff80000010a94a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a94e:	ff d0                	call   *%rax
ffff80000010a950:	48 b8 30 4f 00 00 00 	movabs $0x4f30,%rax
ffff80000010a957:	00 00 00 
ffff80000010a95a:	48 c7 44 03 10 01 00 	movq   $0x1,0x10(%rbx,%rax,1)
ffff80000010a961:	00 00 
ffff80000010a963:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a968:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a96f:	ff ff ff 
ffff80000010a972:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a976:	ff d2                	call   *%rdx
ffff80000010a978:	48 89 c7             	mov    %rax,%rdi
ffff80000010a97b:	48 b8 a7 68 ff ff ff 	movabs $0xffffffffffff68a7,%rax
ffff80000010a982:	ff ff ff 
ffff80000010a985:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010a989:	ff d0                	call   *%rax
ffff80000010a98b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010a98f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010a993:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff80000010a997:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a99c:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a9a3:	ff ff ff 
ffff80000010a9a6:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a9aa:	ff d2                	call   *%rdx
ffff80000010a9ac:	4c 8b 60 28          	mov    0x28(%rax),%r12
ffff80000010a9b0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a9b5:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a9bc:	ff ff ff 
ffff80000010a9bf:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a9c3:	ff d2                	call   *%rdx
ffff80000010a9c5:	4c 8b 78 28          	mov    0x28(%rax),%r15
ffff80000010a9c9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a9cd:	4c 8b 68 28          	mov    0x28(%rax),%r13
ffff80000010a9d1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a9d5:	4c 8b 70 28          	mov    0x28(%rax),%r14
ffff80000010a9d9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a9de:	48 ba d6 12 ff ff ff 	movabs $0xffffffffffff12d6,%rdx
ffff80000010a9e5:	ff ff ff 
ffff80000010a9e8:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
ffff80000010a9ec:	ff d2                	call   *%rdx
ffff80000010a9ee:	48 89 c2             	mov    %rax,%rdx
ffff80000010a9f1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010a9f5:	48 89 d7             	mov    %rdx,%rdi
ffff80000010a9f8:	48 89 c6             	mov    %rax,%rsi
ffff80000010a9fb:	55                   	push   %rbp
ffff80000010a9fc:	50                   	push   %rax
ffff80000010a9fd:	49 89 64 24 10       	mov    %rsp,0x10(%r12)
ffff80000010aa02:	49 8b 65 10          	mov    0x10(%r13),%rsp
ffff80000010aa06:	48 8d 05 0d 00 00 00 	lea    0xd(%rip),%rax        # ffff80000010aa1a <task_init+0x3d0>
ffff80000010aa0d:	49 89 47 08          	mov    %rax,0x8(%r15)
ffff80000010aa11:	41 ff 76 08          	push   0x8(%r14)
ffff80000010aa15:	e9 65 fa ff ff       	jmp    ffff80000010a47f <__switch_to>
ffff80000010aa1a:	58                   	pop    %rax
ffff80000010aa1b:	5d                   	pop    %rbp
ffff80000010aa1c:	90                   	nop
ffff80000010aa1d:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
ffff80000010aa21:	5b                   	pop    %rbx
ffff80000010aa22:	41 5c                	pop    %r12
ffff80000010aa24:	41 5d                	pop    %r13
ffff80000010aa26:	41 5e                	pop    %r14
ffff80000010aa28:	41 5f                	pop    %r15
ffff80000010aa2a:	5d                   	pop    %rbp
ffff80000010aa2b:	c3                   	ret    

ffff80000010aa2c <get_cpuid>:
ffff80000010aa2c:	f3 0f 1e fa          	endbr64 
ffff80000010aa30:	55                   	push   %rbp
ffff80000010aa31:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aa34:	53                   	push   %rbx
ffff80000010aa35:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ffff80000010aa35 <get_cpuid+0x9>
ffff80000010aa3c:	49 bb 9b 86 00 00 00 	movabs $0x869b,%r11
ffff80000010aa43:	00 00 00 
ffff80000010aa46:	4c 01 d8             	add    %r11,%rax
ffff80000010aa49:	89 7d f4             	mov    %edi,-0xc(%rbp)
ffff80000010aa4c:	89 75 f0             	mov    %esi,-0x10(%rbp)
ffff80000010aa4f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff80000010aa53:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
ffff80000010aa57:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
ffff80000010aa5b:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
ffff80000010aa5f:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010aa62:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff80000010aa65:	89 d1                	mov    %edx,%ecx
ffff80000010aa67:	0f a2                	cpuid  
ffff80000010aa69:	89 de                	mov    %ebx,%esi
ffff80000010aa6b:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
ffff80000010aa6f:	89 07                	mov    %eax,(%rdi)
ffff80000010aa71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010aa75:	89 30                	mov    %esi,(%rax)
ffff80000010aa77:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010aa7b:	89 08                	mov    %ecx,(%rax)
ffff80000010aa7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010aa81:	89 10                	mov    %edx,(%rax)
ffff80000010aa83:	90                   	nop
ffff80000010aa84:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010aa88:	c9                   	leave  
ffff80000010aa89:	c3                   	ret    

ffff80000010aa8a <init_cpu>:
ffff80000010aa8a:	f3 0f 1e fa          	endbr64 
ffff80000010aa8e:	55                   	push   %rbp
ffff80000010aa8f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aa92:	41 57                	push   %r15
ffff80000010aa94:	53                   	push   %rbx
ffff80000010aa95:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010aa99:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ffff80000010aa99 <init_cpu+0xf>
ffff80000010aaa0:	49 bb 37 86 00 00 00 	movabs $0x8637,%r11
ffff80000010aaa7:	00 00 00 
ffff80000010aaaa:	4c 01 db             	add    %r11,%rbx
ffff80000010aaad:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
ffff80000010aab4:	00 
ffff80000010aab5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
ffff80000010aabc:	00 
ffff80000010aabd:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
ffff80000010aac4:	00 
ffff80000010aac5:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
ffff80000010aacc:	00 
ffff80000010aacd:	c6 45 c0 00          	movb   $0x0,-0x40(%rbp)
ffff80000010aad1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010aad5:	48 8d 70 0c          	lea    0xc(%rax),%rsi
ffff80000010aad9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010aadd:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff80000010aae1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010aae5:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010aae9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010aaed:	49 89 f1             	mov    %rsi,%r9
ffff80000010aaf0:	49 89 c8             	mov    %rcx,%r8
ffff80000010aaf3:	48 89 d1             	mov    %rdx,%rcx
ffff80000010aaf6:	48 89 c2             	mov    %rax,%rdx
ffff80000010aaf9:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010aafe:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010ab03:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010ab0a:	ff ff ff 
ffff80000010ab0d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ab11:	ff d0                	call   *%rax
ffff80000010ab13:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010ab17:	8b 55 d0             	mov    -0x30(%rbp),%edx
ffff80000010ab1a:	89 10                	mov    %edx,(%rax)
ffff80000010ab1c:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010ab20:	48 83 c0 04          	add    $0x4,%rax
ffff80000010ab24:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010ab27:	89 10                	mov    %edx,(%rax)
ffff80000010ab29:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010ab2d:	48 83 c0 08          	add    $0x8,%rax
ffff80000010ab31:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010ab34:	89 10                	mov    %edx,(%rax)
ffff80000010ab36:	c6 45 bc 00          	movb   $0x0,-0x44(%rbp)
ffff80000010ab3a:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010ab3d:	8b 75 dc             	mov    -0x24(%rbp),%esi
ffff80000010ab40:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
ffff80000010ab43:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010ab47:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ab4b:	52                   	push   %rdx
ffff80000010ab4c:	41 89 f1             	mov    %esi,%r9d
ffff80000010ab4f:	41 89 c8             	mov    %ecx,%r8d
ffff80000010ab52:	48 89 c1             	mov    %rax,%rcx
ffff80000010ab55:	48 b8 d0 1f 00 00 00 	movabs $0x1fd0,%rax
ffff80000010ab5c:	00 00 00 
ffff80000010ab5f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ab63:	48 89 c2             	mov    %rax,%rdx
ffff80000010ab66:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ab6b:	bf 00 ff ff 00       	mov    $0xffff00,%edi
ffff80000010ab70:	49 89 df             	mov    %rbx,%r15
ffff80000010ab73:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ab78:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff80000010ab7f:	ff ff ff 
ffff80000010ab82:	49 01 da             	add    %rbx,%r10
ffff80000010ab85:	41 ff d2             	call   *%r10
ffff80000010ab88:	48 83 c4 10          	add    $0x10,%rsp
ffff80000010ab8c:	c7 45 ec 02 00 00 80 	movl   $0x80000002,-0x14(%rbp)
ffff80000010ab93:	e9 ae 00 00 00       	jmp    ffff80000010ac46 <init_cpu+0x1bc>
ffff80000010ab98:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010ab9b:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffff80000010ab9f:	48 8d 7a 0c          	lea    0xc(%rdx),%rdi
ffff80000010aba3:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffff80000010aba7:	48 8d 72 08          	lea    0x8(%rdx),%rsi
ffff80000010abab:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffff80000010abaf:	48 8d 4a 04          	lea    0x4(%rdx),%rcx
ffff80000010abb3:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffff80000010abb7:	49 89 f9             	mov    %rdi,%r9
ffff80000010abba:	49 89 f0             	mov    %rsi,%r8
ffff80000010abbd:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010abc2:	89 c7                	mov    %eax,%edi
ffff80000010abc4:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010abcb:	ff ff ff 
ffff80000010abce:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010abd2:	ff d0                	call   *%rax
ffff80000010abd4:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010abd8:	8b 55 d0             	mov    -0x30(%rbp),%edx
ffff80000010abdb:	89 10                	mov    %edx,(%rax)
ffff80000010abdd:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010abe1:	48 83 c0 04          	add    $0x4,%rax
ffff80000010abe5:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff80000010abe8:	89 10                	mov    %edx,(%rax)
ffff80000010abea:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010abee:	48 83 c0 08          	add    $0x8,%rax
ffff80000010abf2:	8b 55 d8             	mov    -0x28(%rbp),%edx
ffff80000010abf5:	89 10                	mov    %edx,(%rax)
ffff80000010abf7:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010abfb:	48 83 c0 0c          	add    $0xc,%rax
ffff80000010abff:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010ac02:	89 10                	mov    %edx,(%rax)
ffff80000010ac04:	c6 45 bc 00          	movb   $0x0,-0x44(%rbp)
ffff80000010ac08:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
ffff80000010ac0c:	48 89 c1             	mov    %rax,%rcx
ffff80000010ac0f:	48 b8 e9 1f 00 00 00 	movabs $0x1fe9,%rax
ffff80000010ac16:	00 00 00 
ffff80000010ac19:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ac1d:	48 89 c2             	mov    %rax,%rdx
ffff80000010ac20:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ac25:	bf 00 ff ff 00       	mov    $0xffff00,%edi
ffff80000010ac2a:	49 89 df             	mov    %rbx,%r15
ffff80000010ac2d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ac32:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010ac39:	ff ff ff 
ffff80000010ac3c:	49 01 d8             	add    %rbx,%r8
ffff80000010ac3f:	41 ff d0             	call   *%r8
ffff80000010ac42:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff80000010ac46:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010ac49:	3d 04 00 00 80       	cmp    $0x80000004,%eax
ffff80000010ac4e:	0f 86 44 ff ff ff    	jbe    ffff80000010ab98 <init_cpu+0x10e>
ffff80000010ac54:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ac58:	48 8d 70 0c          	lea    0xc(%rax),%rsi
ffff80000010ac5c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ac60:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff80000010ac64:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ac68:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010ac6c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ac70:	49 89 f1             	mov    %rsi,%r9
ffff80000010ac73:	49 89 c8             	mov    %rcx,%r8
ffff80000010ac76:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ac79:	48 89 c2             	mov    %rax,%rdx
ffff80000010ac7c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ac81:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010ac86:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010ac8d:	ff ff ff 
ffff80000010ac90:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ac94:	ff d0                	call   *%rax
ffff80000010ac96:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010ac99:	83 e0 0f             	and    $0xf,%eax
ffff80000010ac9c:	89 c6                	mov    %eax,%esi
ffff80000010ac9e:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010aca1:	c1 e8 0c             	shr    $0xc,%eax
ffff80000010aca4:	83 e0 03             	and    $0x3,%eax
ffff80000010aca7:	89 c1                	mov    %eax,%ecx
ffff80000010aca9:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010acac:	c1 e8 10             	shr    $0x10,%eax
ffff80000010acaf:	83 e0 0f             	and    $0xf,%eax
ffff80000010acb2:	89 c2                	mov    %eax,%edx
ffff80000010acb4:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010acb7:	c1 e8 04             	shr    $0x4,%eax
ffff80000010acba:	83 e0 0f             	and    $0xf,%eax
ffff80000010acbd:	41 89 c0             	mov    %eax,%r8d
ffff80000010acc0:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010acc3:	c1 e8 14             	shr    $0x14,%eax
ffff80000010acc6:	0f b6 f8             	movzbl %al,%edi
ffff80000010acc9:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010accc:	c1 e8 08             	shr    $0x8,%eax
ffff80000010accf:	83 e0 0f             	and    $0xf,%eax
ffff80000010acd2:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010acd6:	56                   	push   %rsi
ffff80000010acd7:	51                   	push   %rcx
ffff80000010acd8:	52                   	push   %rdx
ffff80000010acd9:	45 89 c1             	mov    %r8d,%r9d
ffff80000010acdc:	41 89 f8             	mov    %edi,%r8d
ffff80000010acdf:	89 c1                	mov    %eax,%ecx
ffff80000010ace1:	48 b8 f0 1f 00 00 00 	movabs $0x1ff0,%rax
ffff80000010ace8:	00 00 00 
ffff80000010aceb:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010acef:	48 89 c2             	mov    %rax,%rdx
ffff80000010acf2:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010acf7:	bf 00 ff ff 00       	mov    $0xffff00,%edi
ffff80000010acfc:	49 89 df             	mov    %rbx,%r15
ffff80000010acff:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ad04:	49 ba 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r10
ffff80000010ad0b:	ff ff ff 
ffff80000010ad0e:	49 01 da             	add    %rbx,%r10
ffff80000010ad11:	41 ff d2             	call   *%r10
ffff80000010ad14:	48 83 c4 20          	add    $0x20,%rsp
ffff80000010ad18:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ad1c:	48 8d 70 0c          	lea    0xc(%rax),%rsi
ffff80000010ad20:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ad24:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff80000010ad28:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ad2c:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010ad30:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ad34:	49 89 f1             	mov    %rsi,%r9
ffff80000010ad37:	49 89 c8             	mov    %rcx,%r8
ffff80000010ad3a:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ad3d:	48 89 c2             	mov    %rax,%rdx
ffff80000010ad40:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ad45:	bf 08 00 00 80       	mov    $0x80000008,%edi
ffff80000010ad4a:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010ad51:	ff ff ff 
ffff80000010ad54:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ad58:	ff d0                	call   *%rax
ffff80000010ad5a:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010ad5d:	c1 e8 08             	shr    $0x8,%eax
ffff80000010ad60:	0f b6 d0             	movzbl %al,%edx
ffff80000010ad63:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010ad66:	0f b6 c0             	movzbl %al,%eax
ffff80000010ad69:	41 89 d0             	mov    %edx,%r8d
ffff80000010ad6c:	89 c1                	mov    %eax,%ecx
ffff80000010ad6e:	48 b8 70 20 00 00 00 	movabs $0x2070,%rax
ffff80000010ad75:	00 00 00 
ffff80000010ad78:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ad7c:	48 89 c2             	mov    %rax,%rdx
ffff80000010ad7f:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ad84:	bf 00 ff ff 00       	mov    $0xffff00,%edi
ffff80000010ad89:	49 89 df             	mov    %rbx,%r15
ffff80000010ad8c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ad91:	49 b9 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r9
ffff80000010ad98:	ff ff ff 
ffff80000010ad9b:	49 01 d9             	add    %rbx,%r9
ffff80000010ad9e:	41 ff d1             	call   *%r9
ffff80000010ada1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ada5:	48 8d 70 0c          	lea    0xc(%rax),%rsi
ffff80000010ada9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010adad:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff80000010adb1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010adb5:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010adb9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010adbd:	49 89 f1             	mov    %rsi,%r9
ffff80000010adc0:	49 89 c8             	mov    %rcx,%r8
ffff80000010adc3:	48 89 d1             	mov    %rdx,%rcx
ffff80000010adc6:	48 89 c2             	mov    %rax,%rdx
ffff80000010adc9:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010adce:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010add3:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010adda:	ff ff ff 
ffff80000010addd:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ade1:	ff d0                	call   *%rax
ffff80000010ade3:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010ade6:	89 c1                	mov    %eax,%ecx
ffff80000010ade8:	48 b8 a8 20 00 00 00 	movabs $0x20a8,%rax
ffff80000010adef:	00 00 00 
ffff80000010adf2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010adf6:	48 89 c2             	mov    %rax,%rdx
ffff80000010adf9:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010adfe:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010ae03:	49 89 df             	mov    %rbx,%r15
ffff80000010ae06:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ae0b:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010ae12:	ff ff ff 
ffff80000010ae15:	49 01 d8             	add    %rbx,%r8
ffff80000010ae18:	41 ff d0             	call   *%r8
ffff80000010ae1b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ae1f:	48 8d 70 0c          	lea    0xc(%rax),%rsi
ffff80000010ae23:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ae27:	48 8d 48 08          	lea    0x8(%rax),%rcx
ffff80000010ae2b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ae2f:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010ae33:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010ae37:	49 89 f1             	mov    %rsi,%r9
ffff80000010ae3a:	49 89 c8             	mov    %rcx,%r8
ffff80000010ae3d:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ae40:	48 89 c2             	mov    %rax,%rdx
ffff80000010ae43:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae48:	bf 00 00 00 80       	mov    $0x80000000,%edi
ffff80000010ae4d:	48 b8 5c 79 ff ff ff 	movabs $0xffffffffffff795c,%rax
ffff80000010ae54:	ff ff ff 
ffff80000010ae57:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ae5b:	ff d0                	call   *%rax
ffff80000010ae5d:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffff80000010ae60:	89 c1                	mov    %eax,%ecx
ffff80000010ae62:	48 b8 d0 20 00 00 00 	movabs $0x20d0,%rax
ffff80000010ae69:	00 00 00 
ffff80000010ae6c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
ffff80000010ae70:	48 89 c2             	mov    %rax,%rdx
ffff80000010ae73:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae78:	bf ff ff ff 00       	mov    $0xffffff,%edi
ffff80000010ae7d:	49 89 df             	mov    %rbx,%r15
ffff80000010ae80:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ae85:	49 b8 3d 17 ff ff ff 	movabs $0xffffffffffff173d,%r8
ffff80000010ae8c:	ff ff ff 
ffff80000010ae8f:	49 01 d8             	add    %rbx,%r8
ffff80000010ae92:	41 ff d0             	call   *%r8
ffff80000010ae95:	90                   	nop
ffff80000010ae96:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff80000010ae9a:	5b                   	pop    %rbx
ffff80000010ae9b:	41 5f                	pop    %r15
ffff80000010ae9d:	5d                   	pop    %rbp
ffff80000010ae9e:	c3                   	ret    
