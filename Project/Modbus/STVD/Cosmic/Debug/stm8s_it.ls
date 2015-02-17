   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 53 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 54 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 58 }
  60  0000 80            	iret	
  82                     ; 66 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 67 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 71 }
  91  0001 80            	iret	
 113                     ; 77 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 78 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 82 }
 122  0002 80            	iret	
 144                     ; 89 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 90 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 94 }
 153  0003 80            	iret	
 175                     ; 101 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 102 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 106 }
 184  0004 80            	iret	
 207                     ; 113 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 114 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 118 }
 216  0005 80            	iret	
 239                     ; 125 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 126 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 130 }
 248  0006 80            	iret	
 271                     ; 137 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 138 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 142 }
 280  0007 80            	iret	
 303                     ; 149 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 150 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 154 }
 312  0008 80            	iret	
 335                     ; 161 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 162 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 166 }
 344  0009 80            	iret	
 366                     ; 212 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 213 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 217 }
 375  000a 80            	iret	
 398                     ; 224 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 225 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 229 }
 407  000b 80            	iret	
 430                     ; 236 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 237 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 241 }
 439  000c 80            	iret	
 476                     ; 273  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 476                     ; 274 {
 477                     	switch	.text
 478  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 480  000d 8a            	push	cc
 481  000e 84            	pop	a
 482  000f a4bf          	and	a,#191
 483  0011 88            	push	a
 484  0012 86            	pop	cc
 485       00000001      OFST:	set	1
 486  0013 3b0002        	push	c_x+2
 487  0016 be00          	ldw	x,c_x
 488  0018 89            	pushw	x
 489  0019 3b0002        	push	c_y+2
 490  001c be00          	ldw	x,c_y
 491  001e 89            	pushw	x
 492  001f 88            	push	a
 495                     ; 276 	if(word[0] != '\0')
 497  0020 b606          	ld	a,_word
 498  0022 2715          	jreq	L771
 499                     ; 278 		UART_SendStr(word);
 501  0024 ae0006        	ldw	x,#_word
 502  0027 cd0000        	call	_UART_SendStr
 504                     ; 279 		for(i = 0; i<20; i++){word[i] = '\0';}
 506  002a 4f            	clr	a
 507  002b 6b01          	ld	(OFST+0,sp),a
 508  002d               L102:
 511  002d 5f            	clrw	x
 512  002e 97            	ld	xl,a
 513  002f 6f06          	clr	(_word,x)
 516  0031 0c01          	inc	(OFST+0,sp)
 519  0033 7b01          	ld	a,(OFST+0,sp)
 520  0035 a114          	cp	a,#20
 521  0037 25f4          	jrult	L102
 522  0039               L771:
 523                     ; 281   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 525  0039 a601          	ld	a,#1
 526  003b cd0000        	call	_TIM2_ClearITPendingBit
 528                     ; 282 }
 531  003e 84            	pop	a
 532  003f 85            	popw	x
 533  0040 bf00          	ldw	c_y,x
 534  0042 320002        	pop	c_y+2
 535  0045 85            	popw	x
 536  0046 bf00          	ldw	c_x,x
 537  0048 320002        	pop	c_x+2
 538  004b 80            	iret	
 561                     ; 289  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 561                     ; 290 {
 562                     	switch	.text
 563  004c               f_TIM2_CAP_COM_IRQHandler:
 567                     ; 294 }
 570  004c 80            	iret	
 595                     ; 304  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 595                     ; 305 {
 596                     	switch	.text
 597  004d               f_TIM3_UPD_OVF_BRK_IRQHandler:
 599  004d 8a            	push	cc
 600  004e 84            	pop	a
 601  004f a4bf          	and	a,#191
 602  0051 88            	push	a
 603  0052 86            	pop	cc
 604  0053 3b0002        	push	c_x+2
 605  0056 be00          	ldw	x,c_x
 606  0058 89            	pushw	x
 607  0059 3b0002        	push	c_y+2
 608  005c be00          	ldw	x,c_y
 609  005e 89            	pushw	x
 612                     ; 307 	if(TimmingDelay !=0)
 614  005f ae0000        	ldw	x,#_TimmingDelay
 615  0062 cd0000        	call	c_lzmp
 617  0065 2705          	jreq	L722
 618                     ; 309 		TimmingDelay--;
 620  0067 a601          	ld	a,#1
 621  0069 cd0000        	call	c_lgsbc
 623  006c               L722:
 624                     ; 311 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 626  006c a601          	ld	a,#1
 627  006e cd0000        	call	_TIM3_ClearITPendingBit
 629                     ; 312 }
 632  0071 85            	popw	x
 633  0072 bf00          	ldw	c_y,x
 634  0074 320002        	pop	c_y+2
 635  0077 85            	popw	x
 636  0078 bf00          	ldw	c_x,x
 637  007a 320002        	pop	c_x+2
 638  007d 80            	iret	
 661                     ; 319  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 661                     ; 320 {
 662                     	switch	.text
 663  007e               f_TIM3_CAP_COM_IRQHandler:
 667                     ; 324 }
 670  007e 80            	iret	
 692                     ; 359 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 692                     ; 360 {
 693                     	switch	.text
 694  007f               f_I2C_IRQHandler:
 698                     ; 364 }
 701  007f 80            	iret	
 724                     ; 372  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 724                     ; 373 {
 725                     	switch	.text
 726  0080               f_UART2_TX_IRQHandler:
 730                     ; 377   }
 733  0080 80            	iret	
 794                     ; 385  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 794                     ; 386 {
 795                     	switch	.text
 796  0081               f_UART2_RX_IRQHandler:
 798  0081 8a            	push	cc
 799  0082 84            	pop	a
 800  0083 a4bf          	and	a,#191
 801  0085 88            	push	a
 802  0086 86            	pop	cc
 803       00000004      OFST:	set	4
 804  0087 3b0002        	push	c_x+2
 805  008a be00          	ldw	x,c_x
 806  008c 89            	pushw	x
 807  008d 3b0002        	push	c_y+2
 808  0090 be00          	ldw	x,c_y
 809  0092 89            	pushw	x
 810  0093 5204          	subw	sp,#4
 813                     ; 388 	buffer[counter] = UART2_ReceiveData8();
 815  0095 b605          	ld	a,_counter
 816  0097 5f            	clrw	x
 817  0098 97            	ld	xl,a
 818  0099 89            	pushw	x
 819  009a cd0000        	call	_UART2_ReceiveData8
 821  009d 85            	popw	x
 822  009e e71a          	ld	(_buffer,x),a
 823                     ; 390 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 825  00a0 5f            	clrw	x
 826  00a1 b605          	ld	a,_counter
 827  00a3 97            	ld	xl,a
 828  00a4 e61a          	ld	a,(_buffer,x)
 829  00a6 a10d          	cp	a,#13
 830  00a8 2604          	jrne	L703
 833  00aa 35010000      	mov	_STATUS_BIT,#1
 834  00ae               L703:
 835                     ; 391 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 837  00ae b605          	ld	a,_counter
 838  00b0 5f            	clrw	x
 839  00b1 97            	ld	xl,a
 840  00b2 e61a          	ld	a,(_buffer,x)
 841  00b4 a10a          	cp	a,#10
 842  00b6 264b          	jrne	L113
 844  00b8 b600          	ld	a,_STATUS_BIT
 845  00ba 4a            	dec	a
 846  00bb 2646          	jrne	L113
 847                     ; 397 	temp[0] = buffer[1];
 849  00bd b61b          	ld	a,_buffer+1
 850  00bf 6b02          	ld	(OFST-2,sp),a
 851                     ; 398 	temp[1] = buffer[2];
 853  00c1 b61c          	ld	a,_buffer+2
 854  00c3 6b03          	ld	(OFST-1,sp),a
 855                     ; 399 	HexToByte(temp, &Addr);
 857  00c5 96            	ldw	x,sp
 858  00c6 5c            	incw	x
 859  00c7 89            	pushw	x
 860  00c8 5c            	incw	x
 861  00c9 cd0000        	call	_HexToByte
 863  00cc 85            	popw	x
 864                     ; 401 		if(Addr == Address || Addr == 0)
 866  00cd 7b01          	ld	a,(OFST-3,sp)
 867  00cf b104          	cp	a,_Address
 868  00d1 2704          	jreq	L513
 870  00d3 7b01          	ld	a,(OFST-3,sp)
 871  00d5 2619          	jrne	L313
 872  00d7               L513:
 873                     ; 404 			for(i = 0; i<20; i++)
 875  00d7 4f            	clr	a
 876  00d8 6b04          	ld	(OFST+0,sp),a
 877  00da               L713:
 878                     ; 406 			word[i] = buffer[i];
 880  00da 5f            	clrw	x
 881  00db 97            	ld	xl,a
 882  00dc e61a          	ld	a,(_buffer,x)
 883  00de e706          	ld	(_word,x),a
 884                     ; 407 			buffer[i] = '\0';	
 886  00e0 5f            	clrw	x
 887  00e1 7b04          	ld	a,(OFST+0,sp)
 888  00e3 97            	ld	xl,a
 889  00e4 6f1a          	clr	(_buffer,x)
 890                     ; 404 			for(i = 0; i<20; i++)
 892  00e6 0c04          	inc	(OFST+0,sp)
 895  00e8 7b04          	ld	a,(OFST+0,sp)
 896  00ea a114          	cp	a,#20
 897  00ec 25ec          	jrult	L713
 898                     ; 409 			counter = 0;
 900  00ee 200f          	jpf	LC001
 901  00f0               L313:
 902                     ; 414 			for(i = 0; i<20; i++)
 904  00f0 4f            	clr	a
 905  00f1 6b04          	ld	(OFST+0,sp),a
 906  00f3               L723:
 907                     ; 416 			buffer[i] = '\0';	
 909  00f3 5f            	clrw	x
 910  00f4 97            	ld	xl,a
 911  00f5 6f1a          	clr	(_buffer,x)
 912                     ; 414 			for(i = 0; i<20; i++)
 914  00f7 0c04          	inc	(OFST+0,sp)
 917  00f9 7b04          	ld	a,(OFST+0,sp)
 918  00fb a114          	cp	a,#20
 919  00fd 25f4          	jrult	L723
 920                     ; 418 			counter = 0;
 922  00ff               LC001:
 924  00ff 3f05          	clr	_counter
 925  0101 2002          	jra	L533
 926  0103               L113:
 927                     ; 424 	counter++;
 929  0103 3c05          	inc	_counter
 930  0105               L533:
 931                     ; 427 	UART2_ClearITPendingBit(UART2_IT_RXNE);
 933  0105 ae0255        	ldw	x,#597
 934  0108 cd0000        	call	_UART2_ClearITPendingBit
 936                     ; 428 }
 939  010b 5b04          	addw	sp,#4
 940  010d 85            	popw	x
 941  010e bf00          	ldw	c_y,x
 942  0110 320002        	pop	c_y+2
 943  0113 85            	popw	x
 944  0114 bf00          	ldw	c_x,x
 945  0116 320002        	pop	c_x+2
 946  0119 80            	iret	
 968                     ; 476  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 968                     ; 477 {
 969                     	switch	.text
 970  011a               f_ADC1_IRQHandler:
 974                     ; 482 }
 977  011a 80            	iret	
