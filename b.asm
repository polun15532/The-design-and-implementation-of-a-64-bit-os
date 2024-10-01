
./src/user/system_api_lib:     file format elf64-x86-64


Disassembly of section .text:

0000000000800000 <main>:
  800000:	f3 0f 1e fa          	endbr64 
  800004:	55                   	push   %rbp
  800005:	48 89 e5             	mov    %rsp,%rbp
  800008:	41 57                	push   %r15
  80000a:	53                   	push   %rbx
  80000b:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  800012:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 800012 <main+0x12>
  800019:	49 bb 4e 38 00 00 00 	movabs $0x384e,%r11
  800020:	00 00 00 
  800023:	4c 01 db             	add    %r11,%rbx
  800026:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  80002d:	48 c7 85 e0 fe ff ff 	movq   $0x0,-0x120(%rbp)
  800034:	00 00 00 00 
  800038:	48 c7 85 e8 fe ff ff 	movq   $0x0,-0x118(%rbp)
  80003f:	00 00 00 00 
  800043:	48 c7 85 f0 fe ff ff 	movq   $0x0,-0x110(%rbp)
  80004a:	00 00 00 00 
  80004e:	48 c7 85 f8 fe ff ff 	movq   $0x0,-0x108(%rbp)
  800055:	00 00 00 00 
  800059:	48 c7 85 00 ff ff ff 	movq   $0x0,-0x100(%rbp)
  800060:	00 00 00 00 
  800064:	48 c7 85 08 ff ff ff 	movq   $0x0,-0xf8(%rbp)
  80006b:	00 00 00 00 
  80006f:	48 c7 85 10 ff ff ff 	movq   $0x0,-0xf0(%rbp)
  800076:	00 00 00 00 
  80007a:	48 c7 85 18 ff ff ff 	movq   $0x0,-0xe8(%rbp)
  800081:	00 00 00 00 
  800085:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
  80008c:	00 00 00 00 
  800090:	48 c7 85 28 ff ff ff 	movq   $0x0,-0xd8(%rbp)
  800097:	00 00 00 00 
  80009b:	48 c7 85 30 ff ff ff 	movq   $0x0,-0xd0(%rbp)
  8000a2:	00 00 00 00 
  8000a6:	48 c7 85 38 ff ff ff 	movq   $0x0,-0xc8(%rbp)
  8000ad:	00 00 00 00 
  8000b1:	48 c7 85 40 ff ff ff 	movq   $0x0,-0xc0(%rbp)
  8000b8:	00 00 00 00 
  8000bc:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
  8000c3:	00 00 00 00 
  8000c7:	48 c7 85 50 ff ff ff 	movq   $0x0,-0xb0(%rbp)
  8000ce:	00 00 00 00 
  8000d2:	48 c7 85 58 ff ff ff 	movq   $0x0,-0xa8(%rbp)
  8000d9:	00 00 00 00 
  8000dd:	48 c7 85 60 ff ff ff 	movq   $0x0,-0xa0(%rbp)
  8000e4:	00 00 00 00 
  8000e8:	48 c7 85 68 ff ff ff 	movq   $0x0,-0x98(%rbp)
  8000ef:	00 00 00 00 
  8000f3:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
  8000fa:	00 00 00 00 
  8000fe:	48 c7 85 78 ff ff ff 	movq   $0x0,-0x88(%rbp)
  800105:	00 00 00 00 
  800109:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
  800110:	00 
  800111:	48 c7 45 88 00 00 00 	movq   $0x0,-0x78(%rbp)
  800118:	00 
  800119:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
  800120:	00 
  800121:	48 c7 45 98 00 00 00 	movq   $0x0,-0x68(%rbp)
  800128:	00 
  800129:	48 c7 45 a0 00 00 00 	movq   $0x0,-0x60(%rbp)
  800130:	00 
  800131:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
  800138:	00 
  800139:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
  800140:	00 
  800141:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
  800148:	00 
  800149:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
  800150:	00 
  800151:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
  800158:	00 
  800159:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
  800160:	00 
  800161:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  800168:	00 
  800169:	48 b8 2f 4b 45 59 42 	movabs $0x52414f4259454b2f,%rax
  800170:	4f 41 52 
  800173:	48 89 85 d2 fe ff ff 	mov    %rax,-0x12e(%rbp)
  80017a:	c7 85 da fe ff ff 44 	movl   $0x45442e44,-0x126(%rbp)
  800181:	2e 44 45 
  800184:	66 c7 85 de fe ff ff 	movw   $0x56,-0x122(%rbp)
  80018b:	56 00 
  80018d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
  800194:	48 8d 85 d2 fe ff ff 	lea    -0x12e(%rbp),%rax
  80019b:	be 00 00 00 00       	mov    $0x0,%esi
  8001a0:	48 89 c7             	mov    %rax,%rdi
  8001a3:	49 89 df             	mov    %rbx,%r15
  8001a6:	48 b8 a5 e0 ff ff ff 	movabs $0xffffffffffffe0a5,%rax
  8001ad:	ff ff ff 
  8001b0:	48 01 d8             	add    %rbx,%rax
  8001b3:	ff d0                	call   *%rax
  8001b5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8001b8:	c7 85 cc fe ff ff 00 	movl   $0x0,-0x134(%rbp)
  8001bf:	00 00 00 
  8001c2:	48 c7 85 c0 fe ff ff 	movq   $0x0,-0x140(%rbp)
  8001c9:	00 00 00 00 
  8001cd:	48 b8 18 00 00 00 00 	movabs $0x18,%rax
  8001d4:	00 00 00 
  8001d7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8001db:	48 89 c7             	mov    %rax,%rdi
  8001de:	49 89 df             	mov    %rbx,%r15
  8001e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8001e6:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  8001ed:	ff ff ff 
  8001f0:	48 01 da             	add    %rbx,%rdx
  8001f3:	ff d2                	call   *%rdx
  8001f5:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
  8001fc:	ba 00 01 00 00       	mov    $0x100,%edx
  800201:	be 00 00 00 00       	mov    $0x0,%esi
  800206:	48 89 c7             	mov    %rax,%rdi
  800209:	49 89 df             	mov    %rbx,%r15
  80020c:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  800213:	ff ff ff 
  800216:	48 01 d8             	add    %rbx,%rax
  800219:	ff d0                	call   *%rax
  80021b:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
  800222:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800225:	48 89 d6             	mov    %rdx,%rsi
  800228:	89 c7                	mov    %eax,%edi
  80022a:	48 b8 0f de ff ff ff 	movabs $0xffffffffffffde0f,%rax
  800231:	ff ff ff 
  800234:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800238:	ff d0                	call   *%rax
  80023a:	48 b8 22 00 00 00 00 	movabs $0x22,%rax
  800241:	00 00 00 
  800244:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800248:	48 89 c7             	mov    %rax,%rdi
  80024b:	49 89 df             	mov    %rbx,%r15
  80024e:	b8 00 00 00 00       	mov    $0x0,%eax
  800253:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80025a:	ff ff ff 
  80025d:	48 01 da             	add    %rbx,%rdx
  800260:	ff d2                	call   *%rdx
  800262:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
  800269:	48 8d 8d cc fe ff ff 	lea    -0x134(%rbp),%rcx
  800270:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
  800277:	48 89 ce             	mov    %rcx,%rsi
  80027a:	48 89 c7             	mov    %rax,%rdi
  80027d:	48 b8 c0 de ff ff ff 	movabs $0xffffffffffffdec0,%rax
  800284:	ff ff ff 
  800287:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80028b:	ff d0                	call   *%rax
  80028d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800290:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800294:	79 2d                	jns    8002c3 <main+0x2c3>
  800296:	48 b8 24 00 00 00 00 	movabs $0x24,%rax
  80029d:	00 00 00 
  8002a0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8002a4:	48 89 c7             	mov    %rax,%rdi
  8002a7:	49 89 df             	mov    %rbx,%r15
  8002aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8002af:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  8002b6:	ff ff ff 
  8002b9:	48 01 da             	add    %rbx,%rdx
  8002bc:	ff d2                	call   *%rdx
  8002be:	e9 f5 fe ff ff       	jmp    8001b8 <main+0x1b8>
  8002c3:	48 8b 95 c0 fe ff ff 	mov    -0x140(%rbp),%rdx
  8002ca:	8b 8d cc fe ff ff    	mov    -0x134(%rbp),%ecx
  8002d0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8002d3:	89 ce                	mov    %ecx,%esi
  8002d5:	89 c7                	mov    %eax,%edi
  8002d7:	48 b8 64 d9 ff ff ff 	movabs $0xffffffffffffd964,%rax
  8002de:	ff ff ff 
  8002e1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8002e5:	ff d0                	call   *%rax
  8002e7:	e9 cc fe ff ff       	jmp    8001b8 <main+0x1b8>

00000000008002ec <simplifyPath>:
  8002ec:	f3 0f 1e fa          	endbr64 
  8002f0:	55                   	push   %rbp
  8002f1:	48 89 e5             	mov    %rsp,%rbp
  8002f4:	41 57                	push   %r15
  8002f6:	53                   	push   %rbx
  8002f7:	48 81 ec 30 04 00 00 	sub    $0x430,%rsp
  8002fe:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8002fe <simplifyPath+0x12>
  800305:	49 bb 62 35 00 00 00 	movabs $0x3562,%r11
  80030c:	00 00 00 
  80030f:	4c 01 db             	add    %r11,%rbx
  800312:	48 89 bd c8 fb ff ff 	mov    %rdi,-0x438(%rbp)
  800319:	48 89 b5 c0 fb ff ff 	mov    %rsi,-0x440(%rbp)
  800320:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  800327:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  80032e:	48 89 c7             	mov    %rax,%rdi
  800331:	49 89 df             	mov    %rbx,%r15
  800334:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  80033b:	ff ff ff 
  80033e:	48 01 d8             	add    %rbx,%rax
  800341:	ff d0                	call   *%rax
  800343:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800346:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  80034d:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  800354:	0f b6 00             	movzbl (%rax),%eax
  800357:	3c 2f                	cmp    $0x2f,%al
  800359:	75 40                	jne    80039b <simplifyPath+0xaf>
  80035b:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  800362:	48 ba 35 00 00 00 00 	movabs $0x35,%rdx
  800369:	00 00 00 
  80036c:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  800370:	48 89 d6             	mov    %rdx,%rsi
  800373:	48 89 c7             	mov    %rax,%rdi
  800376:	49 89 df             	mov    %rbx,%r15
  800379:	48 b8 aa f2 ff ff ff 	movabs $0xfffffffffffff2aa,%rax
  800380:	ff ff ff 
  800383:	48 01 d8             	add    %rbx,%rax
  800386:	ff d0                	call   *%rax
  800388:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
  80038f:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%rbp)
  800396:	e9 c3 02 00 00       	jmp    80065e <simplifyPath+0x372>
  80039b:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8003a2:	48 89 c7             	mov    %rax,%rdi
  8003a5:	49 89 df             	mov    %rbx,%r15
  8003a8:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  8003af:	ff ff ff 
  8003b2:	48 01 d8             	add    %rbx,%rax
  8003b5:	ff d0                	call   *%rax
  8003b7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  8003ba:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  8003be:	0f 8e 9a 02 00 00    	jle    80065e <simplifyPath+0x372>
  8003c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8003c7:	48 98                	cltq   
  8003c9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8003cd:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8003d4:	48 01 d0             	add    %rdx,%rax
  8003d7:	0f b6 00             	movzbl (%rax),%eax
  8003da:	3c 2f                	cmp    $0x2f,%al
  8003dc:	0f 84 7c 02 00 00    	je     80065e <simplifyPath+0x372>
  8003e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8003e5:	8d 50 01             	lea    0x1(%rax),%edx
  8003e8:	89 55 ec             	mov    %edx,-0x14(%rbp)
  8003eb:	48 63 d0             	movslq %eax,%rdx
  8003ee:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8003f5:	48 01 d0             	add    %rdx,%rax
  8003f8:	c6 00 2f             	movb   $0x2f,(%rax)
  8003fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8003fe:	48 63 d0             	movslq %eax,%rdx
  800401:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  800408:	48 01 d0             	add    %rdx,%rax
  80040b:	c6 00 00             	movb   $0x0,(%rax)
  80040e:	e9 4b 02 00 00       	jmp    80065e <simplifyPath+0x372>
  800413:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  800417:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80041a:	48 63 d0             	movslq %eax,%rdx
  80041d:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  800424:	48 01 d0             	add    %rdx,%rax
  800427:	0f b6 00             	movzbl (%rax),%eax
  80042a:	3c 2f                	cmp    $0x2f,%al
  80042c:	74 e5                	je     800413 <simplifyPath+0x127>
  80042e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  800435:	eb 33                	jmp    80046a <simplifyPath+0x17e>
  800437:	81 7d e4 fe 03 00 00 	cmpl   $0x3fe,-0x1c(%rbp)
  80043e:	7f 26                	jg     800466 <simplifyPath+0x17a>
  800440:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800443:	48 63 d0             	movslq %eax,%rdx
  800446:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  80044d:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  800451:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800454:	8d 50 01             	lea    0x1(%rax),%edx
  800457:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  80045a:	0f b6 11             	movzbl (%rcx),%edx
  80045d:	48 98                	cltq   
  80045f:	88 94 05 d0 fb ff ff 	mov    %dl,-0x430(%rbp,%rax,1)
  800466:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  80046a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80046d:	48 63 d0             	movslq %eax,%rdx
  800470:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  800477:	48 01 d0             	add    %rdx,%rax
  80047a:	0f b6 00             	movzbl (%rax),%eax
  80047d:	3c 2f                	cmp    $0x2f,%al
  80047f:	74 17                	je     800498 <simplifyPath+0x1ac>
  800481:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800484:	48 63 d0             	movslq %eax,%rdx
  800487:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  80048e:	48 01 d0             	add    %rdx,%rax
  800491:	0f b6 00             	movzbl (%rax),%eax
  800494:	84 c0                	test   %al,%al
  800496:	75 9f                	jne    800437 <simplifyPath+0x14b>
  800498:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  80049b:	48 98                	cltq   
  80049d:	c6 84 05 d0 fb ff ff 	movb   $0x0,-0x430(%rbp,%rax,1)
  8004a4:	00 
  8004a5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  8004a9:	0f 84 bd 01 00 00    	je     80066c <simplifyPath+0x380>
  8004af:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  8004b6:	48 ba 37 00 00 00 00 	movabs $0x37,%rdx
  8004bd:	00 00 00 
  8004c0:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  8004c4:	48 89 d6             	mov    %rdx,%rsi
  8004c7:	48 89 c7             	mov    %rax,%rdi
  8004ca:	49 89 df             	mov    %rbx,%r15
  8004cd:	48 b8 7f f3 ff ff ff 	movabs $0xfffffffffffff37f,%rax
  8004d4:	ff ff ff 
  8004d7:	48 01 d8             	add    %rbx,%rax
  8004da:	ff d0                	call   *%rax
  8004dc:	85 c0                	test   %eax,%eax
  8004de:	75 66                	jne    800546 <simplifyPath+0x25a>
  8004e0:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  8004e4:	0f 8e 5d 01 00 00    	jle    800647 <simplifyPath+0x35b>
  8004ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8004ed:	48 98                	cltq   
  8004ef:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  8004f3:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8004fa:	48 01 d0             	add    %rdx,%rax
  8004fd:	0f b6 00             	movzbl (%rax),%eax
  800500:	3c 2f                	cmp    $0x2f,%al
  800502:	75 0a                	jne    80050e <simplifyPath+0x222>
  800504:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
  800508:	eb 04                	jmp    80050e <simplifyPath+0x222>
  80050a:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
  80050e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800512:	7e 1a                	jle    80052e <simplifyPath+0x242>
  800514:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800517:	48 98                	cltq   
  800519:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  80051d:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  800524:	48 01 d0             	add    %rdx,%rax
  800527:	0f b6 00             	movzbl (%rax),%eax
  80052a:	3c 2f                	cmp    $0x2f,%al
  80052c:	75 dc                	jne    80050a <simplifyPath+0x21e>
  80052e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800531:	48 63 d0             	movslq %eax,%rdx
  800534:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  80053b:	48 01 d0             	add    %rdx,%rax
  80053e:	c6 00 00             	movb   $0x0,(%rax)
  800541:	e9 01 01 00 00       	jmp    800647 <simplifyPath+0x35b>
  800546:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  80054d:	48 ba 3a 00 00 00 00 	movabs $0x3a,%rdx
  800554:	00 00 00 
  800557:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  80055b:	48 89 d6             	mov    %rdx,%rsi
  80055e:	48 89 c7             	mov    %rax,%rdi
  800561:	49 89 df             	mov    %rbx,%r15
  800564:	48 b8 7f f3 ff ff ff 	movabs $0xfffffffffffff37f,%rax
  80056b:	ff ff ff 
  80056e:	48 01 d8             	add    %rbx,%rax
  800571:	ff d0                	call   *%rax
  800573:	85 c0                	test   %eax,%eax
  800575:	0f 84 cc 00 00 00    	je     800647 <simplifyPath+0x35b>
  80057b:	81 7d ec fe 03 00 00 	cmpl   $0x3fe,-0x14(%rbp)
  800582:	0f 8f 91 00 00 00    	jg     800619 <simplifyPath+0x32d>
  800588:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  80058c:	7e 33                	jle    8005c1 <simplifyPath+0x2d5>
  80058e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800591:	48 98                	cltq   
  800593:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  800597:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  80059e:	48 01 d0             	add    %rdx,%rax
  8005a1:	0f b6 00             	movzbl (%rax),%eax
  8005a4:	3c 2f                	cmp    $0x2f,%al
  8005a6:	74 19                	je     8005c1 <simplifyPath+0x2d5>
  8005a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8005ab:	8d 50 01             	lea    0x1(%rax),%edx
  8005ae:	89 55 ec             	mov    %edx,-0x14(%rbp)
  8005b1:	48 63 d0             	movslq %eax,%rdx
  8005b4:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8005bb:	48 01 d0             	add    %rdx,%rax
  8005be:	c6 00 2f             	movb   $0x2f,(%rax)
  8005c1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  8005c8:	eb 29                	jmp    8005f3 <simplifyPath+0x307>
  8005ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8005cd:	8d 50 01             	lea    0x1(%rax),%edx
  8005d0:	89 55 ec             	mov    %edx,-0x14(%rbp)
  8005d3:	48 63 d0             	movslq %eax,%rdx
  8005d6:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8005dd:	48 01 c2             	add    %rax,%rdx
  8005e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8005e3:	48 98                	cltq   
  8005e5:	0f b6 84 05 d0 fb ff 	movzbl -0x430(%rbp,%rax,1),%eax
  8005ec:	ff 
  8005ed:	88 02                	mov    %al,(%rdx)
  8005ef:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
  8005f3:	8b 45 e0             	mov    -0x20(%rbp),%eax
  8005f6:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  8005f9:	7d 09                	jge    800604 <simplifyPath+0x318>
  8005fb:	81 7d ec fe 03 00 00 	cmpl   $0x3fe,-0x14(%rbp)
  800602:	7e c6                	jle    8005ca <simplifyPath+0x2de>
  800604:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800607:	48 63 d0             	movslq %eax,%rdx
  80060a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  800611:	48 01 d0             	add    %rdx,%rax
  800614:	c6 00 00             	movb   $0x0,(%rax)
  800617:	eb 2e                	jmp    800647 <simplifyPath+0x35b>
  800619:	48 b8 3c 00 00 00 00 	movabs $0x3c,%rax
  800620:	00 00 00 
  800623:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800627:	48 89 c7             	mov    %rax,%rdi
  80062a:	49 89 df             	mov    %rbx,%r15
  80062d:	b8 00 00 00 00       	mov    $0x0,%eax
  800632:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800639:	ff ff ff 
  80063c:	48 01 da             	add    %rbx,%rdx
  80063f:	ff d2                	call   *%rdx
  800641:	eb 2a                	jmp    80066d <simplifyPath+0x381>
  800643:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  800647:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80064a:	48 63 d0             	movslq %eax,%rdx
  80064d:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  800654:	48 01 d0             	add    %rdx,%rax
  800657:	0f b6 00             	movzbl (%rax),%eax
  80065a:	3c 2f                	cmp    $0x2f,%al
  80065c:	74 e5                	je     800643 <simplifyPath+0x357>
  80065e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  800661:	3b 45 dc             	cmp    -0x24(%rbp),%eax
  800664:	0f 8e ad fd ff ff    	jle    800417 <simplifyPath+0x12b>
  80066a:	eb 01                	jmp    80066d <simplifyPath+0x381>
  80066c:	90                   	nop
  80066d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  800671:	75 2f                	jne    8006a2 <simplifyPath+0x3b6>
  800673:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  80067a:	48 ba 35 00 00 00 00 	movabs $0x35,%rdx
  800681:	00 00 00 
  800684:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  800688:	48 89 d6             	mov    %rdx,%rsi
  80068b:	48 89 c7             	mov    %rax,%rdi
  80068e:	49 89 df             	mov    %rbx,%r15
  800691:	48 b8 aa f2 ff ff ff 	movabs $0xfffffffffffff2aa,%rax
  800698:	ff ff ff 
  80069b:	48 01 d8             	add    %rbx,%rax
  80069e:	ff d0                	call   *%rax
  8006a0:	eb 13                	jmp    8006b5 <simplifyPath+0x3c9>
  8006a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8006a5:	48 63 d0             	movslq %eax,%rdx
  8006a8:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  8006af:	48 01 d0             	add    %rdx,%rax
  8006b2:	c6 00 00             	movb   $0x0,(%rax)
  8006b5:	90                   	nop
  8006b6:	48 81 c4 30 04 00 00 	add    $0x430,%rsp
  8006bd:	5b                   	pop    %rbx
  8006be:	41 5f                	pop    %r15
  8006c0:	5d                   	pop    %rbp
  8006c1:	c3                   	ret    

