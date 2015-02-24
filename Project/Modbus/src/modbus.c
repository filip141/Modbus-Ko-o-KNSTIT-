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
	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
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


void ReadCoilStatus(void)
{
/////////////////////////////////////////////////////   zmienne
char OutputFrame[15];   // output frame
uint8_t counter = 0;
uint8_t TempSum=0;
uint8_t FirstCoil;
uint8_t NumberOfCoils;
uint8_t g;
uint8_t NumberOfDataBytes;
char temp[2];
uint8_t n = 0;

// coils
bool data[60];

data[4] = 1;
data[5] = 1;
data[6] = 1;
data[7] = 1;
data[8] = 1;
data[4] = 1;
data[9] = 1;
data[10] = 1;
data[11] = 1;
data[12] = 1;
data[13] = 1;
data[14] = 1;
data[15] = 1;
data[16] = 1;
data[17] = 1;
data[18] = 1;
data[19] = 1;
data[20] = 1;
data[21] = 0;
data[22] = 0;
data[23] = 0;
data[24] = 0;
data[25] = 0;
data[26] = 0;
data[27] = 0;
data[28] = 0;
/////////////////////////////////////////////////////

// rewriting slave's address & number of function
RewritingChars(OutputFrame,0,4);
	
//getting number of first coil	
temp[0] = word[7];
temp[1] = word[8];
HexToByte(temp, &FirstCoil);

//getting quantity of coils
temp[0] = word[11];
temp[1] = word[12];
HexToByte(temp, &NumberOfCoils);

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
g = FirstCoil + 1;
n = NumberOfCoils;
while(n>0)
{
		if(n>=8)                   //    zamiana oktetu na HEX
				{
						uint8_t pwr = 0;
						for(pwr =0; pwr<8; pwr++,g++)
							{
								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
								n--;
							}			
						
						ByteToHex(temp,TempSum);
						TempSum = 0;
						OutputFrame[counter] = temp[0];
						counter++;
						OutputFrame[counter] = temp[1];
						counter++;
				}
				
		else                                       //        zamiana niepe³nego oktetu na HEX
				{
						uint8_t pwr = 0;
						uint8_t zm = n;
						for(pwr =0; pwr<zm; pwr++,g++)
							{
								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
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

//   calculating CRC
for(counter; counter<=15; counter++)
	{
			OutputFrame[counter] = '*';
	}
UART_SendStr(OutputFrame); 
//UART_SendStr("\nFunction 1 handled."); 
}


 
void ReadInputStatus(void)
{
UART_SendStr("Function 2 Handled");
}
void ReadHoldingRegisters(void)
{}
void ReadInputRegisters(void)
{}
void ForceSingleCoil(void)
{}
void PresetSingleRegister(void)
{}