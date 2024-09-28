
disk.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <list_add_to_before>:
       0:	f3 0f 1e fa          	endbr64 
       4:	55                   	push   %rbp
       5:	48 89 e5             	mov    %rsp,%rbp
       8:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 8 <list_add_to_before+0x8>
       f:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
      16:	00 00 00 
      19:	4c 01 d8             	add    %r11,%rax
      1c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
      20:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
      24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
      28:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
      2c:	48 89 50 08          	mov    %rdx,0x8(%rax)
      30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      34:	48 8b 00             	mov    (%rax),%rax
      37:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
      3b:	48 89 50 08          	mov    %rdx,0x8(%rax)
      3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      43:	48 8b 10             	mov    (%rax),%rdx
      46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
      4a:	48 89 10             	mov    %rdx,(%rax)
      4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      51:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
      55:	48 89 10             	mov    %rdx,(%rax)
      58:	90                   	nop
      59:	5d                   	pop    %rbp
      5a:	c3                   	ret    

000000000000005b <list_del>:
      5b:	f3 0f 1e fa          	endbr64 
      5f:	55                   	push   %rbp
      60:	48 89 e5             	mov    %rsp,%rbp
      63:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 63 <list_del+0x8>
      6a:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
      71:	00 00 00 
      74:	4c 01 d8             	add    %r11,%rax
      77:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
      7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      7f:	48 8b 40 08          	mov    0x8(%rax),%rax
      83:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
      87:	48 8b 12             	mov    (%rdx),%rdx
      8a:	48 89 10             	mov    %rdx,(%rax)
      8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      91:	48 8b 00             	mov    (%rax),%rax
      94:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
      98:	48 8b 52 08          	mov    0x8(%rdx),%rdx
      9c:	48 89 50 08          	mov    %rdx,0x8(%rax)
      a0:	90                   	nop
      a1:	5d                   	pop    %rbp
      a2:	c3                   	ret    

00000000000000a3 <list_next>:
      a3:	f3 0f 1e fa          	endbr64 
      a7:	55                   	push   %rbp
      a8:	48 89 e5             	mov    %rsp,%rbp
      ab:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # ab <list_next+0x8>
      b2:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
      b9:	00 00 00 
      bc:	4c 01 d8             	add    %r11,%rax
      bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
      c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      c7:	48 8b 40 08          	mov    0x8(%rax),%rax
      cb:	48 85 c0             	test   %rax,%rax
      ce:	74 0a                	je     da <list_next+0x37>
      d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      d4:	48 8b 40 08          	mov    0x8(%rax),%rax
      d8:	eb 05                	jmp    df <list_next+0x3c>
      da:	b8 00 00 00 00       	mov    $0x0,%eax
      df:	5d                   	pop    %rbp
      e0:	c3                   	ret    

00000000000000e1 <io_in8>:
      e1:	f3 0f 1e fa          	endbr64 
      e5:	55                   	push   %rbp
      e6:	48 89 e5             	mov    %rsp,%rbp
      e9:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # e9 <io_in8+0x8>
      f0:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
      f7:	00 00 00 
      fa:	4c 01 d8             	add    %r11,%rax
      fd:	89 f8                	mov    %edi,%eax
      ff:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
     103:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
     107:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
     10b:	89 c2                	mov    %eax,%edx
     10d:	ec                   	in     (%dx),%al
     10e:	0f ae f0             	mfence 
     111:	88 45 ff             	mov    %al,-0x1(%rbp)
     114:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
     118:	5d                   	pop    %rbp
     119:	c3                   	ret    

000000000000011a <io_out8>:
     11a:	f3 0f 1e fa          	endbr64 
     11e:	55                   	push   %rbp
     11f:	48 89 e5             	mov    %rsp,%rbp
     122:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 122 <io_out8+0x8>
     129:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     130:	00 00 00 
     133:	4c 01 d8             	add    %r11,%rax
     136:	89 f8                	mov    %edi,%eax
     138:	89 f2                	mov    %esi,%edx
     13a:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
     13e:	89 d0                	mov    %edx,%eax
     140:	88 45 f8             	mov    %al,-0x8(%rbp)
     143:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
     147:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
     14b:	ee                   	out    %al,(%dx)
     14c:	0f ae f0             	mfence 
     14f:	90                   	nop
     150:	5d                   	pop    %rbp
     151:	c3                   	ret    

0000000000000152 <get_current>:
     152:	f3 0f 1e fa          	endbr64 
     156:	55                   	push   %rbp
     157:	48 89 e5             	mov    %rsp,%rbp
     15a:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 15a <get_current+0x8>
     161:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     168:	00 00 00 
     16b:	4c 01 d8             	add    %r11,%rax
     16e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
     175:	00 
     176:	48 c7 c0 00 80 ff ff 	mov    $0xffffffffffff8000,%rax
     17d:	48 21 e0             	and    %rsp,%rax
     180:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     184:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     188:	5d                   	pop    %rbp
     189:	c3                   	ret    

000000000000018a <end_request>:
     18a:	f3 0f 1e fa          	endbr64 
     18e:	55                   	push   %rbp
     18f:	48 89 e5             	mov    %rsp,%rbp
     192:	41 57                	push   %r15
     194:	53                   	push   %rbx
     195:	48 83 ec 10          	sub    $0x10,%rsp
     199:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 199 <end_request+0xf>
     1a0:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     1a7:	00 00 00 
     1aa:	4c 01 db             	add    %r11,%rbx
     1ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     1b1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     1b6:	75 32                	jne    1ea <end_request+0x60>
     1b8:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     1bf:	00 00 00 
     1c2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     1c6:	48 89 c2             	mov    %rax,%rdx
     1c9:	be 00 00 00 00       	mov    $0x0,%esi
     1ce:	bf 00 00 ff 00       	mov    $0xff0000,%edi
     1d3:	49 89 df             	mov    %rbx,%r15
     1d6:	b8 00 00 00 00       	mov    $0x0,%eax
     1db:	48 b9 00 00 00 00 00 	movabs $0x0,%rcx
     1e2:	00 00 00 
     1e5:	48 01 d9             	add    %rbx,%rcx
     1e8:	ff d1                	call   *%rcx
     1ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     1ee:	48 8b 40 30          	mov    0x30(%rax),%rax
     1f2:	48 c7 00 01 00 00 00 	movq   $0x1,(%rax)
     1f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     1fd:	48 8b 40 30          	mov    0x30(%rax),%rax
     201:	48 89 c7             	mov    %rax,%rdi
     204:	49 89 df             	mov    %rbx,%r15
     207:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     20e:	00 00 00 
     211:	48 01 d8             	add    %rbx,%rax
     214:	ff d0                	call   *%rax
     216:	b8 00 00 00 00       	mov    $0x0,%eax
     21b:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     222:	00 00 00 
     225:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     229:	ff d2                	call   *%rdx
     22b:	48 8b 50 08          	mov    0x8(%rax),%rdx
     22f:	48 83 ca 02          	or     $0x2,%rdx
     233:	48 89 50 08          	mov    %rdx,0x8(%rax)
     237:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     23e:	00 00 00 
     241:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
     246:	48 89 c7             	mov    %rax,%rdi
     249:	49 89 df             	mov    %rbx,%r15
     24c:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     253:	00 00 00 
     256:	48 01 d8             	add    %rbx,%rax
     259:	ff d0                	call   *%rax
     25b:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     262:	00 00 00 
     265:	48 c7 44 03 18 00 00 	movq   $0x0,0x18(%rbx,%rax,1)
     26c:	00 00 
     26e:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     275:	00 00 00 
     278:	48 8b 44 03 20       	mov    0x20(%rbx,%rax,1),%rax
     27d:	48 85 c0             	test   %rax,%rax
     280:	74 15                	je     297 <end_request+0x10d>
     282:	b8 00 00 00 00       	mov    $0x0,%eax
     287:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     28e:	00 00 00 
     291:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     295:	ff d2                	call   *%rdx
     297:	90                   	nop
     298:	48 83 c4 10          	add    $0x10,%rsp
     29c:	5b                   	pop    %rbx
     29d:	41 5f                	pop    %r15
     29f:	5d                   	pop    %rbp
     2a0:	c3                   	ret    