00000000008006c2 <cd_command>:
  8006c2:	f3 0f 1e fa          	endbr64 
  8006c6:	55                   	push   %rbp
  8006c7:	48 89 e5             	mov    %rsp,%rbp
  8006ca:	41 57                	push   %r15
  8006cc:	53                   	push   %rbx
  8006cd:	48 81 ec 10 04 00 00 	sub    $0x410,%rsp
  8006d4:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8006d4 <cd_command+0x12>
  8006db:	49 bb 8c 31 00 00 00 	movabs $0x318c,%r11
  8006e2:	00 00 00 
  8006e5:	4c 01 db             	add    %r11,%rbx
  8006e8:	89 bd ec fb ff ff    	mov    %edi,-0x414(%rbp)
  8006ee:	48 89 b5 e0 fb ff ff 	mov    %rsi,-0x420(%rbp)
  8006f5:	83 bd ec fb ff ff 01 	cmpl   $0x1,-0x414(%rbp)
  8006fc:	7f 32                	jg     800730 <cd_command+0x6e>
  8006fe:	48 b8 4b 00 00 00 00 	movabs $0x4b,%rax
  800705:	00 00 00 
  800708:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80070c:	48 89 c7             	mov    %rax,%rdi
  80070f:	49 89 df             	mov    %rbx,%r15
  800712:	b8 00 00 00 00       	mov    $0x0,%eax
  800717:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80071e:	ff ff ff 
  800721:	48 01 da             	add    %rbx,%rdx
  800724:	ff d2                	call   *%rdx
  800726:	b8 01 00 00 00       	mov    $0x1,%eax
  80072b:	e9 6a 01 00 00       	jmp    80089a <cd_command+0x1d8>
  800730:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  800737:	ba ff 03 00 00       	mov    $0x3ff,%edx
  80073c:	48 b9 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rcx
  800743:	ff ff ff 
  800746:	48 8d 0c 0b          	lea    (%rbx,%rcx,1),%rcx
  80074a:	48 89 ce             	mov    %rcx,%rsi
  80074d:	48 89 c7             	mov    %rax,%rdi
  800750:	49 89 df             	mov    %rbx,%r15
  800753:	48 b8 e9 f2 ff ff ff 	movabs $0xfffffffffffff2e9,%rax
  80075a:	ff ff ff 
  80075d:	48 01 d8             	add    %rbx,%rax
  800760:	ff d0                	call   *%rax
  800762:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  800766:	48 8b 85 e0 fb ff ff 	mov    -0x420(%rbp),%rax
  80076d:	48 83 c0 08          	add    $0x8,%rax
  800771:	48 8b 10             	mov    (%rax),%rdx
  800774:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  80077b:	48 89 d6             	mov    %rdx,%rsi
  80077e:	48 89 c7             	mov    %rax,%rdi
  800781:	48 b8 8c ca ff ff ff 	movabs $0xffffffffffffca8c,%rax
  800788:	ff ff ff 
  80078b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80078f:	ff d0                	call   *%rax
  800791:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  800798:	48 89 c6             	mov    %rax,%rsi
  80079b:	48 b8 61 00 00 00 00 	movabs $0x61,%rax
  8007a2:	00 00 00 
  8007a5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8007a9:	48 89 c7             	mov    %rax,%rdi
  8007ac:	49 89 df             	mov    %rbx,%r15
  8007af:	b8 00 00 00 00       	mov    $0x0,%eax
  8007b4:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  8007bb:	ff ff ff 
  8007be:	48 01 da             	add    %rbx,%rdx
  8007c1:	ff d2                	call   *%rdx
  8007c3:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  8007ca:	48 89 c7             	mov    %rax,%rdi
  8007cd:	49 89 df             	mov    %rbx,%r15
  8007d0:	48 b8 11 e1 ff ff ff 	movabs $0xffffffffffffe111,%rax
  8007d7:	ff ff ff 
  8007da:	48 01 d8             	add    %rbx,%rax
  8007dd:	ff d0                	call   *%rax
  8007df:	48 85 c0             	test   %rax,%rax
  8007e2:	75 7f                	jne    800863 <cd_command+0x1a1>
  8007e4:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  8007eb:	ba ff 03 00 00       	mov    $0x3ff,%edx
  8007f0:	48 89 c6             	mov    %rax,%rsi
  8007f3:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  8007fa:	ff ff ff 
  8007fd:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800801:	48 89 c7             	mov    %rax,%rdi
  800804:	49 89 df             	mov    %rbx,%r15
  800807:	48 b8 e9 f2 ff ff ff 	movabs $0xfffffffffffff2e9,%rax
  80080e:	ff ff ff 
  800811:	48 01 d8             	add    %rbx,%rax
  800814:	ff d0                	call   *%rax
  800816:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  80081d:	ff ff ff 
  800820:	c6 84 03 ff 03 00 00 	movb   $0x0,0x3ff(%rbx,%rax,1)
  800827:	00 
  800828:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  80082f:	ff ff ff 
  800832:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800836:	48 89 c6             	mov    %rax,%rsi
  800839:	48 b8 76 00 00 00 00 	movabs $0x76,%rax
  800840:	00 00 00 
  800843:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800847:	48 89 c7             	mov    %rax,%rdi
  80084a:	49 89 df             	mov    %rbx,%r15
  80084d:	b8 00 00 00 00       	mov    $0x0,%eax
  800852:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800859:	ff ff ff 
  80085c:	48 01 da             	add    %rbx,%rdx
  80085f:	ff d2                	call   *%rdx
  800861:	eb 32                	jmp    800895 <cd_command+0x1d3>
  800863:	48 8d 85 f0 fb ff ff 	lea    -0x410(%rbp),%rax
  80086a:	48 89 c6             	mov    %rax,%rsi
  80086d:	48 b8 88 00 00 00 00 	movabs $0x88,%rax
  800874:	00 00 00 
  800877:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80087b:	48 89 c7             	mov    %rax,%rdi
  80087e:	49 89 df             	mov    %rbx,%r15
  800881:	b8 00 00 00 00       	mov    $0x0,%eax
  800886:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80088d:	ff ff ff 
  800890:	48 01 da             	add    %rbx,%rdx
  800893:	ff d2                	call   *%rdx
  800895:	b8 01 00 00 00       	mov    $0x1,%eax
  80089a:	48 81 c4 10 04 00 00 	add    $0x410,%rsp
  8008a1:	5b                   	pop    %rbx
  8008a2:	41 5f                	pop    %r15
  8008a4:	5d                   	pop    %rbp
  8008a5:	c3                   	ret    

00000000008008a6 <ls_command>:
  8008a6:	f3 0f 1e fa          	endbr64 
  8008aa:	55                   	push   %rbp
  8008ab:	48 89 e5             	mov    %rsp,%rbp
  8008ae:	41 57                	push   %r15
  8008b0:	53                   	push   %rbx
  8008b1:	48 83 ec 20          	sub    $0x20,%rsp
  8008b5:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8008b5 <ls_command+0xf>
  8008bc:	49 bb ab 2f 00 00 00 	movabs $0x2fab,%r11
  8008c3:	00 00 00 
  8008c6:	4c 01 db             	add    %r11,%rbx
  8008c9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  8008cc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  8008d0:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  8008d7:	00 
  8008d8:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
  8008df:	00 
  8008e0:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  8008e7:	ff ff ff 
  8008ea:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8008ee:	48 89 c7             	mov    %rax,%rdi
  8008f1:	49 89 df             	mov    %rbx,%r15
  8008f4:	48 b8 79 f4 ff ff ff 	movabs $0xfffffffffffff479,%rax
  8008fb:	ff ff ff 
  8008fe:	48 01 d8             	add    %rbx,%rax
  800901:	ff d0                	call   *%rax
  800903:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  800907:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80090b:	8b 00                	mov    (%rax),%eax
  80090d:	89 c6                	mov    %eax,%esi
  80090f:	48 b8 9b 00 00 00 00 	movabs $0x9b,%rax
  800916:	00 00 00 
  800919:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80091d:	48 89 c7             	mov    %rax,%rdi
  800920:	49 89 df             	mov    %rbx,%r15
  800923:	b8 00 00 00 00       	mov    $0x0,%eax
  800928:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80092f:	ff ff ff 
  800932:	48 01 da             	add    %rbx,%rdx
  800935:	ff d2                	call   *%rdx
  800937:	bf 00 01 00 00       	mov    $0x100,%edi
  80093c:	49 89 df             	mov    %rbx,%r15
  80093f:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  800946:	ff ff ff 
  800949:	48 01 d8             	add    %rbx,%rax
  80094c:	ff d0                	call   *%rax
  80094e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800952:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  800956:	48 89 c7             	mov    %rax,%rdi
  800959:	49 89 df             	mov    %rbx,%r15
  80095c:	48 b8 af f5 ff ff ff 	movabs $0xfffffffffffff5af,%rax
  800963:	ff ff ff 
  800966:	48 01 d8             	add    %rbx,%rax
  800969:	ff d0                	call   *%rax
  80096b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80096f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  800974:	74 3d                	je     8009b3 <ls_command+0x10d>
  800976:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  80097a:	48 8d 50 18          	lea    0x18(%rax),%rdx
  80097e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800982:	48 8b 40 10          	mov    0x10(%rax),%rax
  800986:	48 89 c6             	mov    %rax,%rsi
  800989:	48 b8 b8 00 00 00 00 	movabs $0xb8,%rax
  800990:	00 00 00 
  800993:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800997:	48 89 c7             	mov    %rax,%rdi
  80099a:	49 89 df             	mov    %rbx,%r15
  80099d:	b8 00 00 00 00       	mov    $0x0,%eax
  8009a2:	48 b9 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rcx
  8009a9:	ff ff ff 
  8009ac:	48 01 d9             	add    %rbx,%rcx
  8009af:	ff d1                	call   *%rcx
  8009b1:	eb 9f                	jmp    800952 <ls_command+0xac>
  8009b3:	90                   	nop
  8009b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8009b8:	48 89 c7             	mov    %rax,%rdi
  8009bb:	49 89 df             	mov    %rbx,%r15
  8009be:	48 b8 47 f5 ff ff ff 	movabs $0xfffffffffffff547,%rax
  8009c5:	ff ff ff 
  8009c8:	48 01 d8             	add    %rbx,%rax
  8009cb:	ff d0                	call   *%rax
  8009cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8009d2:	48 83 c4 20          	add    $0x20,%rsp
  8009d6:	5b                   	pop    %rbx
  8009d7:	41 5f                	pop    %r15
  8009d9:	5d                   	pop    %rbp
  8009da:	c3                   	ret    

00000000008009db <pwd_command>:
  8009db:	f3 0f 1e fa          	endbr64 
  8009df:	55                   	push   %rbp
  8009e0:	48 89 e5             	mov    %rsp,%rbp
  8009e3:	41 57                	push   %r15
  8009e5:	48 83 ec 18          	sub    $0x18,%rsp
  8009e9:	48 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%rdx        # 8009e9 <pwd_command+0xe>
  8009f0:	49 bb 77 2e 00 00 00 	movabs $0x2e77,%r11
  8009f7:	00 00 00 
  8009fa:	4c 01 da             	add    %r11,%rdx
  8009fd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  800a00:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  800a04:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  800a0b:	ff ff ff 
  800a0e:	48 8d 04 02          	lea    (%rdx,%rax,1),%rax
  800a12:	48 89 c6             	mov    %rax,%rsi
  800a15:	48 b8 db 00 00 00 00 	movabs $0xdb,%rax
  800a1c:	00 00 00 
  800a1f:	48 8d 04 02          	lea    (%rdx,%rax,1),%rax
  800a23:	48 89 c7             	mov    %rax,%rdi
  800a26:	49 89 d7             	mov    %rdx,%r15
  800a29:	b8 00 00 00 00       	mov    $0x0,%eax
  800a2e:	48 b9 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rcx
  800a35:	ff ff ff 
  800a38:	48 01 d1             	add    %rdx,%rcx
  800a3b:	ff d1                	call   *%rcx
  800a3d:	b8 00 00 00 00       	mov    $0x0,%eax
  800a42:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
  800a46:	c9                   	leave  
  800a47:	c3                   	ret    

0000000000800a48 <cat_command>:
  800a48:	f3 0f 1e fa          	endbr64 
  800a4c:	55                   	push   %rbp
  800a4d:	48 89 e5             	mov    %rsp,%rbp
  800a50:	41 57                	push   %r15
  800a52:	53                   	push   %rbx
  800a53:	48 83 ec 40          	sub    $0x40,%rsp
  800a57:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 800a57 <cat_command+0xf>
  800a5e:	49 bb 09 2e 00 00 00 	movabs $0x2e09,%r11
  800a65:	00 00 00 
  800a68:	4c 01 db             	add    %r11,%rbx
  800a6b:	89 7d bc             	mov    %edi,-0x44(%rbp)
  800a6e:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
  800a72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  800a79:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
  800a80:	00 
  800a81:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  800a88:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
  800a8f:	00 
  800a90:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
  800a97:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  800a9e:	ff ff ff 
  800aa1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800aa5:	48 89 c7             	mov    %rax,%rdi
  800aa8:	49 89 df             	mov    %rbx,%r15
  800aab:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  800ab2:	ff ff ff 
  800ab5:	48 01 d8             	add    %rbx,%rax
  800ab8:	ff d0                	call   *%rax
  800aba:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800abd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  800ac1:	48 83 c0 08          	add    $0x8,%rax
  800ac5:	48 8b 00             	mov    (%rax),%rax
  800ac8:	48 89 c7             	mov    %rax,%rdi
  800acb:	49 89 df             	mov    %rbx,%r15
  800ace:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  800ad5:	ff ff ff 
  800ad8:	48 01 d8             	add    %rbx,%rax
  800adb:	ff d0                	call   *%rax
  800add:	8b 55 ec             	mov    -0x14(%rbp),%edx
  800ae0:	01 d0                	add    %edx,%eax
  800ae2:	89 45 cc             	mov    %eax,-0x34(%rbp)
  800ae5:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800ae8:	83 c0 02             	add    $0x2,%eax
  800aeb:	48 98                	cltq   
  800aed:	48 89 c7             	mov    %rax,%rdi
  800af0:	49 89 df             	mov    %rbx,%r15
  800af3:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  800afa:	ff ff ff 
  800afd:	48 01 d8             	add    %rbx,%rax
  800b00:	ff d0                	call   *%rax
  800b02:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  800b06:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800b09:	83 c0 02             	add    $0x2,%eax
  800b0c:	48 63 d0             	movslq %eax,%rdx
  800b0f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800b13:	be 00 00 00 00       	mov    $0x0,%esi
  800b18:	48 89 c7             	mov    %rax,%rdi
  800b1b:	49 89 df             	mov    %rbx,%r15
  800b1e:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  800b25:	ff ff ff 
  800b28:	48 01 d8             	add    %rbx,%rax
  800b2b:	ff d0                	call   *%rax
  800b2d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800b31:	48 ba 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rdx
  800b38:	ff ff ff 
  800b3b:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  800b3f:	48 89 d6             	mov    %rdx,%rsi
  800b42:	48 89 c7             	mov    %rax,%rdi
  800b45:	49 89 df             	mov    %rbx,%r15
  800b48:	48 b8 aa f2 ff ff ff 	movabs $0xfffffffffffff2aa,%rax
  800b4f:	ff ff ff 
  800b52:	48 01 d8             	add    %rbx,%rax
  800b55:	ff d0                	call   *%rax
  800b57:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  800b5b:	7e 10                	jle    800b6d <cat_command+0x125>
  800b5d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800b60:	48 63 d0             	movslq %eax,%rdx
  800b63:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800b67:	48 01 d0             	add    %rdx,%rax
  800b6a:	c6 00 2f             	movb   $0x2f,(%rax)
  800b6d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  800b71:	48 83 c0 08          	add    $0x8,%rax
  800b75:	48 8b 10             	mov    (%rax),%rdx
  800b78:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800b7c:	48 89 d6             	mov    %rdx,%rsi
  800b7f:	48 89 c7             	mov    %rax,%rdi
  800b82:	49 89 df             	mov    %rbx,%r15
  800b85:	48 b8 34 f3 ff ff ff 	movabs $0xfffffffffffff334,%rax
  800b8c:	ff ff ff 
  800b8f:	48 01 d8             	add    %rbx,%rax
  800b92:	ff d0                	call   *%rax
  800b94:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800b98:	48 89 c6             	mov    %rax,%rsi
  800b9b:	48 b8 df 00 00 00 00 	movabs $0xdf,%rax
  800ba2:	00 00 00 
  800ba5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800ba9:	48 89 c7             	mov    %rax,%rdi
  800bac:	49 89 df             	mov    %rbx,%r15
  800baf:	b8 00 00 00 00       	mov    $0x0,%eax
  800bb4:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800bbb:	ff ff ff 
  800bbe:	48 01 da             	add    %rbx,%rdx
  800bc1:	ff d2                	call   *%rdx
  800bc3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800bc7:	be 00 00 00 00       	mov    $0x0,%esi
  800bcc:	48 89 c7             	mov    %rax,%rdi
  800bcf:	49 89 df             	mov    %rbx,%r15
  800bd2:	48 b8 a5 e0 ff ff ff 	movabs $0xffffffffffffe0a5,%rax
  800bd9:	ff ff ff 
  800bdc:	48 01 d8             	add    %rbx,%rax
  800bdf:	ff d0                	call   *%rax
  800be1:	89 45 dc             	mov    %eax,-0x24(%rbp)
  800be4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  800be8:	79 39                	jns    800c23 <cat_command+0x1db>
  800bea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800bee:	48 89 c6             	mov    %rax,%rsi
  800bf1:	48 b8 f8 00 00 00 00 	movabs $0xf8,%rax
  800bf8:	00 00 00 
  800bfb:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800bff:	48 89 c7             	mov    %rax,%rdi
  800c02:	49 89 df             	mov    %rbx,%r15
  800c05:	b8 00 00 00 00       	mov    $0x0,%eax
  800c0a:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800c11:	ff ff ff 
  800c14:	48 01 da             	add    %rbx,%rdx
  800c17:	ff d2                	call   *%rdx
  800c19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  800c1e:	e9 33 01 00 00       	jmp    800d56 <cat_command+0x30e>
  800c23:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800c26:	ba 02 00 00 00       	mov    $0x2,%edx
  800c2b:	be 00 00 00 00       	mov    $0x0,%esi
  800c30:	89 c7                	mov    %eax,%edi
  800c32:	49 89 df             	mov    %rbx,%r15
  800c35:	48 b8 c9 e0 ff ff ff 	movabs $0xffffffffffffe0c9,%rax
  800c3c:	ff ff ff 
  800c3f:	48 01 d8             	add    %rbx,%rax
  800c42:	ff d0                	call   *%rax
  800c44:	89 45 cc             	mov    %eax,-0x34(%rbp)
  800c47:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800c4a:	ba 00 00 00 00       	mov    $0x0,%edx
  800c4f:	be 00 00 00 00       	mov    $0x0,%esi
  800c54:	89 c7                	mov    %eax,%edi
  800c56:	49 89 df             	mov    %rbx,%r15
  800c59:	48 b8 c9 e0 ff ff ff 	movabs $0xffffffffffffe0c9,%rax
  800c60:	ff ff ff 
  800c63:	48 01 d8             	add    %rbx,%rax
  800c66:	ff d0                	call   *%rax
  800c68:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800c6b:	83 c0 01             	add    $0x1,%eax
  800c6e:	48 98                	cltq   
  800c70:	48 89 c7             	mov    %rax,%rdi
  800c73:	49 89 df             	mov    %rbx,%r15
  800c76:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  800c7d:	ff ff ff 
  800c80:	48 01 d8             	add    %rbx,%rax
  800c83:	ff d0                	call   *%rax
  800c85:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  800c89:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800c8c:	83 c0 01             	add    $0x1,%eax
  800c8f:	48 63 d0             	movslq %eax,%rdx
  800c92:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800c96:	be 00 00 00 00       	mov    $0x0,%esi
  800c9b:	48 89 c7             	mov    %rax,%rdi
  800c9e:	49 89 df             	mov    %rbx,%r15
  800ca1:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  800ca8:	ff ff ff 
  800cab:	48 01 d8             	add    %rbx,%rax
  800cae:	ff d0                	call   *%rax
  800cb0:	8b 45 cc             	mov    -0x34(%rbp),%eax
  800cb3:	48 63 d0             	movslq %eax,%rdx
  800cb6:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
  800cba:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800cbd:	48 89 ce             	mov    %rcx,%rsi
  800cc0:	89 c7                	mov    %eax,%edi
  800cc2:	49 89 df             	mov    %rbx,%r15
  800cc5:	48 b8 b7 e0 ff ff ff 	movabs $0xffffffffffffe0b7,%rax
  800ccc:	ff ff ff 
  800ccf:	48 01 d8             	add    %rbx,%rax
  800cd2:	ff d0                	call   *%rax
  800cd4:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800cd7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  800cdb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800cde:	89 c6                	mov    %eax,%esi
  800ce0:	48 b8 08 01 00 00 00 	movabs $0x108,%rax
  800ce7:	00 00 00 
  800cea:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800cee:	48 89 c7             	mov    %rax,%rdi
  800cf1:	49 89 df             	mov    %rbx,%r15
  800cf4:	b8 00 00 00 00       	mov    $0x0,%eax
  800cf9:	48 b9 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rcx
  800d00:	ff ff ff 
  800d03:	48 01 d9             	add    %rbx,%rcx
  800d06:	ff d1                	call   *%rcx
  800d08:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  800d0c:	48 89 c7             	mov    %rax,%rdi
  800d0f:	49 89 df             	mov    %rbx,%r15
  800d12:	48 b8 e2 e2 ff ff ff 	movabs $0xffffffffffffe2e2,%rax
  800d19:	ff ff ff 
  800d1c:	48 01 d8             	add    %rbx,%rax
  800d1f:	ff d0                	call   *%rax
  800d21:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  800d25:	48 89 c7             	mov    %rax,%rdi
  800d28:	49 89 df             	mov    %rbx,%r15
  800d2b:	48 b8 e2 e2 ff ff ff 	movabs $0xffffffffffffe2e2,%rax
  800d32:	ff ff ff 
  800d35:	48 01 d8             	add    %rbx,%rax
  800d38:	ff d0                	call   *%rax
  800d3a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  800d3d:	89 c7                	mov    %eax,%edi
  800d3f:	49 89 df             	mov    %rbx,%r15
  800d42:	48 b8 ae e0 ff ff ff 	movabs $0xffffffffffffe0ae,%rax
  800d49:	ff ff ff 
  800d4c:	48 01 d8             	add    %rbx,%rax
  800d4f:	ff d0                	call   *%rax
  800d51:	b8 00 00 00 00       	mov    $0x0,%eax
  800d56:	48 83 c4 40          	add    $0x40,%rsp
  800d5a:	5b                   	pop    %rbx
  800d5b:	41 5f                	pop    %r15
  800d5d:	5d                   	pop    %rbp
  800d5e:	c3                   	ret    

