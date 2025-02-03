#ifndef FREQ_ANALYSING_UNIT_H_
#define FREQ_ANALYSING_UNIT_H_

#include <alt_types.h>
#include "../freertos/FreeRTOS.h"
#include "../freertos/queue.h"

#define SAMPLING_FREQ 16000.0

void freqRelayISR(void *context, alt_u32 id);

extern QueueHandle_t freqAnalyserQ;

#endif