00000000000002a1 <add_request>:
     2a1:	f3 0f 1e fa          	endbr64 
     2a5:	55                   	push   %rbp
     2a6:	48 89 e5             	mov    %rsp,%rbp
     2a9:	53                   	push   %rbx
     2aa:	48 83 ec 08          	sub    $0x8,%rsp
     2ae:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 2ae <add_request+0xd>
     2b5:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     2bc:	00 00 00 
     2bf:	4c 01 db             	add    %r11,%rbx
     2c2:	48 89 7d f0          	mov    %rdi,-0x10(%rbp)
     2c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     2ca:	48 83 c0 20          	add    $0x20,%rax
     2ce:	48 89 c6             	mov    %rax,%rsi
     2d1:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     2d8:	00 00 00 
     2db:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     2df:	48 89 c7             	mov    %rax,%rdi
     2e2:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     2e9:	00 00 00 
     2ec:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     2f0:	ff d0                	call   *%rax
     2f2:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     2f9:	00 00 00 
     2fc:	48 8b 44 03 20       	mov    0x20(%rbx,%rax,1),%rax
     301:	48 8d 50 01          	lea    0x1(%rax),%rdx
     305:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     30c:	00 00 00 
     30f:	48 89 54 03 20       	mov    %rdx,0x20(%rbx,%rax,1)
     314:	90                   	nop
     315:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     319:	c9                   	leave  
     31a:	c3                   	ret    

