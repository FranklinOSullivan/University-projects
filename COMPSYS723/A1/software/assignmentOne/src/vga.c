#include "../includes/vga.h"
#include "../includes/circularbuffer.h"
#include "../includes/defines.h"
#include "../includes/types.h"
#include "../includes/state_management.h"
#include <system.h>
#include <altera_avalon_pio_regs.h>
#include "altera_up_avalon_video_character_buffer_with_dma.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "altera_up_avalon_ps2.h"
#include "altera_up_ps2_keyboard.h"


uint16_t get_min_max();
void handle_timing();

// Define arrays for printing
char printString[100];
int printIndex = 0;

uint8_t freqComp = 49;
uint8_t rocComp = 15;

int32_t shedTimes[] = {0, 0, 0, 0, 0};

char codes_ascii[SCAN_CODE_NUM] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
	'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
	'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'`', '-', '=', 0, 0x08, 0, 0x09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0A,
	0x1B, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[', 0, 0, 0, 0x7F, 0, 0,
	0, 0, 0, 0, 0, '/', '*', '-', '+', 0x0A, '.', '0', '1', '2', '3', '4',
	'5', '6', '7', '8', '9', ']', ';', '\'', ',', '.', '/' };

alt_u8 codes[SCAN_CODE_NUM] = { 0x1C, 0x32, 0x21, 0x23, 0x24,
	0x2B, 0x34, 0x33,//output_values_t outputVals = {0};
 0x43, 0x3B, 0x42, 0x4B, 0x3A, 0x31, 0x44, 0x4D, 0x15,
	0x2D, 0x1B, 0x2C, 0x3C, 0x2A, 0x1D, 0x22, 0x35, 0x1A, 0x45, 0x16, 0x1E,
	0x26, 0x25, 0x2E, 0x36, 0x3D, 0x3E, 0x46, 0x0E, 0x4E, 0x55, 0x5D, 0x66,
	0x29, 0x0D, 0x58, 0x12, 0x14, 0, 0x11, 0x59, 0, 0, 0, 0, 0x5A, 0x76,
	0x05, 0x06, 0x04, 0x0C, 0x03, 0x0B, 0x83, 0x0A, 0x01, 0x09, 0x78, 0x07,
	0x7E, 0x54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x77, 0, 0x7C, 0x7B, 0x79, 0,
	0x71, 0x70, 0x69, 0x72, 0x7A, 0x6B, 0x73, 0x74, 0x6C, 0x75, 0x7D, 0x5B,
	0x4C, 0x52, 0x41, 0x49, 0x4A };

CIRC_BUF_DEF(freq_buf,FreqAnalyserMsgSize);
CIRC_BUF_DEF(rocFreq_buf,FreqAnalyserMsgSize);

uint8_t keyInput;
uint8_t newInput = 0;

void ps2KBISR(void *context, alt_u32 id)
{
	char ascii;
	KB_CODE_TYPE decode_mode;
	decode_scancode(context, &decode_mode, &keyInput, &ascii);
	newInput++;
	if (newInput == 2){
		newInput = 0;
	}
}

void initVGA() {
	// Set up keyboard
	alt_up_ps2_dev *ps2_device = alt_up_ps2_open_dev(PS2_NAME);

	if (ps2_device == NULL)
	{
		printf("can't find PS/2 device\n");
	}

	alt_up_ps2_clear_fifo(ps2_device);
	alt_irq_register(PS2_IRQ, ps2_device, ps2KBISR);
	// initialize VGA controllers
	alt_up_pixel_buffer_dma_dev *pixel_buf;
	pixel_buf = alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_NAME);
	if (pixel_buf == NULL)
	{
		printf("can't find pixel buffer device\n");
	}
	alt_up_pixel_buffer_dma_clear_screen(pixel_buf, 0);

	alt_up_char_buffer_dev *char_buf;
	char_buf = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma");
	if (char_buf == NULL)
	{
		printf("can't find char buffer device\n");
	}
	alt_up_char_buffer_clear(char_buf);
	// Set up plot axes
	alt_up_pixel_buffer_dma_draw_hline(pixel_buf, 100, 590, 200, ((0x3ff << 20) + (0x3ff << 10) + (0x3ff)), 0);
	alt_up_pixel_buffer_dma_draw_hline(pixel_buf, 100, 590, 300, ((0x3ff << 20) + (0x3ff << 10) + (0x3ff)), 0);
	alt_up_pixel_buffer_dma_draw_vline(pixel_buf, 100, 50, 200, ((0x3ff << 20) + (0x3ff << 10) + (0x3ff)), 0);
	alt_up_pixel_buffer_dma_draw_vline(pixel_buf, 100, 220, 300, ((0x3ff << 20) + (0x3ff << 10) + (0x3ff)), 0);

	alt_up_char_buffer_string(char_buf, "Frequency(Hz)", 4, 4);
	alt_up_char_buffer_string(char_buf, "52", 10, 7);
	alt_up_char_buffer_string(char_buf, "50", 10, 12);
	alt_up_char_buffer_string(char_buf, "48", 10, 17);
	alt_up_char_buffer_string(char_buf, "46", 10, 22);

	alt_up_char_buffer_string(char_buf, "df/dt(Hz/s)", 4, 26);
	alt_up_char_buffer_string(char_buf, "60", 10, 28);
	alt_up_char_buffer_string(char_buf, "30", 10, 30);
	alt_up_char_buffer_string(char_buf, "0", 10, 32);
	alt_up_char_buffer_string(char_buf, "-30", 9, 34);
	alt_up_char_buffer_string(char_buf, "-60", 9, 36);
}

void VGAManagementTask(void *pvParameters)
{
	while (1)
	{
		/*
		 * Writes outputs through the VGA interface
		 * to display Frequency, Frequency Rate of
		 * Change and current threshold information
		 * from the Load Management Task.
		 *
		 * This occurs 30 times per second.
		 * Executes periodically (33 ms)
		 *
		 * Reads Maintenance Flag
		 * Reads Output Values
		 *
		 * Sends compValQ message to LoadManagementTask
		 * Takes keyInputQ isr interrupt
		 */

		if (newInput == 1)
		{
			char temp;
			for (int i=0; i<SCAN_CODE_NUM; i++){
				if (keyInput == codes[i]){
					temp = codes_ascii[i];
				}
			}
			if (temp == -91){
				for (int i=0; i < printIndex; i++){
					printString[i] = '\0';
				}
				printIndex = 0;
			} else {
				printString[printIndex] = temp;
				++printIndex;
			}
			printf("Input: %c\n", temp);

			// Handle order of inputs
			// On enter
			char zero = '0';
			if (temp == codes_ascii[53]){
				if (printString[0] == 'F'){
					freqComp = (printString[1]-zero)*10 + printString[2]-zero;
				} else if(printString[0] == 'R'){
					rocComp = (printString[1]-zero)*10 + printString[2]-zero;
				}
				for (int i=0; i < printIndex; i++){
					printString[i] = ' ';
				}
				printIndex = 0;
			}
			newInput = 0;
		}


		// initialize VGA controllers
		alt_up_pixel_buffer_dma_dev *pixel_buf;
		pixel_buf = alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_NAME);
		if (pixel_buf == NULL)
		{
			printf("can't find pixel buffer device\n");
		}

		alt_up_char_buffer_dev *char_buf;
		char_buf = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma");
		if (char_buf == NULL)
		{
			printf("can't find char buffer device\n");
		}

		line_t line_freq;
		line_t line_roc;

		// clear old graph to draw new graph
		alt_up_pixel_buffer_dma_draw_box(pixel_buf, 101, 0, 639, 199, 0, 0);
		alt_up_pixel_buffer_dma_draw_box(pixel_buf, 101, 201, 639, 299, 0, 0);

		for (int i = 0; i < FreqAnalyserMsgSize-1; ++i)
		{ // i here points to the oldest data, j loops through all the data to be drawn on VGA
//			printf("%f, ", circ_buf_get(&freq_buf, i));
			if (((circ_buf_get(&freq_buf, i)) > MIN_FREQ) && ((circ_buf_get(&freq_buf, i+1)) > MIN_FREQ))
			{
				// Calculate coordinates of the two data points to draw a line in between
				// Frequency plot
				line_freq.x1 = FREQPLT_ORI_X + FREQPLT_GRID_SIZE_X * i;
				line_freq.y1 = (int)(FREQPLT_ORI_Y - FREQPLT_FREQ_RES * (circ_buf_get(&freq_buf,i) - MIN_FREQ));

				line_freq.x2 = FREQPLT_ORI_X + FREQPLT_GRID_SIZE_X * (i + 1);
				line_freq.y2 = (int)(FREQPLT_ORI_Y - FREQPLT_FREQ_RES * (circ_buf_get(&freq_buf,i+1) - MIN_FREQ));

				// Frequency RoC plot
				line_roc.x1 = ROCPLT_ORI_X + ROCPLT_GRID_SIZE_X * i;
				line_roc.y1 = (int)(ROCPLT_ORI_Y - ROCPLT_ROC_RES * circ_buf_get(&rocFreq_buf,i));

				line_roc.x2 = ROCPLT_ORI_X + ROCPLT_GRID_SIZE_X * (i + 1);
				line_roc.y2 = (int)(ROCPLT_ORI_Y - ROCPLT_ROC_RES *circ_buf_get(&rocFreq_buf,i+1));

				// Draw
				alt_up_pixel_buffer_dma_draw_line(pixel_buf, line_freq.x1, line_freq.y1, line_freq.x2, line_freq.y2, 0x3ff << 0, 0);
				alt_up_pixel_buffer_dma_draw_line(pixel_buf, line_roc.x1, line_roc.y1, line_roc.x2, line_roc.y2, 0x3ff << 0, 0);
			}
		}
		char temp[] = "Input (Fxx or Rxx): ";
		strcat(temp, printString);
		alt_up_char_buffer_string(char_buf, temp, 4, 42);
		sprintf(temp, "F comp: %u   ", freqComp);
		alt_up_char_buffer_string(char_buf, temp, 34, 42);
		sprintf(temp, "ROC comp: %u   ", rocComp);
		alt_up_char_buffer_string(char_buf, temp, 54, 42);

		uint32_t uptime = xTaskGetTickCount()/1000;
		handle_timing();
		sprintf(temp, "Uptime: %d s", uptime);
		alt_up_char_buffer_string(char_buf, temp, 4, 46);
		if (stability){
			strcpy(temp, "System: Stable  ");
		} else {
			strcpy(temp, "System: Unstable");
		}
		alt_up_char_buffer_string(char_buf, temp, 44, 46);

		sprintf(temp, "Shed times: %d ms, %d ms, %d ms, %d ms, %d ms    ", shedTimes[0], shedTimes[1], shedTimes[2], shedTimes[3], shedTimes[4]);
		alt_up_char_buffer_string(char_buf, temp, 4, 50);


		int32_t mm[] = {shedTimes[0], shedTimes[0], 0};
		for (int i=0; i<5 ; i++){
			if(shedTimes[i] < mm[0] && shedTimes[i] != 0){
				mm[0] = shedTimes[i];
			} else if (shedTimes[i] > mm[1]){
				mm[1] = shedTimes[i];
			}
			mm[2] += shedTimes[i];
		}
		mm[2] = mm[2] / 5;

		sprintf(temp, "Min: %d ms    ", mm[0]);
		alt_up_char_buffer_string(char_buf, temp, 4, 54);
		sprintf(temp, "Max: %d ms    ", mm[1]);
		alt_up_char_buffer_string(char_buf, temp, 24, 54);
		sprintf(temp, "Ave: %d ms    ", mm[2]);
		alt_up_char_buffer_string(char_buf, temp, 44, 54);

		// Delay
		vTaskDelay(50);
	}
}

void handle_timing(){
	int32_t currentTime = taskEndTime - taskStartTime;
	if (shedTimes[0] != currentTime && currentTime > 1) {
		shedTimes[4] = shedTimes[3];
		shedTimes[3] = shedTimes[2];
		shedTimes[2] = shedTimes[1];
		shedTimes[1] = shedTimes[0];
		shedTimes[0] = currentTime;
	}
}

