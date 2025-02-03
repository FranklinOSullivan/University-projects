/*
 * main.c
 *
 *  Created on: 25/03/2024
 *  Authors: Franklin, Dylan, Bailey
 */
#include "../includes/defines.h"
#include "../includes/types.h"
#include "../includes/vga.h"
#include "../includes/load_management.h"
#include "../includes/state_management.h"
#include "../includes/output_management.h"
#include "../includes/freq_analysing_unit.h"

/* Standard includes. */
#include <system.h>
#include <stdio.h>
#include "../freertos/FreeRTOS.h"
#include "io.h"

// Initial entry for the system
int main(void)
{
	// Set up character LCD
	fp = fopen(CHARACTER_LCD_NAME, "w"); // open the character LCD as a file stream for write

	if (fp == NULL)
	{
		printf("open failed\n"); // invalid file pointer 
		return 1;
	}
	fprintf(fp, "%c%sStart up\n\n", esc, "[2j"); // print start up to lcd 

	// register the PS/2 interrupt
	IOWR_8DIRECT(PS2_BASE, 4, 1);

	//initialise VGA 
	initVGA();

	//creat semaphores and tasks 
	outputValues_semaphore = xSemaphoreCreateMutex();
	loadStatus_semaphore = xSemaphoreCreateMutex();
	dropLoad_semaphore = xSemaphoreCreateMutex();
	xTaskCreate(LoadManagementTask, "LoadManagementTask", configMINIMAL_STACK_SIZE, NULL, HIGHEST_TASK_PRIORITY, NULL);
	xTaskCreate(StateManagementTask, "StateManagementTask", configMINIMAL_STACK_SIZE, NULL, HIGHEST_TASK_PRIORITY - 1, NULL);
	xTaskCreate(VGAManagementTask, "VGAManagementTask", configMINIMAL_STACK_SIZE, NULL, HIGHEST_TASK_PRIORITY, NULL);
	xTaskCreate(OutputManagementTask, "OutputManagementTask", configMINIMAL_STACK_SIZE, NULL, HIGHEST_TASK_PRIORITY - 3, NULL);

	// Set up the frequency Queue 
	freqAnalyserQ = xQueueCreate(FreqAnalyserMsgSize, sizeof(double));

	/* Start the scheduler. */
	vTaskStartScheduler();
	printf("Heap error\n");
	for (;;)
	{
	}
}