000000000000031b <cmd_out>:
     31b:	f3 0f 1e fa          	endbr64 
     31f:	55                   	push   %rbp
     320:	48 89 e5             	mov    %rsp,%rbp
     323:	41 57                	push   %r15
     325:	53                   	push   %rbx
     326:	48 83 ec 20          	sub    $0x20,%rsp
     32a:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 32a <cmd_out+0xf>
     331:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     338:	00 00 00 
     33b:	4c 01 db             	add    %r11,%rbx
     33e:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     345:	00 00 00 
     348:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     34c:	48 89 c7             	mov    %rax,%rdi
     34f:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     356:	00 00 00 
     359:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     35d:	ff d0                	call   *%rax
     35f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     363:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     367:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
     36b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     36f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
     373:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     377:	48 83 e8 20          	sub    $0x20,%rax
     37b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
     37f:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     386:	00 00 00 
     389:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     38d:	48 89 44 13 18       	mov    %rax,0x18(%rbx,%rdx,1)
     392:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     399:	00 00 00 
     39c:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
     3a1:	48 83 c0 20          	add    $0x20,%rax
     3a5:	48 89 c7             	mov    %rax,%rdi
     3a8:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     3af:	00 00 00 
     3b2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     3b6:	ff d0                	call   *%rax
     3b8:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     3bf:	00 00 00 
     3c2:	48 8b 44 03 20       	mov    0x20(%rbx,%rax,1),%rax
     3c7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
     3cb:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     3d2:	00 00 00 
     3d5:	48 89 54 03 20       	mov    %rdx,0x20(%rbx,%rax,1)
     3da:	eb 01                	jmp    3dd <cmd_out+0xc2>
     3dc:	90                   	nop
     3dd:	bf 77 01 00 00       	mov    $0x177,%edi
     3e2:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     3e9:	00 00 00 
     3ec:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     3f0:	ff d0                	call   *%rax
     3f2:	84 c0                	test   %al,%al
     3f4:	78 e6                	js     3dc <cmd_out+0xc1>
     3f6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     3fa:	0f b6 40 04          	movzbl 0x4(%rax),%eax
     3fe:	0f b6 c0             	movzbl %al,%eax
     401:	3d ec 00 00 00       	cmp    $0xec,%eax
     406:	0f 84 cf 03 00 00    	je     7db <cmd_out+0x4c0>
     40c:	3d ec 00 00 00       	cmp    $0xec,%eax
     411:	0f 8f 24 04 00 00    	jg     83b <cmd_out+0x520>
     417:	83 f8 24             	cmp    $0x24,%eax
     41a:	0f 84 01 02 00 00    	je     621 <cmd_out+0x306>
     420:	83 f8 34             	cmp    $0x34,%eax
     423:	0f 85 12 04 00 00    	jne    83b <cmd_out+0x520>
     429:	be 40 00 00 00       	mov    $0x40,%esi
     42e:	bf 76 01 00 00       	mov    $0x176,%edi
     433:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     43a:	00 00 00 
     43d:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     441:	ff d0                	call   *%rax
     443:	be 00 00 00 00       	mov    $0x0,%esi
     448:	bf 71 01 00 00       	mov    $0x171,%edi
     44d:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     454:	00 00 00 
     457:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     45b:	ff d0                	call   *%rax
     45d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     461:	8b 00                	mov    (%rax),%eax
     463:	c1 e8 08             	shr    $0x8,%eax
     466:	0f b6 c0             	movzbl %al,%eax
     469:	89 c6                	mov    %eax,%esi
     46b:	bf 72 01 00 00       	mov    $0x172,%edi
     470:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     477:	00 00 00 
     47a:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     47e:	ff d0                	call   *%rax
     480:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     484:	48 8b 40 08          	mov    0x8(%rax),%rax
     488:	48 c1 e8 18          	shr    $0x18,%rax
     48c:	0f b6 c0             	movzbl %al,%eax
     48f:	89 c6                	mov    %eax,%esi
     491:	bf 73 01 00 00       	mov    $0x173,%edi
     496:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     49d:	00 00 00 
     4a0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     4a4:	ff d0                	call   *%rax
     4a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     4aa:	48 8b 40 08          	mov    0x8(%rax),%rax
     4ae:	48 c1 e8 20          	shr    $0x20,%rax
     4b2:	0f b6 c0             	movzbl %al,%eax
     4b5:	89 c6                	mov    %eax,%esi
     4b7:	bf 74 01 00 00       	mov    $0x174,%edi
     4bc:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     4c3:	00 00 00 
     4c6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     4ca:	ff d0                	call   *%rax
     4cc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     4d0:	48 8b 40 08          	mov    0x8(%rax),%rax
     4d4:	48 c1 e8 28          	shr    $0x28,%rax
     4d8:	0f b6 c0             	movzbl %al,%eax
     4db:	89 c6                	mov    %eax,%esi
     4dd:	bf 75 01 00 00       	mov    $0x175,%edi
     4e2:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     4e9:	00 00 00 
     4ec:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     4f0:	ff d0                	call   *%rax
     4f2:	be 00 00 00 00       	mov    $0x0,%esi
     4f7:	bf 71 01 00 00       	mov    $0x171,%edi
     4fc:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     503:	00 00 00 
     506:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     50a:	ff d0                	call   *%rax
     50c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     510:	8b 00                	mov    (%rax),%eax
     512:	0f b6 c0             	movzbl %al,%eax
     515:	89 c6                	mov    %eax,%esi
     517:	bf 72 01 00 00       	mov    $0x172,%edi
     51c:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     523:	00 00 00 
     526:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     52a:	ff d0                	call   *%rax
     52c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     530:	48 8b 40 08          	mov    0x8(%rax),%rax
     534:	0f b6 c0             	movzbl %al,%eax
     537:	89 c6                	mov    %eax,%esi
     539:	bf 73 01 00 00       	mov    $0x173,%edi
     53e:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     545:	00 00 00 
     548:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     54c:	ff d0                	call   *%rax
     54e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     552:	48 8b 40 08          	mov    0x8(%rax),%rax
     556:	48 c1 e8 08          	shr    $0x8,%rax
     55a:	0f b6 c0             	movzbl %al,%eax
     55d:	89 c6                	mov    %eax,%esi
     55f:	bf 74 01 00 00       	mov    $0x174,%edi
     564:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     56b:	00 00 00 
     56e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     572:	ff d0                	call   *%rax
     574:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     578:	48 8b 40 08          	mov    0x8(%rax),%rax
     57c:	48 c1 e8 10          	shr    $0x10,%rax
     580:	0f b6 c0             	movzbl %al,%eax
     583:	89 c6                	mov    %eax,%esi
     585:	bf 75 01 00 00       	mov    $0x175,%edi
     58a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     591:	00 00 00 
     594:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     598:	ff d0                	call   *%rax
     59a:	eb 01                	jmp    59d <cmd_out+0x282>
     59c:	90                   	nop
     59d:	bf 77 01 00 00       	mov    $0x177,%edi
     5a2:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     5a9:	00 00 00 
     5ac:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     5b0:	ff d0                	call   *%rax
     5b2:	0f b6 c0             	movzbl %al,%eax
     5b5:	83 e0 40             	and    $0x40,%eax
     5b8:	85 c0                	test   %eax,%eax
     5ba:	74 e0                	je     59c <cmd_out+0x281>
     5bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     5c0:	0f b6 40 04          	movzbl 0x4(%rax),%eax
     5c4:	0f b6 c0             	movzbl %al,%eax
     5c7:	89 c6                	mov    %eax,%esi
     5c9:	bf 77 01 00 00       	mov    $0x177,%edi
     5ce:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     5d5:	00 00 00 
     5d8:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     5dc:	ff d0                	call   *%rax
     5de:	eb 01                	jmp    5e1 <cmd_out+0x2c6>
     5e0:	90                   	nop
     5e1:	bf 77 01 00 00       	mov    $0x177,%edi
     5e6:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     5ed:	00 00 00 
     5f0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     5f4:	ff d0                	call   *%rax
     5f6:	0f b6 c0             	movzbl %al,%eax
     5f9:	83 e0 08             	and    $0x8,%eax
     5fc:	85 c0                	test   %eax,%eax
     5fe:	74 e0                	je     5e0 <cmd_out+0x2c5>
     600:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     604:	48 8b 40 10          	mov    0x10(%rax),%rax
     608:	ba 70 01 00 00       	mov    $0x170,%edx
     60d:	b9 00 01 00 00       	mov    $0x100,%ecx
     612:	48 89 c6             	mov    %rax,%rsi
     615:	fc                   	cld    
     616:	f3 66 6f             	rep outsw %ds:(%rsi),(%dx)
     619:	0f ae f0             	mfence 
     61c:	e9 4d 02 00 00       	jmp    86e <cmd_out+0x553>
     621:	be 40 00 00 00       	mov    $0x40,%esi
     626:	bf 76 01 00 00       	mov    $0x176,%edi
     62b:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     632:	00 00 00 
     635:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     639:	ff d0                	call   *%rax
     63b:	be 00 00 00 00       	mov    $0x0,%esi
     640:	bf 71 01 00 00       	mov    $0x171,%edi
     645:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     64c:	00 00 00 
     64f:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     653:	ff d0                	call   *%rax
     655:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     659:	8b 00                	mov    (%rax),%eax
     65b:	c1 e8 08             	shr    $0x8,%eax
     65e:	0f b6 c0             	movzbl %al,%eax
     661:	89 c6                	mov    %eax,%esi
     663:	bf 72 01 00 00       	mov    $0x172,%edi
     668:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     66f:	00 00 00 
     672:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     676:	ff d0                	call   *%rax
     678:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     67c:	48 8b 40 08          	mov    0x8(%rax),%rax
     680:	48 c1 e8 18          	shr    $0x18,%rax
     684:	0f b6 c0             	movzbl %al,%eax
     687:	89 c6                	mov    %eax,%esi
     689:	bf 73 01 00 00       	mov    $0x173,%edi
     68e:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     695:	00 00 00 
     698:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     69c:	ff d0                	call   *%rax
     69e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     6a2:	48 8b 40 08          	mov    0x8(%rax),%rax
     6a6:	48 c1 e8 20          	shr    $0x20,%rax
     6aa:	0f b6 c0             	movzbl %al,%eax
     6ad:	89 c6                	mov    %eax,%esi
     6af:	bf 74 01 00 00       	mov    $0x174,%edi
     6b4:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     6bb:	00 00 00 
     6be:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     6c2:	ff d0                	call   *%rax
     6c4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     6c8:	48 8b 40 08          	mov    0x8(%rax),%rax
     6cc:	48 c1 e8 28          	shr    $0x28,%rax
     6d0:	0f b6 c0             	movzbl %al,%eax
     6d3:	89 c6                	mov    %eax,%esi
     6d5:	bf 75 01 00 00       	mov    $0x175,%edi
     6da:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     6e1:	00 00 00 
     6e4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     6e8:	ff d0                	call   *%rax
     6ea:	be 00 00 00 00       	mov    $0x0,%esi
     6ef:	bf 71 01 00 00       	mov    $0x171,%edi
     6f4:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     6fb:	00 00 00 
     6fe:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     702:	ff d0                	call   *%rax
     704:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     708:	8b 00                	mov    (%rax),%eax
     70a:	0f b6 c0             	movzbl %al,%eax
     70d:	89 c6                	mov    %eax,%esi
     70f:	bf 72 01 00 00       	mov    $0x172,%edi
     714:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     71b:	00 00 00 
     71e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     722:	ff d0                	call   *%rax
     724:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     728:	48 8b 40 08          	mov    0x8(%rax),%rax
     72c:	0f b6 c0             	movzbl %al,%eax
     72f:	89 c6                	mov    %eax,%esi
     731:	bf 73 01 00 00       	mov    $0x173,%edi
     736:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     73d:	00 00 00 
     740:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     744:	ff d0                	call   *%rax
     746:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     74a:	48 8b 40 08          	mov    0x8(%rax),%rax
     74e:	48 c1 e8 08          	shr    $0x8,%rax
     752:	0f b6 c0             	movzbl %al,%eax
     755:	89 c6                	mov    %eax,%esi
     757:	bf 74 01 00 00       	mov    $0x174,%edi
     75c:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     763:	00 00 00 
     766:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     76a:	ff d0                	call   *%rax
     76c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     770:	48 8b 40 08          	mov    0x8(%rax),%rax
     774:	48 c1 e8 10          	shr    $0x10,%rax
     778:	0f b6 c0             	movzbl %al,%eax
     77b:	89 c6                	mov    %eax,%esi
     77d:	bf 75 01 00 00       	mov    $0x175,%edi
     782:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     789:	00 00 00 
     78c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     790:	ff d0                	call   *%rax
     792:	eb 01                	jmp    795 <cmd_out+0x47a>
     794:	90                   	nop
     795:	bf 77 01 00 00       	mov    $0x177,%edi
     79a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     7a1:	00 00 00 
     7a4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     7a8:	ff d0                	call   *%rax
     7aa:	0f b6 c0             	movzbl %al,%eax
     7ad:	83 e0 40             	and    $0x40,%eax
     7b0:	85 c0                	test   %eax,%eax
     7b2:	74 e0                	je     794 <cmd_out+0x479>
     7b4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     7b8:	0f b6 40 04          	movzbl 0x4(%rax),%eax
     7bc:	0f b6 c0             	movzbl %al,%eax
     7bf:	89 c6                	mov    %eax,%esi
     7c1:	bf 77 01 00 00       	mov    $0x177,%edi
     7c6:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     7cd:	00 00 00 
     7d0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     7d4:	ff d0                	call   *%rax
     7d6:	e9 93 00 00 00       	jmp    86e <cmd_out+0x553>
     7db:	be e0 00 00 00       	mov    $0xe0,%esi
     7e0:	bf 76 01 00 00       	mov    $0x176,%edi
     7e5:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     7ec:	00 00 00 
     7ef:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     7f3:	ff d0                	call   *%rax
     7f5:	eb 01                	jmp    7f8 <cmd_out+0x4dd>
     7f7:	90                   	nop
     7f8:	bf 77 01 00 00       	mov    $0x177,%edi
     7fd:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     804:	00 00 00 
     807:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     80b:	ff d0                	call   *%rax
     80d:	0f b6 c0             	movzbl %al,%eax
     810:	83 e0 40             	and    $0x40,%eax
     813:	85 c0                	test   %eax,%eax
     815:	74 e0                	je     7f7 <cmd_out+0x4dc>
     817:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     81b:	0f b6 40 04          	movzbl 0x4(%rax),%eax
     81f:	0f b6 c0             	movzbl %al,%eax
     822:	89 c6                	mov    %eax,%esi
     824:	bf 77 01 00 00       	mov    $0x177,%edi
     829:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     830:	00 00 00 
     833:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     837:	ff d0                	call   *%rax
     839:	eb 33                	jmp    86e <cmd_out+0x553>
     83b:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     842:	00 00 00 
     845:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     849:	48 89 c2             	mov    %rax,%rdx
     84c:	be ff ff ff 00       	mov    $0xffffff,%esi
     851:	bf 00 00 00 00       	mov    $0x0,%edi
     856:	49 89 df             	mov    %rbx,%r15
     859:	b8 00 00 00 00       	mov    $0x0,%eax
     85e:	48 b9 00 00 00 00 00 	movabs $0x0,%rcx
     865:	00 00 00 
     868:	48 01 d9             	add    %rbx,%rcx
     86b:	ff d1                	call   *%rcx
     86d:	90                   	nop
     86e:	b8 01 00 00 00       	mov    $0x1,%eax
     873:	48 83 c4 20          	add    $0x20,%rsp
     877:	5b                   	pop    %rbx
     878:	41 5f                	pop    %r15
     87a:	5d                   	pop    %rbp
     87b:	c3                   	ret    

