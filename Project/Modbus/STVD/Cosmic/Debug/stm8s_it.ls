   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 70 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 71 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 75 }
  60  0000 80            	iret	
  82                     ; 83 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 84 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 88 }
  91  0001 80            	iret	
 113                     ; 94 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 95 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 99 }
 122  0002 80            	iret	
 144                     ; 106 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 107 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 111 }
 153  0003 80            	iret	
 175                     ; 118 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 119 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 123 }
 184  0004 80            	iret	
 207                     ; 130 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 131 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 135 }
 216  0005 80            	iret	
 239                     ; 142 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 143 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 147 }
 248  0006 80            	iret	
 271                     ; 154 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 155 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 159 }
 280  0007 80            	iret	
 303                     ; 166 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 167 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 171 }
 312  0008 80            	iret	
 335                     ; 178 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 179 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 183 }
 344  0009 80            	iret	
 366                     ; 229 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 230 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 234 }
 375  000a 80            	iret	
 398                     ; 241 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 242 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 246 }
 407  000b 80            	iret	
 430                     ; 253 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 254 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 258 }
 439  000c 80            	iret	
 505                     ; 292  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 505                     ; 293 {
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
 524                     ; 298 	if(word[0] != '\0')
 526  0021 b62e          	ld	a,_word
 527  0023 2775          	jreq	L722
 528                     ; 300 		if (CheckLRC(word))
 530  0025 ae002e        	ldw	x,#_word
 531  0028 cd0000        	call	_CheckLRC
 533  002b 4d            	tnz	a
 534  002c 275d          	jreq	L132
 535                     ; 303 		tmp[0] = word[3];
 537  002e b631          	ld	a,_word+3
 538  0030 6b01          	ld	(OFST-3,sp),a
 539                     ; 304 		tmp[1] = word[4];
 541  0032 b632          	ld	a,_word+4
 542  0034 6b02          	ld	(OFST-2,sp),a
 543                     ; 305 		HexToByte(tmp, &FunC);
 545  0036 96            	ldw	x,sp
 546  0037 1c0003        	addw	x,#OFST-1
 547  003a 89            	pushw	x
 548  003b 1d0002        	subw	x,#2
 549  003e cd0000        	call	_HexToByte
 551  0041 85            	popw	x
 552                     ; 307 		if(__checkFunc(FunC))
 554  0042 7b03          	ld	a,(OFST-1,sp)
 555  0044 cd0000        	call	___checkFunc
 557  0047 4d            	tnz	a
 558  0048 2741          	jreq	L132
 559                     ; 310 			switch (FunC) 
 561  004a 7b03          	ld	a,(OFST-1,sp)
 563                     ; 348 			default: 
 563                     ; 349 				break;
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
 578  0062 2027          	jra	L132
 579  0064               L161:
 580                     ; 312 			case 1:
 580                     ; 313 				//Function 1
 580                     ; 314 				ReadCoilStatus(Output_Registers);
 582  0064 ae0004        	ldw	x,#_Output_Registers
 583  0067 cd0000        	call	_ReadCoilStatus
 585                     ; 315 				break;
 587  006a 201f          	jra	L132
 588  006c               L361:
 589                     ; 317 			case 2:
 589                     ; 318 				//Function 2
 589                     ; 319 				ReadInputStatus();
 591  006c cd0000        	call	_ReadInputStatus
 593                     ; 320 				break;
 595  006f 201a          	jra	L132
 596  0071               L561:
 597                     ; 322 			case 3: 
 597                     ; 323 				//Function 3
 597                     ; 324 				ReadHoldingRegisters(Output_Registers);
 599  0071 ae0004        	ldw	x,#_Output_Registers
 600  0074 cd0000        	call	_ReadHoldingRegisters
 602                     ; 325 				break;
 604  0077 2012          	jra	L132
 605  0079               L761:
 606                     ; 327 			case 4: 
 606                     ; 328 				//Function 4
 606                     ; 329 				ReadInputRegisters();				
 608  0079 cd0000        	call	_ReadInputRegisters
 610                     ; 330 				break;
 612  007c 200d          	jra	L132
 613  007e               L171:
 614                     ; 332 			case 5: 
 614                     ; 333 				//Function 5
 614                     ; 334 				ForceSingleCoil();
 616  007e cd0000        	call	_ForceSingleCoil
 618                     ; 335 				break;
 620  0081 2008          	jra	L132
 621  0083               L371:
 622                     ; 337 			case 6:
 622                     ; 338 				//Function 6
 622                     ; 339 				PresetSingleRegister();
 624  0083 cd0000        	call	_PresetSingleRegister
 626                     ; 340 				break;
 628  0086 2003          	jra	L132
 629  0088               L571:
 630                     ; 342 			case 16:
 630                     ; 343 				//Function 16
 630                     ; 344 				ForceMultipleRegisters();
 632  0088 cd0000        	call	_ForceMultipleRegisters
 634                     ; 345 				break;
 636                     ; 348 			default: 
 636                     ; 349 				break;
 638  008b               L132:
 639                     ; 353 		for(i = 0; i<20; i++){word[i] = '\0';}
 641  008b 4f            	clr	a
 642  008c 6b04          	ld	(OFST+0,sp),a
 643  008e               L142:
 646  008e 5f            	clrw	x
 647  008f 97            	ld	xl,a
 648  0090 6f2e          	clr	(_word,x)
 651  0092 0c04          	inc	(OFST+0,sp)
 654  0094 7b04          	ld	a,(OFST+0,sp)
 655  0096 a114          	cp	a,#20
 656  0098 25f4          	jrult	L142
 657  009a               L722:
 658                     ; 355   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 660  009a a601          	ld	a,#1
 661  009c cd0000        	call	_TIM2_ClearITPendingBit
 663                     ; 356 }
 666  009f 5b04          	addw	sp,#4
 667  00a1 85            	popw	x
 668  00a2 bf00          	ldw	c_y,x
 669  00a4 320002        	pop	c_y+2
 670  00a7 85            	popw	x
 671  00a8 bf00          	ldw	c_x,x
 672  00aa 320002        	pop	c_x+2
 673  00ad 80            	iret	
 696                     ; 363  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 696                     ; 364 {
 697                     	switch	.text
 698  00ae               f_TIM2_CAP_COM_IRQHandler:
 702                     ; 368 }
 705  00ae 80            	iret	
 730                     ; 378  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 730                     ; 379 {
 731                     	switch	.text
 732  00af               f_TIM3_UPD_OVF_BRK_IRQHandler:
 734  00af 8a            	push	cc
 735  00b0 84            	pop	a
 736  00b1 a4bf          	and	a,#191
 737  00b3 88            	push	a
 738  00b4 86            	pop	cc
 739  00b5 3b0002        	push	c_x+2
 740  00b8 be00          	ldw	x,c_x
 741  00ba 89            	pushw	x
 742  00bb 3b0002        	push	c_y+2
 743  00be be00          	ldw	x,c_y
 744  00c0 89            	pushw	x
 747                     ; 381 	if(TimmingDelay !=0)
 749  00c1 ae0000        	ldw	x,#_TimmingDelay
 750  00c4 cd0000        	call	c_lzmp
 752  00c7 2705          	jreq	L762
 753                     ; 383 		TimmingDelay--;
 755  00c9 a601          	ld	a,#1
 756  00cb cd0000        	call	c_lgsbc
 758  00ce               L762:
 759                     ; 385 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 761  00ce a601          	ld	a,#1
 762  00d0 cd0000        	call	_TIM3_ClearITPendingBit
 764                     ; 386 }
 767  00d3 85            	popw	x
 768  00d4 bf00          	ldw	c_y,x
 769  00d6 320002        	pop	c_y+2
 770  00d9 85            	popw	x
 771  00da bf00          	ldw	c_x,x
 772  00dc 320002        	pop	c_x+2
 773  00df 80            	iret	
 796                     ; 393  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 796                     ; 394 {
 797                     	switch	.text
 798  00e0               f_TIM3_CAP_COM_IRQHandler:
 802                     ; 398 }
 805  00e0 80            	iret	
 827                     ; 433 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 827                     ; 434 {
 828                     	switch	.text
 829  00e1               f_I2C_IRQHandler:
 833                     ; 438 }
 836  00e1 80            	iret	
 859                     ; 446  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 859                     ; 447 {
 860                     	switch	.text
 861  00e2               f_UART2_TX_IRQHandler:
 865                     ; 451   }
 868  00e2 80            	iret	
 929                     ; 459  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 929                     ; 460 {
 930                     	switch	.text
 931  00e3               f_UART2_RX_IRQHandler:
 933  00e3 8a            	push	cc
 934  00e4 84            	pop	a
 935  00e5 a4bf          	and	a,#191
 936  00e7 88            	push	a
 937  00e8 86            	pop	cc
 938       00000004      OFST:	set	4
 939  00e9 3b0002        	push	c_x+2
 940  00ec be00          	ldw	x,c_x
 941  00ee 89            	pushw	x
 942  00ef 3b0002        	push	c_y+2
 943  00f2 be00          	ldw	x,c_y
 944  00f4 89            	pushw	x
 945  00f5 5204          	subw	sp,#4
 948                     ; 462 	buffer[counter] = UART2_ReceiveData8();
 950  00f7 b62d          	ld	a,_counter
 951  00f9 5f            	clrw	x
 952  00fa 97            	ld	xl,a
 953  00fb 89            	pushw	x
 954  00fc cd0000        	call	_UART2_ReceiveData8
 956  00ff 85            	popw	x
 957  0100 e742          	ld	(_buffer,x),a
 958                     ; 464 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 960  0102 5f            	clrw	x
 961  0103 b62d          	ld	a,_counter
 962  0105 97            	ld	xl,a
 963  0106 e642          	ld	a,(_buffer,x)
 964  0108 a10d          	cp	a,#13
 965  010a 2604          	jrne	L743
 968  010c 35010000      	mov	_STATUS_BIT,#1
 969  0110               L743:
 970                     ; 465 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 972  0110 b62d          	ld	a,_counter
 973  0112 5f            	clrw	x
 974  0113 97            	ld	xl,a
 975  0114 e642          	ld	a,(_buffer,x)
 976  0116 a10a          	cp	a,#10
 977  0118 264b          	jrne	L153
 979  011a b600          	ld	a,_STATUS_BIT
 980  011c 4a            	dec	a
 981  011d 2646          	jrne	L153
 982                     ; 471 	temp[0] = buffer[1];
 984  011f b643          	ld	a,_buffer+1
 985  0121 6b02          	ld	(OFST-2,sp),a
 986                     ; 472 	temp[1] = buffer[2];
 988  0123 b644          	ld	a,_buffer+2
 989  0125 6b03          	ld	(OFST-1,sp),a
 990                     ; 473 	HexToByte(temp, &Addr);
 992  0127 96            	ldw	x,sp
 993  0128 5c            	incw	x
 994  0129 89            	pushw	x
 995  012a 5c            	incw	x
 996  012b cd0000        	call	_HexToByte
 998  012e 85            	popw	x
 999                     ; 475 		if(Addr == Address || Addr == 0)
1001  012f 7b01          	ld	a,(OFST-3,sp)
1002  0131 b12c          	cp	a,_Address
1003  0133 2704          	jreq	L553
1005  0135 7b01          	ld	a,(OFST-3,sp)
1006  0137 2619          	jrne	L353
1007  0139               L553:
1008                     ; 478 			for(i = 0; i<20; i++)
1010  0139 4f            	clr	a
1011  013a 6b04          	ld	(OFST+0,sp),a
1012  013c               L753:
1013                     ; 480 			word[i] = buffer[i];
1015  013c 5f            	clrw	x
1016  013d 97            	ld	xl,a
1017  013e e642          	ld	a,(_buffer,x)
1018  0140 e72e          	ld	(_word,x),a
1019                     ; 481 			buffer[i] = '\0';	
1021  0142 5f            	clrw	x
1022  0143 7b04          	ld	a,(OFST+0,sp)
1023  0145 97            	ld	xl,a
1024  0146 6f42          	clr	(_buffer,x)
1025                     ; 478 			for(i = 0; i<20; i++)
1027  0148 0c04          	inc	(OFST+0,sp)
1030  014a 7b04          	ld	a,(OFST+0,sp)
1031  014c a114          	cp	a,#20
1032  014e 25ec          	jrult	L753
1033                     ; 483 			counter = 0;
1035  0150 200f          	jpf	LC001
1036  0152               L353:
1037                     ; 488 			for(i = 0; i<20; i++)
1039  0152 4f            	clr	a
1040  0153 6b04          	ld	(OFST+0,sp),a
1041  0155               L763:
1042                     ; 490 			buffer[i] = '\0';	
1044  0155 5f            	clrw	x
1045  0156 97            	ld	xl,a
1046  0157 6f42          	clr	(_buffer,x)
1047                     ; 488 			for(i = 0; i<20; i++)
1049  0159 0c04          	inc	(OFST+0,sp)
1052  015b 7b04          	ld	a,(OFST+0,sp)
1053  015d a114          	cp	a,#20
1054  015f 25f4          	jrult	L763
1055                     ; 492 			counter = 0;
1057  0161               LC001:
1059  0161 3f2d          	clr	_counter
1060  0163 2002          	jra	L573
1061  0165               L153:
1062                     ; 498 	counter++;
1064  0165 3c2d          	inc	_counter
1065  0167               L573:
1066                     ; 501 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1068  0167 ae0255        	ldw	x,#597
1069  016a cd0000        	call	_UART2_ClearITPendingBit
1071                     ; 502 }
1074  016d 5b04          	addw	sp,#4
1075  016f 85            	popw	x
1076  0170 bf00          	ldw	c_y,x
1077  0172 320002        	pop	c_y+2
1078  0175 85            	popw	x
1079  0176 bf00          	ldw	c_x,x
1080  0178 320002        	pop	c_x+2
1081  017b 80            	iret	
1103                     ; 550  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1103                     ; 551 {
1104                     	switch	.text
1105  017c               f_ADC1_IRQHandler:
1109                     ; 556 }
1112  017c 80            	iret	
1135                     ; 577  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1135                     ; 578 {
1136                     	switch	.text
1137  017d               f_TIM4_UPD_OVF_IRQHandler:
1141                     ; 582 }
1144  017d 80            	iret	
1167                     ; 590 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1167                     ; 591 {
1168                     	switch	.text
1169  017e               f_EEPROM_EEC_IRQHandler:
1173                     ; 595 }
1176  017e 80            	iret	
1266                     	switch	.ubsct
1267  0000               _TimmingDelay:
1268  0000 00000000      	ds.b	4
1269                     	xdef	_TimmingDelay
1270  0004               _Output_Registers:
1271  0004 000000000000  	ds.b	20
1272                     	xdef	_Output_Registers
1273  0018               _Input_Registers:
1274  0018 000000000000  	ds.b	20
1275                     	xdef	_Input_Registers
1276  002c               _Address:
1277  002c 00            	ds.b	1
1278                     	xdef	_Address
1279                     	xdef	_STATUS_BIT
1280  002d               _counter:
1281  002d 00            	ds.b	1
1282                     	xdef	_counter
1283  002e               _word:
1284  002e 000000000000  	ds.b	20
1285                     	xdef	_word
1286  0042               _buffer:
1287  0042 000000000000  	ds.b	20
1288                     	xdef	_buffer
1289                     	xref	_ForceMultipleRegisters
1290                     	xref	_PresetSingleRegister
1291                     	xref	_ForceSingleCoil
1292                     	xref	_ReadInputRegisters
1293                     	xref	_ReadHoldingRegisters
1294                     	xref	_ReadInputStatus
1295                     	xref	_ReadCoilStatus
1296                     	xref	___checkFunc
1297                     	xref	_CheckLRC
1298                     	xref	_HexToByte
1299                     	xdef	f_EEPROM_EEC_IRQHandler
1300                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1301                     	xdef	f_ADC1_IRQHandler
1302                     	xdef	f_UART2_TX_IRQHandler
1303                     	xdef	f_UART2_RX_IRQHandler
1304                     	xdef	f_I2C_IRQHandler
1305                     	xdef	f_TIM3_CAP_COM_IRQHandler
1306                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1307                     	xdef	f_TIM2_CAP_COM_IRQHandler
1308                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1309                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1310                     	xdef	f_TIM1_CAP_COM_IRQHandler
1311                     	xdef	f_SPI_IRQHandler
1312                     	xdef	f_EXTI_PORTE_IRQHandler
1313                     	xdef	f_EXTI_PORTD_IRQHandler
1314                     	xdef	f_EXTI_PORTC_IRQHandler
1315                     	xdef	f_EXTI_PORTB_IRQHandler
1316                     	xdef	f_EXTI_PORTA_IRQHandler
1317                     	xdef	f_CLK_IRQHandler
1318                     	xdef	f_AWU_IRQHandler
1319                     	xdef	f_TLI_IRQHandler
1320                     	xdef	f_TRAP_IRQHandler
1321                     	xdef	f_NonHandledInterrupt
1322                     	xref	_UART2_ClearITPendingBit
1323                     	xref	_UART2_ReceiveData8
1324                     	xref	_TIM3_ClearITPendingBit
1325                     	xref	_TIM2_ClearITPendingBit
1326                     	xref.b	c_x
1327                     	xref.b	c_y
1347                     	xref	c_lgsbc
1348                     	xref	c_lzmp
1349                     	end
