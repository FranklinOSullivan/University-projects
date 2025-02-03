#ifndef DEFINES_H_
#define DEFINES_H_

#define StartUp_S 0
#define NormalOperation_S 1
#define LoadManagement_S 2
#define LoadStatusMsgSize 5
#define FreqAnalyserMsgSize 100

// For frequency plot
#define FREQPLT_ORI_X 101     // x axis pixel position at the plot origin
#define FREQPLT_GRID_SIZE_X 5 // pixel separation in the x axis between two data points
#define FREQPLT_ORI_Y 199.0   // y axis pixel position at the plot origin
#define FREQPLT_FREQ_RES 20.0 // number of pixels per Hz (y axis scale)
static unsigned char esc = 0x1b;

#define ROCPLT_ORI_X 101
#define ROCPLT_GRID_SIZE_X 5
#define ROCPLT_ORI_Y 259.0
#define ROCPLT_ROC_RES 0.5 // number of pixels per Hz/s (y axis scale)

#define MIN_FREQ 45.0 // minimum frequency to draw

#define SCAN_CODE_NUM 102

#define PRVGADraw_Task_P (tskIDLE_PRIORITY + 1)

#define HIGHEST_TASK_PRIORITY 4

#endif
