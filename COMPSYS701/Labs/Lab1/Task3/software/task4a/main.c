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

#define ADDITION 0
#define SUBTRACTION 1
#define MULTIPLICATION 2
#define MAXVAL 3

int Delay_Value = 3000000;

#define N 8
int A[N*N] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1};
int B[N*N] = {2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2,2, 2, 2, 2, 2, 2, 2, 2};
int C[N*N] = {};

void Matrix_Operations(int *A, int *B, int *C, int OP);

int main(){
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(SWITCH_PIO_BASE, 0b1111111);

	printf("This application performs NxN matrix operations\n");
	int OP;
	for(;;){
		OP = IORD_ALTERA_AVALON_PIO_EDGE_CAP(SWITCH_PIO_BASE);
		IOWR_ALTERA_AVALON_PIO_EDGE_CAP(SWITCH_PIO_BASE, 0); // Clear

		printf("N is %d, the operation is %d", N, OP);
		Matrix_Operations(A, B, C, OP);
		for (int i = 0; i < N; i++){
			for (int j = 0; j < N; j++){
				printf("%d, ", C[i*N +j]);
			}
			printf("\n");
		}

		// Delay for sometime
		for (int i = 0; i < Delay_Value; i++) {
			;
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
