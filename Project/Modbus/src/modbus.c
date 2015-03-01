#include "modbus.h"


//Method to send strings via UART
void UART_SendStr(const char *s)
{
	//Set Max485 in Transmitter mode
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	while(*s)
	{
	UART2_SendData8((uint8_t)(*s));
	while ((UART2->SR & UART2_SR_TXE ) != UART2_SR_TXE );
	s++;
	}
	//Set Max485 in Receiver mode
	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
}

//Modbus Initialization
void Modbus_Init(void)
{
//Clock divider equals 1.Clock 16MHz
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
//Clear bits 
	TIM2_DeInit();
	GPIO_DeInit(GPIOA);
	UART2_DeInit();
//Peripetial Initialization
	TIM2_TimeBaseInit(TIM2_PRESCALER_2048, 78);
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
//Enable Periphs
	TIM2_Cmd(ENABLE);
	UART2_Cmd(ENABLE);
//Interrupt configuration
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
#ifndef __DELAY_EN
	#define __MODBUS_EN
	enableInterrupts();
#endif
}

//Delay function Initialization
void Delay_Init(void)
{
//Clear bits 
	TIM3_DeInit();
//Peripetial Initialization
	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
//Enable Periphs
	TIM3_Cmd(ENABLE);
//Interrupt configuration
	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
#ifndef __MODBUS_EN
	#define __DELAY_EN
	enableInterrupts();
#endif
}

//Delay Function
void Delay(uint32_t time)
{
	TimmingDelay = time;
	while(TimmingDelay != 0 );
}

//Byte to HexString. ASCII coding
void ByteToHex(char *hexstring, uint8_t byte)
{
	char fhex;
	char lhex;
	uint8_t fchar = (byte & 0b11110000) >> 4 ;
	uint8_t lchar = (byte & 0b00001111) ; 
	
	if( fchar >= 0 && fchar <= 9 )
	{
		fhex = (char)(fchar+48);
	}
	else
	{
		fhex = (char)(fchar+55);
	}
		if( lchar >= 0 && lchar <= 9 )
	{
		lhex = (char)(lchar+48);
	}
		else
	{
		lhex = (char)(lchar+55);
	}
	hexstring[0] = fhex;
	hexstring[1] = lhex;
}
//HexString to Byte.ASCII decoding
void HexToByte(char *hexstring, uint8_t *byte)
{
	char fhex;
	char lhex;
	uint16_t tmpb;
	uint8_t fchar;
	uint8_t lchar;
	fhex	= hexstring[0];
	lhex = hexstring[1];
	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
	{
		fchar = ((int)fhex) - 48; 
	}
	else
	{
		fchar = ((int)fhex) - 55;
	}
		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
	{
		lchar = ((int)lhex) - 48; 
	}
	else
	{
		lchar = ((int)lhex) - 55;
	}
	tmpb = ((fchar<<4) | lchar);
	*byte =  (uint8_t)tmpb; 
	
}

