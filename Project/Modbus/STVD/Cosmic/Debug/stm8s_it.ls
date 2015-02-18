   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 54 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 55 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 59 }
  60  0000 80            	iret	
  82                     ; 67 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 68 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 72 }
  91  0001 80            	iret	
 113                     ; 78 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 79 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 83 }
 122  0002 80            	iret	
 144                     ; 90 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 91 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 95 }
 153  0003 80            	iret	
 175                     ; 102 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 103 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 107 }
 184  0004 80            	iret	
 207                     ; 114 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 115 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 119 }
 216  0005 80            	iret	
 239                     ; 126 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 127 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 131 }
 248  0006 80            	iret	
 271                     ; 138 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 139 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 143 }
 280  0007 80            	iret	
 303                     ; 150 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 151 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 155 }
 312  0008 80            	iret	
 335                     ; 162 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 163 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 167 }
 344  0009 80            	iret	
 366                     ; 213 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 214 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 218 }
 375  000a 80            	iret	
 398                     ; 225 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 226 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 230 }
 407  000b 80            	iret	
 430                     ; 237 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 238 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 242 }
 439  000c 80            	iret	
 497                     ; 276  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 497                     ; 277 {
 498                     	switch	.text
 499  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 501  000d 8a            	push	cc
 502  000e 84            	pop	a
 503  000f a4bf          	and	a,#191
 504  0011 88            	push	a
 505  0012 86            	pop	cc
 506       00000004      OFST:	set	4
 507  0013 3b0002        	push	c_x+2
 508  0016 be00          	ldw	x,c_x
 509  0018 89            	pushw	x
 510  0019 3b0002        	push	c_y+2
 511  001c be00          	ldw	x,c_y
 512  001e 89            	pushw	x
 513  001f 5204          	subw	sp,#4
 516                     ; 282 	if(word[0] != '\0')
 518  0021 b606          	ld	a,_word
 519  0023 2762          	jreq	L522
 520                     ; 286 		tmp[0] = word[3];
 522  0025 b609          	ld	a,_word+3
 523  0027 6b01          	ld	(OFST-3,sp),a
 524                     ; 287 		tmp[1] = word[4];
 526  0029 b60a          	ld	a,_word+4
 527  002b 6b02          	ld	(OFST-2,sp),a
 528                     ; 288 		HexToByte(tmp, &FunC);
 530  002d 96            	ldw	x,sp
 531  002e 1c0003        	addw	x,#OFST-1
 532  0031 89            	pushw	x
 533  0032 1d0002        	subw	x,#2
 534  0035 cd0000        	call	_HexToByte
 536  0038 85            	popw	x
 537                     ; 290 		if(__checkFunc(FunC))
 539  0039 7b03          	ld	a,(OFST-1,sp)
 540  003b cd0000        	call	___checkFunc
 542  003e 4d            	tnz	a
 543  003f 2737          	jreq	L722
 544                     ; 293 			switch (FunC) 
 546  0041 7b03          	ld	a,(OFST-1,sp)
 548                     ; 319 			default: 
 548                     ; 320 				break;
 549  0043 4a            	dec	a
 550  0044 2713          	jreq	L161
 551  0046 4a            	dec	a
 552  0047 2715          	jreq	L361
 553  0049 4a            	dec	a
 554  004a 2717          	jreq	L561
 555  004c a002          	sub	a,#2
 556  004e 2718          	jreq	L761
 557  0050 4a            	dec	a
 558  0051 271a          	jreq	L171
 559  0053 a00a          	sub	a,#10
 560  0055 271b          	jreq	L371
 561  0057 201f          	jra	L722
 562  0059               L161:
 563                     ; 295 			case 1:
 563                     ; 296 				//Function 1
 563                     ; 297 				UART_SendStr("Function 1 Handled");
 565  0059 ae0060        	ldw	x,#L532
 567                     ; 298 				break;
 569  005c 2017          	jpf	LC001
 570  005e               L361:
 571                     ; 299 			case 2:
 571                     ; 300 				//Function 2
 571                     ; 301 				UART_SendStr("Function 2 Handled");
 573  005e ae004d        	ldw	x,#L732
 575                     ; 302 				break;
 577  0061 2012          	jpf	LC001
 578  0063               L561:
 579                     ; 303 			case 3: 
 579                     ; 304 				//Function 3
 579                     ; 305 				UART_SendStr("Function 3 Handled");
 581  0063 ae003a        	ldw	x,#L142
 583                     ; 306 				break;
 585  0066 200d          	jpf	LC001
 586  0068               L761:
 587                     ; 307 			case 5: 
 587                     ; 308 				//Function 5
 587                     ; 309 				UART_SendStr("Function 5 Handled");
 589  0068 ae0027        	ldw	x,#L342
 591                     ; 310 				break;
 593  006b 2008          	jpf	LC001
 594  006d               L171:
 595                     ; 311 			case 6: 
 595                     ; 312 				//Function 6
 595                     ; 313 				UART_SendStr("Function 6 Handled");
 597  006d ae0014        	ldw	x,#L542
 599                     ; 314 				break;
 601  0070 2003          	jpf	LC001
 602  0072               L371:
 603                     ; 315 			case 16:
 603                     ; 316 				//Function 16
 603                     ; 317 				UART_SendStr("Function 16 Handled");
 605  0072 ae0000        	ldw	x,#L742
 606  0075               LC001:
 607  0075 cd0000        	call	_UART_SendStr
 609                     ; 318 				break;
 611                     ; 319 			default: 
 611                     ; 320 				break;
 613  0078               L722:
 614                     ; 323 		for(i = 0; i<20; i++){word[i] = '\0';}
 616  0078 4f            	clr	a
 617  0079 6b04          	ld	(OFST+0,sp),a
 618  007b               L152:
 621  007b 5f            	clrw	x
 622  007c 97            	ld	xl,a
 623  007d 6f06          	clr	(_word,x)
 626  007f 0c04          	inc	(OFST+0,sp)
 629  0081 7b04          	ld	a,(OFST+0,sp)
 630  0083 a114          	cp	a,#20
 631  0085 25f4          	jrult	L152
 632  0087               L522:
 633                     ; 325   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 635  0087 a601          	ld	a,#1
 636  0089 cd0000        	call	_TIM2_ClearITPendingBit
 638                     ; 326 }
 641  008c 5b04          	addw	sp,#4
 642  008e 85            	popw	x
 643  008f bf00          	ldw	c_y,x
 644  0091 320002        	pop	c_y+2
 645  0094 85            	popw	x
 646  0095 bf00          	ldw	c_x,x
 647  0097 320002        	pop	c_x+2
 648  009a 80            	iret	
 671                     ; 333  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 671                     ; 334 {
 672                     	switch	.text
 673  009b               f_TIM2_CAP_COM_IRQHandler:
 677                     ; 338 }
 680  009b 80            	iret	
 705                     ; 348  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 705                     ; 349 {
 706                     	switch	.text
 707  009c               f_TIM3_UPD_OVF_BRK_IRQHandler:
 709  009c 8a            	push	cc
 710  009d 84            	pop	a
 711  009e a4bf          	and	a,#191
 712  00a0 88            	push	a
 713  00a1 86            	pop	cc
 714  00a2 3b0002        	push	c_x+2
 715  00a5 be00          	ldw	x,c_x
 716  00a7 89            	pushw	x
 717  00a8 3b0002        	push	c_y+2
 718  00ab be00          	ldw	x,c_y
 719  00ad 89            	pushw	x
 722                     ; 351 	if(TimmingDelay !=0)
 724  00ae ae0000        	ldw	x,#_TimmingDelay
 725  00b1 cd0000        	call	c_lzmp
 727  00b4 2705          	jreq	L772
 728                     ; 353 		TimmingDelay--;
 730  00b6 a601          	ld	a,#1
 731  00b8 cd0000        	call	c_lgsbc
 733  00bb               L772:
 734                     ; 355 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 736  00bb a601          	ld	a,#1
 737  00bd cd0000        	call	_TIM3_ClearITPendingBit
 739                     ; 356 }
 742  00c0 85            	popw	x
 743  00c1 bf00          	ldw	c_y,x
 744  00c3 320002        	pop	c_y+2
 745  00c6 85            	popw	x
 746  00c7 bf00          	ldw	c_x,x
 747  00c9 320002        	pop	c_x+2
 748  00cc 80            	iret	
 771                     ; 363  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 771                     ; 364 {
 772                     	switch	.text
 773  00cd               f_TIM3_CAP_COM_IRQHandler:
 777                     ; 368 }
 780  00cd 80            	iret	
 802                     ; 403 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 802                     ; 404 {
 803                     	switch	.text
 804  00ce               f_I2C_IRQHandler:
 808                     ; 408 }
 811  00ce 80            	iret	
 834                     ; 416  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 834                     ; 417 {
 835                     	switch	.text
 836  00cf               f_UART2_TX_IRQHandler:
 840                     ; 421   }
 843  00cf 80            	iret	
 904                     ; 429  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 904                     ; 430 {
 905                     	switch	.text
 906  00d0               f_UART2_RX_IRQHandler:
 908  00d0 8a            	push	cc
 909  00d1 84            	pop	a
 910  00d2 a4bf          	and	a,#191
 911  00d4 88            	push	a
 912  00d5 86            	pop	cc
 913       00000004      OFST:	set	4
 914  00d6 3b0002        	push	c_x+2
 915  00d9 be00          	ldw	x,c_x
 916  00db 89            	pushw	x
 917  00dc 3b0002        	push	c_y+2
 918  00df be00          	ldw	x,c_y
 919  00e1 89            	pushw	x
 920  00e2 5204          	subw	sp,#4
 923                     ; 432 	buffer[counter] = UART2_ReceiveData8();
 925  00e4 b605          	ld	a,_counter
 926  00e6 5f            	clrw	x
 927  00e7 97            	ld	xl,a
 928  00e8 89            	pushw	x
 929  00e9 cd0000        	call	_UART2_ReceiveData8
 931  00ec 85            	popw	x
 932  00ed e71a          	ld	(_buffer,x),a
 933                     ; 434 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 935  00ef 5f            	clrw	x
 936  00f0 b605          	ld	a,_counter
 937  00f2 97            	ld	xl,a
 938  00f3 e61a          	ld	a,(_buffer,x)
 939  00f5 a10d          	cp	a,#13
 940  00f7 2604          	jrne	L753
 943  00f9 35010000      	mov	_STATUS_BIT,#1
 944  00fd               L753:
 945                     ; 435 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 947  00fd b605          	ld	a,_counter
 948  00ff 5f            	clrw	x
 949  0100 97            	ld	xl,a
 950  0101 e61a          	ld	a,(_buffer,x)
 951  0103 a10a          	cp	a,#10
 952  0105 264b          	jrne	L163
 954  0107 b600          	ld	a,_STATUS_BIT
 955  0109 4a            	dec	a
 956  010a 2646          	jrne	L163
 957                     ; 441 	temp[0] = buffer[1];
 959  010c b61b          	ld	a,_buffer+1
 960  010e 6b02          	ld	(OFST-2,sp),a
 961                     ; 442 	temp[1] = buffer[2];
 963  0110 b61c          	ld	a,_buffer+2
 964  0112 6b03          	ld	(OFST-1,sp),a
 965                     ; 443 	HexToByte(temp, &Addr);
 967  0114 96            	ldw	x,sp
 968  0115 5c            	incw	x
 969  0116 89            	pushw	x
 970  0117 5c            	incw	x
 971  0118 cd0000        	call	_HexToByte
 973  011b 85            	popw	x
 974                     ; 445 		if(Addr == Address || Addr == 0)
 976  011c 7b01          	ld	a,(OFST-3,sp)
 977  011e b104          	cp	a,_Address
 978  0120 2704          	jreq	L563
 980  0122 7b01          	ld	a,(OFST-3,sp)
 981  0124 2619          	jrne	L363
 982  0126               L563:
 983                     ; 448 			for(i = 0; i<20; i++)
 985  0126 4f            	clr	a
 986  0127 6b04          	ld	(OFST+0,sp),a
 987  0129               L763:
 988                     ; 450 			word[i] = buffer[i];
 990  0129 5f            	clrw	x
 991  012a 97            	ld	xl,a
 992  012b e61a          	ld	a,(_buffer,x)
 993  012d e706          	ld	(_word,x),a
 994                     ; 451 			buffer[i] = '\0';	
 996  012f 5f            	clrw	x
 997  0130 7b04          	ld	a,(OFST+0,sp)
 998  0132 97            	ld	xl,a
 999  0133 6f1a          	clr	(_buffer,x)
1000                     ; 448 			for(i = 0; i<20; i++)
1002  0135 0c04          	inc	(OFST+0,sp)
1005  0137 7b04          	ld	a,(OFST+0,sp)
1006  0139 a114          	cp	a,#20
1007  013b 25ec          	jrult	L763
1008                     ; 453 			counter = 0;
1010  013d 200f          	jpf	LC002
1011  013f               L363:
1012                     ; 458 			for(i = 0; i<20; i++)
1014  013f 4f            	clr	a
1015  0140 6b04          	ld	(OFST+0,sp),a
1016  0142               L773:
1017                     ; 460 			buffer[i] = '\0';	
1019  0142 5f            	clrw	x
1020  0143 97            	ld	xl,a
1021  0144 6f1a          	clr	(_buffer,x)
1022                     ; 458 			for(i = 0; i<20; i++)
1024  0146 0c04          	inc	(OFST+0,sp)
1027  0148 7b04          	ld	a,(OFST+0,sp)
1028  014a a114          	cp	a,#20
1029  014c 25f4          	jrult	L773
1030                     ; 462 			counter = 0;
1032  014e               LC002:
1034  014e 3f05          	clr	_counter
1035  0150 2002          	jra	L504
1036  0152               L163:
1037                     ; 468 	counter++;
1039  0152 3c05          	inc	_counter
1040  0154               L504:
1041                     ; 471 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1043  0154 ae0255        	ldw	x,#597
1044  0157 cd0000        	call	_UART2_ClearITPendingBit
1046                     ; 472 }
1049  015a 5b04          	addw	sp,#4
1050  015c 85            	popw	x
1051  015d bf00          	ldw	c_y,x
1052  015f 320002        	pop	c_y+2
1053  0162 85            	popw	x
1054  0163 bf00          	ldw	c_x,x
1055  0165 320002        	pop	c_x+2
1056  0168 80            	iret	
1078                     ; 520  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1078                     ; 521 {
1079                     	switch	.text
1080  0169               f_ADC1_IRQHandler:
1084                     ; 526 }
1087  0169 80            	iret	
1110                     ; 547  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1110                     ; 548 {
1111                     	switch	.text
1112  016a               f_TIM4_UPD_OVF_IRQHandler:
1116                     ; 552 }
1119  016a 80            	iret	
1142                     ; 560 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1142                     ; 561 {
1143                     	switch	.text
1144  016b               f_EEPROM_EEC_IRQHandler:
1148                     ; 565 }
1151  016b 80            	iret	
1221                     	switch	.ubsct
1222  0000               _TimmingDelay:
1223  0000 00000000      	ds.b	4
1224                     	xdef	_TimmingDelay
1225  0004               _Address:
1226  0004 00            	ds.b	1
1227                     	xdef	_Address
1228                     	xdef	_STATUS_BIT
1229  0005               _counter:
1230  0005 00            	ds.b	1
1231                     	xdef	_counter
1232  0006               _word:
1233  0006 000000000000  	ds.b	20
1234                     	xdef	_word
1235  001a               _buffer:
1236  001a 000000000000  	ds.b	20
1237                     	xdef	_buffer
1238                     	xref	___checkFunc
1239                     	xref	_UART_SendStr
1240                     	xref	_HexToByte
1241                     	xdef	f_EEPROM_EEC_IRQHandler
1242                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1243                     	xdef	f_ADC1_IRQHandler
1244                     	xdef	f_UART2_TX_IRQHandler
1245                     	xdef	f_UART2_RX_IRQHandler
1246                     	xdef	f_I2C_IRQHandler
1247                     	xdef	f_TIM3_CAP_COM_IRQHandler
1248                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1249                     	xdef	f_TIM2_CAP_COM_IRQHandler
1250                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1251                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1252                     	xdef	f_TIM1_CAP_COM_IRQHandler
1253                     	xdef	f_SPI_IRQHandler
1254                     	xdef	f_EXTI_PORTE_IRQHandler
1255                     	xdef	f_EXTI_PORTD_IRQHandler
1256                     	xdef	f_EXTI_PORTC_IRQHandler
1257                     	xdef	f_EXTI_PORTB_IRQHandler
1258                     	xdef	f_EXTI_PORTA_IRQHandler
1259                     	xdef	f_CLK_IRQHandler
1260                     	xdef	f_AWU_IRQHandler
1261                     	xdef	f_TLI_IRQHandler
1262                     	xdef	f_TRAP_IRQHandler
1263                     	xdef	f_NonHandledInterrupt
1264                     	xref	_UART2_ClearITPendingBit
1265                     	xref	_UART2_ReceiveData8
1266                     	xref	_TIM3_ClearITPendingBit
1267                     	xref	_TIM2_ClearITPendingBit
1268                     .const:	section	.text
1269  0000               L742:
1270  0000 46756e637469  	dc.b	"Function 16 Handle"
1271  0012 6400          	dc.b	"d",0
1272  0014               L542:
1273  0014 46756e637469  	dc.b	"Function 6 Handled",0
1274  0027               L342:
1275  0027 46756e637469  	dc.b	"Function 5 Handled",0
1276  003a               L142:
1277  003a 46756e637469  	dc.b	"Function 3 Handled",0
1278  004d               L732:
1279  004d 46756e637469  	dc.b	"Function 2 Handled",0
1280  0060               L532:
1281  0060 46756e637469  	dc.b	"Function 1 Handled",0
1282                     	xref.b	c_x
1283                     	xref.b	c_y
1303                     	xref	c_lgsbc
1304                     	xref	c_lzmp
1305                     	end
