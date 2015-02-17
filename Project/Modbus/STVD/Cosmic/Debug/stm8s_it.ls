   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  48                     ; 44 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  48                     ; 45 {
  49                     	switch	.text
  50  0000               f_NonHandledInterrupt:
  54                     ; 49 }
  57  0000 80            	iret	
  79                     ; 57 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  79                     ; 58 {
  80                     	switch	.text
  81  0001               f_TRAP_IRQHandler:
  85                     ; 62 }
  88  0001 80            	iret	
 110                     ; 68 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 110                     ; 69 {
 111                     	switch	.text
 112  0002               f_TLI_IRQHandler:
 116                     ; 73 }
 119  0002 80            	iret	
 141                     ; 80 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 141                     ; 81 {
 142                     	switch	.text
 143  0003               f_AWU_IRQHandler:
 147                     ; 85 }
 150  0003 80            	iret	
 172                     ; 92 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 172                     ; 93 {
 173                     	switch	.text
 174  0004               f_CLK_IRQHandler:
 178                     ; 97 }
 181  0004 80            	iret	
 204                     ; 104 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 204                     ; 105 {
 205                     	switch	.text
 206  0005               f_EXTI_PORTA_IRQHandler:
 210                     ; 109 }
 213  0005 80            	iret	
 236                     ; 116 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 236                     ; 117 {
 237                     	switch	.text
 238  0006               f_EXTI_PORTB_IRQHandler:
 242                     ; 121 }
 245  0006 80            	iret	
 268                     ; 128 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 268                     ; 129 {
 269                     	switch	.text
 270  0007               f_EXTI_PORTC_IRQHandler:
 274                     ; 133 }
 277  0007 80            	iret	
 300                     ; 140 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 300                     ; 141 {
 301                     	switch	.text
 302  0008               f_EXTI_PORTD_IRQHandler:
 306                     ; 145 }
 309  0008 80            	iret	
 332                     ; 152 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 332                     ; 153 {
 333                     	switch	.text
 334  0009               f_EXTI_PORTE_IRQHandler:
 338                     ; 157 }
 341  0009 80            	iret	
 363                     ; 203 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 363                     ; 204 {
 364                     	switch	.text
 365  000a               f_SPI_IRQHandler:
 369                     ; 208 }
 372  000a 80            	iret	
 395                     ; 215 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 395                     ; 216 {
 396                     	switch	.text
 397  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 401                     ; 220 }
 404  000b 80            	iret	
 427                     ; 227 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 427                     ; 228 {
 428                     	switch	.text
 429  000c               f_TIM1_CAP_COM_IRQHandler:
 433                     ; 232 }
 436  000c 80            	iret	
 459                     ; 264  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 459                     ; 265 {
 460                     	switch	.text
 461  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 465                     ; 269 }
 468  000d 80            	iret	
 491                     ; 276  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 491                     ; 277 {
 492                     	switch	.text
 493  000e               f_TIM2_CAP_COM_IRQHandler:
 497                     ; 281 }
 500  000e 80            	iret	
 525                     ; 291  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 525                     ; 292 {
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
 542                     ; 294 	if(TimmingDelay !=0)
 544  0021 ae002a        	ldw	x,#_TimmingDelay
 545  0024 cd0000        	call	c_lzmp
 547  0027 2705          	jreq	L112
 548                     ; 296 		TimmingDelay--;
 550  0029 a601          	ld	a,#1
 551  002b cd0000        	call	c_lgsbc
 553  002e               L112:
 554                     ; 298 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 556  002e a601          	ld	a,#1
 557  0030 cd0000        	call	_TIM3_ClearITPendingBit
 559                     ; 299 }
 562  0033 85            	popw	x
 563  0034 bf00          	ldw	c_y,x
 564  0036 320002        	pop	c_y+2
 565  0039 85            	popw	x
 566  003a bf00          	ldw	c_x,x
 567  003c 320002        	pop	c_x+2
 568  003f 80            	iret	
 591                     ; 306  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 591                     ; 307 {
 592                     	switch	.text
 593  0040               f_TIM3_CAP_COM_IRQHandler:
 597                     ; 311 }
 600  0040 80            	iret	
 622                     ; 346 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 622                     ; 347 {
 623                     	switch	.text
 624  0041               f_I2C_IRQHandler:
 628                     ; 351 }
 631  0041 80            	iret	
 654                     ; 359  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 654                     ; 360 {
 655                     	switch	.text
 656  0042               f_UART2_TX_IRQHandler:
 660                     ; 364   }
 663  0042 80            	iret	
 665                     	bsct
 666  0000               _STATUS_BIT:
 667  0000 00            	dc.b	0
 706                     ; 377  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 706                     ; 378 {
 707                     	switch	.text
 708  0043               f_UART2_RX_IRQHandler:
 710  0043 8a            	push	cc
 711  0044 84            	pop	a
 712  0045 a4bf          	and	a,#191
 713  0047 88            	push	a
 714  0048 86            	pop	cc
 715       00000001      OFST:	set	1
 716  0049 3b0002        	push	c_x+2
 717  004c be00          	ldw	x,c_x
 718  004e 89            	pushw	x
 719  004f 3b0002        	push	c_y+2
 720  0052 be00          	ldw	x,c_y
 721  0054 89            	pushw	x
 722  0055 88            	push	a
 725                     ; 380 	buffer[counter] = UART2_ReceiveData8();
 727  0056 b601          	ld	a,_counter
 728  0058 5f            	clrw	x
 729  0059 97            	ld	xl,a
 730  005a 89            	pushw	x
 731  005b cd0000        	call	_UART2_ReceiveData8
 733  005e 85            	popw	x
 734  005f e716          	ld	(_buffer,x),a
 735                     ; 382 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 737  0061 5f            	clrw	x
 738  0062 b601          	ld	a,_counter
 739  0064 97            	ld	xl,a
 740  0065 e616          	ld	a,(_buffer,x)
 741  0067 a10d          	cp	a,#13
 742  0069 2604          	jrne	L162
 745  006b 35010000      	mov	_STATUS_BIT,#1
 746  006f               L162:
 747                     ; 383 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 749  006f b601          	ld	a,_counter
 750  0071 5f            	clrw	x
 751  0072 97            	ld	xl,a
 752  0073 e616          	ld	a,(_buffer,x)
 753  0075 a10a          	cp	a,#10
 754  0077 261f          	jrne	L362
 756  0079 b600          	ld	a,_STATUS_BIT
 757  007b 4a            	dec	a
 758  007c 261a          	jrne	L362
 759                     ; 386 	for(i = 0; i<20; i++)
 761  007e 6b01          	ld	(OFST+0,sp),a
 762  0080               L562:
 763                     ; 388 	word[i] = buffer[i];
 765  0080 5f            	clrw	x
 766  0081 97            	ld	xl,a
 767  0082 e616          	ld	a,(_buffer,x)
 768  0084 e702          	ld	(_word,x),a
 769                     ; 389 	buffer[i] = '\0';	
 771  0086 5f            	clrw	x
 772  0087 7b01          	ld	a,(OFST+0,sp)
 773  0089 97            	ld	xl,a
 774  008a 6f16          	clr	(_buffer,x)
 775                     ; 386 	for(i = 0; i<20; i++)
 777  008c 0c01          	inc	(OFST+0,sp)
 780  008e 7b01          	ld	a,(OFST+0,sp)
 781  0090 a114          	cp	a,#20
 782  0092 25ec          	jrult	L562
 783                     ; 391 	counter = 0;
 785  0094 3f01          	clr	_counter
 787  0096 2002          	jra	L372
 788  0098               L362:
 789                     ; 395 	counter++;
 791  0098 3c01          	inc	_counter
 792  009a               L372:
 793                     ; 398 	UART2_ClearITPendingBit(UART2_IT_RXNE);
 795  009a ae0255        	ldw	x,#597
 796  009d cd0000        	call	_UART2_ClearITPendingBit
 798                     ; 399 }
 801  00a0 84            	pop	a
 802  00a1 85            	popw	x
 803  00a2 bf00          	ldw	c_y,x
 804  00a4 320002        	pop	c_y+2
 805  00a7 85            	popw	x
 806  00a8 bf00          	ldw	c_x,x
 807  00aa 320002        	pop	c_x+2
 808  00ad 80            	iret	
 830                     ; 447  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 830                     ; 448 {
 831                     	switch	.text
 832  00ae               f_ADC1_IRQHandler:
 836                     ; 453 }
 839  00ae 80            	iret	
 862                     ; 474  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 862                     ; 475 {
 863                     	switch	.text
 864  00af               f_TIM4_UPD_OVF_IRQHandler:
 868                     ; 479 }
 871  00af 80            	iret	
 894                     ; 487 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 894                     ; 488 {
 895                     	switch	.text
 896  00b0               f_EEPROM_EEC_IRQHandler:
 900                     ; 492 }
 903  00b0 80            	iret	
 973                     	switch	.ubsct
 974  0000               _Address:
 975  0000 00            	ds.b	1
 976                     	xdef	_Address
 977                     	xdef	_STATUS_BIT
 978  0001               _counter:
 979  0001 00            	ds.b	1
 980                     	xdef	_counter
 981  0002               _word:
 982  0002 000000000000  	ds.b	20
 983                     	xdef	_word
 984  0016               _buffer:
 985  0016 000000000000  	ds.b	20
 986                     	xdef	_buffer
 987  002a               _TimmingDelay:
 988  002a 00000000      	ds.b	4
 989                     	xdef	_TimmingDelay
 990                     	xdef	f_EEPROM_EEC_IRQHandler
 991                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 992                     	xdef	f_ADC1_IRQHandler
 993                     	xdef	f_UART2_TX_IRQHandler
 994                     	xdef	f_UART2_RX_IRQHandler
 995                     	xdef	f_I2C_IRQHandler
 996                     	xdef	f_TIM3_CAP_COM_IRQHandler
 997                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 998                     	xdef	f_TIM2_CAP_COM_IRQHandler
 999                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1000                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1001                     	xdef	f_TIM1_CAP_COM_IRQHandler
1002                     	xdef	f_SPI_IRQHandler
1003                     	xdef	f_EXTI_PORTE_IRQHandler
1004                     	xdef	f_EXTI_PORTD_IRQHandler
1005                     	xdef	f_EXTI_PORTC_IRQHandler
1006                     	xdef	f_EXTI_PORTB_IRQHandler
1007                     	xdef	f_EXTI_PORTA_IRQHandler
1008                     	xdef	f_CLK_IRQHandler
1009                     	xdef	f_AWU_IRQHandler
1010                     	xdef	f_TLI_IRQHandler
1011                     	xdef	f_TRAP_IRQHandler
1012                     	xdef	f_NonHandledInterrupt
1013                     	xref	_UART2_ClearITPendingBit
1014                     	xref	_UART2_ReceiveData8
1015                     	xref	_TIM3_ClearITPendingBit
1016                     	xref.b	c_x
1017                     	xref.b	c_y
1037                     	xref	c_lgsbc
1038                     	xref	c_lzmp
1039                     	end