000000000000087c <read_handler>:
     87c:	f3 0f 1e fa          	endbr64 
     880:	55                   	push   %rbp
     881:	48 89 e5             	mov    %rsp,%rbp
     884:	41 57                	push   %r15
     886:	53                   	push   %rbx
     887:	48 83 ec 20          	sub    $0x20,%rsp
     88b:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 88b <read_handler+0xf>
     892:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     899:	00 00 00 
     89c:	4c 01 db             	add    %r11,%rbx
     89f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     8a3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     8a7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     8ab:	48 8b 40 18          	mov    0x18(%rax),%rax
     8af:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     8b3:	bf 77 01 00 00       	mov    $0x177,%edi
     8b8:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     8bf:	00 00 00 
     8c2:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     8c6:	ff d0                	call   *%rax
     8c8:	0f b6 c0             	movzbl %al,%eax
     8cb:	83 e0 01             	and    $0x1,%eax
     8ce:	85 c0                	test   %eax,%eax
     8d0:	74 4f                	je     921 <read_handler+0xa5>
     8d2:	bf 71 01 00 00       	mov    $0x171,%edi
     8d7:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     8de:	00 00 00 
     8e1:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     8e5:	ff d0                	call   *%rax
     8e7:	0f b6 c0             	movzbl %al,%eax
     8ea:	89 c1                	mov    %eax,%ecx
     8ec:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     8f3:	00 00 00 
     8f6:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     8fa:	48 89 c2             	mov    %rax,%rdx
     8fd:	be 00 00 00 00       	mov    $0x0,%esi
     902:	bf 00 00 ff 00       	mov    $0xff0000,%edi
     907:	49 89 df             	mov    %rbx,%r15
     90a:	b8 00 00 00 00       	mov    $0x0,%eax
     90f:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     916:	00 00 00 
     919:	49 01 d8             	add    %rbx,%r8
     91c:	41 ff d0             	call   *%r8
     91f:	eb 1c                	jmp    93d <read_handler+0xc1>
     921:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     925:	48 8b 40 10          	mov    0x10(%rax),%rax
     929:	ba 70 01 00 00       	mov    $0x170,%edx
     92e:	b9 00 01 00 00       	mov    $0x100,%ecx
     933:	48 89 c7             	mov    %rax,%rdi
     936:	fc                   	cld    
     937:	f3 66 6d             	rep insw (%dx),%es:(%rdi)
     93a:	0f ae f0             	mfence 
     93d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     941:	8b 00                	mov    (%rax),%eax
     943:	8d 50 ff             	lea    -0x1(%rax),%edx
     946:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     94a:	89 10                	mov    %edx,(%rax)
     94c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     950:	8b 00                	mov    (%rax),%eax
     952:	85 c0                	test   %eax,%eax
     954:	74 19                	je     96f <read_handler+0xf3>
     956:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     95a:	48 8b 40 10          	mov    0x10(%rax),%rax
     95e:	48 8d 90 00 02 00 00 	lea    0x200(%rax),%rdx
     965:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     969:	48 89 50 10          	mov    %rdx,0x10(%rax)
     96d:	eb 17                	jmp    986 <read_handler+0x10a>
     96f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     973:	48 89 c7             	mov    %rax,%rdi
     976:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     97d:	00 00 00 
     980:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     984:	ff d0                	call   *%rax
     986:	48 83 c4 20          	add    $0x20,%rsp
     98a:	5b                   	pop    %rbx
     98b:	41 5f                	pop    %r15
     98d:	5d                   	pop    %rbp
     98e:	c3                   	ret    