0000000000800d5f <touch_command>:
  800d5f:	f3 0f 1e fa          	endbr64 
  800d63:	55                   	push   %rbp
  800d64:	48 89 e5             	mov    %rsp,%rbp
  800d67:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 800d67 <touch_command+0x8>
  800d6e:	49 bb f9 2a 00 00 00 	movabs $0x2af9,%r11
  800d75:	00 00 00 
  800d78:	4c 01 d8             	add    %r11,%rax
  800d7b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800d7e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800d82:	90                   	nop
  800d83:	5d                   	pop    %rbp
  800d84:	c3                   	ret    

0000000000800d85 <mkdir_command>:
  800d85:	f3 0f 1e fa          	endbr64 
  800d89:	55                   	push   %rbp
  800d8a:	48 89 e5             	mov    %rsp,%rbp
  800d8d:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 800d8d <mkdir_command+0x8>
  800d94:	49 bb d3 2a 00 00 00 	movabs $0x2ad3,%r11
  800d9b:	00 00 00 
  800d9e:	4c 01 d8             	add    %r11,%rax
  800da1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800da4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800da8:	90                   	nop
  800da9:	5d                   	pop    %rbp
  800daa:	c3                   	ret    

0000000000800dab <rmdir_command>:
  800dab:	f3 0f 1e fa          	endbr64 
  800daf:	55                   	push   %rbp
  800db0:	48 89 e5             	mov    %rsp,%rbp
  800db3:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 800db3 <rmdir_command+0x8>
  800dba:	49 bb ad 2a 00 00 00 	movabs $0x2aad,%r11
  800dc1:	00 00 00 
  800dc4:	4c 01 d8             	add    %r11,%rax
  800dc7:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800dca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800dce:	90                   	nop
  800dcf:	5d                   	pop    %rbp
  800dd0:	c3                   	ret    

0000000000800dd1 <rm_command>:
  800dd1:	f3 0f 1e fa          	endbr64 
  800dd5:	55                   	push   %rbp
  800dd6:	48 89 e5             	mov    %rsp,%rbp
  800dd9:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 800dd9 <rm_command+0x8>
  800de0:	49 bb 87 2a 00 00 00 	movabs $0x2a87,%r11
  800de7:	00 00 00 
  800dea:	4c 01 d8             	add    %r11,%rax
  800ded:	89 7d fc             	mov    %edi,-0x4(%rbp)
  800df0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  800df4:	90                   	nop
  800df5:	5d                   	pop    %rbp
  800df6:	c3                   	ret    

0000000000800df7 <exec_command>:
  800df7:	f3 0f 1e fa          	endbr64 
  800dfb:	55                   	push   %rbp
  800dfc:	48 89 e5             	mov    %rsp,%rbp
  800dff:	41 57                	push   %r15
  800e01:	53                   	push   %rbx
  800e02:	48 83 ec 30          	sub    $0x30,%rsp
  800e06:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 800e06 <exec_command+0xf>
  800e0d:	49 bb 5a 2a 00 00 00 	movabs $0x2a5a,%r11
  800e14:	00 00 00 
  800e17:	4c 01 db             	add    %r11,%rbx
  800e1a:	89 7d cc             	mov    %edi,-0x34(%rbp)
  800e1d:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  800e21:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  800e28:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
  800e2f:	00 
  800e30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  800e37:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  800e3e:	00 
  800e3f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  800e46:	49 89 df             	mov    %rbx,%r15
  800e49:	b8 00 00 00 00       	mov    $0x0,%eax
  800e4e:	48 ba d2 e0 ff ff ff 	movabs $0xffffffffffffe0d2,%rdx
  800e55:	ff ff ff 
  800e58:	48 01 da             	add    %rbx,%rdx
  800e5b:	ff d2                	call   *%rdx
  800e5d:	89 45 e8             	mov    %eax,-0x18(%rbp)
  800e60:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  800e64:	0f 85 eb 01 00 00    	jne    801055 <exec_command+0x25e>
  800e6a:	48 b8 16 01 00 00 00 	movabs $0x116,%rax
  800e71:	00 00 00 
  800e74:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800e78:	48 89 c7             	mov    %rax,%rdi
  800e7b:	49 89 df             	mov    %rbx,%r15
  800e7e:	b8 00 00 00 00       	mov    $0x0,%eax
  800e83:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800e8a:	ff ff ff 
  800e8d:	48 01 da             	add    %rbx,%rdx
  800e90:	ff d2                	call   *%rdx
  800e92:	48 b8 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rax
  800e99:	ff ff ff 
  800e9c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800ea0:	48 89 c7             	mov    %rax,%rdi
  800ea3:	49 89 df             	mov    %rbx,%r15
  800ea6:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  800ead:	ff ff ff 
  800eb0:	48 01 d8             	add    %rbx,%rax
  800eb3:	ff d0                	call   *%rax
  800eb5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  800eb8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  800ebc:	48 83 c0 08          	add    $0x8,%rax
  800ec0:	48 8b 00             	mov    (%rax),%rax
  800ec3:	48 89 c7             	mov    %rax,%rdi
  800ec6:	49 89 df             	mov    %rbx,%r15
  800ec9:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  800ed0:	ff ff ff 
  800ed3:	48 01 d8             	add    %rbx,%rax
  800ed6:	ff d0                	call   *%rax
  800ed8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  800edb:	01 d0                	add    %edx,%eax
  800edd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  800ee0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800ee3:	83 c0 02             	add    $0x2,%eax
  800ee6:	48 98                	cltq   
  800ee8:	48 89 c7             	mov    %rax,%rdi
  800eeb:	49 89 df             	mov    %rbx,%r15
  800eee:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  800ef5:	ff ff ff 
  800ef8:	48 01 d8             	add    %rbx,%rax
  800efb:	ff d0                	call   *%rax
  800efd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  800f01:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800f04:	83 c0 02             	add    $0x2,%eax
  800f07:	48 63 d0             	movslq %eax,%rdx
  800f0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800f0e:	be 00 00 00 00       	mov    $0x0,%esi
  800f13:	48 89 c7             	mov    %rax,%rdi
  800f16:	49 89 df             	mov    %rbx,%r15
  800f19:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  800f20:	ff ff ff 
  800f23:	48 01 d8             	add    %rbx,%rax
  800f26:	ff d0                	call   *%rax
  800f28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800f2c:	48 ba 00 f7 ff ff ff 	movabs $0xfffffffffffff700,%rdx
  800f33:	ff ff ff 
  800f36:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
  800f3a:	48 89 d6             	mov    %rdx,%rsi
  800f3d:	48 89 c7             	mov    %rax,%rdi
  800f40:	49 89 df             	mov    %rbx,%r15
  800f43:	48 b8 aa f2 ff ff ff 	movabs $0xfffffffffffff2aa,%rax
  800f4a:	ff ff ff 
  800f4d:	48 01 d8             	add    %rbx,%rax
  800f50:	ff d0                	call   *%rax
  800f52:	83 7d e4 01          	cmpl   $0x1,-0x1c(%rbp)
  800f56:	7e 10                	jle    800f68 <exec_command+0x171>
  800f58:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  800f5b:	48 63 d0             	movslq %eax,%rdx
  800f5e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800f62:	48 01 d0             	add    %rdx,%rax
  800f65:	c6 00 2f             	movb   $0x2f,(%rax)
  800f68:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  800f6c:	48 83 c0 08          	add    $0x8,%rax
  800f70:	48 8b 10             	mov    (%rax),%rdx
  800f73:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800f77:	48 89 d6             	mov    %rdx,%rsi
  800f7a:	48 89 c7             	mov    %rax,%rdi
  800f7d:	49 89 df             	mov    %rbx,%r15
  800f80:	48 b8 34 f3 ff ff ff 	movabs $0xfffffffffffff334,%rax
  800f87:	ff ff ff 
  800f8a:	48 01 d8             	add    %rbx,%rax
  800f8d:	ff d0                	call   *%rax
  800f8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  800f93:	48 89 c6             	mov    %rax,%rsi
  800f96:	48 b8 25 01 00 00 00 	movabs $0x125,%rax
  800f9d:	00 00 00 
  800fa0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800fa4:	48 89 c7             	mov    %rax,%rdi
  800fa7:	49 89 df             	mov    %rbx,%r15
  800faa:	b8 00 00 00 00       	mov    $0x0,%eax
  800faf:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  800fb6:	ff ff ff 
  800fb9:	48 01 da             	add    %rbx,%rdx
  800fbc:	ff d2                	call   *%rdx
  800fbe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  800fc5:	eb 48                	jmp    80100f <exec_command+0x218>
  800fc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800fca:	48 98                	cltq   
  800fcc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  800fd3:	00 
  800fd4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  800fd8:	48 01 d0             	add    %rdx,%rax
  800fdb:	48 8b 10             	mov    (%rax),%rdx
  800fde:	8b 45 ec             	mov    -0x14(%rbp),%eax
  800fe1:	89 c6                	mov    %eax,%esi
  800fe3:	48 b8 3f 01 00 00 00 	movabs $0x13f,%rax
  800fea:	00 00 00 
  800fed:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  800ff1:	48 89 c7             	mov    %rax,%rdi
  800ff4:	49 89 df             	mov    %rbx,%r15
  800ff7:	b8 00 00 00 00       	mov    $0x0,%eax
  800ffc:	48 b9 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rcx
  801003:	ff ff ff 
  801006:	48 01 d9             	add    %rbx,%rcx
  801009:	ff d1                	call   *%rcx
  80100b:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  80100f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801012:	3b 45 cc             	cmp    -0x34(%rbp),%eax
  801015:	7c b0                	jl     800fc7 <exec_command+0x1d0>
  801017:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  80101b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80101f:	ba 00 00 00 00       	mov    $0x0,%edx
  801024:	48 89 ce             	mov    %rcx,%rsi
  801027:	48 89 c7             	mov    %rax,%rdi
  80102a:	49 89 df             	mov    %rbx,%r15
  80102d:	48 b8 e4 e0 ff ff ff 	movabs $0xffffffffffffe0e4,%rax
  801034:	ff ff ff 
  801037:	48 01 d8             	add    %rbx,%rax
  80103a:	ff d0                	call   *%rax
  80103c:	bf 00 00 00 00       	mov    $0x0,%edi
  801041:	49 89 df             	mov    %rbx,%r15
  801044:	48 b8 ed e0 ff ff ff 	movabs $0xffffffffffffe0ed,%rax
  80104b:	ff ff ff 
  80104e:	48 01 d8             	add    %rbx,%rax
  801051:	ff d0                	call   *%rax
  801053:	eb 7f                	jmp    8010d4 <exec_command+0x2dd>
  801055:	8b 45 e8             	mov    -0x18(%rbp),%eax
  801058:	89 c6                	mov    %eax,%esi
  80105a:	48 b8 4c 01 00 00 00 	movabs $0x14c,%rax
  801061:	00 00 00 
  801064:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  801068:	48 89 c7             	mov    %rax,%rdi
  80106b:	49 89 df             	mov    %rbx,%r15
  80106e:	b8 00 00 00 00       	mov    $0x0,%eax
  801073:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80107a:	ff ff ff 
  80107d:	48 01 da             	add    %rbx,%rdx
  801080:	ff d2                	call   *%rdx
  801082:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  801086:	8b 45 e8             	mov    -0x18(%rbp),%eax
  801089:	ba 00 00 00 00       	mov    $0x0,%edx
  80108e:	48 89 ce             	mov    %rcx,%rsi
  801091:	89 c7                	mov    %eax,%edi
  801093:	49 89 df             	mov    %rbx,%r15
  801096:	48 b8 9e f6 ff ff ff 	movabs $0xfffffffffffff69e,%rax
  80109d:	ff ff ff 
  8010a0:	48 01 d8             	add    %rbx,%rax
  8010a3:	ff d0                	call   *%rax
  8010a5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8010a9:	48 89 c6             	mov    %rax,%rsi
  8010ac:	48 b8 70 01 00 00 00 	movabs $0x170,%rax
  8010b3:	00 00 00 
  8010b6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8010ba:	48 89 c7             	mov    %rax,%rdi
  8010bd:	49 89 df             	mov    %rbx,%r15
  8010c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8010c5:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  8010cc:	ff ff ff 
  8010cf:	48 01 da             	add    %rbx,%rdx
  8010d2:	ff d2                	call   *%rdx
  8010d4:	b8 01 00 00 00       	mov    $0x1,%eax
  8010d9:	48 83 c4 30          	add    $0x30,%rsp
  8010dd:	5b                   	pop    %rbx
  8010de:	41 5f                	pop    %r15
  8010e0:	5d                   	pop    %rbp
  8010e1:	c3                   	ret    

00000000008010e2 <reboot_command>:
  8010e2:	f3 0f 1e fa          	endbr64 
  8010e6:	55                   	push   %rbp
  8010e7:	48 89 e5             	mov    %rsp,%rbp
  8010ea:	41 57                	push   %r15
  8010ec:	48 83 ec 18          	sub    $0x18,%rsp
  8010f0:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 8010f0 <reboot_command+0xe>
  8010f7:	49 bb 70 27 00 00 00 	movabs $0x2770,%r11
  8010fe:	00 00 00 
  801101:	4c 01 d8             	add    %r11,%rax
  801104:	89 7d ec             	mov    %edi,-0x14(%rbp)
  801107:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  80110b:	be 00 00 00 00       	mov    $0x0,%esi
  801110:	bf 01 00 00 00       	mov    $0x1,%edi
  801115:	49 89 c7             	mov    %rax,%r15
  801118:	48 ba 08 e1 ff ff ff 	movabs $0xffffffffffffe108,%rdx
  80111f:	ff ff ff 
  801122:	48 01 c2             	add    %rax,%rdx
  801125:	ff d2                	call   *%rdx
  801127:	b8 01 00 00 00       	mov    $0x1,%eax
  80112c:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
  801130:	c9                   	leave  
  801131:	c3                   	ret    

0000000000801132 <find_cmd>:
  801132:	f3 0f 1e fa          	endbr64 
  801136:	55                   	push   %rbp
  801137:	48 89 e5             	mov    %rsp,%rbp
  80113a:	41 57                	push   %r15
  80113c:	53                   	push   %rbx
  80113d:	48 83 ec 20          	sub    $0x20,%rsp
  801141:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 801141 <find_cmd+0xf>
  801148:	49 bb 1f 27 00 00 00 	movabs $0x271f,%r11
  80114f:	00 00 00 
  801152:	4c 01 db             	add    %r11,%rbx
  801155:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801159:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801160:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801167:	eb 45                	jmp    8011ae <find_cmd+0x7c>
  801169:	48 ba 20 ff ff ff ff 	movabs $0xffffffffffffff20,%rdx
  801170:	ff ff ff 
  801173:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801176:	48 98                	cltq   
  801178:	48 01 da             	add    %rbx,%rdx
  80117b:	48 c1 e0 04          	shl    $0x4,%rax
  80117f:	48 01 d0             	add    %rdx,%rax
  801182:	48 8b 10             	mov    (%rax),%rdx
  801185:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801189:	48 89 d6             	mov    %rdx,%rsi
  80118c:	48 89 c7             	mov    %rax,%rdi
  80118f:	49 89 df             	mov    %rbx,%r15
  801192:	48 b8 7f f3 ff ff ff 	movabs $0xfffffffffffff37f,%rax
  801199:	ff ff ff 
  80119c:	48 01 d8             	add    %rbx,%rax
  80119f:	ff d0                	call   *%rax
  8011a1:	85 c0                	test   %eax,%eax
  8011a3:	75 05                	jne    8011aa <find_cmd+0x78>
  8011a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8011a8:	eb 11                	jmp    8011bb <find_cmd+0x89>
  8011aa:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  8011ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8011b1:	83 f8 09             	cmp    $0x9,%eax
  8011b4:	76 b3                	jbe    801169 <find_cmd+0x37>
  8011b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  8011bb:	48 83 c4 20          	add    $0x20,%rsp
  8011bf:	5b                   	pop    %rbx
  8011c0:	41 5f                	pop    %r15
  8011c2:	5d                   	pop    %rbp
  8011c3:	c3                   	ret    

00000000008011c4 <run_command>:
  8011c4:	f3 0f 1e fa          	endbr64 
  8011c8:	55                   	push   %rbp
  8011c9:	48 89 e5             	mov    %rsp,%rbp
  8011cc:	41 57                	push   %r15
  8011ce:	53                   	push   %rbx
  8011cf:	48 83 ec 10          	sub    $0x10,%rsp
  8011d3:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8011d3 <run_command+0xf>
  8011da:	49 bb 8d 26 00 00 00 	movabs $0x268d,%r11
  8011e1:	00 00 00 
  8011e4:	4c 01 db             	add    %r11,%rbx
  8011e7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  8011ea:	89 75 e8             	mov    %esi,-0x18(%rbp)
  8011ed:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  8011f1:	48 ba 20 ff ff ff ff 	movabs $0xffffffffffffff20,%rdx
  8011f8:	ff ff ff 
  8011fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8011fe:	48 98                	cltq   
  801200:	48 01 da             	add    %rbx,%rdx
  801203:	48 c1 e0 04          	shl    $0x4,%rax
  801207:	48 01 d0             	add    %rdx,%rax
  80120a:	48 8b 00             	mov    (%rax),%rax
  80120d:	48 89 c6             	mov    %rax,%rsi
  801210:	48 b8 bf 01 00 00 00 	movabs $0x1bf,%rax
  801217:	00 00 00 
  80121a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80121e:	48 89 c7             	mov    %rax,%rdi
  801221:	49 89 df             	mov    %rbx,%r15
  801224:	b8 00 00 00 00       	mov    $0x0,%eax
  801229:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  801230:	ff ff ff 
  801233:	48 01 da             	add    %rbx,%rdx
  801236:	ff d2                	call   *%rdx
  801238:	48 ba 20 ff ff ff ff 	movabs $0xffffffffffffff20,%rdx
  80123f:	ff ff ff 
  801242:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801245:	48 98                	cltq   
  801247:	48 c1 e0 04          	shl    $0x4,%rax
  80124b:	48 01 d8             	add    %rbx,%rax
  80124e:	48 01 d0             	add    %rdx,%rax
  801251:	48 83 c0 08          	add    $0x8,%rax
  801255:	48 8b 08             	mov    (%rax),%rcx
  801258:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  80125c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80125f:	48 89 d6             	mov    %rdx,%rsi
  801262:	89 c7                	mov    %eax,%edi
  801264:	ff d1                	call   *%rcx
  801266:	90                   	nop
  801267:	48 83 c4 10          	add    $0x10,%rsp
  80126b:	5b                   	pop    %rbx
  80126c:	41 5f                	pop    %r15
  80126e:	5d                   	pop    %rbp
  80126f:	c3                   	ret    

0000000000801270 <get_scancode>:
  801270:	f3 0f 1e fa          	endbr64 
  801274:	55                   	push   %rbp
  801275:	48 89 e5             	mov    %rsp,%rbp
  801278:	41 57                	push   %r15
  80127a:	48 83 ec 28          	sub    $0x28,%rsp
  80127e:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 80127e <get_scancode+0xe>
  801285:	49 bb e2 25 00 00 00 	movabs $0x25e2,%r11
  80128c:	00 00 00 
  80128f:	4c 01 d8             	add    %r11,%rax
  801292:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801295:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  801299:	48 8d 75 ef          	lea    -0x11(%rbp),%rsi
  80129d:	8b 4d dc             	mov    -0x24(%rbp),%ecx
  8012a0:	ba 01 00 00 00       	mov    $0x1,%edx
  8012a5:	89 cf                	mov    %ecx,%edi
  8012a7:	49 89 c7             	mov    %rax,%r15
  8012aa:	48 b9 b7 e0 ff ff ff 	movabs $0xffffffffffffe0b7,%rcx
  8012b1:	ff ff ff 
  8012b4:	48 01 c1             	add    %rax,%rcx
  8012b7:	ff d1                	call   *%rcx
  8012b9:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8012bd:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

