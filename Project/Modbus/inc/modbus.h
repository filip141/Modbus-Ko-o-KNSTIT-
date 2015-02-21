#ifndef __MODBUS_HEADER_H
#define __MODBUS_HEADER_H

/* Includes -----------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
#define BAUDRATE 19200
/* Private function prototypes -----------------------------------------------*/
void Delay_Init(void);
void Delay(uint32_t time);
void Modbus_Init(void);
void UART_SendStr(const char *s);
void ByteToHex(char *hexstring, uint8_t byte);
void HexToByte(char *hexstring, uint8_t *byte);
void SetDevAddr(uint8_t Addr);
uint8_t __checkAddr(uint8_t address); 
uint8_t __checkFunc(uint8_t Function_Number); 


/* Modbus handler function prototypes ------------------------------------------*/
void ReadCoilStatus(void);
void ReadInputStatus(void);
void ReadHoldingRegisters(void);
void ReadInputRegisters(void);
void ForceSingleCoil(void);
void PresetSingleRegister(void);



/* Private variables -----------------------------------------------------------*/
extern uint32_t TimmingDelay;
extern uint8_t Address;
extern uint8_t buffer[20];
extern uint8_t word[20];



#endif