000000000000098f <write_handler>:
     98f:	f3 0f 1e fa          	endbr64 
     993:	55                   	push   %rbp
     994:	48 89 e5             	mov    %rsp,%rbp
     997:	41 57                	push   %r15
     999:	53                   	push   %rbx
     99a:	48 83 ec 20          	sub    $0x20,%rsp
     99e:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 99e <write_handler+0xf>
     9a5:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     9ac:	00 00 00 
     9af:	4c 01 db             	add    %r11,%rbx
     9b2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     9b6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     9ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     9be:	48 8b 40 18          	mov    0x18(%rax),%rax
     9c2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     9c6:	bf 77 01 00 00       	mov    $0x177,%edi
     9cb:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     9d2:	00 00 00 
     9d5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     9d9:	ff d0                	call   *%rax
     9db:	0f b6 c0             	movzbl %al,%eax
     9de:	83 e0 01             	and    $0x1,%eax
     9e1:	85 c0                	test   %eax,%eax
     9e3:	74 4d                	je     a32 <write_handler+0xa3>
     9e5:	bf 71 01 00 00       	mov    $0x171,%edi
     9ea:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     9f1:	00 00 00 
     9f4:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     9f8:	ff d0                	call   *%rax
     9fa:	0f b6 c0             	movzbl %al,%eax
     9fd:	89 c1                	mov    %eax,%ecx
     9ff:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     a06:	00 00 00 
     a09:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     a0d:	48 89 c2             	mov    %rax,%rdx
     a10:	be 00 00 00 00       	mov    $0x0,%esi
     a15:	bf 00 00 ff 00       	mov    $0xff0000,%edi
     a1a:	49 89 df             	mov    %rbx,%r15
     a1d:	b8 00 00 00 00       	mov    $0x0,%eax
     a22:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     a29:	00 00 00 
     a2c:	49 01 d8             	add    %rbx,%r8
     a2f:	41 ff d0             	call   *%r8
     a32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a36:	8b 00                	mov    (%rax),%eax
     a38:	8d 50 ff             	lea    -0x1(%rax),%edx
     a3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a3f:	89 10                	mov    %edx,(%rax)
     a41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a45:	8b 00                	mov    (%rax),%eax
     a47:	85 c0                	test   %eax,%eax
     a49:	74 57                	je     aa2 <write_handler+0x113>
     a4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a4f:	48 8b 40 10          	mov    0x10(%rax),%rax
     a53:	48 8d 90 00 02 00 00 	lea    0x200(%rax),%rdx
     a5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a5e:	48 89 50 10          	mov    %rdx,0x10(%rax)
     a62:	eb 01                	jmp    a65 <write_handler+0xd6>
     a64:	90                   	nop
     a65:	bf 77 01 00 00       	mov    $0x177,%edi
     a6a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     a71:	00 00 00 
     a74:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     a78:	ff d0                	call   *%rax
     a7a:	0f b6 c0             	movzbl %al,%eax
     a7d:	83 e0 08             	and    $0x8,%eax
     a80:	85 c0                	test   %eax,%eax
     a82:	74 e0                	je     a64 <write_handler+0xd5>
     a84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     a88:	48 8b 40 10          	mov    0x10(%rax),%rax
     a8c:	ba 70 01 00 00       	mov    $0x170,%edx
     a91:	b9 00 01 00 00       	mov    $0x100,%ecx
     a96:	48 89 c6             	mov    %rax,%rsi
     a99:	fc                   	cld    
     a9a:	f3 66 6f             	rep outsw %ds:(%rsi),(%dx)
     a9d:	0f ae f0             	mfence 
     aa0:	eb 17                	jmp    ab9 <write_handler+0x12a>
     aa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     aa6:	48 89 c7             	mov    %rax,%rdi
     aa9:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     ab0:	00 00 00 
     ab3:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     ab7:	ff d0                	call   *%rax
     ab9:	48 83 c4 20          	add    $0x20,%rsp
     abd:	5b                   	pop    %rbx
     abe:	41 5f                	pop    %r15
     ac0:	5d                   	pop    %rbp
     ac1:	c3                   	ret    

0000000000000ac2 <other_handler>:
     ac2:	f3 0f 1e fa          	endbr64 
     ac6:	55                   	push   %rbp
     ac7:	48 89 e5             	mov    %rsp,%rbp
     aca:	41 57                	push   %r15
     acc:	53                   	push   %rbx
     acd:	48 83 ec 20          	sub    $0x20,%rsp
     ad1:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # ad1 <other_handler+0xf>
     ad8:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     adf:	00 00 00 
     ae2:	4c 01 db             	add    %r11,%rbx
     ae5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     ae9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     aed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     af1:	48 8b 40 18          	mov    0x18(%rax),%rax
     af5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     af9:	bf 77 01 00 00       	mov    $0x177,%edi
     afe:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     b05:	00 00 00 
     b08:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     b0c:	ff d0                	call   *%rax
     b0e:	0f b6 c0             	movzbl %al,%eax
     b11:	83 e0 01             	and    $0x1,%eax
     b14:	85 c0                	test   %eax,%eax
     b16:	74 4f                	je     b67 <other_handler+0xa5>
     b18:	bf 71 01 00 00       	mov    $0x171,%edi
     b1d:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     b24:	00 00 00 
     b27:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     b2b:	ff d0                	call   *%rax
     b2d:	0f b6 c0             	movzbl %al,%eax
     b30:	89 c1                	mov    %eax,%ecx
     b32:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     b39:	00 00 00 
     b3c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     b40:	48 89 c2             	mov    %rax,%rdx
     b43:	be 00 00 00 00       	mov    $0x0,%esi
     b48:	bf 00 00 ff 00       	mov    $0xff0000,%edi
     b4d:	49 89 df             	mov    %rbx,%r15
     b50:	b8 00 00 00 00       	mov    $0x0,%eax
     b55:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     b5c:	00 00 00 
     b5f:	49 01 d8             	add    %rbx,%r8
     b62:	41 ff d0             	call   *%r8
     b65:	eb 1c                	jmp    b83 <other_handler+0xc1>
     b67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b6b:	48 8b 40 10          	mov    0x10(%rax),%rax
     b6f:	ba 70 01 00 00       	mov    $0x170,%edx
     b74:	b9 00 01 00 00       	mov    $0x100,%ecx
     b79:	48 89 c7             	mov    %rax,%rdi
     b7c:	fc                   	cld    
     b7d:	f3 66 6d             	rep insw (%dx),%es:(%rdi)
     b80:	0f ae f0             	mfence 
     b83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b87:	48 89 c7             	mov    %rax,%rdi
     b8a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     b91:	00 00 00 
     b94:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     b98:	ff d0                	call   *%rax
     b9a:	90                   	nop
     b9b:	48 83 c4 20          	add    $0x20,%rsp
     b9f:	5b                   	pop    %rbx
     ba0:	41 5f                	pop    %r15
     ba2:	5d                   	pop    %rbp
     ba3:	c3                   	ret    