00000000008012c3 <analysis_keycode>:
  8012c3:	f3 0f 1e fa          	endbr64 
  8012c7:	55                   	push   %rbp
  8012c8:	48 89 e5             	mov    %rsp,%rbp
  8012cb:	53                   	push   %rbx
  8012cc:	48 83 ec 38          	sub    $0x38,%rsp
  8012d0:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8012d0 <analysis_keycode+0xd>
  8012d7:	49 bb 90 25 00 00 00 	movabs $0x2590,%r11
  8012de:	00 00 00 
  8012e1:	4c 01 db             	add    %r11,%rbx
  8012e4:	89 7d cc             	mov    %edi,-0x34(%rbp)
  8012e7:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  8012eb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  8012f2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  8012f9:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8012fc:	89 c7                	mov    %eax,%edi
  8012fe:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801305:	ff ff ff 
  801308:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80130c:	ff d0                	call   *%rax
  80130e:	88 45 ef             	mov    %al,-0x11(%rbp)
  801311:	80 7d ef e1          	cmpb   $0xe1,-0x11(%rbp)
  801315:	75 5c                	jne    801373 <analysis_keycode+0xb0>
  801317:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%rbp)
  80131e:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%rbp)
  801325:	eb 41                	jmp    801368 <analysis_keycode+0xa5>
  801327:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80132a:	89 c7                	mov    %eax,%edi
  80132c:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801333:	ff ff ff 
  801336:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80133a:	ff d0                	call   *%rax
  80133c:	48 ba f0 ff ff ff ff 	movabs $0xfffffffffffffff0,%rdx
  801343:	ff ff ff 
  801346:	48 8b 0c 13          	mov    (%rbx,%rdx,1),%rcx
  80134a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  80134d:	48 63 d2             	movslq %edx,%rdx
  801350:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
  801354:	38 d0                	cmp    %dl,%al
  801356:	74 0c                	je     801364 <analysis_keycode+0xa1>
  801358:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  80135f:	e9 b6 01 00 00       	jmp    80151a <analysis_keycode+0x257>
  801364:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  801368:	83 7d e8 05          	cmpl   $0x5,-0x18(%rbp)
  80136c:	7e b9                	jle    801327 <analysis_keycode+0x64>
  80136e:	e9 a7 01 00 00       	jmp    80151a <analysis_keycode+0x257>
  801373:	80 7d ef e0          	cmpb   $0xe0,-0x11(%rbp)
  801377:	0f 85 9d 01 00 00    	jne    80151a <analysis_keycode+0x257>
  80137d:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801380:	89 c7                	mov    %eax,%edi
  801382:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801389:	ff ff ff 
  80138c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  801390:	ff d0                	call   *%rax
  801392:	88 45 ef             	mov    %al,-0x11(%rbp)
  801395:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801399:	3d b8 00 00 00       	cmp    $0xb8,%eax
  80139e:	0f 84 4c 01 00 00    	je     8014f0 <analysis_keycode+0x22d>
  8013a4:	3d b8 00 00 00       	cmp    $0xb8,%eax
  8013a9:	0f 8f 5e 01 00 00    	jg     80150d <analysis_keycode+0x24a>
  8013af:	3d b7 00 00 00       	cmp    $0xb7,%eax
  8013b4:	0f 84 92 00 00 00    	je     80144c <analysis_keycode+0x189>
  8013ba:	3d b7 00 00 00       	cmp    $0xb7,%eax
  8013bf:	0f 8f 48 01 00 00    	jg     80150d <analysis_keycode+0x24a>
  8013c5:	3d 9d 00 00 00       	cmp    $0x9d,%eax
  8013ca:	0f 84 e6 00 00 00    	je     8014b6 <analysis_keycode+0x1f3>
  8013d0:	3d 9d 00 00 00       	cmp    $0x9d,%eax
  8013d5:	0f 8f 32 01 00 00    	jg     80150d <analysis_keycode+0x24a>
  8013db:	83 f8 38             	cmp    $0x38,%eax
  8013de:	0f 84 ef 00 00 00    	je     8014d3 <analysis_keycode+0x210>
  8013e4:	83 f8 38             	cmp    $0x38,%eax
  8013e7:	0f 8f 20 01 00 00    	jg     80150d <analysis_keycode+0x24a>
  8013ed:	83 f8 1d             	cmp    $0x1d,%eax
  8013f0:	0f 84 a3 00 00 00    	je     801499 <analysis_keycode+0x1d6>
  8013f6:	83 f8 2a             	cmp    $0x2a,%eax
  8013f9:	0f 85 0e 01 00 00    	jne    80150d <analysis_keycode+0x24a>
  8013ff:	8b 45 cc             	mov    -0x34(%rbp),%eax
  801402:	89 c7                	mov    %eax,%edi
  801404:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  80140b:	ff ff ff 
  80140e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  801412:	ff d0                	call   *%rax
  801414:	3c e0                	cmp    $0xe0,%al
  801416:	0f 85 fa 00 00 00    	jne    801516 <analysis_keycode+0x253>
  80141c:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80141f:	89 c7                	mov    %eax,%edi
  801421:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801428:	ff ff ff 
  80142b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80142f:	ff d0                	call   *%rax
  801431:	3c 37                	cmp    $0x37,%al
  801433:	0f 85 dd 00 00 00    	jne    801516 <analysis_keycode+0x253>
  801439:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%rbp)
  801440:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%rbp)
  801447:	e9 ca 00 00 00       	jmp    801516 <analysis_keycode+0x253>
  80144c:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80144f:	89 c7                	mov    %eax,%edi
  801451:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801458:	ff ff ff 
  80145b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80145f:	ff d0                	call   *%rax
  801461:	3c e0                	cmp    $0xe0,%al
  801463:	0f 85 b0 00 00 00    	jne    801519 <analysis_keycode+0x256>
  801469:	8b 45 cc             	mov    -0x34(%rbp),%eax
  80146c:	89 c7                	mov    %eax,%edi
  80146e:	48 b8 10 da ff ff ff 	movabs $0xffffffffffffda10,%rax
  801475:	ff ff ff 
  801478:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80147c:	ff d0                	call   *%rax
  80147e:	3c aa                	cmp    $0xaa,%al
  801480:	0f 85 93 00 00 00    	jne    801519 <analysis_keycode+0x256>
  801486:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%rbp)
  80148d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  801494:	e9 80 00 00 00       	jmp    801519 <analysis_keycode+0x256>
  801499:	48 b8 c0 ff ff ff ff 	movabs $0xffffffffffffffc0,%rax
  8014a0:	ff ff ff 
  8014a3:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  8014a7:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  8014ad:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%rbp)
  8014b4:	eb 64                	jmp    80151a <analysis_keycode+0x257>
  8014b6:	48 b8 c0 ff ff ff ff 	movabs $0xffffffffffffffc0,%rax
  8014bd:	ff ff ff 
  8014c0:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  8014c4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  8014ca:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%rbp)
  8014d1:	eb 47                	jmp    80151a <analysis_keycode+0x257>
  8014d3:	48 b8 e8 ff ff ff ff 	movabs $0xffffffffffffffe8,%rax
  8014da:	ff ff ff 
  8014dd:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  8014e1:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  8014e7:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%rbp)
  8014ee:	eb 2a                	jmp    80151a <analysis_keycode+0x257>
  8014f0:	48 b8 e8 ff ff ff ff 	movabs $0xffffffffffffffe8,%rax
  8014f7:	ff ff ff 
  8014fa:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  8014fe:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  801504:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%rbp)
  80150b:	eb 0d                	jmp    80151a <analysis_keycode+0x257>
  80150d:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%rbp)
  801514:	eb 04                	jmp    80151a <analysis_keycode+0x257>
  801516:	90                   	nop
  801517:	eb 01                	jmp    80151a <analysis_keycode+0x257>
  801519:	90                   	nop
  80151a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80151e:	0f 85 40 01 00 00    	jne    801664 <analysis_keycode+0x3a1>
  801524:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
  80152b:	00 
  80152c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  801533:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801537:	f7 d0                	not    %eax
  801539:	c0 e8 07             	shr    $0x7,%al
  80153c:	0f b6 c0             	movzbl %al,%eax
  80153f:	89 45 dc             	mov    %eax,-0x24(%rbp)
  801542:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  801546:	83 e0 7f             	and    $0x7f,%eax
  801549:	01 c0                	add    %eax,%eax
  80154b:	48 98                	cltq   
  80154d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  801554:	00 
  801555:	48 b8 d8 ff ff ff ff 	movabs $0xffffffffffffffd8,%rax
  80155c:	ff ff ff 
  80155f:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801563:	48 01 d0             	add    %rdx,%rax
  801566:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  80156a:	48 b8 f8 ff ff ff ff 	movabs $0xfffffffffffffff8,%rax
  801571:	ff ff ff 
  801574:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801578:	8b 00                	mov    (%rax),%eax
  80157a:	85 c0                	test   %eax,%eax
  80157c:	75 14                	jne    801592 <analysis_keycode+0x2cf>
  80157e:	48 b8 c8 ff ff ff ff 	movabs $0xffffffffffffffc8,%rax
  801585:	ff ff ff 
  801588:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  80158c:	8b 00                	mov    (%rax),%eax
  80158e:	85 c0                	test   %eax,%eax
  801590:	74 07                	je     801599 <analysis_keycode+0x2d6>
  801592:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%rbp)
  801599:	8b 45 e0             	mov    -0x20(%rbp),%eax
  80159c:	48 98                	cltq   
  80159e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  8015a5:	00 
  8015a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8015aa:	48 01 d0             	add    %rdx,%rax
  8015ad:	8b 00                	mov    (%rax),%eax
  8015af:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  8015b2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
  8015b6:	83 e0 7f             	and    $0x7f,%eax
  8015b9:	83 f8 38             	cmp    $0x38,%eax
  8015bc:	74 71                	je     80162f <analysis_keycode+0x36c>
  8015be:	83 f8 38             	cmp    $0x38,%eax
  8015c1:	0f 8f 84 00 00 00    	jg     80164b <analysis_keycode+0x388>
  8015c7:	83 f8 36             	cmp    $0x36,%eax
  8015ca:	74 2b                	je     8015f7 <analysis_keycode+0x334>
  8015cc:	83 f8 36             	cmp    $0x36,%eax
  8015cf:	7f 7a                	jg     80164b <analysis_keycode+0x388>
  8015d1:	83 f8 1d             	cmp    $0x1d,%eax
  8015d4:	74 3d                	je     801613 <analysis_keycode+0x350>
  8015d6:	83 f8 2a             	cmp    $0x2a,%eax
  8015d9:	75 70                	jne    80164b <analysis_keycode+0x388>
  8015db:	48 b8 f8 ff ff ff ff 	movabs $0xfffffffffffffff8,%rax
  8015e2:	ff ff ff 
  8015e5:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  8015e9:	8b 55 dc             	mov    -0x24(%rbp),%edx
  8015ec:	89 10                	mov    %edx,(%rax)
  8015ee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  8015f5:	eb 62                	jmp    801659 <analysis_keycode+0x396>
  8015f7:	48 b8 c8 ff ff ff ff 	movabs $0xffffffffffffffc8,%rax
  8015fe:	ff ff ff 
  801601:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801605:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801608:	89 10                	mov    %edx,(%rax)
  80160a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  801611:	eb 46                	jmp    801659 <analysis_keycode+0x396>
  801613:	48 b8 e0 ff ff ff ff 	movabs $0xffffffffffffffe0,%rax
  80161a:	ff ff ff 
  80161d:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801621:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801624:	89 10                	mov    %edx,(%rax)
  801626:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  80162d:	eb 2a                	jmp    801659 <analysis_keycode+0x396>
  80162f:	48 b8 d0 ff ff ff ff 	movabs $0xffffffffffffffd0,%rax
  801636:	ff ff ff 
  801639:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  80163d:	8b 55 dc             	mov    -0x24(%rbp),%edx
  801640:	89 10                	mov    %edx,(%rax)
  801642:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  801649:	eb 0e                	jmp    801659 <analysis_keycode+0x396>
  80164b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  80164f:	75 07                	jne    801658 <analysis_keycode+0x395>
  801651:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  801658:	90                   	nop
  801659:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  80165d:	74 05                	je     801664 <analysis_keycode+0x3a1>
  80165f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801662:	eb 05                	jmp    801669 <analysis_keycode+0x3a6>
  801664:	b8 00 00 00 00       	mov    $0x0,%eax
  801669:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

000000000080166f <read_line>:
  80166f:	f3 0f 1e fa          	endbr64 
  801673:	55                   	push   %rbp
  801674:	48 89 e5             	mov    %rsp,%rbp
  801677:	41 57                	push   %r15
  801679:	53                   	push   %rbx
  80167a:	48 83 ec 20          	sub    $0x20,%rsp
  80167e:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 80167e <read_line+0xf>
  801685:	49 bb e2 21 00 00 00 	movabs $0x21e2,%r11
  80168c:	00 00 00 
  80168f:	4c 01 db             	add    %r11,%rbx
  801692:	89 7d dc             	mov    %edi,-0x24(%rbp)
  801695:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  801699:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  8016a0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  8016a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  8016aa:	89 c7                	mov    %eax,%edi
  8016ac:	48 b8 63 da ff ff ff 	movabs $0xffffffffffffda63,%rax
  8016b3:	ff ff ff 
  8016b6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8016ba:	ff d0                	call   *%rax
  8016bc:	89 45 e8             	mov    %eax,-0x18(%rbp)
  8016bf:	83 7d e8 0a          	cmpl   $0xa,-0x18(%rbp)
  8016c3:	75 05                	jne    8016ca <read_line+0x5b>
  8016c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016c8:	eb 4d                	jmp    801717 <read_line+0xa8>
  8016ca:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  8016ce:	74 d7                	je     8016a7 <read_line+0x38>
  8016d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8016d3:	8d 50 01             	lea    0x1(%rax),%edx
  8016d6:	89 55 ec             	mov    %edx,-0x14(%rbp)
  8016d9:	48 63 d0             	movslq %eax,%rdx
  8016dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8016e0:	48 01 d0             	add    %rdx,%rax
  8016e3:	8b 55 e8             	mov    -0x18(%rbp),%edx
  8016e6:	88 10                	mov    %dl,(%rax)
  8016e8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8016eb:	89 c6                	mov    %eax,%esi
  8016ed:	48 b8 d0 01 00 00 00 	movabs $0x1d0,%rax
  8016f4:	00 00 00 
  8016f7:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8016fb:	48 89 c7             	mov    %rax,%rdi
  8016fe:	49 89 df             	mov    %rbx,%r15
  801701:	b8 00 00 00 00       	mov    $0x0,%eax
  801706:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  80170d:	ff ff ff 
  801710:	48 01 da             	add    %rbx,%rdx
  801713:	ff d2                	call   *%rdx
  801715:	eb 90                	jmp    8016a7 <read_line+0x38>
  801717:	48 83 c4 20          	add    $0x20,%rsp
  80171b:	5b                   	pop    %rbx
  80171c:	41 5f                	pop    %r15
  80171e:	5d                   	pop    %rbp
  80171f:	c3                   	ret    

0000000000801720 <parse_command>:
  801720:	f3 0f 1e fa          	endbr64 
  801724:	55                   	push   %rbp
  801725:	48 89 e5             	mov    %rsp,%rbp
  801728:	41 57                	push   %r15
  80172a:	53                   	push   %rbx
  80172b:	48 83 ec 30          	sub    $0x30,%rsp
  80172f:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 80172f <parse_command+0xf>
  801736:	49 bb 31 21 00 00 00 	movabs $0x2131,%r11
  80173d:	00 00 00 
  801740:	4c 01 db             	add    %r11,%rbx
  801743:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  801747:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  80174b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  80174f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801756:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  80175d:	eb 04                	jmp    801763 <parse_command+0x43>
  80175f:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  801763:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801766:	48 63 d0             	movslq %eax,%rdx
  801769:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80176d:	48 01 d0             	add    %rdx,%rax
  801770:	0f b6 00             	movzbl (%rax),%eax
  801773:	3c 20                	cmp    $0x20,%al
  801775:	74 e8                	je     80175f <parse_command+0x3f>
  801777:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80177a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  80177d:	eb 55                	jmp    8017d4 <parse_command+0xb4>
  80177f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801782:	48 63 d0             	movslq %eax,%rdx
  801785:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801789:	48 01 d0             	add    %rdx,%rax
  80178c:	0f b6 00             	movzbl (%rax),%eax
  80178f:	3c 20                	cmp    $0x20,%al
  801791:	74 3d                	je     8017d0 <parse_command+0xb0>
  801793:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801796:	48 98                	cltq   
  801798:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80179c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017a0:	48 01 d0             	add    %rdx,%rax
  8017a3:	0f b6 00             	movzbl (%rax),%eax
  8017a6:	3c 20                	cmp    $0x20,%al
  8017a8:	74 17                	je     8017c1 <parse_command+0xa1>
  8017aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8017ad:	48 98                	cltq   
  8017af:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8017b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017b7:	48 01 d0             	add    %rdx,%rax
  8017ba:	0f b6 00             	movzbl (%rax),%eax
  8017bd:	84 c0                	test   %al,%al
  8017bf:	75 0f                	jne    8017d0 <parse_command+0xb0>
  8017c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8017c5:	8b 00                	mov    (%rax),%eax
  8017c7:	8d 50 01             	lea    0x1(%rax),%edx
  8017ca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8017ce:	89 10                	mov    %edx,(%rax)
  8017d0:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  8017d4:	81 7d ec ff 00 00 00 	cmpl   $0xff,-0x14(%rbp)
  8017db:	7f 14                	jg     8017f1 <parse_command+0xd1>
  8017dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  8017e0:	48 63 d0             	movslq %eax,%rdx
  8017e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8017e7:	48 01 d0             	add    %rdx,%rax
  8017ea:	0f b6 00             	movzbl (%rax),%eax
  8017ed:	84 c0                	test   %al,%al
  8017ef:	75 8e                	jne    80177f <parse_command+0x5f>
  8017f1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8017f5:	8b 00                	mov    (%rax),%eax
  8017f7:	85 c0                	test   %eax,%eax
  8017f9:	75 0a                	jne    801805 <parse_command+0xe5>
  8017fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  801800:	e9 ee 00 00 00       	jmp    8018f3 <parse_command+0x1d3>
  801805:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  801809:	8b 00                	mov    (%rax),%eax
  80180b:	48 98                	cltq   
  80180d:	48 c1 e0 03          	shl    $0x3,%rax
  801811:	48 89 c7             	mov    %rax,%rdi
  801814:	49 89 df             	mov    %rbx,%r15
  801817:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  80181e:	ff ff ff 
  801821:	48 01 d8             	add    %rbx,%rax
  801824:	ff d0                	call   *%rax
  801826:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  80182a:	48 89 02             	mov    %rax,(%rdx)
  80182d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801834:	e9 85 00 00 00       	jmp    8018be <parse_command+0x19e>
  801839:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80183c:	48 63 c8             	movslq %eax,%rcx
  80183f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  801843:	48 8b 10             	mov    (%rax),%rdx
  801846:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801849:	48 98                	cltq   
  80184b:	48 c1 e0 03          	shl    $0x3,%rax
  80184f:	48 01 d0             	add    %rdx,%rax
  801852:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  801856:	48 01 ca             	add    %rcx,%rdx
  801859:	48 89 10             	mov    %rdx,(%rax)
  80185c:	eb 04                	jmp    801862 <parse_command+0x142>
  80185e:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  801862:	8b 45 e8             	mov    -0x18(%rbp),%eax
  801865:	48 63 d0             	movslq %eax,%rdx
  801868:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80186c:	48 01 d0             	add    %rdx,%rax
  80186f:	0f b6 00             	movzbl (%rax),%eax
  801872:	84 c0                	test   %al,%al
  801874:	74 14                	je     80188a <parse_command+0x16a>
  801876:	8b 45 e8             	mov    -0x18(%rbp),%eax
  801879:	48 63 d0             	movslq %eax,%rdx
  80187c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801880:	48 01 d0             	add    %rdx,%rax
  801883:	0f b6 00             	movzbl (%rax),%eax
  801886:	3c 20                	cmp    $0x20,%al
  801888:	75 d4                	jne    80185e <parse_command+0x13e>
  80188a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  80188d:	8d 50 01             	lea    0x1(%rax),%edx
  801890:	89 55 e8             	mov    %edx,-0x18(%rbp)
  801893:	48 63 d0             	movslq %eax,%rdx
  801896:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  80189a:	48 01 d0             	add    %rdx,%rax
  80189d:	c6 00 00             	movb   $0x0,(%rax)
  8018a0:	eb 04                	jmp    8018a6 <parse_command+0x186>
  8018a2:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
  8018a6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  8018a9:	48 63 d0             	movslq %eax,%rdx
  8018ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8018b0:	48 01 d0             	add    %rdx,%rax
  8018b3:	0f b6 00             	movzbl (%rax),%eax
  8018b6:	3c 20                	cmp    $0x20,%al
  8018b8:	74 e8                	je     8018a2 <parse_command+0x182>
  8018ba:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  8018be:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  8018c2:	8b 00                	mov    (%rax),%eax
  8018c4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
  8018c7:	7d 0d                	jge    8018d6 <parse_command+0x1b6>
  8018c9:	81 7d e8 ff 00 00 00 	cmpl   $0xff,-0x18(%rbp)
  8018d0:	0f 8e 63 ff ff ff    	jle    801839 <parse_command+0x119>
  8018d6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  8018da:	48 8b 00             	mov    (%rax),%rax
  8018dd:	48 8b 00             	mov    (%rax),%rax
  8018e0:	48 89 c7             	mov    %rax,%rdi
  8018e3:	48 b8 d2 d8 ff ff ff 	movabs $0xffffffffffffd8d2,%rax
  8018ea:	ff ff ff 
  8018ed:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8018f1:	ff d0                	call   *%rax
  8018f3:	48 83 c4 30          	add    $0x30,%rsp
  8018f7:	5b                   	pop    %rbx
  8018f8:	41 5f                	pop    %r15
  8018fa:	5d                   	pop    %rbp
  8018fb:	c3                   	ret    

