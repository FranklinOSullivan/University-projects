#ifndef STATE_MANAGEMENT_H_
#define STATE_MANAGEMENT_H_

#include <stdint.h>
#include "../freertos/FreeRTOS.h"
#include "../freertos/semphr.h"
#include "../freertos/timers.h"
#include <stdio.h>

void StateManagementTask(void *pvParameters);

extern xSemaphoreHandle outputValues_semaphore;
extern uint8_t currentState;
extern TickType_t startTime;
extern TickType_t taskStartTime;
extern TickType_t taskEndTime;
extern TickType_t upTime;
extern uint8_t firstLoadDropped;
extern FILE *fp;
extern uint8_t maintenanceFlag;
extern int8_t drop_load;
extern uint8_t stability;
#endif