0000000000000ba4 <make_request>:
     ba4:	f3 0f 1e fa          	endbr64 
     ba8:	55                   	push   %rbp
     ba9:	48 89 e5             	mov    %rsp,%rbp
     bac:	41 57                	push   %r15
     bae:	53                   	push   %rbx
     baf:	48 83 ec 30          	sub    $0x30,%rsp
     bb3:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # bb3 <make_request+0xf>
     bba:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     bc1:	00 00 00 
     bc4:	4c 01 db             	add    %r11,%rbx
     bc7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     bcb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     bcf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
     bd3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
     bd7:	be 00 00 00 00       	mov    $0x0,%esi
     bdc:	bf 38 00 00 00       	mov    $0x38,%edi
     be1:	49 89 df             	mov    %rbx,%r15
     be4:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     beb:	00 00 00 
     bee:	48 01 d8             	add    %rbx,%rax
     bf1:	ff d0                	call   *%rax
     bf3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     bf7:	b8 00 00 00 00       	mov    $0x0,%eax
     bfc:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     c03:	00 00 00 
     c06:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     c0a:	ff d2                	call   *%rdx
     c0c:	48 89 c2             	mov    %rax,%rdx
     c0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c13:	48 83 c0 20          	add    $0x20,%rax
     c17:	48 89 d6             	mov    %rdx,%rsi
     c1a:	48 89 c7             	mov    %rax,%rdi
     c1d:	49 89 df             	mov    %rbx,%r15
     c20:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     c27:	00 00 00 
     c2a:	48 01 d8             	add    %rbx,%rax
     c2d:	ff d0                	call   *%rax
     c2f:	48 83 7d d8 24       	cmpq   $0x24,-0x28(%rbp)
     c34:	74 09                	je     c3f <make_request+0x9b>
     c36:	48 83 7d d8 34       	cmpq   $0x34,-0x28(%rbp)
     c3b:	74 1a                	je     c57 <make_request+0xb3>
     c3d:	eb 30                	jmp    c6f <make_request+0xcb>
     c3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c43:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     c4a:	00 00 00 
     c4d:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     c51:	48 89 50 18          	mov    %rdx,0x18(%rax)
     c55:	eb 2f                	jmp    c86 <make_request+0xe2>
     c57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c5b:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     c62:	00 00 00 
     c65:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     c69:	48 89 50 18          	mov    %rdx,0x18(%rax)
     c6d:	eb 17                	jmp    c86 <make_request+0xe2>
     c6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c73:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     c7a:	00 00 00 
     c7d:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     c81:	48 89 50 18          	mov    %rdx,0x18(%rax)
     c85:	90                   	nop
     c86:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     c8a:	89 c2                	mov    %eax,%edx
     c8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c90:	88 50 04             	mov    %dl,0x4(%rax)
     c93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c97:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
     c9b:	48 89 50 08          	mov    %rdx,0x8(%rax)
     c9f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     ca3:	89 c2                	mov    %eax,%edx
     ca5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ca9:	89 10                	mov    %edx,(%rax)
     cab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     caf:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     cb3:	48 89 50 10          	mov    %rdx,0x10(%rax)
     cb7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     cbb:	48 83 c4 30          	add    $0x30,%rsp
     cbf:	5b                   	pop    %rbx
     cc0:	41 5f                	pop    %r15
     cc2:	5d                   	pop    %rbp
     cc3:	c3                   	ret    

0000000000000cc4 <submit>:
     cc4:	f3 0f 1e fa          	endbr64 
     cc8:	55                   	push   %rbp
     cc9:	48 89 e5             	mov    %rsp,%rbp
     ccc:	53                   	push   %rbx
     ccd:	48 83 ec 18          	sub    $0x18,%rsp
     cd1:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # cd1 <submit+0xd>
     cd8:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     cdf:	00 00 00 
     ce2:	4c 01 db             	add    %r11,%rbx
     ce5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     ce9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ced:	48 89 c7             	mov    %rax,%rdi
     cf0:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     cf7:	00 00 00 
     cfa:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     cfe:	ff d0                	call   *%rax
     d00:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     d07:	00 00 00 
     d0a:	48 8b 44 03 18       	mov    0x18(%rbx,%rax,1),%rax
     d0f:	48 85 c0             	test   %rax,%rax
     d12:	75 15                	jne    d29 <submit+0x65>
     d14:	b8 00 00 00 00       	mov    $0x0,%eax
     d19:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     d20:	00 00 00 
     d23:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     d27:	ff d2                	call   *%rdx
     d29:	90                   	nop
     d2a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     d2e:	c9                   	leave  
     d2f:	c3                   	ret    

0000000000000d30 <wait_for_finish>:
     d30:	f3 0f 1e fa          	endbr64 
     d34:	55                   	push   %rbp
     d35:	48 89 e5             	mov    %rsp,%rbp
     d38:	41 57                	push   %r15
     d3a:	53                   	push   %rbx
     d3b:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # d3b <wait_for_finish+0xb>
     d42:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     d49:	00 00 00 
     d4c:	4c 01 db             	add    %r11,%rbx
     d4f:	b8 00 00 00 00       	mov    $0x0,%eax
     d54:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     d5b:	00 00 00 
     d5e:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     d62:	ff d2                	call   *%rdx
     d64:	48 c7 00 02 00 00 00 	movq   $0x2,(%rax)
     d6b:	49 89 df             	mov    %rbx,%r15
     d6e:	b8 00 00 00 00       	mov    $0x0,%eax
     d73:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     d7a:	00 00 00 
     d7d:	48 01 da             	add    %rbx,%rdx
     d80:	ff d2                	call   *%rdx
     d82:	90                   	nop
     d83:	5b                   	pop    %rbx
     d84:	41 5f                	pop    %r15
     d86:	5d                   	pop    %rbp
     d87:	c3                   	ret    

