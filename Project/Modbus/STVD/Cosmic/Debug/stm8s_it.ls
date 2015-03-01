   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 69 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 70 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 74 }
  60  0000 80            	iret	
  82                     ; 82 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 83 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 87 }
  91  0001 80            	iret	
 113                     ; 93 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 94 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 98 }
 122  0002 80            	iret	
 144                     ; 105 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 106 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 110 }
 153  0003 80            	iret	
 175                     ; 117 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 118 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 122 }
 184  0004 80            	iret	
 207                     ; 129 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 130 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 134 }
 216  0005 80            	iret	
 239                     ; 141 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 142 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 146 }
 248  0006 80            	iret	
 271                     ; 153 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 154 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 158 }
 280  0007 80            	iret	
 303                     ; 165 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 166 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 170 }
 312  0008 80            	iret	
 335                     ; 177 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 178 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 182 }
 344  0009 80            	iret	
 366                     ; 228 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 229 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 233 }
 375  000a 80            	iret	
 398                     ; 240 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 241 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 245 }
 407  000b 80            	iret	
 430                     ; 252 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 253 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 257 }
 439  000c 80            	iret	
 505                     ; 291  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 505                     ; 292 {
 506                     	switch	.text
 507  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 509  000d 8a            	push	cc
 510  000e 84            	pop	a
 511  000f a4bf          	and	a,#191
 512  0011 88            	push	a
 513  0012 86            	pop	cc
 514       00000004      OFST:	set	4
 515  0013 3b0002        	push	c_x+2
 516  0016 be00          	ldw	x,c_x
 517  0018 89            	pushw	x
 518  0019 3b0002        	push	c_y+2
 519  001c be00          	ldw	x,c_y
 520  001e 89            	pushw	x
 521  001f 5204          	subw	sp,#4
 524                     ; 297 	if(word[0] != '\0')
 526  0021 b62e          	ld	a,_word
 527  0023 2604acaa00aa  	jreq	L722
 528                     ; 299 		if (CheckLRC(word))
 530  0029 ae002e        	ldw	x,#_word
 531  002c cd0000        	call	_CheckLRC
 533  002f 4d            	tnz	a
 534  0030 2769          	jreq	L132
 535                     ; 302 		tmp[0] = word[3];
 537  0032 b631          	ld	a,_word+3
 538  0034 6b01          	ld	(OFST-3,sp),a
 539                     ; 303 		tmp[1] = word[4];
 541  0036 b632          	ld	a,_word+4
 542  0038 6b02          	ld	(OFST-2,sp),a
 543                     ; 304 		HexToByte(tmp, &FunC);
 545  003a 96            	ldw	x,sp
 546  003b 1c0003        	addw	x,#OFST-1
 547  003e 89            	pushw	x
 548  003f 1d0002        	subw	x,#2
 549  0042 cd0000        	call	_HexToByte
 551  0045 85            	popw	x
 552                     ; 306 		if(__checkFunc(FunC))
 554  0046 7b03          	ld	a,(OFST-1,sp)
 555  0048 cd0000        	call	___checkFunc
 557  004b 4d            	tnz	a
 558  004c 274d          	jreq	L132
 559                     ; 309 			switch (FunC) 
 561  004e 7b03          	ld	a,(OFST-1,sp)
 563                     ; 345 			default: 
 563                     ; 346 				break;
 564  0050 4a            	dec	a
 565  0051 2715          	jreq	L161
 566  0053 4a            	dec	a
 567  0054 2717          	jreq	L361
 568  0056 4a            	dec	a
 569  0057 2719          	jreq	L561
 570  0059 4a            	dec	a
 571  005a 271e          	jreq	L761
 572  005c 4a            	dec	a
 573  005d 2720          	jreq	L171
 574  005f 4a            	dec	a
 575  0060 2728          	jreq	L371
 576  0062 a00a          	sub	a,#10
 577  0064 272f          	jreq	L571
 578  0066 2033          	jra	L132
 579  0068               L161:
 580                     ; 311 			case 1:
 580                     ; 312 				//Function 1
 580                     ; 313 				ReadCoilStatus();
 582  0068 cd0000        	call	_ReadCoilStatus
 584                     ; 314 				break;
 586  006b 202e          	jra	L132
 587  006d               L361:
 588                     ; 315 			case 2:
 588                     ; 316 				//Function 2
 588                     ; 317 				ReadInputStatus();
 590  006d cd0000        	call	_ReadInputStatus
 592                     ; 318 				break;
 594  0070 2029          	jra	L132
 595  0072               L561:
 596                     ; 319 			case 3: 
 596                     ; 320 				//Function 3
 596                     ; 321 				ReadHoldingRegisters(Output_Registers);
 598  0072 ae0004        	ldw	x,#_Output_Registers
 599  0075 cd0000        	call	_ReadHoldingRegisters
 601                     ; 322 				break;
 603  0078 2021          	jra	L132
 604  007a               L761:
 605                     ; 324 			case 4: 
 605                     ; 325 				//Function 4
 605                     ; 326 				ReadInputRegisters();
 607  007a cd0000        	call	_ReadInputRegisters
 609                     ; 328 				break;
 611  007d 201c          	jra	L132
 612  007f               L171:
 613                     ; 329 			case 5: 
 613                     ; 330 				//Function 5
 613                     ; 331 				UART_SendStr("Function 5 Handled");
 615  007f ae0027        	ldw	x,#L142
 616  0082 cd0000        	call	_UART_SendStr
 618                     ; 332 				ForceSingleCoil();
 620  0085 cd0000        	call	_ForceSingleCoil
 622                     ; 333 				break;
 624  0088 2011          	jra	L132
 625  008a               L371:
 626                     ; 335 			case 6:
 626                     ; 336 				//Function 6
 626                     ; 337 				UART_SendStr("Function 6 Handled");
 628  008a ae0014        	ldw	x,#L342
 629  008d cd0000        	call	_UART_SendStr
 631                     ; 338 				PresetSingleRegister();
 633  0090 cd0000        	call	_PresetSingleRegister
 635                     ; 339 				break;
 637  0093 2006          	jra	L132
 638  0095               L571:
 639                     ; 341 			case 16:
 639                     ; 342 				//Function 16
 639                     ; 343 				UART_SendStr("Function 16 Handled");
 641  0095 ae0000        	ldw	x,#L542
 642  0098 cd0000        	call	_UART_SendStr
 644                     ; 344 				break;
 646                     ; 345 			default: 
 646                     ; 346 				break;
 648  009b               L132:
 649                     ; 350 		for(i = 0; i<20; i++){word[i] = '\0';}
 651  009b 4f            	clr	a
 652  009c 6b04          	ld	(OFST+0,sp),a
 653  009e               L742:
 656  009e 5f            	clrw	x
 657  009f 97            	ld	xl,a
 658  00a0 6f2e          	clr	(_word,x)
 661  00a2 0c04          	inc	(OFST+0,sp)
 664  00a4 7b04          	ld	a,(OFST+0,sp)
 665  00a6 a114          	cp	a,#20
 666  00a8 25f4          	jrult	L742
 667  00aa               L722:
 668                     ; 352   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 670  00aa a601          	ld	a,#1
 671  00ac cd0000        	call	_TIM2_ClearITPendingBit
 673                     ; 353 }
 676  00af 5b04          	addw	sp,#4
 677  00b1 85            	popw	x
 678  00b2 bf00          	ldw	c_y,x
 679  00b4 320002        	pop	c_y+2
 680  00b7 85            	popw	x
 681  00b8 bf00          	ldw	c_x,x
 682  00ba 320002        	pop	c_x+2
 683  00bd 80            	iret	
 706                     ; 360  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 706                     ; 361 {
 707                     	switch	.text
 708  00be               f_TIM2_CAP_COM_IRQHandler:
 712                     ; 365 }
 715  00be 80            	iret	
 740                     ; 375  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 740                     ; 376 {
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
 757                     ; 378 	if(TimmingDelay !=0)
 759  00d1 ae0000        	ldw	x,#_TimmingDelay
 760  00d4 cd0000        	call	c_lzmp
 762  00d7 2705          	jreq	L572
 763                     ; 380 		TimmingDelay--;
 765  00d9 a601          	ld	a,#1
 766  00db cd0000        	call	c_lgsbc
 768  00de               L572:
 769                     ; 382 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 771  00de a601          	ld	a,#1
 772  00e0 cd0000        	call	_TIM3_ClearITPendingBit
 774                     ; 383 }
 777  00e3 85            	popw	x
 778  00e4 bf00          	ldw	c_y,x
 779  00e6 320002        	pop	c_y+2
 780  00e9 85            	popw	x
 781  00ea bf00          	ldw	c_x,x
 782  00ec 320002        	pop	c_x+2
 783  00ef 80            	iret	
 806                     ; 390  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 806                     ; 391 {
 807                     	switch	.text
 808  00f0               f_TIM3_CAP_COM_IRQHandler:
 812                     ; 395 }
 815  00f0 80            	iret	
 837                     ; 430 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 837                     ; 431 {
 838                     	switch	.text
 839  00f1               f_I2C_IRQHandler:
 843                     ; 435 }
 846  00f1 80            	iret	
 869                     ; 443  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 869                     ; 444 {
 870                     	switch	.text
 871  00f2               f_UART2_TX_IRQHandler:
 875                     ; 448   }
 878  00f2 80            	iret	
 939                     ; 456  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 939                     ; 457 {
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
 958                     ; 459 	buffer[counter] = UART2_ReceiveData8();
 960  0107 b62d          	ld	a,_counter
 961  0109 5f            	clrw	x
 962  010a 97            	ld	xl,a
 963  010b 89            	pushw	x
 964  010c cd0000        	call	_UART2_ReceiveData8
 966  010f 85            	popw	x
 967  0110 e742          	ld	(_buffer,x),a
 968                     ; 461 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 970  0112 5f            	clrw	x
 971  0113 b62d          	ld	a,_counter
 972  0115 97            	ld	xl,a
 973  0116 e642          	ld	a,(_buffer,x)
 974  0118 a10d          	cp	a,#13
 975  011a 2604          	jrne	L553
 978  011c 35010000      	mov	_STATUS_BIT,#1
 979  0120               L553:
 980                     ; 462 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 982  0120 b62d          	ld	a,_counter
 983  0122 5f            	clrw	x
 984  0123 97            	ld	xl,a
 985  0124 e642          	ld	a,(_buffer,x)
 986  0126 a10a          	cp	a,#10
 987  0128 264b          	jrne	L753
 989  012a b600          	ld	a,_STATUS_BIT
 990  012c 4a            	dec	a
 991  012d 2646          	jrne	L753
 992                     ; 468 	temp[0] = buffer[1];
 994  012f b643          	ld	a,_buffer+1
 995  0131 6b02          	ld	(OFST-2,sp),a
 996                     ; 469 	temp[1] = buffer[2];
 998  0133 b644          	ld	a,_buffer+2
 999  0135 6b03          	ld	(OFST-1,sp),a
1000                     ; 470 	HexToByte(temp, &Addr);
1002  0137 96            	ldw	x,sp
1003  0138 5c            	incw	x
1004  0139 89            	pushw	x
1005  013a 5c            	incw	x
1006  013b cd0000        	call	_HexToByte
1008  013e 85            	popw	x
1009                     ; 472 		if(Addr == Address || Addr == 0)
1011  013f 7b01          	ld	a,(OFST-3,sp)
1012  0141 b12c          	cp	a,_Address
1013  0143 2704          	jreq	L363
1015  0145 7b01          	ld	a,(OFST-3,sp)
1016  0147 2619          	jrne	L163
1017  0149               L363:
1018                     ; 475 			for(i = 0; i<20; i++)
1020  0149 4f            	clr	a
1021  014a 6b04          	ld	(OFST+0,sp),a
1022  014c               L563:
1023                     ; 477 			word[i] = buffer[i];
1025  014c 5f            	clrw	x
1026  014d 97            	ld	xl,a
1027  014e e642          	ld	a,(_buffer,x)
1028  0150 e72e          	ld	(_word,x),a
1029                     ; 478 			buffer[i] = '\0';	
1031  0152 5f            	clrw	x
1032  0153 7b04          	ld	a,(OFST+0,sp)
1033  0155 97            	ld	xl,a
1034  0156 6f42          	clr	(_buffer,x)
1035                     ; 475 			for(i = 0; i<20; i++)
1037  0158 0c04          	inc	(OFST+0,sp)
1040  015a 7b04          	ld	a,(OFST+0,sp)
1041  015c a114          	cp	a,#20
1042  015e 25ec          	jrult	L563
1043                     ; 480 			counter = 0;
1045  0160 200f          	jpf	LC001
1046  0162               L163:
1047                     ; 485 			for(i = 0; i<20; i++)
1049  0162 4f            	clr	a
1050  0163 6b04          	ld	(OFST+0,sp),a
1051  0165               L573:
1052                     ; 487 			buffer[i] = '\0';	
1054  0165 5f            	clrw	x
1055  0166 97            	ld	xl,a
1056  0167 6f42          	clr	(_buffer,x)
1057                     ; 485 			for(i = 0; i<20; i++)
1059  0169 0c04          	inc	(OFST+0,sp)
1062  016b 7b04          	ld	a,(OFST+0,sp)
1063  016d a114          	cp	a,#20
1064  016f 25f4          	jrult	L573
1065                     ; 489 			counter = 0;
1067  0171               LC001:
1069  0171 3f2d          	clr	_counter
1070  0173 2002          	jra	L304
1071  0175               L753:
1072                     ; 495 	counter++;
1074  0175 3c2d          	inc	_counter
1075  0177               L304:
1076                     ; 498 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1078  0177 ae0255        	ldw	x,#597
1079  017a cd0000        	call	_UART2_ClearITPendingBit
1081                     ; 499 }
1084  017d 5b04          	addw	sp,#4
1085  017f 85            	popw	x
1086  0180 bf00          	ldw	c_y,x
1087  0182 320002        	pop	c_y+2
1088  0185 85            	popw	x
1089  0186 bf00          	ldw	c_x,x
1090  0188 320002        	pop	c_x+2
1091  018b 80            	iret	
1113                     ; 547  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1113                     ; 548 {
1114                     	switch	.text
1115  018c               f_ADC1_IRQHandler:
1119                     ; 553 }
1122  018c 80            	iret	
1145                     ; 574  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1145                     ; 575 {
1146                     	switch	.text
1147  018d               f_TIM4_UPD_OVF_IRQHandler:
1151                     ; 579 }
1154  018d 80            	iret	
1177                     ; 587 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1177                     ; 588 {
1178                     	switch	.text
1179  018e               f_EEPROM_EEC_IRQHandler:
1183                     ; 592 }
1186  018e 80            	iret	
1276                     	switch	.ubsct
1277  0000               _TimmingDelay:
1278  0000 00000000      	ds.b	4
1279                     	xdef	_TimmingDelay
1280  0004               _Output_Registers:
1281  0004 000000000000  	ds.b	20
1282                     	xdef	_Output_Registers
1283  0018               _Input_Registers:
1284  0018 000000000000  	ds.b	20
1285                     	xdef	_Input_Registers
1286  002c               _Address:
1287  002c 00            	ds.b	1
1288                     	xdef	_Address
1289                     	xdef	_STATUS_BIT
1290  002d               _counter:
1291  002d 00            	ds.b	1
1292                     	xdef	_counter
1293  002e               _word:
1294  002e 000000000000  	ds.b	20
1295                     	xdef	_word
1296  0042               _buffer:
1297  0042 000000000000  	ds.b	20
1298                     	xdef	_buffer
1299                     	xref	_PresetSingleRegister
1300                     	xref	_ForceSingleCoil
1301                     	xref	_ReadInputRegisters
1302                     	xref	_ReadHoldingRegisters
1303                     	xref	_ReadInputStatus
1304                     	xref	_ReadCoilStatus
1305                     	xref	___checkFunc
1306                     	xref	_CheckLRC
1307                     	xref	_UART_SendStr
1308                     	xref	_HexToByte
1309                     	xdef	f_EEPROM_EEC_IRQHandler
1310                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1311                     	xdef	f_ADC1_IRQHandler
1312                     	xdef	f_UART2_TX_IRQHandler
1313                     	xdef	f_UART2_RX_IRQHandler
1314                     	xdef	f_I2C_IRQHandler
1315                     	xdef	f_TIM3_CAP_COM_IRQHandler
1316                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1317                     	xdef	f_TIM2_CAP_COM_IRQHandler
1318                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1319                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1320                     	xdef	f_TIM1_CAP_COM_IRQHandler
1321                     	xdef	f_SPI_IRQHandler
1322                     	xdef	f_EXTI_PORTE_IRQHandler
1323                     	xdef	f_EXTI_PORTD_IRQHandler
1324                     	xdef	f_EXTI_PORTC_IRQHandler
1325                     	xdef	f_EXTI_PORTB_IRQHandler
1326                     	xdef	f_EXTI_PORTA_IRQHandler
1327                     	xdef	f_CLK_IRQHandler
1328                     	xdef	f_AWU_IRQHandler
1329                     	xdef	f_TLI_IRQHandler
1330                     	xdef	f_TRAP_IRQHandler
1331                     	xdef	f_NonHandledInterrupt
1332                     	xref	_UART2_ClearITPendingBit
1333                     	xref	_UART2_ReceiveData8
1334                     	xref	_TIM3_ClearITPendingBit
1335                     	xref	_TIM2_ClearITPendingBit
1336                     .const:	section	.text
1337  0000               L542:
1338  0000 46756e637469  	dc.b	"Function 16 Handle"
1339  0012 6400          	dc.b	"d",0
1340  0014               L342:
1341  0014 46756e637469  	dc.b	"Function 6 Handled",0
1342  0027               L142:
1343  0027 46756e637469  	dc.b	"Function 5 Handled",0
1344                     	xref.b	c_x
1345                     	xref.b	c_y
1365                     	xref	c_lgsbc
1366                     	xref	c_lzmp
1367                     	end
