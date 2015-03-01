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
 527  0023 2778          	jreq	L722
 528                     ; 299 		if (CheckLRC(word))
 530  0025 ae002e        	ldw	x,#_word
 531  0028 cd0000        	call	_CheckLRC
 533  002b 4d            	tnz	a
 534  002c 2760          	jreq	L132
 535                     ; 302 		tmp[0] = word[3];
 537  002e b631          	ld	a,_word+3
 538  0030 6b01          	ld	(OFST-3,sp),a
 539                     ; 303 		tmp[1] = word[4];
 541  0032 b632          	ld	a,_word+4
 542  0034 6b02          	ld	(OFST-2,sp),a
 543                     ; 304 		HexToByte(tmp, &FunC);
 545  0036 96            	ldw	x,sp
 546  0037 1c0003        	addw	x,#OFST-1
 547  003a 89            	pushw	x
 548  003b 1d0002        	subw	x,#2
 549  003e cd0000        	call	_HexToByte
 551  0041 85            	popw	x
 552                     ; 306 		if(__checkFunc(FunC))
 554  0042 7b03          	ld	a,(OFST-1,sp)
 555  0044 cd0000        	call	___checkFunc
 557  0047 4d            	tnz	a
 558  0048 2744          	jreq	L132
 559                     ; 309 			switch (FunC) 
 561  004a 7b03          	ld	a,(OFST-1,sp)
 563                     ; 345 			default: 
 563                     ; 346 				break;
 564  004c 4a            	dec	a
 565  004d 2715          	jreq	L161
 566  004f 4a            	dec	a
 567  0050 271a          	jreq	L361
 568  0052 4a            	dec	a
 569  0053 271c          	jreq	L561
 570  0055 4a            	dec	a
 571  0056 2721          	jreq	L761
 572  0058 4a            	dec	a
 573  0059 2723          	jreq	L171
 574  005b 4a            	dec	a
 575  005c 2725          	jreq	L371
 576  005e a00a          	sub	a,#10
 577  0060 2726          	jreq	L571
 578  0062 202a          	jra	L132
 579  0064               L161:
 580                     ; 311 			case 1:
 580                     ; 312 				//Function 1
 580                     ; 313 				ReadCoilStatus(Output_Registers);
 582  0064 ae0004        	ldw	x,#_Output_Registers
 583  0067 cd0000        	call	_ReadCoilStatus
 585                     ; 314 				break;
 587  006a 2022          	jra	L132
 588  006c               L361:
 589                     ; 316 			case 2:
 589                     ; 317 				//Function 2
 589                     ; 318 				ReadInputStatus();
 591  006c cd0000        	call	_ReadInputStatus
 593                     ; 319 				break;
 595  006f 201d          	jra	L132
 596  0071               L561:
 597                     ; 321 			case 3: 
 597                     ; 322 				//Function 3
 597                     ; 323 				ReadHoldingRegisters(Output_Registers);
 599  0071 ae0004        	ldw	x,#_Output_Registers
 600  0074 cd0000        	call	_ReadHoldingRegisters
 602                     ; 324 				break;
 604  0077 2015          	jra	L132
 605  0079               L761:
 606                     ; 326 			case 4: 
 606                     ; 327 				//Function 4
 606                     ; 328 				ReadInputRegisters();				
 608  0079 cd0000        	call	_ReadInputRegisters
 610                     ; 329 				break;
 612  007c 2010          	jra	L132
 613  007e               L171:
 614                     ; 331 			case 5: 
 614                     ; 332 				//Function 5
 614                     ; 333 				ForceSingleCoil();
 616  007e cd0000        	call	_ForceSingleCoil
 618                     ; 334 				break;
 620  0081 200b          	jra	L132
 621  0083               L371:
 622                     ; 336 			case 6:
 622                     ; 337 				//Function 6
 622                     ; 338 				PresetSingleRegister();
 624  0083 cd0000        	call	_PresetSingleRegister
 626                     ; 339 				break;
 628  0086 2006          	jra	L132
 629  0088               L571:
 630                     ; 341 			case 16:
 630                     ; 342 				//Function 16
 630                     ; 343 				UART_SendStr("Function 16 Handled");
 632  0088 ae0000        	ldw	x,#L142
 633  008b cd0000        	call	_UART_SendStr
 635                     ; 344 				break;
 637                     ; 345 			default: 
 637                     ; 346 				break;
 639  008e               L132:
 640                     ; 350 		for(i = 0; i<20; i++){word[i] = '\0';}
 642  008e 4f            	clr	a
 643  008f 6b04          	ld	(OFST+0,sp),a
 644  0091               L342:
 647  0091 5f            	clrw	x
 648  0092 97            	ld	xl,a
 649  0093 6f2e          	clr	(_word,x)
 652  0095 0c04          	inc	(OFST+0,sp)
 655  0097 7b04          	ld	a,(OFST+0,sp)
 656  0099 a114          	cp	a,#20
 657  009b 25f4          	jrult	L342
 658  009d               L722:
 659                     ; 352   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 661  009d a601          	ld	a,#1
 662  009f cd0000        	call	_TIM2_ClearITPendingBit
 664                     ; 353 }
 667  00a2 5b04          	addw	sp,#4
 668  00a4 85            	popw	x
 669  00a5 bf00          	ldw	c_y,x
 670  00a7 320002        	pop	c_y+2
 671  00aa 85            	popw	x
 672  00ab bf00          	ldw	c_x,x
 673  00ad 320002        	pop	c_x+2
 674  00b0 80            	iret	
 697                     ; 360  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 697                     ; 361 {
 698                     	switch	.text
 699  00b1               f_TIM2_CAP_COM_IRQHandler:
 703                     ; 365 }
 706  00b1 80            	iret	
 731                     ; 375  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 731                     ; 376 {
 732                     	switch	.text
 733  00b2               f_TIM3_UPD_OVF_BRK_IRQHandler:
 735  00b2 8a            	push	cc
 736  00b3 84            	pop	a
 737  00b4 a4bf          	and	a,#191
 738  00b6 88            	push	a
 739  00b7 86            	pop	cc
 740  00b8 3b0002        	push	c_x+2
 741  00bb be00          	ldw	x,c_x
 742  00bd 89            	pushw	x
 743  00be 3b0002        	push	c_y+2
 744  00c1 be00          	ldw	x,c_y
 745  00c3 89            	pushw	x
 748                     ; 378 	if(TimmingDelay !=0)
 750  00c4 ae0000        	ldw	x,#_TimmingDelay
 751  00c7 cd0000        	call	c_lzmp
 753  00ca 2705          	jreq	L172
 754                     ; 380 		TimmingDelay--;
 756  00cc a601          	ld	a,#1
 757  00ce cd0000        	call	c_lgsbc
 759  00d1               L172:
 760                     ; 382 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 762  00d1 a601          	ld	a,#1
 763  00d3 cd0000        	call	_TIM3_ClearITPendingBit
 765                     ; 383 }
 768  00d6 85            	popw	x
 769  00d7 bf00          	ldw	c_y,x
 770  00d9 320002        	pop	c_y+2
 771  00dc 85            	popw	x
 772  00dd bf00          	ldw	c_x,x
 773  00df 320002        	pop	c_x+2
 774  00e2 80            	iret	
 797                     ; 390  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 797                     ; 391 {
 798                     	switch	.text
 799  00e3               f_TIM3_CAP_COM_IRQHandler:
 803                     ; 395 }
 806  00e3 80            	iret	
 828                     ; 430 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 828                     ; 431 {
 829                     	switch	.text
 830  00e4               f_I2C_IRQHandler:
 834                     ; 435 }
 837  00e4 80            	iret	
 860                     ; 443  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 860                     ; 444 {
 861                     	switch	.text
 862  00e5               f_UART2_TX_IRQHandler:
 866                     ; 448   }
 869  00e5 80            	iret	
 930                     ; 456  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 930                     ; 457 {
 931                     	switch	.text
 932  00e6               f_UART2_RX_IRQHandler:
 934  00e6 8a            	push	cc
 935  00e7 84            	pop	a
 936  00e8 a4bf          	and	a,#191
 937  00ea 88            	push	a
 938  00eb 86            	pop	cc
 939       00000004      OFST:	set	4
 940  00ec 3b0002        	push	c_x+2
 941  00ef be00          	ldw	x,c_x
 942  00f1 89            	pushw	x
 943  00f2 3b0002        	push	c_y+2
 944  00f5 be00          	ldw	x,c_y
 945  00f7 89            	pushw	x
 946  00f8 5204          	subw	sp,#4
 949                     ; 459 	buffer[counter] = UART2_ReceiveData8();
 951  00fa b62d          	ld	a,_counter
 952  00fc 5f            	clrw	x
 953  00fd 97            	ld	xl,a
 954  00fe 89            	pushw	x
 955  00ff cd0000        	call	_UART2_ReceiveData8
 957  0102 85            	popw	x
 958  0103 e742          	ld	(_buffer,x),a
 959                     ; 461 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 961  0105 5f            	clrw	x
 962  0106 b62d          	ld	a,_counter
 963  0108 97            	ld	xl,a
 964  0109 e642          	ld	a,(_buffer,x)
 965  010b a10d          	cp	a,#13
 966  010d 2604          	jrne	L153
 969  010f 35010000      	mov	_STATUS_BIT,#1
 970  0113               L153:
 971                     ; 462 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 973  0113 b62d          	ld	a,_counter
 974  0115 5f            	clrw	x
 975  0116 97            	ld	xl,a
 976  0117 e642          	ld	a,(_buffer,x)
 977  0119 a10a          	cp	a,#10
 978  011b 264b          	jrne	L353
 980  011d b600          	ld	a,_STATUS_BIT
 981  011f 4a            	dec	a
 982  0120 2646          	jrne	L353
 983                     ; 468 	temp[0] = buffer[1];
 985  0122 b643          	ld	a,_buffer+1
 986  0124 6b02          	ld	(OFST-2,sp),a
 987                     ; 469 	temp[1] = buffer[2];
 989  0126 b644          	ld	a,_buffer+2
 990  0128 6b03          	ld	(OFST-1,sp),a
 991                     ; 470 	HexToByte(temp, &Addr);
 993  012a 96            	ldw	x,sp
 994  012b 5c            	incw	x
 995  012c 89            	pushw	x
 996  012d 5c            	incw	x
 997  012e cd0000        	call	_HexToByte
 999  0131 85            	popw	x
1000                     ; 472 		if(Addr == Address || Addr == 0)
1002  0132 7b01          	ld	a,(OFST-3,sp)
1003  0134 b12c          	cp	a,_Address
1004  0136 2704          	jreq	L753
1006  0138 7b01          	ld	a,(OFST-3,sp)
1007  013a 2619          	jrne	L553
1008  013c               L753:
1009                     ; 475 			for(i = 0; i<20; i++)
1011  013c 4f            	clr	a
1012  013d 6b04          	ld	(OFST+0,sp),a
1013  013f               L163:
1014                     ; 477 			word[i] = buffer[i];
1016  013f 5f            	clrw	x
1017  0140 97            	ld	xl,a
1018  0141 e642          	ld	a,(_buffer,x)
1019  0143 e72e          	ld	(_word,x),a
1020                     ; 478 			buffer[i] = '\0';	
1022  0145 5f            	clrw	x
1023  0146 7b04          	ld	a,(OFST+0,sp)
1024  0148 97            	ld	xl,a
1025  0149 6f42          	clr	(_buffer,x)
1026                     ; 475 			for(i = 0; i<20; i++)
1028  014b 0c04          	inc	(OFST+0,sp)
1031  014d 7b04          	ld	a,(OFST+0,sp)
1032  014f a114          	cp	a,#20
1033  0151 25ec          	jrult	L163
1034                     ; 480 			counter = 0;
1036  0153 200f          	jpf	LC001
1037  0155               L553:
1038                     ; 485 			for(i = 0; i<20; i++)
1040  0155 4f            	clr	a
1041  0156 6b04          	ld	(OFST+0,sp),a
1042  0158               L173:
1043                     ; 487 			buffer[i] = '\0';	
1045  0158 5f            	clrw	x
1046  0159 97            	ld	xl,a
1047  015a 6f42          	clr	(_buffer,x)
1048                     ; 485 			for(i = 0; i<20; i++)
1050  015c 0c04          	inc	(OFST+0,sp)
1053  015e 7b04          	ld	a,(OFST+0,sp)
1054  0160 a114          	cp	a,#20
1055  0162 25f4          	jrult	L173
1056                     ; 489 			counter = 0;
1058  0164               LC001:
1060  0164 3f2d          	clr	_counter
1061  0166 2002          	jra	L773
1062  0168               L353:
1063                     ; 495 	counter++;
1065  0168 3c2d          	inc	_counter
1066  016a               L773:
1067                     ; 498 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1069  016a ae0255        	ldw	x,#597
1070  016d cd0000        	call	_UART2_ClearITPendingBit
1072                     ; 499 }
1075  0170 5b04          	addw	sp,#4
1076  0172 85            	popw	x
1077  0173 bf00          	ldw	c_y,x
1078  0175 320002        	pop	c_y+2
1079  0178 85            	popw	x
1080  0179 bf00          	ldw	c_x,x
1081  017b 320002        	pop	c_x+2
1082  017e 80            	iret	
1104                     ; 547  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1104                     ; 548 {
1105                     	switch	.text
1106  017f               f_ADC1_IRQHandler:
1110                     ; 553 }
1113  017f 80            	iret	
1136                     ; 574  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1136                     ; 575 {
1137                     	switch	.text
1138  0180               f_TIM4_UPD_OVF_IRQHandler:
1142                     ; 579 }
1145  0180 80            	iret	
1168                     ; 587 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1168                     ; 588 {
1169                     	switch	.text
1170  0181               f_EEPROM_EEC_IRQHandler:
1174                     ; 592 }
1177  0181 80            	iret	
1267                     	switch	.ubsct
1268  0000               _TimmingDelay:
1269  0000 00000000      	ds.b	4
1270                     	xdef	_TimmingDelay
1271  0004               _Output_Registers:
1272  0004 000000000000  	ds.b	20
1273                     	xdef	_Output_Registers
1274  0018               _Input_Registers:
1275  0018 000000000000  	ds.b	20
1276                     	xdef	_Input_Registers
1277  002c               _Address:
1278  002c 00            	ds.b	1
1279                     	xdef	_Address
1280                     	xdef	_STATUS_BIT
1281  002d               _counter:
1282  002d 00            	ds.b	1
1283                     	xdef	_counter
1284  002e               _word:
1285  002e 000000000000  	ds.b	20
1286                     	xdef	_word
1287  0042               _buffer:
1288  0042 000000000000  	ds.b	20
1289                     	xdef	_buffer
1290                     	xref	_PresetSingleRegister
1291                     	xref	_ForceSingleCoil
1292                     	xref	_ReadInputRegisters
1293                     	xref	_ReadHoldingRegisters
1294                     	xref	_ReadInputStatus
1295                     	xref	_ReadCoilStatus
1296                     	xref	___checkFunc
1297                     	xref	_CheckLRC
1298                     	xref	_UART_SendStr
1299                     	xref	_HexToByte
1300                     	xdef	f_EEPROM_EEC_IRQHandler
1301                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1302                     	xdef	f_ADC1_IRQHandler
1303                     	xdef	f_UART2_TX_IRQHandler
1304                     	xdef	f_UART2_RX_IRQHandler
1305                     	xdef	f_I2C_IRQHandler
1306                     	xdef	f_TIM3_CAP_COM_IRQHandler
1307                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1308                     	xdef	f_TIM2_CAP_COM_IRQHandler
1309                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1310                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1311                     	xdef	f_TIM1_CAP_COM_IRQHandler
1312                     	xdef	f_SPI_IRQHandler
1313                     	xdef	f_EXTI_PORTE_IRQHandler
1314                     	xdef	f_EXTI_PORTD_IRQHandler
1315                     	xdef	f_EXTI_PORTC_IRQHandler
1316                     	xdef	f_EXTI_PORTB_IRQHandler
1317                     	xdef	f_EXTI_PORTA_IRQHandler
1318                     	xdef	f_CLK_IRQHandler
1319                     	xdef	f_AWU_IRQHandler
1320                     	xdef	f_TLI_IRQHandler
1321                     	xdef	f_TRAP_IRQHandler
1322                     	xdef	f_NonHandledInterrupt
1323                     	xref	_UART2_ClearITPendingBit
1324                     	xref	_UART2_ReceiveData8
1325                     	xref	_TIM3_ClearITPendingBit
1326                     	xref	_TIM2_ClearITPendingBit
1327                     .const:	section	.text
1328  0000               L142:
1329  0000 46756e637469  	dc.b	"Function 16 Handle"
1330  0012 6400          	dc.b	"d",0
1331                     	xref.b	c_x
1332                     	xref.b	c_y
1352                     	xref	c_lgsbc
1353                     	xref	c_lzmp
1354                     	end