00000000008018fc <putstring>:
  8018fc:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
  801903:	eb 7e                	jmp    801983 <LABEL_SYSCALL>

0000000000801905 <open>:
  801905:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
  80190c:	eb 75                	jmp    801983 <LABEL_SYSCALL>

000000000080190e <close>:
  80190e:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
  801915:	eb 6c                	jmp    801983 <LABEL_SYSCALL>

0000000000801917 <read>:
  801917:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
  80191e:	eb 63                	jmp    801983 <LABEL_SYSCALL>

0000000000801920 <write>:
  801920:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
  801927:	eb 5a                	jmp    801983 <LABEL_SYSCALL>

0000000000801929 <lseek>:
  801929:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
  801930:	eb 51                	jmp    801983 <LABEL_SYSCALL>

0000000000801932 <fork>:
  801932:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
  801939:	eb 48                	jmp    801983 <LABEL_SYSCALL>

000000000080193b <vfork>:
  80193b:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
  801942:	eb 3f                	jmp    801983 <LABEL_SYSCALL>

0000000000801944 <execve>:
  801944:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
  80194b:	eb 36                	jmp    801983 <LABEL_SYSCALL>

000000000080194d <exit>:
  80194d:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
  801954:	eb 2d                	jmp    801983 <LABEL_SYSCALL>

0000000000801956 <wait4>:
  801956:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
  80195d:	eb 24                	jmp    801983 <LABEL_SYSCALL>

000000000080195f <brk>:
  80195f:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
  801966:	eb 1b                	jmp    801983 <LABEL_SYSCALL>

0000000000801968 <reboot>:
  801968:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
  80196f:	eb 12                	jmp    801983 <LABEL_SYSCALL>

0000000000801971 <chdir>:
  801971:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
  801978:	eb 09                	jmp    801983 <LABEL_SYSCALL>

000000000080197a <getdents>:
  80197a:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
  801981:	eb 00                	jmp    801983 <LABEL_SYSCALL>

0000000000801983 <LABEL_SYSCALL>:
  801983:	41 52                	push   %r10
  801985:	41 53                	push   %r11
  801987:	4c 8d 15 05 00 00 00 	lea    0x5(%rip),%r10        # 801993 <sysexit_return_address>
  80198e:	49 89 e3             	mov    %rsp,%r11
  801991:	0f 34                	sysenter 

0000000000801993 <sysexit_return_address>:
  801993:	49 87 d2             	xchg   %rdx,%r10
  801996:	49 87 cb             	xchg   %rcx,%r11
  801999:	41 5b                	pop    %r11
  80199b:	41 5a                	pop    %r10
  80199d:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  8019a3:	72 0b                	jb     8019b0 <LABEL_SYSCALL_RET>
  8019a5:	48 89 05 9c 29 00 00 	mov    %rax,0x299c(%rip)        # 804348 <errno>
  8019ac:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax

00000000008019b0 <LABEL_SYSCALL_RET>:
  8019b0:	c3                   	ret    

00000000008019b1 <malloc>:
  8019b1:	f3 0f 1e fa          	endbr64 
  8019b5:	55                   	push   %rbp
  8019b6:	48 89 e5             	mov    %rsp,%rbp
  8019b9:	41 57                	push   %r15
  8019bb:	53                   	push   %rbx
  8019bc:	48 83 ec 20          	sub    $0x20,%rsp
  8019c0:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8019c0 <malloc+0xf>
  8019c7:	49 bb a0 1e 00 00 00 	movabs $0x1ea0,%r11
  8019ce:	00 00 00 
  8019d1:	4c 01 db             	add    %r11,%rbx
  8019d4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  8019d8:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
  8019df:	00 
  8019e0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  8019e5:	75 32                	jne    801a19 <malloc+0x68>
  8019e7:	48 b8 d3 01 00 00 00 	movabs $0x1d3,%rax
  8019ee:	00 00 00 
  8019f1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8019f5:	48 89 c7             	mov    %rax,%rdi
  8019f8:	49 89 df             	mov    %rbx,%r15
  8019fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801a00:	48 ba 48 f0 ff ff ff 	movabs $0xfffffffffffff048,%rdx
  801a07:	ff ff ff 
  801a0a:	48 01 da             	add    %rbx,%rdx
  801a0d:	ff d2                	call   *%rdx
  801a0f:	b8 00 00 00 00       	mov    $0x0,%eax
  801a14:	e9 20 01 00 00       	jmp    801b39 <malloc+0x188>
  801a19:	48 b8 f0 0a 00 00 00 	movabs $0xaf0,%rax
  801a20:	00 00 00 
  801a23:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801a27:	48 85 c0             	test   %rax,%rax
  801a2a:	75 5d                	jne    801a89 <malloc+0xd8>
  801a2c:	bf 00 00 00 00       	mov    $0x0,%edi
  801a31:	49 89 df             	mov    %rbx,%r15
  801a34:	48 b8 ff e0 ff ff ff 	movabs $0xffffffffffffe0ff,%rax
  801a3b:	ff ff ff 
  801a3e:	48 01 d8             	add    %rbx,%rax
  801a41:	ff d0                	call   *%rax
  801a43:	48 ba 00 0b 00 00 00 	movabs $0xb00,%rdx
  801a4a:	00 00 00 
  801a4d:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
  801a51:	48 b8 00 0b 00 00 00 	movabs $0xb00,%rax
  801a58:	00 00 00 
  801a5b:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801a5f:	48 ba f8 0a 00 00 00 	movabs $0xaf8,%rdx
  801a66:	00 00 00 
  801a69:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
  801a6d:	48 b8 f8 0a 00 00 00 	movabs $0xaf8,%rax
  801a74:	00 00 00 
  801a77:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801a7b:	48 ba f0 0a 00 00 00 	movabs $0xaf0,%rdx
  801a82:	00 00 00 
  801a85:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
  801a89:	48 b8 f8 0a 00 00 00 	movabs $0xaf8,%rax
  801a90:	00 00 00 
  801a93:	48 8b 14 03          	mov    (%rbx,%rax,1),%rdx
  801a97:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801a9b:	48 01 d0             	add    %rdx,%rax
  801a9e:	48 8d 50 40          	lea    0x40(%rax),%rdx
  801aa2:	48 b8 00 0b 00 00 00 	movabs $0xb00,%rax
  801aa9:	00 00 00 
  801aac:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801ab0:	48 39 c2             	cmp    %rax,%rdx
  801ab3:	72 47                	jb     801afc <malloc+0x14b>
  801ab5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801ab9:	48 05 3f 00 20 00    	add    $0x20003f,%rax
  801abf:	48 25 00 00 e0 ff    	and    $0xffffffffffe00000,%rax
  801ac5:	48 89 c2             	mov    %rax,%rdx
  801ac8:	48 b8 00 0b 00 00 00 	movabs $0xb00,%rax
  801acf:	00 00 00 
  801ad2:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801ad6:	48 01 d0             	add    %rdx,%rax
  801ad9:	48 89 c7             	mov    %rax,%rdi
  801adc:	49 89 df             	mov    %rbx,%r15
  801adf:	48 b8 ff e0 ff ff ff 	movabs $0xffffffffffffe0ff,%rax
  801ae6:	ff ff ff 
  801ae9:	48 01 d8             	add    %rbx,%rax
  801aec:	ff d0                	call   *%rax
  801aee:	48 ba 00 0b 00 00 00 	movabs $0xb00,%rdx
  801af5:	00 00 00 
  801af8:	48 89 04 13          	mov    %rax,(%rbx,%rdx,1)
  801afc:	48 b8 f8 0a 00 00 00 	movabs $0xaf8,%rax
  801b03:	00 00 00 
  801b06:	48 8b 04 03          	mov    (%rbx,%rax,1),%rax
  801b0a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801b0e:	48 b8 f8 0a 00 00 00 	movabs $0xaf8,%rax
  801b15:	00 00 00 
  801b18:	48 8b 14 03          	mov    (%rbx,%rax,1),%rdx
  801b1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  801b20:	48 01 d0             	add    %rdx,%rax
  801b23:	48 8d 50 40          	lea    0x40(%rax),%rdx
  801b27:	48 b8 f8 0a 00 00 00 	movabs $0xaf8,%rax
  801b2e:	00 00 00 
  801b31:	48 89 14 03          	mov    %rdx,(%rbx,%rax,1)
  801b35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801b39:	48 83 c4 20          	add    $0x20,%rsp
  801b3d:	5b                   	pop    %rbx
  801b3e:	41 5f                	pop    %r15
  801b40:	5d                   	pop    %rbp
  801b41:	c3                   	ret    

0000000000801b42 <free>:
  801b42:	f3 0f 1e fa          	endbr64 
  801b46:	55                   	push   %rbp
  801b47:	48 89 e5             	mov    %rsp,%rbp
  801b4a:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 801b4a <free+0x8>
  801b51:	49 bb 16 1d 00 00 00 	movabs $0x1d16,%r11
  801b58:	00 00 00 
  801b5b:	4c 01 d8             	add    %r11,%rax
  801b5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  801b62:	90                   	nop
  801b63:	5d                   	pop    %rbp
  801b64:	c3                   	ret    

0000000000801b65 <skip_atoi>:
  801b65:	f3 0f 1e fa          	endbr64 
  801b69:	55                   	push   %rbp
  801b6a:	48 89 e5             	mov    %rsp,%rbp
  801b6d:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 801b6d <skip_atoi+0x8>
  801b74:	49 bb f3 1c 00 00 00 	movabs $0x1cf3,%r11
  801b7b:	00 00 00 
  801b7e:	4c 01 d8             	add    %r11,%rax
  801b81:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  801b85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  801b8c:	eb 2e                	jmp    801bbc <skip_atoi+0x57>
  801b8e:	8b 55 fc             	mov    -0x4(%rbp),%edx
  801b91:	89 d0                	mov    %edx,%eax
  801b93:	c1 e0 02             	shl    $0x2,%eax
  801b96:	01 d0                	add    %edx,%eax
  801b98:	01 c0                	add    %eax,%eax
  801b9a:	89 c6                	mov    %eax,%esi
  801b9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ba0:	48 8b 00             	mov    (%rax),%rax
  801ba3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801ba7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  801bab:	48 89 0a             	mov    %rcx,(%rdx)
  801bae:	0f b6 00             	movzbl (%rax),%eax
  801bb1:	0f be c0             	movsbl %al,%eax
  801bb4:	01 f0                	add    %esi,%eax
  801bb6:	83 e8 30             	sub    $0x30,%eax
  801bb9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  801bbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bc0:	48 8b 00             	mov    (%rax),%rax
  801bc3:	0f b6 00             	movzbl (%rax),%eax
  801bc6:	3c 2f                	cmp    $0x2f,%al
  801bc8:	7e 0e                	jle    801bd8 <skip_atoi+0x73>
  801bca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801bce:	48 8b 00             	mov    (%rax),%rax
  801bd1:	0f b6 00             	movzbl (%rax),%eax
  801bd4:	3c 39                	cmp    $0x39,%al
  801bd6:	7e b6                	jle    801b8e <skip_atoi+0x29>
  801bd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  801bdb:	5d                   	pop    %rbp
  801bdc:	c3                   	ret    

0000000000801bdd <number>:
  801bdd:	f3 0f 1e fa          	endbr64 
  801be1:	55                   	push   %rbp
  801be2:	48 89 e5             	mov    %rsp,%rbp
  801be5:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 801be5 <number+0x8>
  801bec:	49 bb 7b 1c 00 00 00 	movabs $0x1c7b,%r11
  801bf3:	00 00 00 
  801bf6:	4c 01 d8             	add    %r11,%rax
  801bf9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  801bfd:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  801c01:	89 55 9c             	mov    %edx,-0x64(%rbp)
  801c04:	89 4d 98             	mov    %ecx,-0x68(%rbp)
  801c07:	44 89 45 94          	mov    %r8d,-0x6c(%rbp)
  801c0b:	44 89 4d 90          	mov    %r9d,-0x70(%rbp)
  801c0f:	48 ba e8 01 00 00 00 	movabs $0x1e8,%rdx
  801c16:	00 00 00 
  801c19:	48 8d 14 10          	lea    (%rax,%rdx,1),%rdx
  801c1d:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
  801c21:	8b 55 90             	mov    -0x70(%rbp),%edx
  801c24:	83 e2 40             	and    $0x40,%edx
  801c27:	85 d2                	test   %edx,%edx
  801c29:	74 12                	je     801c3d <number+0x60>
  801c2b:	48 ba 10 02 00 00 00 	movabs $0x210,%rdx
  801c32:	00 00 00 
  801c35:	48 8d 04 10          	lea    (%rax,%rdx,1),%rax
  801c39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  801c3d:	8b 45 90             	mov    -0x70(%rbp),%eax
  801c40:	83 e0 10             	and    $0x10,%eax
  801c43:	85 c0                	test   %eax,%eax
  801c45:	74 04                	je     801c4b <number+0x6e>
  801c47:	83 65 90 fe          	andl   $0xfffffffe,-0x70(%rbp)
  801c4b:	83 7d 9c 01          	cmpl   $0x1,-0x64(%rbp)
  801c4f:	7e 06                	jle    801c57 <number+0x7a>
  801c51:	83 7d 9c 24          	cmpl   $0x24,-0x64(%rbp)
  801c55:	7e 0a                	jle    801c61 <number+0x84>
  801c57:	b8 00 00 00 00       	mov    $0x0,%eax
  801c5c:	e9 17 02 00 00       	jmp    801e78 <number+0x29b>
  801c61:	8b 45 90             	mov    -0x70(%rbp),%eax
  801c64:	83 e0 01             	and    $0x1,%eax
  801c67:	85 c0                	test   %eax,%eax
  801c69:	74 07                	je     801c72 <number+0x95>
  801c6b:	b8 30 00 00 00       	mov    $0x30,%eax
  801c70:	eb 05                	jmp    801c77 <number+0x9a>
  801c72:	b8 20 00 00 00       	mov    $0x20,%eax
  801c77:	88 45 eb             	mov    %al,-0x15(%rbp)
  801c7a:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
  801c7e:	8b 45 90             	mov    -0x70(%rbp),%eax
  801c81:	83 e0 02             	and    $0x2,%eax
  801c84:	85 c0                	test   %eax,%eax
  801c86:	74 11                	je     801c99 <number+0xbc>
  801c88:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
  801c8d:	79 0a                	jns    801c99 <number+0xbc>
  801c8f:	c6 45 ff 2d          	movb   $0x2d,-0x1(%rbp)
  801c93:	48 f7 5d a0          	negq   -0x60(%rbp)
  801c97:	eb 1d                	jmp    801cb6 <number+0xd9>
  801c99:	8b 45 90             	mov    -0x70(%rbp),%eax
  801c9c:	83 e0 04             	and    $0x4,%eax
  801c9f:	85 c0                	test   %eax,%eax
  801ca1:	75 0b                	jne    801cae <number+0xd1>
  801ca3:	8b 45 90             	mov    -0x70(%rbp),%eax
  801ca6:	c1 e0 02             	shl    $0x2,%eax
  801ca9:	83 e0 20             	and    $0x20,%eax
  801cac:	eb 05                	jmp    801cb3 <number+0xd6>
  801cae:	b8 2b 00 00 00       	mov    $0x2b,%eax
  801cb3:	88 45 ff             	mov    %al,-0x1(%rbp)
  801cb6:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801cba:	74 04                	je     801cc0 <number+0xe3>
  801cbc:	83 6d 98 01          	subl   $0x1,-0x68(%rbp)
  801cc0:	8b 45 90             	mov    -0x70(%rbp),%eax
  801cc3:	83 e0 20             	and    $0x20,%eax
  801cc6:	85 c0                	test   %eax,%eax
  801cc8:	74 1a                	je     801ce4 <number+0x107>
  801cca:	83 7d 9c 10          	cmpl   $0x10,-0x64(%rbp)
  801cce:	74 0c                	je     801cdc <number+0xff>
  801cd0:	83 7d 9c 08          	cmpl   $0x8,-0x64(%rbp)
  801cd4:	0f 94 c0             	sete   %al
  801cd7:	0f b6 c0             	movzbl %al,%eax
  801cda:	eb 05                	jmp    801ce1 <number+0x104>
  801cdc:	b8 02 00 00 00       	mov    $0x2,%eax
  801ce1:	29 45 98             	sub    %eax,-0x68(%rbp)
  801ce4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  801ceb:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
  801cf0:	75 48                	jne    801d3a <number+0x15d>
  801cf2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801cf5:	8d 50 01             	lea    0x1(%rax),%edx
  801cf8:	89 55 ec             	mov    %edx,-0x14(%rbp)
  801cfb:	48 98                	cltq   
  801cfd:	c6 44 05 b0 30       	movb   $0x30,-0x50(%rbp,%rax,1)
  801d02:	eb 3d                	jmp    801d41 <number+0x164>
  801d04:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801d08:	ba 00 00 00 00       	mov    $0x0,%edx
  801d0d:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  801d10:	48 f7 f1             	div    %rcx
  801d13:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  801d17:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  801d1a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  801d1d:	48 63 d0             	movslq %eax,%rdx
  801d20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801d24:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
  801d28:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801d2b:	8d 50 01             	lea    0x1(%rax),%edx
  801d2e:	89 55 ec             	mov    %edx,-0x14(%rbp)
  801d31:	0f b6 11             	movzbl (%rcx),%edx
  801d34:	48 98                	cltq   
  801d36:	88 54 05 b0          	mov    %dl,-0x50(%rbp,%rax,1)
  801d3a:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
  801d3f:	75 c3                	jne    801d04 <number+0x127>
  801d41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801d44:	3b 45 94             	cmp    -0x6c(%rbp),%eax
  801d47:	7e 06                	jle    801d4f <number+0x172>
  801d49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801d4c:	89 45 94             	mov    %eax,-0x6c(%rbp)
  801d4f:	8b 45 94             	mov    -0x6c(%rbp),%eax
  801d52:	29 45 98             	sub    %eax,-0x68(%rbp)
  801d55:	8b 45 90             	mov    -0x70(%rbp),%eax
  801d58:	83 e0 11             	and    $0x11,%eax
  801d5b:	85 c0                	test   %eax,%eax
  801d5d:	75 1e                	jne    801d7d <number+0x1a0>
  801d5f:	eb 0f                	jmp    801d70 <number+0x193>
  801d61:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801d65:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801d69:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801d6d:	c6 00 20             	movb   $0x20,(%rax)
  801d70:	8b 45 98             	mov    -0x68(%rbp),%eax
  801d73:	8d 50 ff             	lea    -0x1(%rax),%edx
  801d76:	89 55 98             	mov    %edx,-0x68(%rbp)
  801d79:	85 c0                	test   %eax,%eax
  801d7b:	7f e4                	jg     801d61 <number+0x184>
  801d7d:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
  801d81:	74 12                	je     801d95 <number+0x1b8>
  801d83:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801d87:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801d8b:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801d8f:	0f b6 55 ff          	movzbl -0x1(%rbp),%edx
  801d93:	88 10                	mov    %dl,(%rax)
  801d95:	8b 45 90             	mov    -0x70(%rbp),%eax
  801d98:	83 e0 20             	and    $0x20,%eax
  801d9b:	85 c0                	test   %eax,%eax
  801d9d:	74 45                	je     801de4 <number+0x207>
  801d9f:	83 7d 9c 08          	cmpl   $0x8,-0x64(%rbp)
  801da3:	75 11                	jne    801db6 <number+0x1d9>
  801da5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801da9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801dad:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801db1:	c6 00 30             	movb   $0x30,(%rax)
  801db4:	eb 2e                	jmp    801de4 <number+0x207>
  801db6:	83 7d 9c 10          	cmpl   $0x10,-0x64(%rbp)
  801dba:	75 28                	jne    801de4 <number+0x207>
  801dbc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801dc0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801dc4:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801dc8:	c6 00 30             	movb   $0x30,(%rax)
  801dcb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  801dcf:	48 8d 48 21          	lea    0x21(%rax),%rcx
  801dd3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801dd7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801ddb:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801ddf:	0f b6 11             	movzbl (%rcx),%edx
  801de2:	88 10                	mov    %dl,(%rax)
  801de4:	8b 45 90             	mov    -0x70(%rbp),%eax
  801de7:	83 e0 10             	and    $0x10,%eax
  801dea:	85 c0                	test   %eax,%eax
  801dec:	75 32                	jne    801e20 <number+0x243>
  801dee:	eb 12                	jmp    801e02 <number+0x225>
  801df0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801df4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801df8:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801dfc:	0f b6 55 eb          	movzbl -0x15(%rbp),%edx
  801e00:	88 10                	mov    %dl,(%rax)
  801e02:	8b 45 98             	mov    -0x68(%rbp),%eax
  801e05:	8d 50 ff             	lea    -0x1(%rax),%edx
  801e08:	89 55 98             	mov    %edx,-0x68(%rbp)
  801e0b:	85 c0                	test   %eax,%eax
  801e0d:	7f e1                	jg     801df0 <number+0x213>
  801e0f:	eb 0f                	jmp    801e20 <number+0x243>
  801e11:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801e15:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801e19:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801e1d:	c6 00 30             	movb   $0x30,(%rax)
  801e20:	8b 45 94             	mov    -0x6c(%rbp),%eax
  801e23:	8d 50 ff             	lea    -0x1(%rax),%edx
  801e26:	89 55 94             	mov    %edx,-0x6c(%rbp)
  801e29:	39 45 ec             	cmp    %eax,-0x14(%rbp)
  801e2c:	7c e3                	jl     801e11 <number+0x234>
  801e2e:	eb 19                	jmp    801e49 <number+0x26c>
  801e30:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801e34:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801e38:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801e3c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  801e3f:	48 63 d2             	movslq %edx,%rdx
  801e42:	0f b6 54 15 b0       	movzbl -0x50(%rbp,%rdx,1),%edx
  801e47:	88 10                	mov    %dl,(%rax)
  801e49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  801e4c:	8d 50 ff             	lea    -0x1(%rax),%edx
  801e4f:	89 55 ec             	mov    %edx,-0x14(%rbp)
  801e52:	85 c0                	test   %eax,%eax
  801e54:	7f da                	jg     801e30 <number+0x253>
  801e56:	eb 0f                	jmp    801e67 <number+0x28a>
  801e58:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801e5c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  801e60:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
  801e64:	c6 00 20             	movb   $0x20,(%rax)
  801e67:	8b 45 98             	mov    -0x68(%rbp),%eax
  801e6a:	8d 50 ff             	lea    -0x1(%rax),%edx
  801e6d:	89 55 98             	mov    %edx,-0x68(%rbp)
  801e70:	85 c0                	test   %eax,%eax
  801e72:	7f e4                	jg     801e58 <number+0x27b>
  801e74:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801e78:	5d                   	pop    %rbp
  801e79:	c3                   	ret    

