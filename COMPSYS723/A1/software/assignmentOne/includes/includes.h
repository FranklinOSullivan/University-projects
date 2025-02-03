#ifndef INCLUDES_H_
#define INCLUDES_H_

#include <system.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

#include <unistd.h>

#include <sys/alt_alarm.h>
#include <sys/alt_irq.h>
#include "io.h"

/* Scheduler includes. */
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "freertos/semphr.h"
#include "freertos/timers.h"

alt_u8 keyInput;
uint8_t newInput;

extern TickType_t taskStartTime;
extern TickType_t taskEndTime;

extern uint8_t freqComp;
extern uint8_t rocComp;
extern uint8_t curStability;

#endif
