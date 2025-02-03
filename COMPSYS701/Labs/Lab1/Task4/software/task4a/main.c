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
#include "altera_avalon_timer_regs.h"
#include "sys/alt_timestamp.h"

#define ADDITION 0
#define SUBTRACTION 1
#define MULTIPLICATION 2
#define MAXVAL 3

int Delay_Value = 300000;

#define N 8
#define COUNTS 10
int A[N*N] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1};
int B[N*N] = {2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2};
int C[N*N] = {};

uint8_t sevenSegCodes[] = {0b1000000, 0b1111001, 0b0100100, 0b0110000, 0b0011001, 0b0010010, 0b0000010, 0b1111000, 0b0000000, 0b0010000};

void Matrix_Operations(int *A, int *B, int *C, int OP);

int main(){
	//IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SWITCH_PIO_BASE, 0b1111111);
	unsigned int timestamp_start_time, timestamp_end_time;
	unsigned int timestamp_overhead_time, T1, T2;

	uint8_t upper;
	uint8_t lower;

	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_3_BASE, sevenSegCodes[6]);
	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_2_BASE, sevenSegCodes[4]);

	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTON_PIO_BASE, 0b1);

	if (alt_timestamp_start() < 0) {
			    printf ("No timestamp device is available.\n");
	} else {
		printf("This application performs NxN matrix operations\n");
		int OP;

		for(;;){

			while(!IORD_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE)){
			}
			IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE, 0);
			// Measure the number of cycles for the delay loop (only in the first iteration)
			OP = IORD_ALTERA_AVALON_PIO_DATA(SWITCH_PIO_BASE);
			//IOWR_ALTERA_AVALON_PIO_EDGE_CAP(SWITCH_PIO_BASE, 0); // Clear
			printf("N is %d, the operation is ", N);
			switch(OP) {
			case 0:
				printf("Addition\n");
				break;
			case 1:
				printf("Subtraction\n");
				break;
			case 2:
				printf("Multiplication\n");
				break;
			case 3:
				printf("Max val\n");
				break;
			}
			upper = OP / 2;
			lower = OP % 2;
			IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_1_BASE, sevenSegCodes[upper]);
			IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_0_BASE, sevenSegCodes[lower]);
			timestamp_start_time = alt_timestamp();
			Matrix_Operations(A, B, C, OP);
			timestamp_end_time = alt_timestamp();

			for (int i = 0; i < N; i++){
				for (int j = 0; j < N; j++){
					printf("%d, ", C[i*N +j]);
				}
				printf("\n");
			}

			T1 = alt_timestamp();
			T2 = alt_timestamp();
			timestamp_overhead_time = T2 - T1;

			// Print-out the Timestamp interval timer peripheral measurements.
			printf("timestamp_start_time = %u ticks\n",
								   (unsigned int) (timestamp_start_time));
			printf("timestamp_end_time = %u ticks\n\n",
										   (unsigned int) (timestamp_end_time));
			printf("timestamp measurement = %u ticks\n",
						   (unsigned int) (timestamp_end_time - timestamp_start_time));
			printf("timestamp measurement overhead = %u ticks\n",
						   (unsigned int) (timestamp_overhead_time));
			printf("Actual time  = %u ticks\n",
						   (unsigned int) (((timestamp_end_time - timestamp_start_time)) -
						   timestamp_overhead_time));
			printf("Timestamp timer frequency = %u\n",
						   (unsigned int)alt_timestamp_freq());

			// Delay for sometime
			for (int i = 0; i < Delay_Value; i++) {
				;
			}
		}
	}
	return 0;
}

void Matrix_Operations(int *A, int *B, int *C, int OP) {
	for (int i = 0; i < N; i++){
		for (int j = 0; j < N; j++){
			switch(OP){
				case ADDITION:
					C[i*N + j] = A[i*N + j] + B[i*N + j];
					break;
				case SUBTRACTION:
					C[i*N + j] = A[i*N + j] - B[i*N + j];
					break;
				case MULTIPLICATION:
					C[i*N + j] = A[i*N + j] * B[i*N + j];
					break;
				case MAXVAL:
					C[i*N + j] = (A[i*N + j] >= B[i*N + j]) ? A[i*N + j] : B[i*N + j];
					break;
				}
		}
	}

}
