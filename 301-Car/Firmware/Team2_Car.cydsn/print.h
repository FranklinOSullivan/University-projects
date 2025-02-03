/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#include <project.h> 
#include <defines.h>

void usbPutString(char *s);
void usbPutChar(char c);
void handle_usb();

extern uint8 flag_KB_string;
extern char line[BUF_SIZE];
extern char displaystring[BUF_SIZE];

//* ========================================
typedef struct data_main
{
	int8 rssi;
	uint8 index;	  // index number of packet. incremented number
	int16 robot_xpos; //
	int16 robot_ypos; //
	int16 robot_orientation;
	int16 g0_xpos;		//
	int16 g0_ypos;		//
	int16 g0_speed;		//
	int16 g0_direction; //
	int16 g1_xpos;		//
	int16 g1_ypos;		//
	int16 g1_speed;		//
	int16 g1_direction; //
	int16 g2_xpos;		//
	int16 g2_ypos;		//
	int16 g2_speed;		//
	int16 g2_direction; //
} vtype1;
struct data_main system_state;
//* ========================================

/* [] END OF FILE */