0000000000000d88 <IDE_open>:
     d88:	f3 0f 1e fa          	endbr64 
     d8c:	55                   	push   %rbp
     d8d:	48 89 e5             	mov    %rsp,%rbp
     d90:	41 57                	push   %r15
     d92:	48 83 ec 08          	sub    $0x8,%rsp
     d96:	48 8d 0d f9 ff ff ff 	lea    -0x7(%rip),%rcx        # d96 <IDE_open+0xe>
     d9d:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     da4:	00 00 00 
     da7:	4c 01 d9             	add    %r11,%rcx
     daa:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     db1:	00 00 00 
     db4:	48 8d 04 01          	lea    (%rcx,%rax,1),%rax
     db8:	48 89 c2             	mov    %rax,%rdx
     dbb:	be ff ff ff 00       	mov    $0xffffff,%esi
     dc0:	bf 00 00 00 00       	mov    $0x0,%edi
     dc5:	49 89 cf             	mov    %rcx,%r15
     dc8:	b8 00 00 00 00       	mov    $0x0,%eax
     dcd:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     dd4:	00 00 00 
     dd7:	49 01 c8             	add    %rcx,%r8
     dda:	41 ff d0             	call   *%r8
     ddd:	b8 01 00 00 00       	mov    $0x1,%eax
     de2:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
     de6:	c9                   	leave  
     de7:	c3                   	ret    

0000000000000de8 <IDE_close>:
     de8:	f3 0f 1e fa          	endbr64 
     dec:	55                   	push   %rbp
     ded:	48 89 e5             	mov    %rsp,%rbp
     df0:	41 57                	push   %r15
     df2:	48 83 ec 08          	sub    $0x8,%rsp
     df6:	48 8d 0d f9 ff ff ff 	lea    -0x7(%rip),%rcx        # df6 <IDE_close+0xe>
     dfd:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     e04:	00 00 00 
     e07:	4c 01 d9             	add    %r11,%rcx
     e0a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     e11:	00 00 00 
     e14:	48 8d 04 01          	lea    (%rcx,%rax,1),%rax
     e18:	48 89 c2             	mov    %rax,%rdx
     e1b:	be ff ff ff 00       	mov    $0xffffff,%esi
     e20:	bf 00 00 00 00       	mov    $0x0,%edi
     e25:	49 89 cf             	mov    %rcx,%r15
     e28:	b8 00 00 00 00       	mov    $0x0,%eax
     e2d:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     e34:	00 00 00 
     e37:	49 01 c8             	add    %rcx,%r8
     e3a:	41 ff d0             	call   *%r8
     e3d:	b8 01 00 00 00       	mov    $0x1,%eax
     e42:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
     e46:	c9                   	leave  
     e47:	c3                   	ret    

0000000000000e48 <IDE_ioctl>:
     e48:	f3 0f 1e fa          	endbr64 
     e4c:	55                   	push   %rbp
     e4d:	48 89 e5             	mov    %rsp,%rbp
     e50:	53                   	push   %rbx
     e51:	48 83 ec 28          	sub    $0x28,%rsp
     e55:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # e55 <IDE_ioctl+0xd>
     e5c:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     e63:	00 00 00 
     e66:	4c 01 db             	add    %r11,%rbx
     e69:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     e6d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     e71:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
     e78:	00 
     e79:	48 81 7d d8 ec 00 00 	cmpq   $0xec,-0x28(%rbp)
     e80:	00 
     e81:	75 5f                	jne    ee2 <IDE_ioctl+0x9a>
     e83:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
     e87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     e8b:	48 89 d1             	mov    %rdx,%rcx
     e8e:	ba 00 00 00 00       	mov    $0x0,%edx
     e93:	be 00 00 00 00       	mov    $0x0,%esi
     e98:	48 89 c7             	mov    %rax,%rdi
     e9b:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     ea2:	00 00 00 
     ea5:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     ea9:	ff d0                	call   *%rax
     eab:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     eaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     eb3:	48 89 c7             	mov    %rax,%rdi
     eb6:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     ebd:	00 00 00 
     ec0:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     ec4:	ff d0                	call   *%rax
     ec6:	b8 00 00 00 00       	mov    $0x0,%eax
     ecb:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     ed2:	00 00 00 
     ed5:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     ed9:	ff d2                	call   *%rdx
     edb:	b8 01 00 00 00       	mov    $0x1,%eax
     ee0:	eb 05                	jmp    ee7 <IDE_ioctl+0x9f>
     ee2:	b8 00 00 00 00       	mov    $0x0,%eax
     ee7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     eeb:	c9                   	leave  
     eec:	c3                   	ret    

0000000000000eed <IDE_transfer>:
     eed:	f3 0f 1e fa          	endbr64 
     ef1:	55                   	push   %rbp
     ef2:	48 89 e5             	mov    %rsp,%rbp
     ef5:	53                   	push   %rbx
     ef6:	48 83 ec 38          	sub    $0x38,%rsp
     efa:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # efa <IDE_transfer+0xd>
     f01:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     f08:	00 00 00 
     f0b:	4c 01 db             	add    %r11,%rbx
     f0e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     f12:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     f16:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
     f1a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
     f1e:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
     f25:	00 
     f26:	48 83 7d d8 24       	cmpq   $0x24,-0x28(%rbp)
     f2b:	74 07                	je     f34 <IDE_transfer+0x47>
     f2d:	48 83 7d d8 34       	cmpq   $0x34,-0x28(%rbp)
     f32:	75 5a                	jne    f8e <IDE_transfer+0xa1>
     f34:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
     f38:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
     f3c:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
     f40:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     f44:	48 89 c7             	mov    %rax,%rdi
     f47:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     f4e:	00 00 00 
     f51:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     f55:	ff d0                	call   *%rax
     f57:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     f5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     f5f:	48 89 c7             	mov    %rax,%rdi
     f62:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     f69:	00 00 00 
     f6c:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
     f70:	ff d0                	call   *%rax
     f72:	b8 00 00 00 00       	mov    $0x0,%eax
     f77:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
     f7e:	00 00 00 
     f81:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
     f85:	ff d2                	call   *%rdx
     f87:	b8 01 00 00 00       	mov    $0x1,%eax
     f8c:	eb 05                	jmp    f93 <IDE_transfer+0xa6>
     f8e:	b8 00 00 00 00       	mov    $0x0,%eax
     f93:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     f97:	c9                   	leave  
     f98:	c3                   	ret    

0000000000000f99 <disk_handler>:
     f99:	f3 0f 1e fa          	endbr64 
     f9d:	55                   	push   %rbp
     f9e:	48 89 e5             	mov    %rsp,%rbp
     fa1:	41 57                	push   %r15
     fa3:	48 83 ec 38          	sub    $0x38,%rsp
     fa7:	48 8d 0d f9 ff ff ff 	lea    -0x7(%rip),%rcx        # fa7 <disk_handler+0xe>
     fae:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
     fb5:	00 00 00 
     fb8:	4c 01 d9             	add    %r11,%rcx
     fbb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     fbf:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     fc3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
     fc7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     fcb:	48 8b 40 18          	mov    0x18(%rax),%rax
     fcf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     fd3:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
     fda:	00 00 00 
     fdd:	48 8d 04 01          	lea    (%rcx,%rax,1),%rax
     fe1:	48 89 c2             	mov    %rax,%rdx
     fe4:	be ff ff ff 00       	mov    $0xffffff,%esi
     fe9:	bf 00 00 00 00       	mov    $0x0,%edi
     fee:	49 89 cf             	mov    %rcx,%r15
     ff1:	b8 00 00 00 00       	mov    $0x0,%eax
     ff6:	49 b8 00 00 00 00 00 	movabs $0x0,%r8
     ffd:	00 00 00 
    1000:	49 01 c8             	add    %rcx,%r8
    1003:	41 ff d0             	call   *%r8
    1006:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    100a:	48 8b 48 18          	mov    0x18(%rax),%rcx
    100e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    1012:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1016:	48 89 d6             	mov    %rdx,%rsi
    1019:	48 89 c7             	mov    %rax,%rdi
    101c:	ff d1                	call   *%rcx
    101e:	90                   	nop
    101f:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
    1023:	c9                   	leave  
    1024:	c3                   	ret    