0000000000801e7a <vsprintf>:
  801e7a:	f3 0f 1e fa          	endbr64 
  801e7e:	55                   	push   %rbp
  801e7f:	48 89 e5             	mov    %rsp,%rbp
  801e82:	41 57                	push   %r15
  801e84:	53                   	push   %rbx
  801e85:	48 83 ec 60          	sub    $0x60,%rsp
  801e89:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 801e89 <vsprintf+0xf>
  801e90:	49 bb d7 19 00 00 00 	movabs $0x19d7,%r11
  801e97:	00 00 00 
  801e9a:	4c 01 db             	add    %r11,%rbx
  801e9d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  801ea1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  801ea5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  801ea9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  801ead:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  801eb1:	e9 ea 08 00 00       	jmp    8027a0 <vsprintf+0x926>
  801eb6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801eba:	0f b6 00             	movzbl (%rax),%eax
  801ebd:	3c 25                	cmp    $0x25,%al
  801ebf:	74 1a                	je     801edb <vsprintf+0x61>
  801ec1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  801ec5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  801ec9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  801ecd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  801ed1:	0f b6 12             	movzbl (%rdx),%edx
  801ed4:	88 10                	mov    %dl,(%rax)
  801ed6:	e9 b9 08 00 00       	jmp    802794 <vsprintf+0x91a>
  801edb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
  801ee2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801ee6:	48 83 c0 01          	add    $0x1,%rax
  801eea:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  801eee:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801ef2:	0f b6 00             	movzbl (%rax),%eax
  801ef5:	0f be c0             	movsbl %al,%eax
  801ef8:	83 e8 20             	sub    $0x20,%eax
  801efb:	83 f8 10             	cmp    $0x10,%eax
  801efe:	77 40                	ja     801f40 <vsprintf+0xc6>
  801f00:	89 c0                	mov    %eax,%eax
  801f02:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  801f09:	00 
  801f0a:	48 8d 05 87 1b 00 00 	lea    0x1b87(%rip),%rax        # 803a98 <.LC1+0x28>
  801f11:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
  801f15:	48 8d 15 7c 1b 00 00 	lea    0x1b7c(%rip),%rdx        # 803a98 <.LC1+0x28>
  801f1c:	48 01 d0             	add    %rdx,%rax
  801f1f:	3e ff e0             	notrack jmp *%rax
  801f22:	83 4d dc 10          	orl    $0x10,-0x24(%rbp)
  801f26:	eb ba                	jmp    801ee2 <vsprintf+0x68>
  801f28:	83 4d dc 04          	orl    $0x4,-0x24(%rbp)
  801f2c:	eb b4                	jmp    801ee2 <vsprintf+0x68>
  801f2e:	83 4d dc 08          	orl    $0x8,-0x24(%rbp)
  801f32:	eb ae                	jmp    801ee2 <vsprintf+0x68>
  801f34:	83 4d dc 20          	orl    $0x20,-0x24(%rbp)
  801f38:	eb a8                	jmp    801ee2 <vsprintf+0x68>
  801f3a:	83 4d dc 01          	orl    $0x1,-0x24(%rbp)
  801f3e:	eb a2                	jmp    801ee2 <vsprintf+0x68>
  801f40:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%rbp)
  801f47:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801f4b:	0f b6 00             	movzbl (%rax),%eax
  801f4e:	3c 2f                	cmp    $0x2f,%al
  801f50:	7e 27                	jle    801f79 <vsprintf+0xff>
  801f52:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801f56:	0f b6 00             	movzbl (%rax),%eax
  801f59:	3c 39                	cmp    $0x39,%al
  801f5b:	7f 1c                	jg     801f79 <vsprintf+0xff>
  801f5d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
  801f61:	48 89 c7             	mov    %rax,%rdi
  801f64:	48 b8 05 e3 ff ff ff 	movabs $0xffffffffffffe305,%rax
  801f6b:	ff ff ff 
  801f6e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  801f72:	ff d0                	call   *%rax
  801f74:	89 45 d8             	mov    %eax,-0x28(%rbp)
  801f77:	eb 6c                	jmp    801fe5 <vsprintf+0x16b>
  801f79:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801f7d:	0f b6 00             	movzbl (%rax),%eax
  801f80:	3c 2a                	cmp    $0x2a,%al
  801f82:	75 61                	jne    801fe5 <vsprintf+0x16b>
  801f84:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801f88:	48 83 c0 01          	add    $0x1,%rax
  801f8c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  801f90:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801f94:	8b 00                	mov    (%rax),%eax
  801f96:	83 f8 2f             	cmp    $0x2f,%eax
  801f99:	77 24                	ja     801fbf <vsprintf+0x145>
  801f9b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801f9f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  801fa3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801fa7:	8b 00                	mov    (%rax),%eax
  801fa9:	89 c0                	mov    %eax,%eax
  801fab:	48 01 d0             	add    %rdx,%rax
  801fae:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  801fb2:	8b 12                	mov    (%rdx),%edx
  801fb4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  801fb7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  801fbb:	89 0a                	mov    %ecx,(%rdx)
  801fbd:	eb 14                	jmp    801fd3 <vsprintf+0x159>
  801fbf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  801fc3:	48 8b 40 08          	mov    0x8(%rax),%rax
  801fc7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  801fcb:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  801fcf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  801fd3:	8b 00                	mov    (%rax),%eax
  801fd5:	89 45 d8             	mov    %eax,-0x28(%rbp)
  801fd8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  801fdc:	79 07                	jns    801fe5 <vsprintf+0x16b>
  801fde:	f7 5d d8             	negl   -0x28(%rbp)
  801fe1:	83 4d dc 10          	orl    $0x10,-0x24(%rbp)
  801fe5:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%rbp)
  801fec:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801ff0:	0f b6 00             	movzbl (%rax),%eax
  801ff3:	3c 2e                	cmp    $0x2e,%al
  801ff5:	0f 85 aa 00 00 00    	jne    8020a5 <vsprintf+0x22b>
  801ffb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  801fff:	48 83 c0 01          	add    $0x1,%rax
  802003:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  802007:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  80200b:	0f b6 00             	movzbl (%rax),%eax
  80200e:	3c 2f                	cmp    $0x2f,%al
  802010:	7e 27                	jle    802039 <vsprintf+0x1bf>
  802012:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  802016:	0f b6 00             	movzbl (%rax),%eax
  802019:	3c 39                	cmp    $0x39,%al
  80201b:	7f 1c                	jg     802039 <vsprintf+0x1bf>
  80201d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
  802021:	48 89 c7             	mov    %rax,%rdi
  802024:	48 b8 05 e3 ff ff ff 	movabs $0xffffffffffffe305,%rax
  80202b:	ff ff ff 
  80202e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  802032:	ff d0                	call   *%rax
  802034:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  802037:	eb 5f                	jmp    802098 <vsprintf+0x21e>
  802039:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  80203d:	0f b6 00             	movzbl (%rax),%eax
  802040:	3c 2a                	cmp    $0x2a,%al
  802042:	75 54                	jne    802098 <vsprintf+0x21e>
  802044:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  802048:	48 83 c0 01          	add    $0x1,%rax
  80204c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  802050:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802054:	8b 00                	mov    (%rax),%eax
  802056:	83 f8 2f             	cmp    $0x2f,%eax
  802059:	77 24                	ja     80207f <vsprintf+0x205>
  80205b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80205f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802063:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802067:	8b 00                	mov    (%rax),%eax
  802069:	89 c0                	mov    %eax,%eax
  80206b:	48 01 d0             	add    %rdx,%rax
  80206e:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802072:	8b 12                	mov    (%rdx),%edx
  802074:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802077:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80207b:	89 0a                	mov    %ecx,(%rdx)
  80207d:	eb 14                	jmp    802093 <vsprintf+0x219>
  80207f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802083:	48 8b 40 08          	mov    0x8(%rax),%rax
  802087:	48 8d 48 08          	lea    0x8(%rax),%rcx
  80208b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80208f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802093:	8b 00                	mov    (%rax),%eax
  802095:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  802098:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  80209c:	79 07                	jns    8020a5 <vsprintf+0x22b>
  80209e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
  8020a5:	c7 45 c8 ff ff ff ff 	movl   $0xffffffff,-0x38(%rbp)
  8020ac:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020b0:	0f b6 00             	movzbl (%rax),%eax
  8020b3:	3c 68                	cmp    $0x68,%al
  8020b5:	74 21                	je     8020d8 <vsprintf+0x25e>
  8020b7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020bb:	0f b6 00             	movzbl (%rax),%eax
  8020be:	3c 6c                	cmp    $0x6c,%al
  8020c0:	74 16                	je     8020d8 <vsprintf+0x25e>
  8020c2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020c6:	0f b6 00             	movzbl (%rax),%eax
  8020c9:	3c 4c                	cmp    $0x4c,%al
  8020cb:	74 0b                	je     8020d8 <vsprintf+0x25e>
  8020cd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020d1:	0f b6 00             	movzbl (%rax),%eax
  8020d4:	3c 5a                	cmp    $0x5a,%al
  8020d6:	75 19                	jne    8020f1 <vsprintf+0x277>
  8020d8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020dc:	0f b6 00             	movzbl (%rax),%eax
  8020df:	0f be c0             	movsbl %al,%eax
  8020e2:	89 45 c8             	mov    %eax,-0x38(%rbp)
  8020e5:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020e9:	48 83 c0 01          	add    $0x1,%rax
  8020ed:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  8020f1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8020f5:	0f b6 00             	movzbl (%rax),%eax
  8020f8:	0f be c0             	movsbl %al,%eax
  8020fb:	83 e8 25             	sub    $0x25,%eax
  8020fe:	83 f8 53             	cmp    $0x53,%eax
  802101:	0f 87 4f 06 00 00    	ja     802756 <vsprintf+0x8dc>
  802107:	89 c0                	mov    %eax,%eax
  802109:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  802110:	00 
  802111:	48 8d 05 08 1a 00 00 	lea    0x1a08(%rip),%rax        # 803b20 <.LC1+0xb0>
  802118:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
  80211c:	48 8d 15 fd 19 00 00 	lea    0x19fd(%rip),%rdx        # 803b20 <.LC1+0xb0>
  802123:	48 01 d0             	add    %rdx,%rax
  802126:	3e ff e0             	notrack jmp *%rax
  802129:	8b 45 dc             	mov    -0x24(%rbp),%eax
  80212c:	83 e0 10             	and    $0x10,%eax
  80212f:	85 c0                	test   %eax,%eax
  802131:	75 1b                	jne    80214e <vsprintf+0x2d4>
  802133:	eb 0f                	jmp    802144 <vsprintf+0x2ca>
  802135:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802139:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80213d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802141:	c6 00 20             	movb   $0x20,(%rax)
  802144:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  802148:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  80214c:	7f e7                	jg     802135 <vsprintf+0x2bb>
  80214e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802152:	8b 00                	mov    (%rax),%eax
  802154:	83 f8 2f             	cmp    $0x2f,%eax
  802157:	77 24                	ja     80217d <vsprintf+0x303>
  802159:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80215d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802161:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802165:	8b 00                	mov    (%rax),%eax
  802167:	89 c0                	mov    %eax,%eax
  802169:	48 01 d0             	add    %rdx,%rax
  80216c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802170:	8b 12                	mov    (%rdx),%edx
  802172:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802175:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802179:	89 0a                	mov    %ecx,(%rdx)
  80217b:	eb 14                	jmp    802191 <vsprintf+0x317>
  80217d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802181:	48 8b 40 08          	mov    0x8(%rax),%rax
  802185:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802189:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80218d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802191:	8b 08                	mov    (%rax),%ecx
  802193:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802197:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80219b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80219f:	89 ca                	mov    %ecx,%edx
  8021a1:	88 10                	mov    %dl,(%rax)
  8021a3:	eb 0f                	jmp    8021b4 <vsprintf+0x33a>
  8021a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8021a9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8021ad:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8021b1:	c6 00 20             	movb   $0x20,(%rax)
  8021b4:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  8021b8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
  8021bc:	7f e7                	jg     8021a5 <vsprintf+0x32b>
  8021be:	e9 d1 05 00 00       	jmp    802794 <vsprintf+0x91a>
  8021c3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8021c7:	8b 00                	mov    (%rax),%eax
  8021c9:	83 f8 2f             	cmp    $0x2f,%eax
  8021cc:	77 24                	ja     8021f2 <vsprintf+0x378>
  8021ce:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8021d2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8021d6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8021da:	8b 00                	mov    (%rax),%eax
  8021dc:	89 c0                	mov    %eax,%eax
  8021de:	48 01 d0             	add    %rdx,%rax
  8021e1:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8021e5:	8b 12                	mov    (%rdx),%edx
  8021e7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8021ea:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8021ee:	89 0a                	mov    %ecx,(%rdx)
  8021f0:	eb 14                	jmp    802206 <vsprintf+0x38c>
  8021f2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8021f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  8021fa:	48 8d 48 08          	lea    0x8(%rax),%rcx
  8021fe:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802202:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802206:	48 8b 00             	mov    (%rax),%rax
  802209:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  80220d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  802212:	75 08                	jne    80221c <vsprintf+0x3a2>
  802214:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
  80221b:	00 
  80221c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802220:	48 89 c7             	mov    %rax,%rdi
  802223:	49 89 df             	mov    %rbx,%r15
  802226:	48 b8 32 f4 ff ff ff 	movabs $0xfffffffffffff432,%rax
  80222d:	ff ff ff 
  802230:	48 01 d8             	add    %rbx,%rax
  802233:	ff d0                	call   *%rax
  802235:	89 45 d0             	mov    %eax,-0x30(%rbp)
  802238:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  80223c:	79 08                	jns    802246 <vsprintf+0x3cc>
  80223e:	8b 45 d0             	mov    -0x30(%rbp),%eax
  802241:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  802244:	eb 0e                	jmp    802254 <vsprintf+0x3da>
  802246:	8b 45 d0             	mov    -0x30(%rbp),%eax
  802249:	3b 45 d4             	cmp    -0x2c(%rbp),%eax
  80224c:	7e 06                	jle    802254 <vsprintf+0x3da>
  80224e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
  802251:	89 45 d0             	mov    %eax,-0x30(%rbp)
  802254:	8b 45 dc             	mov    -0x24(%rbp),%eax
  802257:	83 e0 10             	and    $0x10,%eax
  80225a:	85 c0                	test   %eax,%eax
  80225c:	75 1d                	jne    80227b <vsprintf+0x401>
  80225e:	eb 0f                	jmp    80226f <vsprintf+0x3f5>
  802260:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802264:	48 8d 50 01          	lea    0x1(%rax),%rdx
  802268:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  80226c:	c6 00 20             	movb   $0x20,(%rax)
  80226f:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  802273:	8b 45 d8             	mov    -0x28(%rbp),%eax
  802276:	3b 45 d0             	cmp    -0x30(%rbp),%eax
  802279:	7f e5                	jg     802260 <vsprintf+0x3e6>
  80227b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
  802282:	eb 21                	jmp    8022a5 <vsprintf+0x42b>
  802284:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  802288:	48 8d 42 01          	lea    0x1(%rdx),%rax
  80228c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802290:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802294:	48 8d 48 01          	lea    0x1(%rax),%rcx
  802298:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80229c:	0f b6 12             	movzbl (%rdx),%edx
  80229f:	88 10                	mov    %dl,(%rax)
  8022a1:	83 45 cc 01          	addl   $0x1,-0x34(%rbp)
  8022a5:	8b 45 cc             	mov    -0x34(%rbp),%eax
  8022a8:	3b 45 d0             	cmp    -0x30(%rbp),%eax
  8022ab:	7c d7                	jl     802284 <vsprintf+0x40a>
  8022ad:	eb 0f                	jmp    8022be <vsprintf+0x444>
  8022af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8022b3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  8022b7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  8022bb:	c6 00 20             	movb   $0x20,(%rax)
  8022be:	83 6d d8 01          	subl   $0x1,-0x28(%rbp)
  8022c2:	8b 45 d8             	mov    -0x28(%rbp),%eax
  8022c5:	3b 45 d0             	cmp    -0x30(%rbp),%eax
  8022c8:	7f e5                	jg     8022af <vsprintf+0x435>
  8022ca:	e9 c5 04 00 00       	jmp    802794 <vsprintf+0x91a>
  8022cf:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
  8022d3:	0f 85 82 00 00 00    	jne    80235b <vsprintf+0x4e1>
  8022d9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8022dd:	8b 00                	mov    (%rax),%eax
  8022df:	83 f8 2f             	cmp    $0x2f,%eax
  8022e2:	77 24                	ja     802308 <vsprintf+0x48e>
  8022e4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8022e8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8022ec:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8022f0:	8b 00                	mov    (%rax),%eax
  8022f2:	89 c0                	mov    %eax,%eax
  8022f4:	48 01 d0             	add    %rdx,%rax
  8022f7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8022fb:	8b 12                	mov    (%rdx),%edx
  8022fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802300:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802304:	89 0a                	mov    %ecx,(%rdx)
  802306:	eb 14                	jmp    80231c <vsprintf+0x4a2>
  802308:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80230c:	48 8b 40 08          	mov    0x8(%rax),%rax
  802310:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802314:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802318:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80231c:	48 8b 00             	mov    (%rax),%rax
  80231f:	48 89 c7             	mov    %rax,%rdi
  802322:	8b 75 dc             	mov    -0x24(%rbp),%esi
  802325:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  802328:	8b 55 d8             	mov    -0x28(%rbp),%edx
  80232b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80232f:	41 89 f1             	mov    %esi,%r9d
  802332:	41 89 c8             	mov    %ecx,%r8d
  802335:	89 d1                	mov    %edx,%ecx
  802337:	ba 08 00 00 00       	mov    $0x8,%edx
  80233c:	48 89 fe             	mov    %rdi,%rsi
  80233f:	48 89 c7             	mov    %rax,%rdi
  802342:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  802349:	ff ff ff 
  80234c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  802350:	ff d0                	call   *%rax
  802352:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802356:	e9 39 04 00 00       	jmp    802794 <vsprintf+0x91a>
  80235b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80235f:	8b 00                	mov    (%rax),%eax
  802361:	83 f8 2f             	cmp    $0x2f,%eax
  802364:	77 24                	ja     80238a <vsprintf+0x510>
  802366:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80236a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80236e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802372:	8b 00                	mov    (%rax),%eax
  802374:	89 c0                	mov    %eax,%eax
  802376:	48 01 d0             	add    %rdx,%rax
  802379:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80237d:	8b 12                	mov    (%rdx),%edx
  80237f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802382:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802386:	89 0a                	mov    %ecx,(%rdx)
  802388:	eb 14                	jmp    80239e <vsprintf+0x524>
  80238a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80238e:	48 8b 40 08          	mov    0x8(%rax),%rax
  802392:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802396:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80239a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80239e:	8b 00                	mov    (%rax),%eax
  8023a0:	89 c7                	mov    %eax,%edi
  8023a2:	8b 75 dc             	mov    -0x24(%rbp),%esi
  8023a5:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8023a8:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8023ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8023af:	41 89 f1             	mov    %esi,%r9d
  8023b2:	41 89 c8             	mov    %ecx,%r8d
  8023b5:	89 d1                	mov    %edx,%ecx
  8023b7:	ba 08 00 00 00       	mov    $0x8,%edx
  8023bc:	48 89 fe             	mov    %rdi,%rsi
  8023bf:	48 89 c7             	mov    %rax,%rdi
  8023c2:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  8023c9:	ff ff ff 
  8023cc:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8023d0:	ff d0                	call   *%rax
  8023d2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8023d6:	e9 b9 03 00 00       	jmp    802794 <vsprintf+0x91a>
  8023db:	83 7d d8 ff          	cmpl   $0xffffffff,-0x28(%rbp)
  8023df:	75 0b                	jne    8023ec <vsprintf+0x572>
  8023e1:	c7 45 d8 10 00 00 00 	movl   $0x10,-0x28(%rbp)
  8023e8:	83 4d dc 01          	orl    $0x1,-0x24(%rbp)
  8023ec:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8023f0:	8b 00                	mov    (%rax),%eax
  8023f2:	83 f8 2f             	cmp    $0x2f,%eax
  8023f5:	77 24                	ja     80241b <vsprintf+0x5a1>
  8023f7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8023fb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8023ff:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802403:	8b 00                	mov    (%rax),%eax
  802405:	89 c0                	mov    %eax,%eax
  802407:	48 01 d0             	add    %rdx,%rax
  80240a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80240e:	8b 12                	mov    (%rdx),%edx
  802410:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802413:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802417:	89 0a                	mov    %ecx,(%rdx)
  802419:	eb 14                	jmp    80242f <vsprintf+0x5b5>
  80241b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80241f:	48 8b 40 08          	mov    0x8(%rax),%rax
  802423:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802427:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80242b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80242f:	48 8b 00             	mov    (%rax),%rax
  802432:	48 89 c7             	mov    %rax,%rdi
  802435:	8b 75 dc             	mov    -0x24(%rbp),%esi
  802438:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80243b:	8b 55 d8             	mov    -0x28(%rbp),%edx
  80243e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802442:	41 89 f1             	mov    %esi,%r9d
  802445:	41 89 c8             	mov    %ecx,%r8d
  802448:	89 d1                	mov    %edx,%ecx
  80244a:	ba 10 00 00 00       	mov    $0x10,%edx
  80244f:	48 89 fe             	mov    %rdi,%rsi
  802452:	48 89 c7             	mov    %rax,%rdi
  802455:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  80245c:	ff ff ff 
  80245f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  802463:	ff d0                	call   *%rax
  802465:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802469:	e9 26 03 00 00       	jmp    802794 <vsprintf+0x91a>
  80246e:	83 4d dc 40          	orl    $0x40,-0x24(%rbp)
  802472:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
  802476:	0f 85 82 00 00 00    	jne    8024fe <vsprintf+0x684>
  80247c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802480:	8b 00                	mov    (%rax),%eax
  802482:	83 f8 2f             	cmp    $0x2f,%eax
  802485:	77 24                	ja     8024ab <vsprintf+0x631>
  802487:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80248b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80248f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802493:	8b 00                	mov    (%rax),%eax
  802495:	89 c0                	mov    %eax,%eax
  802497:	48 01 d0             	add    %rdx,%rax
  80249a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80249e:	8b 12                	mov    (%rdx),%edx
  8024a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8024a3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8024a7:	89 0a                	mov    %ecx,(%rdx)
  8024a9:	eb 14                	jmp    8024bf <vsprintf+0x645>
  8024ab:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8024af:	48 8b 40 08          	mov    0x8(%rax),%rax
  8024b3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  8024b7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8024bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8024bf:	48 8b 00             	mov    (%rax),%rax
  8024c2:	48 89 c7             	mov    %rax,%rdi
  8024c5:	8b 75 dc             	mov    -0x24(%rbp),%esi
  8024c8:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8024cb:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8024ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8024d2:	41 89 f1             	mov    %esi,%r9d
  8024d5:	41 89 c8             	mov    %ecx,%r8d
  8024d8:	89 d1                	mov    %edx,%ecx
  8024da:	ba 10 00 00 00       	mov    $0x10,%edx
  8024df:	48 89 fe             	mov    %rdi,%rsi
  8024e2:	48 89 c7             	mov    %rax,%rdi
  8024e5:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  8024ec:	ff ff ff 
  8024ef:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8024f3:	ff d0                	call   *%rax
  8024f5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8024f9:	e9 96 02 00 00       	jmp    802794 <vsprintf+0x91a>
  8024fe:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802502:	8b 00                	mov    (%rax),%eax
  802504:	83 f8 2f             	cmp    $0x2f,%eax
  802507:	77 24                	ja     80252d <vsprintf+0x6b3>
  802509:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80250d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802511:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802515:	8b 00                	mov    (%rax),%eax
  802517:	89 c0                	mov    %eax,%eax
  802519:	48 01 d0             	add    %rdx,%rax
  80251c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802520:	8b 12                	mov    (%rdx),%edx
  802522:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802525:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802529:	89 0a                	mov    %ecx,(%rdx)
  80252b:	eb 14                	jmp    802541 <vsprintf+0x6c7>
  80252d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802531:	48 8b 40 08          	mov    0x8(%rax),%rax
  802535:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802539:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80253d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802541:	8b 00                	mov    (%rax),%eax
  802543:	89 c7                	mov    %eax,%edi
  802545:	8b 75 dc             	mov    -0x24(%rbp),%esi
  802548:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  80254b:	8b 55 d8             	mov    -0x28(%rbp),%edx
  80254e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802552:	41 89 f1             	mov    %esi,%r9d
  802555:	41 89 c8             	mov    %ecx,%r8d
  802558:	89 d1                	mov    %edx,%ecx
  80255a:	ba 10 00 00 00       	mov    $0x10,%edx
  80255f:	48 89 fe             	mov    %rdi,%rsi
  802562:	48 89 c7             	mov    %rax,%rdi
  802565:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  80256c:	ff ff ff 
  80256f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  802573:	ff d0                	call   *%rax
  802575:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  802579:	e9 16 02 00 00       	jmp    802794 <vsprintf+0x91a>
  80257e:	83 4d dc 02          	orl    $0x2,-0x24(%rbp)
  802582:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
  802586:	75 7c                	jne    802604 <vsprintf+0x78a>
  802588:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80258c:	8b 00                	mov    (%rax),%eax
  80258e:	83 f8 2f             	cmp    $0x2f,%eax
  802591:	77 24                	ja     8025b7 <vsprintf+0x73d>
  802593:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802597:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80259b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80259f:	8b 00                	mov    (%rax),%eax
  8025a1:	89 c0                	mov    %eax,%eax
  8025a3:	48 01 d0             	add    %rdx,%rax
  8025a6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8025aa:	8b 12                	mov    (%rdx),%edx
  8025ac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8025af:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8025b3:	89 0a                	mov    %ecx,(%rdx)
  8025b5:	eb 14                	jmp    8025cb <vsprintf+0x751>
  8025b7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8025bb:	48 8b 40 08          	mov    0x8(%rax),%rax
  8025bf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  8025c3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8025c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8025cb:	48 8b 30             	mov    (%rax),%rsi
  8025ce:	8b 7d dc             	mov    -0x24(%rbp),%edi
  8025d1:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  8025d4:	8b 55 d8             	mov    -0x28(%rbp),%edx
  8025d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8025db:	41 89 f9             	mov    %edi,%r9d
  8025de:	41 89 c8             	mov    %ecx,%r8d
  8025e1:	89 d1                	mov    %edx,%ecx
  8025e3:	ba 0a 00 00 00       	mov    $0xa,%edx
  8025e8:	48 89 c7             	mov    %rax,%rdi
  8025eb:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  8025f2:	ff ff ff 
  8025f5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  8025f9:	ff d0                	call   *%rax
  8025fb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  8025ff:	e9 90 01 00 00       	jmp    802794 <vsprintf+0x91a>
  802604:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802608:	8b 00                	mov    (%rax),%eax
  80260a:	83 f8 2f             	cmp    $0x2f,%eax
  80260d:	77 24                	ja     802633 <vsprintf+0x7b9>
  80260f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802613:	48 8b 50 10          	mov    0x10(%rax),%rdx
  802617:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80261b:	8b 00                	mov    (%rax),%eax
  80261d:	89 c0                	mov    %eax,%eax
  80261f:	48 01 d0             	add    %rdx,%rax
  802622:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802626:	8b 12                	mov    (%rdx),%edx
  802628:	8d 4a 08             	lea    0x8(%rdx),%ecx
  80262b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80262f:	89 0a                	mov    %ecx,(%rdx)
  802631:	eb 14                	jmp    802647 <vsprintf+0x7cd>
  802633:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802637:	48 8b 40 08          	mov    0x8(%rax),%rax
  80263b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  80263f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802643:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  802647:	8b 00                	mov    (%rax),%eax
  802649:	48 63 f0             	movslq %eax,%rsi
  80264c:	8b 7d dc             	mov    -0x24(%rbp),%edi
  80264f:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
  802652:	8b 55 d8             	mov    -0x28(%rbp),%edx
  802655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802659:	41 89 f9             	mov    %edi,%r9d
  80265c:	41 89 c8             	mov    %ecx,%r8d
  80265f:	89 d1                	mov    %edx,%ecx
  802661:	ba 0a 00 00 00       	mov    $0xa,%edx
  802666:	48 89 c7             	mov    %rax,%rdi
  802669:	48 b8 7d e3 ff ff ff 	movabs $0xffffffffffffe37d,%rax
  802670:	ff ff ff 
  802673:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  802677:	ff d0                	call   *%rax
  802679:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  80267d:	e9 12 01 00 00       	jmp    802794 <vsprintf+0x91a>
  802682:	83 7d c8 6c          	cmpl   $0x6c,-0x38(%rbp)
  802686:	75 61                	jne    8026e9 <vsprintf+0x86f>
  802688:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80268c:	8b 00                	mov    (%rax),%eax
  80268e:	83 f8 2f             	cmp    $0x2f,%eax
  802691:	77 24                	ja     8026b7 <vsprintf+0x83d>
  802693:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802697:	48 8b 50 10          	mov    0x10(%rax),%rdx
  80269b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80269f:	8b 00                	mov    (%rax),%eax
  8026a1:	89 c0                	mov    %eax,%eax
  8026a3:	48 01 d0             	add    %rdx,%rax
  8026a6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8026aa:	8b 12                	mov    (%rdx),%edx
  8026ac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  8026af:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8026b3:	89 0a                	mov    %ecx,(%rdx)
  8026b5:	eb 14                	jmp    8026cb <vsprintf+0x851>
  8026b7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8026bb:	48 8b 40 08          	mov    0x8(%rax),%rax
  8026bf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  8026c3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  8026c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  8026cb:	48 8b 00             	mov    (%rax),%rax
  8026ce:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  8026d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8026d6:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
  8026da:	48 89 c2             	mov    %rax,%rdx
  8026dd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  8026e1:	48 89 10             	mov    %rdx,(%rax)
  8026e4:	e9 ab 00 00 00       	jmp    802794 <vsprintf+0x91a>
  8026e9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8026ed:	8b 00                	mov    (%rax),%eax
  8026ef:	83 f8 2f             	cmp    $0x2f,%eax
  8026f2:	77 24                	ja     802718 <vsprintf+0x89e>
  8026f4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  8026f8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  8026fc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  802700:	8b 00                	mov    (%rax),%eax
  802702:	89 c0                	mov    %eax,%eax
  802704:	48 01 d0             	add    %rdx,%rax
  802707:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  80270b:	8b 12                	mov    (%rdx),%edx
  80270d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  802710:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802714:	89 0a                	mov    %ecx,(%rdx)
  802716:	eb 14                	jmp    80272c <vsprintf+0x8b2>
  802718:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  80271c:	48 8b 40 08          	mov    0x8(%rax),%rax
  802720:	48 8d 48 08          	lea    0x8(%rax),%rcx
  802724:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  802728:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  80272c:	48 8b 00             	mov    (%rax),%rax
  80272f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  802733:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802737:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
  80273b:	89 c2                	mov    %eax,%edx
  80273d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  802741:	89 10                	mov    %edx,(%rax)
  802743:	eb 4f                	jmp    802794 <vsprintf+0x91a>
  802745:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802749:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80274d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802751:	c6 00 25             	movb   $0x25,(%rax)
  802754:	eb 3e                	jmp    802794 <vsprintf+0x91a>
  802756:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  80275a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  80275e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802762:	c6 00 25             	movb   $0x25,(%rax)
  802765:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  802769:	0f b6 00             	movzbl (%rax),%eax
  80276c:	84 c0                	test   %al,%al
  80276e:	74 17                	je     802787 <vsprintf+0x90d>
  802770:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  802774:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802778:	48 8d 48 01          	lea    0x1(%rax),%rcx
  80277c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  802780:	0f b6 12             	movzbl (%rdx),%edx
  802783:	88 10                	mov    %dl,(%rax)
  802785:	eb 0c                	jmp    802793 <vsprintf+0x919>
  802787:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  80278b:	48 83 e8 01          	sub    $0x1,%rax
  80278f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  802793:	90                   	nop
  802794:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  802798:	48 83 c0 01          	add    $0x1,%rax
  80279c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  8027a0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
  8027a4:	0f b6 00             	movzbl (%rax),%eax
  8027a7:	84 c0                	test   %al,%al
  8027a9:	0f 85 07 f7 ff ff    	jne    801eb6 <vsprintf+0x3c>
  8027af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027b3:	c6 00 00             	movb   $0x0,(%rax)
  8027b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  8027ba:	48 2b 45 a8          	sub    -0x58(%rbp),%rax
  8027be:	48 83 c4 60          	add    $0x60,%rsp
  8027c2:	5b                   	pop    %rbx
  8027c3:	41 5f                	pop    %r15
  8027c5:	5d                   	pop    %rbp
  8027c6:	c3                   	ret    

