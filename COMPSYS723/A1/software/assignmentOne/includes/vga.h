/*
 * vga.h
 *
 *  Created on: Apr 16, 2024
 *      Author: dylan
 */

#ifndef VGA_H_
#define VGA_H_

#include "circularbuffer.h"

extern circ_buf_t freq_buf;
extern circ_buf_t rocFreq_buf;
extern uint8_t freqComp;
extern uint8_t rocComp;


void initVGA();
void VGAManagementTask(void *pvParameters);

#endif /* VGA_H_ */