0000000000001025 <disk_init>:
    1025:	f3 0f 1e fa          	endbr64 
    1029:	55                   	push   %rbp
    102a:	48 89 e5             	mov    %rsp,%rbp
    102d:	41 57                	push   %r15
    102f:	53                   	push   %rbx
    1030:	48 83 ec 10          	sub    $0x10,%rsp
    1034:	48 8d 1d f9 ff ff ff 	lea    -0x7(%rip),%rbx        # 1034 <disk_init+0xf>
    103b:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
    1042:	00 00 00 
    1045:	4c 01 db             	add    %r11,%rbx
    1048:	c6 45 e8 2f          	movb   $0x2f,-0x18(%rbp)
    104c:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    1050:	83 e0 f8             	and    $0xfffffff8,%eax
    1053:	88 45 e9             	mov    %al,-0x17(%rbp)
    1056:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    105a:	83 e0 f7             	and    $0xfffffff7,%eax
    105d:	88 45 e9             	mov    %al,-0x17(%rbp)
    1060:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    1064:	83 e0 ef             	and    $0xffffffef,%eax
    1067:	88 45 e9             	mov    %al,-0x17(%rbp)
    106a:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    106e:	83 e0 df             	and    $0xffffffdf,%eax
    1071:	88 45 e9             	mov    %al,-0x17(%rbp)
    1074:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    1078:	83 e0 bf             	and    $0xffffffbf,%eax
    107b:	88 45 e9             	mov    %al,-0x17(%rbp)
    107e:	0f b6 45 e9          	movzbl -0x17(%rbp),%eax
    1082:	83 e0 7f             	and    $0x7f,%eax
    1085:	88 45 e9             	mov    %al,-0x17(%rbp)
    1088:	0f b6 45 ea          	movzbl -0x16(%rbp),%eax
    108c:	83 c8 01             	or     $0x1,%eax
    108f:	88 45 ea             	mov    %al,-0x16(%rbp)
    1092:	0f b7 45 ea          	movzwl -0x16(%rbp),%eax
    1096:	83 e0 01             	and    $0x1,%eax
    1099:	66 89 45 ea          	mov    %ax,-0x16(%rbp)
    109d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    10a0:	25 00 00 00 ff       	and    $0xff000000,%eax
    10a5:	89 45 ec             	mov    %eax,-0x14(%rbp)
    10a8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    10ac:	83 e0 f0             	and    $0xfffffff0,%eax
    10af:	88 45 ef             	mov    %al,-0x11(%rbp)
    10b2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    10b6:	83 e0 0f             	and    $0xf,%eax
    10b9:	88 45 ef             	mov    %al,-0x11(%rbp)
    10bc:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    10c3:	00 00 00 
    10c6:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
    10ca:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
    10ce:	48 b9 00 00 00 00 00 	movabs $0x0,%rcx
    10d5:	00 00 00 
    10d8:	4c 8d 0c 0b          	lea    (%rbx,%rcx,1),%r9
    10dc:	48 b9 00 00 00 00 00 	movabs $0x0,%rcx
    10e3:	00 00 00 
    10e6:	4c 8d 04 0b          	lea    (%rbx,%rcx,1),%r8
    10ea:	48 89 d1             	mov    %rdx,%rcx
    10ed:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
    10f4:	00 00 00 
    10f7:	48 8d 14 13          	lea    (%rbx,%rdx,1),%rdx
    10fb:	48 89 c6             	mov    %rax,%rsi
    10fe:	bf 2f 00 00 00       	mov    $0x2f,%edi
    1103:	49 89 df             	mov    %rbx,%r15
    1106:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    110d:	00 00 00 
    1110:	48 01 d8             	add    %rbx,%rax
    1113:	ff d0                	call   *%rax
    1115:	be 00 00 00 00       	mov    $0x0,%esi
    111a:	bf 76 03 00 00       	mov    $0x376,%edi
    111f:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    1126:	00 00 00 
    1129:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
    112d:	ff d0                	call   *%rax
    112f:	be 00 00 00 00       	mov    $0x0,%esi
    1134:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    113b:	00 00 00 
    113e:	48 8d 04 03          	lea    (%rbx,%rax,1),%rax
    1142:	48 89 c7             	mov    %rax,%rdi
    1145:	49 89 df             	mov    %rbx,%r15
    1148:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    114f:	00 00 00 
    1152:	48 01 d8             	add    %rbx,%rax
    1155:	ff d0                	call   *%rax
    1157:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    115e:	00 00 00 
    1161:	48 c7 44 03 18 00 00 	movq   $0x0,0x18(%rbx,%rax,1)
    1168:	00 00 
    116a:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
    1171:	00 00 00 
    1174:	48 c7 44 03 20 00 00 	movq   $0x0,0x20(%rbx,%rax,1)
    117b:	00 00 
    117d:	90                   	nop
    117e:	48 83 c4 10          	add    $0x10,%rsp
    1182:	5b                   	pop    %rbx
    1183:	41 5f                	pop    %r15
    1185:	5d                   	pop    %rbp
    1186:	c3                   	ret    

0000000000001187 <disk_exit>:
    1187:	f3 0f 1e fa          	endbr64 
    118b:	55                   	push   %rbp
    118c:	48 89 e5             	mov    %rsp,%rbp
    118f:	41 57                	push   %r15
    1191:	48 83 ec 08          	sub    $0x8,%rsp
    1195:	48 8d 05 f9 ff ff ff 	lea    -0x7(%rip),%rax        # 1195 <disk_exit+0xe>
    119c:	49 bb 00 00 00 00 00 	movabs $0x0,%r11
    11a3:	00 00 00 
    11a6:	4c 01 d8             	add    %r11,%rax
    11a9:	bf 2f 00 00 00       	mov    $0x2f,%edi
    11ae:	49 89 c7             	mov    %rax,%r15
    11b1:	48 ba 00 00 00 00 00 	movabs $0x0,%rdx
    11b8:	00 00 00 
    11bb:	48 01 c2             	add    %rax,%rdx
    11be:	ff d2                	call   *%rdx
    11c0:	90                   	nop
    11c1:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
    11c5:	c9                   	leave  
    11c6:	c3                   	ret    