00000000008027c7 <sprintf>:
  8027c7:	f3 0f 1e fa          	endbr64 
  8027cb:	55                   	push   %rbp
  8027cc:	48 89 e5             	mov    %rsp,%rbp
  8027cf:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
  8027d6:	4c 8d 15 f9 ff ff ff 	lea    -0x7(%rip),%r10        # 8027d6 <sprintf+0xf>
  8027dd:	49 bb 8a 10 00 00 00 	movabs $0x108a,%r11
  8027e4:	00 00 00 
  8027e7:	4d 01 da             	add    %r11,%r10
  8027ea:	48 89 bd 28 ff ff ff 	mov    %rdi,-0xd8(%rbp)
  8027f1:	48 89 b5 20 ff ff ff 	mov    %rsi,-0xe0(%rbp)
  8027f8:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  8027ff:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  802806:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  80280d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  802814:	84 c0                	test   %al,%al
  802816:	74 20                	je     802838 <sprintf+0x71>
  802818:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  80281c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  802820:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  802824:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  802828:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  80282c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  802830:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  802834:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  802838:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
  80283f:	00 00 00 
  802842:	c7 85 30 ff ff ff 10 	movl   $0x10,-0xd0(%rbp)
  802849:	00 00 00 
  80284c:	c7 85 34 ff ff ff 30 	movl   $0x30,-0xcc(%rbp)
  802853:	00 00 00 
  802856:	48 8d 45 10          	lea    0x10(%rbp),%rax
  80285a:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
  802861:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
  802868:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
  80286f:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
  802876:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
  80287d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
  802884:	48 89 ce             	mov    %rcx,%rsi
  802887:	48 89 c7             	mov    %rax,%rdi
  80288a:	48 b8 1a e6 ff ff ff 	movabs $0xffffffffffffe61a,%rax
  802891:	ff ff ff 
  802894:	49 8d 04 02          	lea    (%r10,%rax,1),%rax
  802898:	ff d0                	call   *%rax
  80289a:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%rbp)
  8028a0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  8028a6:	c9                   	leave  
  8028a7:	c3                   	ret    

00000000008028a8 <printf>:
  8028a8:	f3 0f 1e fa          	endbr64 
  8028ac:	55                   	push   %rbp
  8028ad:	48 89 e5             	mov    %rsp,%rbp
  8028b0:	41 57                	push   %r15
  8028b2:	53                   	push   %rbx
  8028b3:	48 81 ec f0 04 00 00 	sub    $0x4f0,%rsp
  8028ba:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 8028ba <printf+0x12>
  8028c1:	49 bb a6 0f 00 00 00 	movabs $0xfa6,%r11
  8028c8:	00 00 00 
  8028cb:	4c 01 db             	add    %r11,%rbx
  8028ce:	48 89 bd 08 fb ff ff 	mov    %rdi,-0x4f8(%rbp)
  8028d5:	48 89 b5 48 ff ff ff 	mov    %rsi,-0xb8(%rbp)
  8028dc:	48 89 95 50 ff ff ff 	mov    %rdx,-0xb0(%rbp)
  8028e3:	48 89 8d 58 ff ff ff 	mov    %rcx,-0xa8(%rbp)
  8028ea:	4c 89 85 60 ff ff ff 	mov    %r8,-0xa0(%rbp)
  8028f1:	4c 89 8d 68 ff ff ff 	mov    %r9,-0x98(%rbp)
  8028f8:	84 c0                	test   %al,%al
  8028fa:	74 23                	je     80291f <printf+0x77>
  8028fc:	0f 29 85 70 ff ff ff 	movaps %xmm0,-0x90(%rbp)
  802903:	0f 29 4d 80          	movaps %xmm1,-0x80(%rbp)
  802907:	0f 29 55 90          	movaps %xmm2,-0x70(%rbp)
  80290b:	0f 29 5d a0          	movaps %xmm3,-0x60(%rbp)
  80290f:	0f 29 65 b0          	movaps %xmm4,-0x50(%rbp)
  802913:	0f 29 6d c0          	movaps %xmm5,-0x40(%rbp)
  802917:	0f 29 75 d0          	movaps %xmm6,-0x30(%rbp)
  80291b:	0f 29 7d e0          	movaps %xmm7,-0x20(%rbp)
  80291f:	c7 85 3c ff ff ff 00 	movl   $0x0,-0xc4(%rbp)
  802926:	00 00 00 
  802929:	c7 85 18 fb ff ff 08 	movl   $0x8,-0x4e8(%rbp)
  802930:	00 00 00 
  802933:	c7 85 1c fb ff ff 30 	movl   $0x30,-0x4e4(%rbp)
  80293a:	00 00 00 
  80293d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  802941:	48 89 85 20 fb ff ff 	mov    %rax,-0x4e0(%rbp)
  802948:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
  80294f:	48 89 85 28 fb ff ff 	mov    %rax,-0x4d8(%rbp)
  802956:	48 8d 95 18 fb ff ff 	lea    -0x4e8(%rbp),%rdx
  80295d:	48 8b 8d 08 fb ff ff 	mov    -0x4f8(%rbp),%rcx
  802964:	48 8d 85 30 fb ff ff 	lea    -0x4d0(%rbp),%rax
  80296b:	48 89 ce             	mov    %rcx,%rsi
  80296e:	48 89 c7             	mov    %rax,%rdi
  802971:	48 b8 1a e6 ff ff ff 	movabs $0xffffffffffffe61a,%rax
  802978:	ff ff ff 
  80297b:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
  80297f:	ff d0                	call   *%rax
  802981:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  802987:	48 8d 85 30 fb ff ff 	lea    -0x4d0(%rbp),%rax
  80298e:	48 89 c7             	mov    %rax,%rdi
  802991:	49 89 df             	mov    %rbx,%r15
  802994:	48 b8 9c e0 ff ff ff 	movabs $0xffffffffffffe09c,%rax
  80299b:	ff ff ff 
  80299e:	48 01 d8             	add    %rbx,%rax
  8029a1:	ff d0                	call   *%rax
  8029a3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
  8029a9:	48 81 c4 f0 04 00 00 	add    $0x4f0,%rsp
  8029b0:	5b                   	pop    %rbx
  8029b1:	41 5f                	pop    %r15
  8029b3:	5d                   	pop    %rbp
  8029b4:	c3                   	ret    

00000000008029b5 <memcpy>:
  8029b5:	f3 0f 1e fa          	endbr64 
  8029b9:	55                   	push   %rbp
  8029ba:	48 89 e5             	mov    %rsp,%rbp
  8029bd:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 8029bd <memcpy+0x8>
  8029c4:	49 bb a3 0e 00 00 00 	movabs $0xea3,%r11
  8029cb:	00 00 00 
  8029ce:	4c 01 d8             	add    %r11,%rax
  8029d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  8029d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  8029d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  8029dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029e1:	48 8d 50 07          	lea    0x7(%rax),%rdx
  8029e5:	48 85 c0             	test   %rax,%rax
  8029e8:	48 0f 48 c2          	cmovs  %rdx,%rax
  8029ec:	48 c1 f8 03          	sar    $0x3,%rax
  8029f0:	48 89 c1             	mov    %rax,%rcx
  8029f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  8029f7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  8029fb:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
  8029ff:	48 89 d7             	mov    %rdx,%rdi
  802a02:	fc                   	cld    
  802a03:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  802a06:	a8 04                	test   $0x4,%al
  802a08:	74 01                	je     802a0b <memcpy+0x56>
  802a0a:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
  802a0b:	a8 02                	test   $0x2,%al
  802a0d:	74 02                	je     802a11 <memcpy+0x5c>
  802a0f:	66 a5                	movsw  %ds:(%rsi),%es:(%rdi)
  802a11:	a8 01                	test   $0x1,%al
  802a13:	74 01                	je     802a16 <memcpy+0x61>
  802a15:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  802a16:	89 f2                	mov    %esi,%edx
  802a18:	89 4d fc             	mov    %ecx,-0x4(%rbp)
  802a1b:	89 7d f8             	mov    %edi,-0x8(%rbp)
  802a1e:	89 55 f4             	mov    %edx,-0xc(%rbp)
  802a21:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802a25:	5d                   	pop    %rbp
  802a26:	c3                   	ret    

