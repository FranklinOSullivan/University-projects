/*
 * main.c
 *
 *  Created on: 26/04/2024
 *      Author: fosu562
 */
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <system.h>
#include "altera_avalon_pio_regs.h"
#include "io.h"

uint8_t lastVal;

int main(){
	uint32_t nocOutput;
	// Enable systems
	nocOutput = 0xb1020000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xb1030000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xa0320000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xa0330000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xa0000000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xa0010000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xb1000000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0xb1010000;
	IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_BASE, nocOutput);
	nocOutput = 0x00000000;

	for(;;){
		// Check key press
		uint8_t keys = IORD_ALTERA_AVALON_PIO_DATA(BUTTON_PIO_BASE);
		if (((keys & 0b00000001) == '0') && (lastVal == 1)){

		} else {

		}
		lastVal = (keys & 0b00000001);
		// Get input from the NOC register
		uint32_t nocInput = IORD_ALTERA_AVALON_PIO_DATA(NOC_INPUT_BASE);
		if ((nocInput & 0xF000) == 32768){
			nocOutput = nocInput;
		} else {

		}
	}
	return 0;


}



