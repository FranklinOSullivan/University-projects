#ifndef LOAD_MANAGEMENT_H_
#define LOAD_MANAGEMENT_H_

#include "../freertos/FreeRTOS.h"
#include "../freertos/semphr.h"
#include "../includes/types.h"

void LoadManagementTask(void *pvParameters);
extern xSemaphoreHandle dropLoad_semaphore;
extern xSemaphoreHandle loadStatus_semaphore;
extern load_status_t load_status;
extern uint8_t one_load_remaining;

#endif
