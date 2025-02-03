/*
 * main.c
 *
 *  Created on: 15/03/2024
 *      Author: fosu562
 */
#include <stdio.h>
#include <stdint.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>


uint8_t sevenSegCodes[] = {0b1000000, 0b1111001, 0b0100100, 0b0110000, 0b0011001, 0b0010010, 0b0000010, 0b1111000, 0b0000000, 0b0010000};
int Delay_Value = 3000000;

int main (){
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SEVEN_SEG_0_BASE, 0b1111111);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SEVEN_SEG_1_BASE, 0b1111111);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SEVEN_SEG_2_BASE, 0b1111111);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SEVEN_SEG_3_BASE, 0b1111111);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(LED_PIO_BASE, 0b11111111);
	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_3_BASE, sevenSegCodes[6]);
	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_2_BASE, sevenSegCodes[4]);
	// UPI

	uint8_t counter = 99;
	uint8_t upper;
	uint8_t lower;
	for (;;){
		if (counter == 0){
			counter = 100;
		}
		--counter;
		upper = counter / 10;
		lower = counter % 10;
		printf("%d\n", lower);

		IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, counter);
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_1_BASE, sevenSegCodes[upper]);
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_0_BASE, sevenSegCodes[lower]);
		// Delay for sometime
		for (int i = 0; i < Delay_Value; i++) {
			;
		}
	}


	return 0;
}