//Function to make sure that your address is correct
uint8_t __checkAddr(uint8_t address)
{
	if(address >= 0 && address <= 255)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
//Function to make sure that your Function code is correct
uint8_t __checkFunc(uint8_t Function_Number)
{
	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 4 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
	{
		return 1;
	}
	else 
	{
		return 0;
	}
}
//Set Device Address
void SetDevAddr(uint8_t Addr)
{
	if(__checkAddr(Addr))
	{
	Address = Addr;
	}
}

void RewritingChars(char *destination, uint8_t from, uint8_t to)
{
for(from; from<=to; ++from)
	{
	destination[from] = word[from];	
	}	
	
}


///** Return the value of single bit(coil) **///

bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
{
		// gettng value of current byte
	uint16_t Value = registers[NumberOfCoil/16];   
	
	// calculating the comparing value to find if coil is 1 or 0
	uint16_t Compare = 1<<(NumberOfCoil%16);			
	
	if ((Value & Compare) == Compare  )
		{
				return 1;
		}
		
	else
		{
				return 0;
		} 
}
///FC01  *This command is requesting the ON/OFF status of discrete coils ///
void ReadCoilStatus(void)
{
/////////////////////////////////////////////////////   Variables
char OutputFrame[25];   // output frame
uint8_t counter = 0;
//uint8_t counter2 = 0 ;
uint8_t TempSum=0;
uint16_t FirstCoil;
uint16_t NumberOfCoils;
uint16_t Coil;
uint8_t NumberOfDataBytes;
char temp[2];
char temp4[4];
uint16_t n = 0;


//Clear table
for(n = 0; n<25; n++){OutputFrame[n] = '\0';}
// coils
Input_Registers[0] = 0b0000000011111111;

/////////////////////////////////////////////////////

// rewriting slave's address & number of function
RewritingChars(OutputFrame,0,4);
	
//getting number of first coil
temp4[0] = word[5];
temp4[1] = word[6];
temp4[2] = word[7];
temp4[3] = word[8];
HexToByte_4(temp4, &FirstCoil);

//getting quantity of coils
temp4[0] = word[9];
temp4[1] = word[10];
temp4[2] = word[11];
temp4[3] = word[12];
HexToByte_4(temp4, &NumberOfCoils);

// calculating the number of data bytes
if((NumberOfCoils%8)!=0)
{
	NumberOfDataBytes = ( NumberOfCoils/8)+1;
}
else
{
	NumberOfDataBytes = NumberOfCoils/8;
}

//Writing the number of data bytes
ByteToHex(temp,NumberOfDataBytes);
OutputFrame[5] = temp[0];
OutputFrame[6] = temp[1];

// calculating data bits to HEX and writing to frame
counter = 7; 
Coil = FirstCoil;
n = NumberOfCoils;
while(n>0)
{
		if(n>=8)                   //    changing 8bits to hex
				{
						uint8_t pwr = 0;
						for(pwr =0; pwr<8; pwr++,Coil++)
							{
								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
								n--;
							}			
						
						ByteToHex(temp,TempSum);
						TempSum = 0;
						OutputFrame[counter] = temp[0];
						counter++;
						OutputFrame[counter] = temp[1];
						counter++;
				}
				
		else                                       //        changing incomplete octet to hex
				{
						uint8_t pwr = 0;
						uint8_t zm = n;
						for(pwr =0; pwr<zm; pwr++,Coil++)
							{
								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
								n--;
							}
						ByteToHex(temp,TempSum);
						TempSum = 0;
						OutputFrame[counter] = temp[0];
						counter++;
						OutputFrame[counter] = temp[1];
						counter++;
				}
}
/* 
 //setting * instead of free space to avoid CRUFT,optionaly
counter2 = counter;
for(counter2; counter2<=15; counter2++)
	{
			OutputFrame[counter2] = '*';
	}
*/

// finally writing LRC
ByteToHex(temp,GetLRC(OutputFrame));
OutputFrame[counter] = temp[0];
counter++;
OutputFrame[counter] = temp[1];
counter++;
OutputFrame[counter] = 0x0D;
counter++;
OutputFrame[counter] = 0x0A;
counter++;
OutputFrame[counter] = 0x0A;
counter++;

//sending frame 
	UART_SendStr(OutputFrame); 
}


///FC02  *This command is requesting the ON/OFF status of discrete inputs///
void ReadInputStatus(void)
{
ReadCoilStatus();
}

///FC03  *This command is requesting the content of analog output holding registers///
/// 			*registers => output or input
void ReadHoldingRegisters(uint16_t *registers)
{
char OutputFrame[25];   // output frame
char temp[4];
char temp2[2];

uint16_t FirstReg = 0;
uint16_t NumberOfRegs = 0;
uint8_t NumberOfBytes = 0 ;
uint8_t ct = 0;
uint8_t k = 0;
uint8_t counter = 0;
uint16_t Content_dec = 0;


//Clear table
for(k = 0; k<25; k++){OutputFrame[k] = '\0';}

// rewriting slave's address & number of function
RewritingChars(OutputFrame,0,4);

//getting number of first register
temp[0] = word[5];
temp[1] = word[6];
temp[2] = word[7];
temp[3] = word[8];
HexToByte_4(temp, &FirstReg);

//getting quantity of registers
temp[0] = word[9];
temp[1] = word[10];
temp[2] = word[11];
temp[3] = word[12];
HexToByte_4(temp, &NumberOfRegs);

// calculating the number of data bytes to follow ( n registers * 2 bytes each)
NumberOfBytes = NumberOfRegs*2;

//Writing the number of data bytes
ByteToHex(temp,NumberOfBytes);
OutputFrame[5] = temp[0];
OutputFrame[6] = temp[1];

counter = 7;
k = FirstReg;

Output_Registers[1] = 65535;
Output_Registers[2] = 65535;
//Reading the contents from Output_Registers
for(ct=0;ct<NumberOfRegs;ct++)
	{
		Content_dec = registers[k];
		ByteToHex_4(temp,Content_dec);
		OutputFrame[counter] = temp[0];
		counter++;
		OutputFrame[counter] = temp[1];
		counter++;
		OutputFrame[counter] = temp[2];
		counter++;
		OutputFrame[counter] = temp[3];
		counter++;
		k++;
	}
	
	
// finally writing LRC
ByteToHex(temp2,GetLRC(OutputFrame));
OutputFrame[counter] = temp2[0];
counter++;
OutputFrame[counter] = temp2[1];
counter++;
OutputFrame[counter] = 0x0D;
counter++;
OutputFrame[counter] = 0x0A;
counter++;
OutputFrame[counter] = 0x0A;
counter++;


//sending frame 
UART_SendStr(OutputFrame); 

}

///FC04 *This command is requesting the content of analog input register///
void ReadInputRegisters(void)
{
	// use FC03 because only difference is input or output
ReadHoldingRegisters(Input_Registers);
}



void ForceSingleCoil(void)
{}
void PresetSingleRegister(void)
{}

// if LRC in frame[] is correct return 1, else 0 
bool CheckLRC(char *frame)
{
	uint8_t a = 0;
	uint8_t Sum;
	char tempByte[2];
	uint8_t tempSum = 0;
	char temp[4];
	uint8_t LRC_calculated = 0;

	uint8_t LRC_dec_from_frame = 0;	
	
// counting chars  in frame
	while(word[a] != '\r')
			{
				a++;
			}

temp[1] = frame[a-1];
temp[0] = frame[a-2];

HexToByte(temp,&LRC_dec_from_frame);

frame[a-1] = '\0';
frame[a-2] = '\0';

// calculating LRC
LRC_calculated = GetLRC(frame);

if (LRC_calculated == LRC_dec_from_frame)
	{
//		UART_SendStr("LRC IS OK"); 
		return 1;
}
else
	{
		return 0;
	}
}

uint8_t GetLRC(char *frame)
{
uint8_t LRCsum = 0;
char temp[2];
uint8_t TempSum;
frame++;

while(*frame)
{
temp[0] = *frame++;
temp[1] = *frame++;
HexToByte(temp, &TempSum);
LRCsum += TempSum;
}
LRCsum = (~(LRCsum)+1);
return LRCsum;
}

//** function change hex char[4] to uint16_t
void HexToByte_4(char *hexstring_4, uint16_t *byte)
{
char tempp[2];
uint8_t right_dec = 0;
uint8_t left_dec = 0;
uint16_t right_dec16 = 0;
uint16_t left_dec16 = 0;

tempp[0] = hexstring_4[0];
tempp[1] = hexstring_4[1];
HexToByte(tempp,&left_dec);

tempp[0] = hexstring_4[2];
tempp[1] = hexstring_4[3];
HexToByte(tempp,&right_dec);

left_dec16 = left_dec16 | left_dec;
right_dec16 = right_dec16 | right_dec;

*byte = (left_dec16 << 8) | right_dec16;
}


//** function change uint16_t to hex char[4]
void ByteToHex_4(char *hexstring, uint16_t byte)
{
	char temp1[2];
	char temp2[2];
	uint16_t D1 = byte >> 8;
  uint16_t D2 = byte & 255;
	uint8_t D1_8 = 0;
	uint8_t D2_8 = 0;
	uint8_t ct = 0;
	
	D1_8 |= D1;
	D2_8 |= D2;
	
	ByteToHex(temp1, D1_8);
	ByteToHex(temp2, D2_8);
	
	hexstring[0] = temp1[0];
	hexstring[1] = temp1[1];
	hexstring[2] = temp2[0];
	hexstring[3] = temp2[1];
		
}