1000                     ; 503  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1000                     ; 504 {
1001                     	switch	.text
1002  011b               f_TIM4_UPD_OVF_IRQHandler:
1006                     ; 508 }
1009  011b 80            	iret	
1032                     ; 516 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1032                     ; 517 {
1033                     	switch	.text
1034  011c               f_EEPROM_EEC_IRQHandler:
1038                     ; 521 }
1041  011c 80            	iret	
1111                     	switch	.ubsct
1112  0000               _TimmingDelay:
1113  0000 00000000      	ds.b	4
1114                     	xdef	_TimmingDelay
1115  0004               _Address:
1116  0004 00            	ds.b	1
1117                     	xdef	_Address
1118                     	xdef	_STATUS_BIT
1119  0005               _counter:
1120  0005 00            	ds.b	1
1121                     	xdef	_counter
1122  0006               _word:
1123  0006 000000000000  	ds.b	20
1124                     	xdef	_word
1125  001a               _buffer:
1126  001a 000000000000  	ds.b	20
1127                     	xdef	_buffer
1128                     	xref	_UART_SendStr
1129                     	xref	_HexToByte
1130                     	xdef	f_EEPROM_EEC_IRQHandler
1131                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1132                     	xdef	f_ADC1_IRQHandler
1133                     	xdef	f_UART2_TX_IRQHandler
1134                     	xdef	f_UART2_RX_IRQHandler
1135                     	xdef	f_I2C_IRQHandler
1136                     	xdef	f_TIM3_CAP_COM_IRQHandler
1137                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1138                     	xdef	f_TIM2_CAP_COM_IRQHandler
1139                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1140                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1141                     	xdef	f_TIM1_CAP_COM_IRQHandler
1142                     	xdef	f_SPI_IRQHandler
1143                     	xdef	f_EXTI_PORTE_IRQHandler
1144                     	xdef	f_EXTI_PORTD_IRQHandler
1145                     	xdef	f_EXTI_PORTC_IRQHandler
1146                     	xdef	f_EXTI_PORTB_IRQHandler
1147                     	xdef	f_EXTI_PORTA_IRQHandler
1148                     	xdef	f_CLK_IRQHandler
1149                     	xdef	f_AWU_IRQHandler
1150                     	xdef	f_TLI_IRQHandler
1151                     	xdef	f_TRAP_IRQHandler
1152                     	xdef	f_NonHandledInterrupt
1153                     	xref	_UART2_ClearITPendingBit
1154                     	xref	_UART2_ReceiveData8
1155                     	xref	_TIM3_ClearITPendingBit
1156                     	xref	_TIM2_ClearITPendingBit
1157                     	xref.b	c_x
1158                     	xref.b	c_y
1178                     	xref	c_lgsbc
1179                     	xref	c_lzmp
1180                     	end
