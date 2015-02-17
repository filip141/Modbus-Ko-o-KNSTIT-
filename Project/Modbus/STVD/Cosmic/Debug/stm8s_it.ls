   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  48                     ; 45 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  48                     ; 46 {
  49                     	switch	.text
  50  0000               f_NonHandledInterrupt:
  54                     ; 50 }
  57  0000 80            	iret	
  79                     ; 58 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  79                     ; 59 {
  80                     	switch	.text
  81  0001               f_TRAP_IRQHandler:
  85                     ; 63 }
  88  0001 80            	iret	
 110                     ; 69 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 110                     ; 70 {
 111                     	switch	.text
 112  0002               f_TLI_IRQHandler:
 116                     ; 74 }
 119  0002 80            	iret	
 141                     ; 81 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 141                     ; 82 {
 142                     	switch	.text
 143  0003               f_AWU_IRQHandler:
 147                     ; 86 }
 150  0003 80            	iret	
 172                     ; 93 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 172                     ; 94 {
 173                     	switch	.text
 174  0004               f_CLK_IRQHandler:
 178                     ; 98 }
 181  0004 80            	iret	
 204                     ; 105 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 204                     ; 106 {
 205                     	switch	.text
 206  0005               f_EXTI_PORTA_IRQHandler:
 210                     ; 110 }
 213  0005 80            	iret	
 236                     ; 117 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 236                     ; 118 {
 237                     	switch	.text
 238  0006               f_EXTI_PORTB_IRQHandler:
 242                     ; 122 }
 245  0006 80            	iret	
 268                     ; 129 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 268                     ; 130 {
 269                     	switch	.text
 270  0007               f_EXTI_PORTC_IRQHandler:
 274                     ; 134 }
 277  0007 80            	iret	
 300                     ; 141 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 300                     ; 142 {
 301                     	switch	.text
 302  0008               f_EXTI_PORTD_IRQHandler:
 306                     ; 146 }
 309  0008 80            	iret	
 332                     ; 153 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 332                     ; 154 {
 333                     	switch	.text
 334  0009               f_EXTI_PORTE_IRQHandler:
 338                     ; 158 }
 341  0009 80            	iret	
 363                     ; 204 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 363                     ; 205 {
 364                     	switch	.text
 365  000a               f_SPI_IRQHandler:
 369                     ; 209 }
 372  000a 80            	iret	
 395                     ; 216 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 395                     ; 217 {
 396                     	switch	.text
 397  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 401                     ; 221 }
 404  000b 80            	iret	
 427                     ; 228 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 427                     ; 229 {
 428                     	switch	.text
 429  000c               f_TIM1_CAP_COM_IRQHandler:
 433                     ; 233 }
 436  000c 80            	iret	
 459                     ; 265  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 459                     ; 266 {
 460                     	switch	.text
 461  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 465                     ; 270 }
 468  000d 80            	iret	
 491                     ; 277  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 491                     ; 278 {
 492                     	switch	.text
 493  000e               f_TIM2_CAP_COM_IRQHandler:
 497                     ; 282 }
 500  000e 80            	iret	
 525                     ; 292  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 525                     ; 293 {
 526                     	switch	.text
 527  000f               f_TIM3_UPD_OVF_BRK_IRQHandler:
 529  000f 8a            	push	cc
 530  0010 84            	pop	a
 531  0011 a4bf          	and	a,#191
 532  0013 88            	push	a
 533  0014 86            	pop	cc
 534  0015 3b0002        	push	c_x+2
 535  0018 be00          	ldw	x,c_x
 536  001a 89            	pushw	x
 537  001b 3b0002        	push	c_y+2
 538  001e be00          	ldw	x,c_y
 539  0020 89            	pushw	x
 542                     ; 295 	if(TimmingDelay !=0)
 544  0021 ae002a        	ldw	x,#_TimmingDelay
 545  0024 cd0000        	call	c_lzmp
 547  0027 2705          	jreq	L112
 548                     ; 297 		TimmingDelay--;
 550  0029 a601          	ld	a,#1
 551  002b cd0000        	call	c_lgsbc
 553  002e               L112:
 554                     ; 299 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 556  002e a601          	ld	a,#1
 557  0030 cd0000        	call	_TIM3_ClearITPendingBit
 559                     ; 300 }
 562  0033 85            	popw	x
 563  0034 bf00          	ldw	c_y,x
 564  0036 320002        	pop	c_y+2
 565  0039 85            	popw	x
 566  003a bf00          	ldw	c_x,x
 567  003c 320002        	pop	c_x+2
 568  003f 80            	iret	
 591                     ; 307  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 591                     ; 308 {
 592                     	switch	.text
 593  0040               f_TIM3_CAP_COM_IRQHandler:
 597                     ; 312 }
 600  0040 80            	iret	
 622                     ; 347 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 622                     ; 348 {
 623                     	switch	.text
 624  0041               f_I2C_IRQHandler:
 628                     ; 352 }
 631  0041 80            	iret	
 654                     ; 360  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 654                     ; 361 {
 655                     	switch	.text
 656  0042               f_UART2_TX_IRQHandler:
 660                     ; 365   }
 663  0042 80            	iret	
 665                     	bsct
 666  0000               _STATUS_BIT:
 667  0000 00            	dc.b	0
 727                     ; 378  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 727                     ; 379 {
 728                     	switch	.text
 729  0043               f_UART2_RX_IRQHandler:
 731  0043 8a            	push	cc
 732  0044 84            	pop	a
 733  0045 a4bf          	and	a,#191
 734  0047 88            	push	a
 735  0048 86            	pop	cc
 736       00000004      OFST:	set	4
 737  0049 3b0002        	push	c_x+2
 738  004c be00          	ldw	x,c_x
 739  004e 89            	pushw	x
 740  004f 3b0002        	push	c_y+2
 741  0052 be00          	ldw	x,c_y
 742  0054 89            	pushw	x
 743  0055 5204          	subw	sp,#4
 746                     ; 381 	buffer[counter] = UART2_ReceiveData8();
 748  0057 b601          	ld	a,_counter
 749  0059 5f            	clrw	x
 750  005a 97            	ld	xl,a
 751  005b 89            	pushw	x
 752  005c cd0000        	call	_UART2_ReceiveData8
 754  005f 85            	popw	x
 755  0060 e716          	ld	(_buffer,x),a
 756                     ; 383 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 758  0062 5f            	clrw	x
 759  0063 b601          	ld	a,_counter
 760  0065 97            	ld	xl,a
 761  0066 e616          	ld	a,(_buffer,x)
 762  0068 a10d          	cp	a,#13
 763  006a 2604          	jrne	L172
 766  006c 35010000      	mov	_STATUS_BIT,#1
 767  0070               L172:
 768                     ; 384 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 770  0070 b601          	ld	a,_counter
 771  0072 5f            	clrw	x
 772  0073 97            	ld	xl,a
 773  0074 e616          	ld	a,(_buffer,x)
 774  0076 a10a          	cp	a,#10
 775  0078 264b          	jrne	L372
 777  007a b600          	ld	a,_STATUS_BIT
 778  007c 4a            	dec	a
 779  007d 2646          	jrne	L372
 780                     ; 390 	temp[0] = buffer[1];
 782  007f b617          	ld	a,_buffer+1
 783  0081 6b02          	ld	(OFST-2,sp),a
 784                     ; 391 	temp[1] = buffer[2];
 786  0083 b618          	ld	a,_buffer+2
 787  0085 6b03          	ld	(OFST-1,sp),a
 788                     ; 392 	HexToByte(temp, &Addr);
 790  0087 96            	ldw	x,sp
 791  0088 5c            	incw	x
 792  0089 89            	pushw	x
 793  008a 5c            	incw	x
 794  008b cd0000        	call	_HexToByte
 796  008e 85            	popw	x
 797                     ; 394 		if(Addr == Address || Addr == 0)
 799  008f 7b01          	ld	a,(OFST-3,sp)
 800  0091 b100          	cp	a,_Address
 801  0093 2704          	jreq	L772
 803  0095 7b01          	ld	a,(OFST-3,sp)
 804  0097 2619          	jrne	L572
 805  0099               L772:
 806                     ; 397 			for(i = 0; i<20; i++)
 808  0099 4f            	clr	a
 809  009a 6b04          	ld	(OFST+0,sp),a
 810  009c               L103:
 811                     ; 399 			word[i] = buffer[i];
 813  009c 5f            	clrw	x
 814  009d 97            	ld	xl,a
 815  009e e616          	ld	a,(_buffer,x)
 816  00a0 e702          	ld	(_word,x),a
 817                     ; 400 			buffer[i] = '\0';	
 819  00a2 5f            	clrw	x
 820  00a3 7b04          	ld	a,(OFST+0,sp)
 821  00a5 97            	ld	xl,a
 822  00a6 6f16          	clr	(_buffer,x)
 823                     ; 397 			for(i = 0; i<20; i++)
 825  00a8 0c04          	inc	(OFST+0,sp)
 828  00aa 7b04          	ld	a,(OFST+0,sp)
 829  00ac a114          	cp	a,#20
 830  00ae 25ec          	jrult	L103
 831                     ; 402 			counter = 0;
 833  00b0 200f          	jpf	LC001
 834  00b2               L572:
 835                     ; 407 			for(i = 0; i<20; i++)
 837  00b2 4f            	clr	a
 838  00b3 6b04          	ld	(OFST+0,sp),a
 839  00b5               L113:
 840                     ; 409 			buffer[i] = '\0';	
 842  00b5 5f            	clrw	x
 843  00b6 97            	ld	xl,a
 844  00b7 6f16          	clr	(_buffer,x)
 845                     ; 407 			for(i = 0; i<20; i++)
 847  00b9 0c04          	inc	(OFST+0,sp)
 850  00bb 7b04          	ld	a,(OFST+0,sp)
 851  00bd a114          	cp	a,#20
 852  00bf 25f4          	jrult	L113
 853                     ; 411 			counter = 0;
 855  00c1               LC001:
 857  00c1 3f01          	clr	_counter
 858  00c3 2002          	jra	L713
 859  00c5               L372:
 860                     ; 417 	counter++;
 862  00c5 3c01          	inc	_counter
 863  00c7               L713:
 864                     ; 420 	UART2_ClearITPendingBit(UART2_IT_RXNE);
 866  00c7 ae0255        	ldw	x,#597
 867  00ca cd0000        	call	_UART2_ClearITPendingBit
 869                     ; 421 }
 872  00cd 5b04          	addw	sp,#4
 873  00cf 85            	popw	x
 874  00d0 bf00          	ldw	c_y,x
 875  00d2 320002        	pop	c_y+2
 876  00d5 85            	popw	x
 877  00d6 bf00          	ldw	c_x,x
 878  00d8 320002        	pop	c_x+2
 879  00db 80            	iret	
 901                     ; 469  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 901                     ; 470 {
 902                     	switch	.text
 903  00dc               f_ADC1_IRQHandler:
 907                     ; 475 }
 910  00dc 80            	iret	
 933                     ; 496  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 933                     ; 497 {
 934                     	switch	.text
 935  00dd               f_TIM4_UPD_OVF_IRQHandler:
 939                     ; 501 }
 942  00dd 80            	iret	
 965                     ; 509 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 965                     ; 510 {
 966                     	switch	.text
 967  00de               f_EEPROM_EEC_IRQHandler:
 971                     ; 514 }
 974  00de 80            	iret	
