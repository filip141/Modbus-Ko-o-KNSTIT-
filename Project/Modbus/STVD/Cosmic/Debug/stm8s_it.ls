   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 65 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 66 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 70 }
  60  0000 80            	iret	
  82                     ; 78 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 79 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 83 }
  91  0001 80            	iret	
 113                     ; 89 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 90 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 94 }
 122  0002 80            	iret	
 144                     ; 101 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 102 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 106 }
 153  0003 80            	iret	
 175                     ; 113 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 114 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 118 }
 184  0004 80            	iret	
 207                     ; 125 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 126 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 130 }
 216  0005 80            	iret	
 239                     ; 137 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 138 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 142 }
 248  0006 80            	iret	
 271                     ; 149 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 150 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 154 }
 280  0007 80            	iret	
 303                     ; 161 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 162 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 166 }
 312  0008 80            	iret	
 335                     ; 173 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 174 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 178 }
 344  0009 80            	iret	
 366                     ; 224 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 225 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 229 }
 375  000a 80            	iret	
 398                     ; 236 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 237 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 241 }
 407  000b 80            	iret	
 430                     ; 248 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 249 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 253 }
 439  000c 80            	iret	
 503                     ; 287  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 503                     ; 288 {
 504                     	switch	.text
 505  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 507  000d 8a            	push	cc
 508  000e 84            	pop	a
 509  000f a4bf          	and	a,#191
 510  0011 88            	push	a
 511  0012 86            	pop	cc
 512       00000004      OFST:	set	4
 513  0013 3b0002        	push	c_x+2
 514  0016 be00          	ldw	x,c_x
 515  0018 89            	pushw	x
 516  0019 3b0002        	push	c_y+2
 517  001c be00          	ldw	x,c_y
 518  001e 89            	pushw	x
 519  001f 5204          	subw	sp,#4
 522                     ; 293 	if(word[0] != '\0')
 524  0021 b606          	ld	a,_word
 525  0023 2604acaa00aa  	jreq	L722
 526                     ; 297 		tmp[0] = word[3];
 528  0029 b609          	ld	a,_word+3
 529  002b 6b01          	ld	(OFST-3,sp),a
 530                     ; 298 		tmp[1] = word[4];
 532  002d b60a          	ld	a,_word+4
 533  002f 6b02          	ld	(OFST-2,sp),a
 534                     ; 299 		HexToByte(tmp, &FunC);
 536  0031 96            	ldw	x,sp
 537  0032 1c0003        	addw	x,#OFST-1
 538  0035 89            	pushw	x
 539  0036 1d0002        	subw	x,#2
 540  0039 cd0000        	call	_HexToByte
 542  003c 85            	popw	x
 543                     ; 301 		if(__checkFunc(FunC))
 545  003d 7b03          	ld	a,(OFST-1,sp)
 546  003f cd0000        	call	___checkFunc
 548  0042 4d            	tnz	a
 549  0043 2756          	jreq	L132
 550                     ; 304 			switch (FunC) 
 552  0045 7b03          	ld	a,(OFST-1,sp)
 554                     ; 342 			default: 
 554                     ; 343 				break;
 555  0047 4a            	dec	a
 556  0048 2715          	jreq	L161
 557  004a 4a            	dec	a
 558  004b 2717          	jreq	L361
 559  004d 4a            	dec	a
 560  004e 2719          	jreq	L561
 561  0050 4a            	dec	a
 562  0051 2721          	jreq	L761
 563  0053 4a            	dec	a
 564  0054 2729          	jreq	L171
 565  0056 4a            	dec	a
 566  0057 2731          	jreq	L371
 567  0059 a00a          	sub	a,#10
 568  005b 2738          	jreq	L571
 569  005d 203c          	jra	L132
 570  005f               L161:
 571                     ; 306 			case 1:
 571                     ; 307 				//Function 1
 571                     ; 308 				ReadCoilStatus();
 573  005f cd0000        	call	_ReadCoilStatus
 575                     ; 309 				break;
 577  0062 2037          	jra	L132
 578  0064               L361:
 579                     ; 310 			case 2:
 579                     ; 311 				//Function 2
 579                     ; 312 				ReadInputStatus();
 581  0064 cd0000        	call	_ReadInputStatus
 583                     ; 313 				break;
 585  0067 2032          	jra	L132
 586  0069               L561:
 587                     ; 314 			case 3: 
 587                     ; 315 				//Function 3
 587                     ; 316 				UART_SendStr("Function 3 Handled");
 589  0069 ae004d        	ldw	x,#L732
 590  006c cd0000        	call	_UART_SendStr
 592                     ; 317 				ReadHoldingRegisters();
 594  006f cd0000        	call	_ReadHoldingRegisters
 596                     ; 318 				break;
 598  0072 2027          	jra	L132
 599  0074               L761:
 600                     ; 320 			case 4: 
 600                     ; 321 				//Function 4
 600                     ; 322 				UART_SendStr("Function 4 Handled");
 602  0074 ae003a        	ldw	x,#L142
 603  0077 cd0000        	call	_UART_SendStr
 605                     ; 323 				ReadInputRegisters();
 607  007a cd0000        	call	_ReadInputRegisters
 609                     ; 325 				break;
 611  007d 201c          	jra	L132
 612  007f               L171:
 613                     ; 326 			case 5: 
 613                     ; 327 				//Function 5
 613                     ; 328 				UART_SendStr("Function 5 Handled");
 615  007f ae0027        	ldw	x,#L342
 616  0082 cd0000        	call	_UART_SendStr
 618                     ; 329 				ForceSingleCoil();
 620  0085 cd0000        	call	_ForceSingleCoil
 622                     ; 330 				break;
 624  0088 2011          	jra	L132
 625  008a               L371:
 626                     ; 332 			case 6:
 626                     ; 333 				//Function 6
 626                     ; 334 				UART_SendStr("Function 6 Handled");
 628  008a ae0014        	ldw	x,#L542
 629  008d cd0000        	call	_UART_SendStr
 631                     ; 335 				PresetSingleRegister();
 633  0090 cd0000        	call	_PresetSingleRegister
 635                     ; 336 				break;
 637  0093 2006          	jra	L132
 638  0095               L571:
 639                     ; 338 			case 16:
 639                     ; 339 				//Function 16
 639                     ; 340 				UART_SendStr("Function 16 Handled");
 641  0095 ae0000        	ldw	x,#L742
 642  0098 cd0000        	call	_UART_SendStr
 644                     ; 341 				break;
 646                     ; 342 			default: 
 646                     ; 343 				break;
 648  009b               L132:
 649                     ; 346 		for(i = 0; i<20; i++){word[i] = '\0';}
 651  009b 4f            	clr	a
 652  009c 6b04          	ld	(OFST+0,sp),a
 653  009e               L152:
 656  009e 5f            	clrw	x
 657  009f 97            	ld	xl,a
 658  00a0 6f06          	clr	(_word,x)
 661  00a2 0c04          	inc	(OFST+0,sp)
 664  00a4 7b04          	ld	a,(OFST+0,sp)
 665  00a6 a114          	cp	a,#20
 666  00a8 25f4          	jrult	L152
 667  00aa               L722:
 668                     ; 348   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 670  00aa a601          	ld	a,#1
 671  00ac cd0000        	call	_TIM2_ClearITPendingBit
 673                     ; 349 }
 676  00af 5b04          	addw	sp,#4
 677  00b1 85            	popw	x
 678  00b2 bf00          	ldw	c_y,x
 679  00b4 320002        	pop	c_y+2
 680  00b7 85            	popw	x
 681  00b8 bf00          	ldw	c_x,x
 682  00ba 320002        	pop	c_x+2
 683  00bd 80            	iret	
 706                     ; 356  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 706                     ; 357 {
 707                     	switch	.text
 708  00be               f_TIM2_CAP_COM_IRQHandler:
 712                     ; 361 }
 715  00be 80            	iret	
 740                     ; 371  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 740                     ; 372 {
 741                     	switch	.text
 742  00bf               f_TIM3_UPD_OVF_BRK_IRQHandler:
 744  00bf 8a            	push	cc
 745  00c0 84            	pop	a
 746  00c1 a4bf          	and	a,#191
 747  00c3 88            	push	a
 748  00c4 86            	pop	cc
 749  00c5 3b0002        	push	c_x+2
 750  00c8 be00          	ldw	x,c_x
 751  00ca 89            	pushw	x
 752  00cb 3b0002        	push	c_y+2
 753  00ce be00          	ldw	x,c_y
 754  00d0 89            	pushw	x
 757                     ; 374 	if(TimmingDelay !=0)
 759  00d1 ae0000        	ldw	x,#_TimmingDelay
 760  00d4 cd0000        	call	c_lzmp
 762  00d7 2705          	jreq	L772
 763                     ; 376 		TimmingDelay--;
 765  00d9 a601          	ld	a,#1
 766  00db cd0000        	call	c_lgsbc
 768  00de               L772:
 769                     ; 378 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 771  00de a601          	ld	a,#1
 772  00e0 cd0000        	call	_TIM3_ClearITPendingBit
 774                     ; 379 }
 777  00e3 85            	popw	x
 778  00e4 bf00          	ldw	c_y,x
 779  00e6 320002        	pop	c_y+2
 780  00e9 85            	popw	x
 781  00ea bf00          	ldw	c_x,x
 782  00ec 320002        	pop	c_x+2
 783  00ef 80            	iret	
 806                     ; 386  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 806                     ; 387 {
 807                     	switch	.text
 808  00f0               f_TIM3_CAP_COM_IRQHandler:
 812                     ; 391 }
 815  00f0 80            	iret	
 837                     ; 426 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 837                     ; 427 {
 838                     	switch	.text
 839  00f1               f_I2C_IRQHandler:
 843                     ; 431 }
 846  00f1 80            	iret	
 869                     ; 439  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 869                     ; 440 {
 870                     	switch	.text
 871  00f2               f_UART2_TX_IRQHandler:
 875                     ; 444   }
 878  00f2 80            	iret	
 939                     ; 452  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 939                     ; 453 {
 940                     	switch	.text
 941  00f3               f_UART2_RX_IRQHandler:
 943  00f3 8a            	push	cc
 944  00f4 84            	pop	a
 945  00f5 a4bf          	and	a,#191
 946  00f7 88            	push	a
 947  00f8 86            	pop	cc
 948       00000004      OFST:	set	4
 949  00f9 3b0002        	push	c_x+2
 950  00fc be00          	ldw	x,c_x
 951  00fe 89            	pushw	x
 952  00ff 3b0002        	push	c_y+2
 953  0102 be00          	ldw	x,c_y
 954  0104 89            	pushw	x
 955  0105 5204          	subw	sp,#4
 958                     ; 455 	buffer[counter] = UART2_ReceiveData8();
 960  0107 b605          	ld	a,_counter
 961  0109 5f            	clrw	x
 962  010a 97            	ld	xl,a
 963  010b 89            	pushw	x
 964  010c cd0000        	call	_UART2_ReceiveData8
 966  010f 85            	popw	x
 967  0110 e71a          	ld	(_buffer,x),a
 968                     ; 457 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 970  0112 5f            	clrw	x
 971  0113 b605          	ld	a,_counter
 972  0115 97            	ld	xl,a
 973  0116 e61a          	ld	a,(_buffer,x)
 974  0118 a10d          	cp	a,#13
 975  011a 2604          	jrne	L753
 978  011c 35010000      	mov	_STATUS_BIT,#1
 979  0120               L753:
 980                     ; 458 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 982  0120 b605          	ld	a,_counter
 983  0122 5f            	clrw	x
 984  0123 97            	ld	xl,a
 985  0124 e61a          	ld	a,(_buffer,x)
 986  0126 a10a          	cp	a,#10
 987  0128 264b          	jrne	L163
 989  012a b600          	ld	a,_STATUS_BIT
 990  012c 4a            	dec	a
 991  012d 2646          	jrne	L163
 992                     ; 464 	temp[0] = buffer[1];
 994  012f b61b          	ld	a,_buffer+1
 995  0131 6b02          	ld	(OFST-2,sp),a
 996                     ; 465 	temp[1] = buffer[2];
 998  0133 b61c          	ld	a,_buffer+2
 999  0135 6b03          	ld	(OFST-1,sp),a
1000                     ; 466 	HexToByte(temp, &Addr);
1002  0137 96            	ldw	x,sp
1003  0138 5c            	incw	x
1004  0139 89            	pushw	x
1005  013a 5c            	incw	x
1006  013b cd0000        	call	_HexToByte
1008  013e 85            	popw	x
1009                     ; 468 		if(Addr == Address || Addr == 0)
1011  013f 7b01          	ld	a,(OFST-3,sp)
1012  0141 b104          	cp	a,_Address
1013  0143 2704          	jreq	L563
1015  0145 7b01          	ld	a,(OFST-3,sp)
1016  0147 2619          	jrne	L363
1017  0149               L563:
1018                     ; 471 			for(i = 0; i<20; i++)
1020  0149 4f            	clr	a
1021  014a 6b04          	ld	(OFST+0,sp),a
1022  014c               L763:
1023                     ; 473 			word[i] = buffer[i];
1025  014c 5f            	clrw	x
1026  014d 97            	ld	xl,a
1027  014e e61a          	ld	a,(_buffer,x)
1028  0150 e706          	ld	(_word,x),a
1029                     ; 474 			buffer[i] = '\0';	
1031  0152 5f            	clrw	x
1032  0153 7b04          	ld	a,(OFST+0,sp)
1033  0155 97            	ld	xl,a
1034  0156 6f1a          	clr	(_buffer,x)
1035                     ; 471 			for(i = 0; i<20; i++)
1037  0158 0c04          	inc	(OFST+0,sp)
1040  015a 7b04          	ld	a,(OFST+0,sp)
1041  015c a114          	cp	a,#20
1042  015e 25ec          	jrult	L763
1043                     ; 476 			counter = 0;
1045  0160 200f          	jpf	LC001
1046  0162               L363:
1047                     ; 481 			for(i = 0; i<20; i++)
1049  0162 4f            	clr	a
1050  0163 6b04          	ld	(OFST+0,sp),a
1051  0165               L773:
1052                     ; 483 			buffer[i] = '\0';	
1054  0165 5f            	clrw	x
1055  0166 97            	ld	xl,a
1056  0167 6f1a          	clr	(_buffer,x)
1057                     ; 481 			for(i = 0; i<20; i++)
1059  0169 0c04          	inc	(OFST+0,sp)
1062  016b 7b04          	ld	a,(OFST+0,sp)
1063  016d a114          	cp	a,#20
1064  016f 25f4          	jrult	L773
1065                     ; 485 			counter = 0;
1067  0171               LC001:
1069  0171 3f05          	clr	_counter
1070  0173 2002          	jra	L504
1071  0175               L163:
1072                     ; 491 	counter++;
1074  0175 3c05          	inc	_counter
1075  0177               L504:
1076                     ; 494 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1078  0177 ae0255        	ldw	x,#597
1079  017a cd0000        	call	_UART2_ClearITPendingBit
1081                     ; 495 }
1084  017d 5b04          	addw	sp,#4
1085  017f 85            	popw	x
1086  0180 bf00          	ldw	c_y,x
1087  0182 320002        	pop	c_y+2
1088  0185 85            	popw	x
1089  0186 bf00          	ldw	c_x,x
1090  0188 320002        	pop	c_x+2
1091  018b 80            	iret	
1113                     ; 543  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1113                     ; 544 {
1114                     	switch	.text
1115  018c               f_ADC1_IRQHandler:
1119                     ; 549 }
1122  018c 80            	iret	
1145                     ; 570  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1145                     ; 571 {
1146                     	switch	.text
1147  018d               f_TIM4_UPD_OVF_IRQHandler:
1151                     ; 575 }
1154  018d 80            	iret	
1177                     ; 583 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1177                     ; 584 {
1178                     	switch	.text
1179  018e               f_EEPROM_EEC_IRQHandler:
1183                     ; 588 }
1186  018e 80            	iret	
1256                     	switch	.ubsct
1257  0000               _TimmingDelay:
1258  0000 00000000      	ds.b	4
1259                     	xdef	_TimmingDelay
1260  0004               _Address:
1261  0004 00            	ds.b	1
1262                     	xdef	_Address
1263                     	xdef	_STATUS_BIT
1264  0005               _counter:
1265  0005 00            	ds.b	1
1266                     	xdef	_counter
1267  0006               _word:
1268  0006 000000000000  	ds.b	20
1269                     	xdef	_word
1270  001a               _buffer:
1271  001a 000000000000  	ds.b	20
1272                     	xdef	_buffer
1273                     	xref	_PresetSingleRegister
1274                     	xref	_ForceSingleCoil
1275                     	xref	_ReadInputRegisters
1276                     	xref	_ReadHoldingRegisters
1277                     	xref	_ReadInputStatus
1278                     	xref	_ReadCoilStatus
1279                     	xref	___checkFunc
1280                     	xref	_UART_SendStr
1281                     	xref	_HexToByte
1282                     	xdef	f_EEPROM_EEC_IRQHandler
1283                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1284                     	xdef	f_ADC1_IRQHandler
1285                     	xdef	f_UART2_TX_IRQHandler
1286                     	xdef	f_UART2_RX_IRQHandler
1287                     	xdef	f_I2C_IRQHandler
1288                     	xdef	f_TIM3_CAP_COM_IRQHandler
1289                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1290                     	xdef	f_TIM2_CAP_COM_IRQHandler
1291                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1292                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1293                     	xdef	f_TIM1_CAP_COM_IRQHandler
1294                     	xdef	f_SPI_IRQHandler
1295                     	xdef	f_EXTI_PORTE_IRQHandler
1296                     	xdef	f_EXTI_PORTD_IRQHandler
1297                     	xdef	f_EXTI_PORTC_IRQHandler
1298                     	xdef	f_EXTI_PORTB_IRQHandler
1299                     	xdef	f_EXTI_PORTA_IRQHandler
1300                     	xdef	f_CLK_IRQHandler
1301                     	xdef	f_AWU_IRQHandler
1302                     	xdef	f_TLI_IRQHandler
1303                     	xdef	f_TRAP_IRQHandler
1304                     	xdef	f_NonHandledInterrupt
1305                     	xref	_UART2_ClearITPendingBit
1306                     	xref	_UART2_ReceiveData8
1307                     	xref	_TIM3_ClearITPendingBit
1308                     	xref	_TIM2_ClearITPendingBit
1309                     .const:	section	.text
1310  0000               L742:
1311  0000 46756e637469  	dc.b	"Function 16 Handle"
1312  0012 6400          	dc.b	"d",0
1313  0014               L542:
1314  0014 46756e637469  	dc.b	"Function 6 Handled",0
1315  0027               L342:
1316  0027 46756e637469  	dc.b	"Function 5 Handled",0
1317  003a               L142:
1318  003a 46756e637469  	dc.b	"Function 4 Handled",0
1319  004d               L732:
1320  004d 46756e637469  	dc.b	"Function 3 Handled",0
1321                     	xref.b	c_x
1322                     	xref.b	c_y
1342                     	xref	c_lgsbc
1343                     	xref	c_lzmp
1344                     	end