0000000000802a27 <memcmp>:
  802a27:	f3 0f 1e fa          	endbr64 
  802a2b:	55                   	push   %rbp
  802a2c:	48 89 e5             	mov    %rsp,%rbp
  802a2f:	53                   	push   %rbx
  802a30:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802a30 <memcmp+0x9>
  802a37:	49 bb 30 0e 00 00 00 	movabs $0xe30,%r11
  802a3e:	00 00 00 
  802a41:	4c 01 d8             	add    %r11,%rax
  802a44:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
  802a48:	48 89 75 e8          	mov    %rsi,-0x18(%rbp)
  802a4c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802a50:	b8 00 00 00 00       	mov    $0x0,%eax
  802a55:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802a59:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
  802a5d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802a61:	48 89 d7             	mov    %rdx,%rdi
  802a64:	fc                   	cld    
  802a65:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  802a67:	74 09                	je     802a72 <memcmp+0x4b>
  802a69:	b8 01 00 00 00       	mov    $0x1,%eax
  802a6e:	7c 02                	jl     802a72 <memcmp+0x4b>
  802a70:	f7 d8                	neg    %eax
  802a72:	89 c3                	mov    %eax,%ebx
  802a74:	89 d8                	mov    %ebx,%eax
  802a76:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  802a7a:	c9                   	leave  
  802a7b:	c3                   	ret    

0000000000802a7c <memset>:
  802a7c:	f3 0f 1e fa          	endbr64 
  802a80:	55                   	push   %rbp
  802a81:	48 89 e5             	mov    %rsp,%rbp
  802a84:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802a84 <memset+0x8>
  802a8b:	49 bb dc 0d 00 00 00 	movabs $0xddc,%r11
  802a92:	00 00 00 
  802a95:	4c 01 d8             	add    %r11,%rax
  802a98:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802a9c:	89 f0                	mov    %esi,%eax
  802a9e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  802aa2:	88 45 e4             	mov    %al,-0x1c(%rbp)
  802aa5:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  802aa9:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
  802ab0:	01 01 01 
  802ab3:	48 0f af c2          	imul   %rdx,%rax
  802ab7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  802abb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802abf:	48 8d 50 07          	lea    0x7(%rax),%rdx
  802ac3:	48 85 c0             	test   %rax,%rax
  802ac6:	48 0f 48 c2          	cmovs  %rdx,%rax
  802aca:	48 c1 f8 03          	sar    $0x3,%rax
  802ace:	48 89 c1             	mov    %rax,%rcx
  802ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802ad5:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
  802ad9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802add:	48 89 d7             	mov    %rdx,%rdi
  802ae0:	fc                   	cld    
  802ae1:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  802ae4:	40 f6 c6 04          	test   $0x4,%sil
  802ae8:	74 01                	je     802aeb <memset+0x6f>
  802aea:	ab                   	stos   %eax,%es:(%rdi)
  802aeb:	40 f6 c6 02          	test   $0x2,%sil
  802aef:	74 02                	je     802af3 <memset+0x77>
  802af1:	66 ab                	stos   %ax,%es:(%rdi)
  802af3:	40 f6 c6 01          	test   $0x1,%sil
  802af7:	74 01                	je     802afa <memset+0x7e>
  802af9:	aa                   	stos   %al,%es:(%rdi)
  802afa:	89 f8                	mov    %edi,%eax
  802afc:	89 ca                	mov    %ecx,%edx
  802afe:	89 55 f4             	mov    %edx,-0xc(%rbp)
  802b01:	89 45 f0             	mov    %eax,-0x10(%rbp)
  802b04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802b08:	5d                   	pop    %rbp
  802b09:	c3                   	ret    

0000000000802b0a <strcpy>:
  802b0a:	f3 0f 1e fa          	endbr64 
  802b0e:	55                   	push   %rbp
  802b0f:	48 89 e5             	mov    %rsp,%rbp
  802b12:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802b12 <strcpy+0x8>
  802b19:	49 bb 4e 0d 00 00 00 	movabs $0xd4e,%r11
  802b20:	00 00 00 
  802b23:	4c 01 d8             	add    %r11,%rax
  802b26:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802b2a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802b2e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b32:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  802b36:	48 89 d6             	mov    %rdx,%rsi
  802b39:	48 89 cf             	mov    %rcx,%rdi
  802b3c:	fc                   	cld    
  802b3d:	ac                   	lods   %ds:(%rsi),%al
  802b3e:	aa                   	stos   %al,%es:(%rdi)
  802b3f:	84 c0                	test   %al,%al
  802b41:	75 fa                	jne    802b3d <strcpy+0x33>
  802b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b47:	5d                   	pop    %rbp
  802b48:	c3                   	ret    

0000000000802b49 <strncpy>:
  802b49:	f3 0f 1e fa          	endbr64 
  802b4d:	55                   	push   %rbp
  802b4e:	48 89 e5             	mov    %rsp,%rbp
  802b51:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802b51 <strncpy+0x8>
  802b58:	49 bb 0f 0d 00 00 00 	movabs $0xd0f,%r11
  802b5f:	00 00 00 
  802b62:	4c 01 d8             	add    %r11,%rax
  802b65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802b69:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802b6d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  802b71:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802b75:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  802b79:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802b7d:	48 89 d6             	mov    %rdx,%rsi
  802b80:	fc                   	cld    
  802b81:	48 ff c9             	dec    %rcx
  802b84:	78 08                	js     802b8e <strncpy+0x45>
  802b86:	ac                   	lods   %ds:(%rsi),%al
  802b87:	aa                   	stos   %al,%es:(%rdi)
  802b88:	84 c0                	test   %al,%al
  802b8a:	75 f5                	jne    802b81 <strncpy+0x38>
  802b8c:	f3 aa                	rep stos %al,%es:(%rdi)
  802b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802b92:	5d                   	pop    %rbp
  802b93:	c3                   	ret    

0000000000802b94 <strcat>:
  802b94:	f3 0f 1e fa          	endbr64 
  802b98:	55                   	push   %rbp
  802b99:	48 89 e5             	mov    %rsp,%rbp
  802b9c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802b9c <strcat+0x8>
  802ba3:	49 bb c4 0c 00 00 00 	movabs $0xcc4,%r11
  802baa:	00 00 00 
  802bad:	4c 01 d8             	add    %r11,%rax
  802bb0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  802bb4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  802bb8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  802bbc:	48 8b 7d f8          	mov    -0x8(%rbp),%rdi
  802bc0:	b8 00 00 00 00       	mov    $0x0,%eax
  802bc5:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  802bca:	48 89 d6             	mov    %rdx,%rsi
  802bcd:	fc                   	cld    
  802bce:	f2 ae                	repnz scas %es:(%rdi),%al
  802bd0:	48 ff cf             	dec    %rdi
  802bd3:	ac                   	lods   %ds:(%rsi),%al
  802bd4:	aa                   	stos   %al,%es:(%rdi)
  802bd5:	84 c0                	test   %al,%al
  802bd7:	75 fa                	jne    802bd3 <strcat+0x3f>
  802bd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  802bdd:	5d                   	pop    %rbp
  802bde:	c3                   	ret    

0000000000802bdf <strcmp>:
  802bdf:	f3 0f 1e fa          	endbr64 
  802be3:	55                   	push   %rbp
  802be4:	48 89 e5             	mov    %rsp,%rbp
  802be7:	53                   	push   %rbx
  802be8:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802be8 <strcmp+0x9>
  802bef:	49 bb 78 0c 00 00 00 	movabs $0xc78,%r11
  802bf6:	00 00 00 
  802bf9:	4c 01 d8             	add    %r11,%rax
  802bfc:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
  802c00:	48 89 75 e8          	mov    %rsi,-0x18(%rbp)
  802c04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c08:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c0c:	48 89 c7             	mov    %rax,%rdi
  802c0f:	48 89 d6             	mov    %rdx,%rsi
  802c12:	fc                   	cld    
  802c13:	ac                   	lods   %ds:(%rsi),%al
  802c14:	ae                   	scas   %es:(%rdi),%al
  802c15:	75 08                	jne    802c1f <strcmp+0x40>
  802c17:	84 c0                	test   %al,%al
  802c19:	75 f8                	jne    802c13 <strcmp+0x34>
  802c1b:	31 c0                	xor    %eax,%eax
  802c1d:	eb 09                	jmp    802c28 <strcmp+0x49>
  802c1f:	b8 01 00 00 00       	mov    $0x1,%eax
  802c24:	7c 02                	jl     802c28 <strcmp+0x49>
  802c26:	f7 d8                	neg    %eax
  802c28:	89 c3                	mov    %eax,%ebx
  802c2a:	89 d8                	mov    %ebx,%eax
  802c2c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  802c30:	c9                   	leave  
  802c31:	c3                   	ret    

0000000000802c32 <strncmp>:
  802c32:	f3 0f 1e fa          	endbr64 
  802c36:	55                   	push   %rbp
  802c37:	48 89 e5             	mov    %rsp,%rbp
  802c3a:	53                   	push   %rbx
  802c3b:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802c3b <strncmp+0x9>
  802c42:	49 bb 25 0c 00 00 00 	movabs $0xc25,%r11
  802c49:	00 00 00 
  802c4c:	4c 01 d8             	add    %r11,%rax
  802c4f:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
  802c53:	48 89 75 e8          	mov    %rsi,-0x18(%rbp)
  802c57:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  802c5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  802c5f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  802c63:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  802c67:	48 89 c7             	mov    %rax,%rdi
  802c6a:	48 89 d6             	mov    %rdx,%rsi
  802c6d:	fc                   	cld    
  802c6e:	48 ff c9             	dec    %rcx
  802c71:	78 08                	js     802c7b <strncmp+0x49>
  802c73:	ac                   	lods   %ds:(%rsi),%al
  802c74:	ae                   	scas   %es:(%rdi),%al
  802c75:	75 08                	jne    802c7f <strncmp+0x4d>
  802c77:	84 c0                	test   %al,%al
  802c79:	75 f3                	jne    802c6e <strncmp+0x3c>
  802c7b:	31 c0                	xor    %eax,%eax
  802c7d:	eb 09                	jmp    802c88 <strncmp+0x56>
  802c7f:	b8 01 00 00 00       	mov    $0x1,%eax
  802c84:	7c 02                	jl     802c88 <strncmp+0x56>
  802c86:	f7 d8                	neg    %eax
  802c88:	89 c3                	mov    %eax,%ebx
  802c8a:	89 d8                	mov    %ebx,%eax
  802c8c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  802c90:	c9                   	leave  
  802c91:	c3                   	ret    

0000000000802c92 <strlen>:
  802c92:	f3 0f 1e fa          	endbr64 
  802c96:	55                   	push   %rbp
  802c97:	48 89 e5             	mov    %rsp,%rbp
  802c9a:	53                   	push   %rbx
  802c9b:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802c9b <strlen+0x9>
  802ca2:	49 bb c5 0b 00 00 00 	movabs $0xbc5,%r11
  802ca9:	00 00 00 
  802cac:	4c 01 d8             	add    %r11,%rax
  802caf:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
  802cb3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  802cb7:	b8 00 00 00 00       	mov    $0x0,%eax
  802cbc:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  802cc1:	89 d1                	mov    %edx,%ecx
  802cc3:	48 89 f7             	mov    %rsi,%rdi
  802cc6:	fc                   	cld    
  802cc7:	f2 ae                	repnz scas %es:(%rdi),%al
  802cc9:	f7 d1                	not    %ecx
  802ccb:	ff c9                	dec    %ecx
  802ccd:	89 ca                	mov    %ecx,%edx
  802ccf:	89 d3                	mov    %edx,%ebx
  802cd1:	89 d8                	mov    %ebx,%eax
  802cd3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  802cd7:	c9                   	leave  
  802cd8:	c3                   	ret    

0000000000802cd9 <opendir>:
  802cd9:	f3 0f 1e fa          	endbr64 
  802cdd:	55                   	push   %rbp
  802cde:	48 89 e5             	mov    %rsp,%rbp
  802ce1:	41 57                	push   %r15
  802ce3:	53                   	push   %rbx
  802ce4:	48 83 ec 20          	sub    $0x20,%rsp
  802ce8:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 802ce8 <opendir+0xf>
  802cef:	49 bb 78 0b 00 00 00 	movabs $0xb78,%r11
  802cf6:	00 00 00 
  802cf9:	4c 01 db             	add    %r11,%rbx
  802cfc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802d00:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  802d07:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
  802d0e:	00 
  802d0f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802d13:	be 00 40 00 00       	mov    $0x4000,%esi
  802d18:	48 89 c7             	mov    %rax,%rdi
  802d1b:	49 89 df             	mov    %rbx,%r15
  802d1e:	48 b8 a5 e0 ff ff ff 	movabs $0xffffffffffffe0a5,%rax
  802d25:	ff ff ff 
  802d28:	48 01 d8             	add    %rbx,%rax
  802d2b:	ff d0                	call   *%rax
  802d2d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802d30:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802d34:	79 07                	jns    802d3d <opendir+0x64>
  802d36:	b8 00 00 00 00       	mov    $0x0,%eax
  802d3b:	eb 61                	jmp    802d9e <opendir+0xc5>
  802d3d:	bf 0c 01 00 00       	mov    $0x10c,%edi
  802d42:	49 89 df             	mov    %rbx,%r15
  802d45:	48 b8 51 e1 ff ff ff 	movabs $0xffffffffffffe151,%rax
  802d4c:	ff ff ff 
  802d4f:	48 01 d8             	add    %rbx,%rax
  802d52:	ff d0                	call   *%rax
  802d54:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  802d58:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d5c:	ba 0c 01 00 00       	mov    $0x10c,%edx
  802d61:	be 00 00 00 00       	mov    $0x0,%esi
  802d66:	48 89 c7             	mov    %rax,%rdi
  802d69:	49 89 df             	mov    %rbx,%r15
  802d6c:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  802d73:	ff ff ff 
  802d76:	48 01 d8             	add    %rbx,%rax
  802d79:	ff d0                	call   *%rax
  802d7b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d7f:	8b 55 ec             	mov    -0x14(%rbp),%edx
  802d82:	89 10                	mov    %edx,(%rax)
  802d84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d88:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  802d8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d93:	c7 40 08 00 01 00 00 	movl   $0x100,0x8(%rax)
  802d9a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  802d9e:	48 83 c4 20          	add    $0x20,%rsp
  802da2:	5b                   	pop    %rbx
  802da3:	41 5f                	pop    %r15
  802da5:	5d                   	pop    %rbp
  802da6:	c3                   	ret    

0000000000802da7 <closedir>:
  802da7:	f3 0f 1e fa          	endbr64 
  802dab:	55                   	push   %rbp
  802dac:	48 89 e5             	mov    %rsp,%rbp
  802daf:	41 57                	push   %r15
  802db1:	53                   	push   %rbx
  802db2:	48 83 ec 10          	sub    $0x10,%rsp
  802db6:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 802db6 <closedir+0xf>
  802dbd:	49 bb aa 0a 00 00 00 	movabs $0xaaa,%r11
  802dc4:	00 00 00 
  802dc7:	4c 01 db             	add    %r11,%rbx
  802dca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802dce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dd2:	8b 00                	mov    (%rax),%eax
  802dd4:	89 c7                	mov    %eax,%edi
  802dd6:	49 89 df             	mov    %rbx,%r15
  802dd9:	48 b8 ae e0 ff ff ff 	movabs $0xffffffffffffe0ae,%rax
  802de0:	ff ff ff 
  802de3:	48 01 d8             	add    %rbx,%rax
  802de6:	ff d0                	call   *%rax
  802de8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  802dec:	48 89 c7             	mov    %rax,%rdi
  802def:	49 89 df             	mov    %rbx,%r15
  802df2:	48 b8 e2 e2 ff ff ff 	movabs $0xffffffffffffe2e2,%rax
  802df9:	ff ff ff 
  802dfc:	48 01 d8             	add    %rbx,%rax
  802dff:	ff d0                	call   *%rax
  802e01:	b8 00 00 00 00       	mov    $0x0,%eax
  802e06:	48 83 c4 10          	add    $0x10,%rsp
  802e0a:	5b                   	pop    %rbx
  802e0b:	41 5f                	pop    %r15
  802e0d:	5d                   	pop    %rbp
  802e0e:	c3                   	ret    

0000000000802e0f <readdir>:
  802e0f:	f3 0f 1e fa          	endbr64 
  802e13:	55                   	push   %rbp
  802e14:	48 89 e5             	mov    %rsp,%rbp
  802e17:	41 57                	push   %r15
  802e19:	53                   	push   %rbx
  802e1a:	48 83 ec 20          	sub    $0x20,%rsp
  802e1e:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 802e1e <readdir+0xf>
  802e25:	49 bb 42 0a 00 00 00 	movabs $0xa42,%r11
  802e2c:	00 00 00 
  802e2f:	4c 01 db             	add    %r11,%rbx
  802e32:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  802e36:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  802e3d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e41:	48 83 c0 0c          	add    $0xc,%rax
  802e45:	ba 00 01 00 00       	mov    $0x100,%edx
  802e4a:	be 00 00 00 00       	mov    $0x0,%esi
  802e4f:	48 89 c7             	mov    %rax,%rdi
  802e52:	49 89 df             	mov    %rbx,%r15
  802e55:	48 b8 1c f2 ff ff ff 	movabs $0xfffffffffffff21c,%rax
  802e5c:	ff ff ff 
  802e5f:	48 01 d8             	add    %rbx,%rax
  802e62:	ff d0                	call   *%rax
  802e64:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e68:	48 8d 48 0c          	lea    0xc(%rax),%rcx
  802e6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e70:	8b 00                	mov    (%rax),%eax
  802e72:	ba 00 01 00 00       	mov    $0x100,%edx
  802e77:	48 89 ce             	mov    %rcx,%rsi
  802e7a:	89 c7                	mov    %eax,%edi
  802e7c:	49 89 df             	mov    %rbx,%r15
  802e7f:	48 b8 1a e1 ff ff ff 	movabs $0xffffffffffffe11a,%rax
  802e86:	ff ff ff 
  802e89:	48 01 d8             	add    %rbx,%rax
  802e8c:	ff d0                	call   *%rax
  802e8e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  802e91:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  802e95:	7e 0a                	jle    802ea1 <readdir+0x92>
  802e97:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  802e9b:	48 83 c0 0c          	add    $0xc,%rax
  802e9f:	eb 05                	jmp    802ea6 <readdir+0x97>
  802ea1:	b8 00 00 00 00       	mov    $0x0,%eax
  802ea6:	48 83 c4 20          	add    $0x20,%rsp
  802eaa:	5b                   	pop    %rbx
  802eab:	41 5f                	pop    %r15
  802ead:	5d                   	pop    %rbp
  802eae:	c3                   	ret    

0000000000802eaf <wait>:
  802eaf:	f3 0f 1e fa          	endbr64 
  802eb3:	55                   	push   %rbp
  802eb4:	48 89 e5             	mov    %rsp,%rbp
  802eb7:	41 57                	push   %r15
  802eb9:	48 83 ec 18          	sub    $0x18,%rsp
  802ebd:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802ebd <wait+0xe>
  802ec4:	49 bb a3 09 00 00 00 	movabs $0x9a3,%r11
  802ecb:	00 00 00 
  802ece:	4c 01 d8             	add    %r11,%rax
  802ed1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  802ed5:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
  802ed9:	ba 00 00 00 00       	mov    $0x0,%edx
  802ede:	48 89 ce             	mov    %rcx,%rsi
  802ee1:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  802ee6:	49 89 c7             	mov    %rax,%r15
  802ee9:	48 b9 f6 e0 ff ff ff 	movabs $0xffffffffffffe0f6,%rcx
  802ef0:	ff ff ff 
  802ef3:	48 01 c1             	add    %rax,%rcx
  802ef6:	ff d1                	call   *%rcx
  802ef8:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
  802efc:	c9                   	leave  
  802efd:	c3                   	ret    

0000000000802efe <waitpid>:
  802efe:	f3 0f 1e fa          	endbr64 
  802f02:	55                   	push   %rbp
  802f03:	48 89 e5             	mov    %rsp,%rbp
  802f06:	41 57                	push   %r15
  802f08:	48 83 ec 18          	sub    $0x18,%rsp
  802f0c:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 802f0c <waitpid+0xe>
  802f13:	49 bb 54 09 00 00 00 	movabs $0x954,%r11
  802f1a:	00 00 00 
  802f1d:	4c 01 d8             	add    %r11,%rax
  802f20:	89 7d ec             	mov    %edi,-0x14(%rbp)
  802f23:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  802f27:	89 55 e8             	mov    %edx,-0x18(%rbp)
  802f2a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  802f2d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  802f31:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  802f34:	89 cf                	mov    %ecx,%edi
  802f36:	49 89 c7             	mov    %rax,%r15
  802f39:	48 b9 f6 e0 ff ff ff 	movabs $0xffffffffffffe0f6,%rcx
  802f40:	ff ff ff 
  802f43:	48 01 c1             	add    %rax,%rcx
  802f46:	ff d1                	call   *%rcx
  802f48:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
  802f4c:	c9                   	leave  
  802f4d:	c3                   	ret    