1044                     	switch	.ubsct
1045  0000               _Address:
1046  0000 00            	ds.b	1
1047                     	xdef	_Address
1048                     	xdef	_STATUS_BIT
1049  0001               _counter:
1050  0001 00            	ds.b	1
1051                     	xdef	_counter
1052  0002               _word:
1053  0002 000000000000  	ds.b	20
1054                     	xdef	_word
1055  0016               _buffer:
1056  0016 000000000000  	ds.b	20
1057                     	xdef	_buffer
1058  002a               _TimmingDelay:
1059  002a 00000000      	ds.b	4
1060                     	xdef	_TimmingDelay
1061                     	xref	_HexToByte
1062                     	xdef	f_EEPROM_EEC_IRQHandler
1063                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1064                     	xdef	f_ADC1_IRQHandler
1065                     	xdef	f_UART2_TX_IRQHandler
1066                     	xdef	f_UART2_RX_IRQHandler
1067                     	xdef	f_I2C_IRQHandler
1068                     	xdef	f_TIM3_CAP_COM_IRQHandler
1069                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1070                     	xdef	f_TIM2_CAP_COM_IRQHandler
1071                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1072                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1073                     	xdef	f_TIM1_CAP_COM_IRQHandler
1074                     	xdef	f_SPI_IRQHandler
1075                     	xdef	f_EXTI_PORTE_IRQHandler
1076                     	xdef	f_EXTI_PORTD_IRQHandler
1077                     	xdef	f_EXTI_PORTC_IRQHandler
1078                     	xdef	f_EXTI_PORTB_IRQHandler
1079                     	xdef	f_EXTI_PORTA_IRQHandler
1080                     	xdef	f_CLK_IRQHandler
1081                     	xdef	f_AWU_IRQHandler
1082                     	xdef	f_TLI_IRQHandler
1083                     	xdef	f_TRAP_IRQHandler
1084                     	xdef	f_NonHandledInterrupt
1085                     	xref	_UART2_ClearITPendingBit
1086                     	xref	_UART2_ReceiveData8
1087                     	xref	_TIM3_ClearITPendingBit
1088                     	xref.b	c_x
1089                     	xref.b	c_y
1109                     	xref	c_lgsbc
1110                     	xref	c_lzmp
1111                     	end
