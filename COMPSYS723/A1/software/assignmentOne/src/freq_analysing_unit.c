#include "../includes/freq_analysing_unit.h"

#include <system.h>
#include "../freertos/FreeRTOS.h"
#include "io.h"


QueueHandle_t freqAnalyserQ;

void freqRelayISR(void *context, alt_u32 id)
{
    double temp = SAMPLING_FREQ / (double)IORD(FREQUENCY_ANALYSER_BASE, 0);

    xQueueSendToBackFromISR(freqAnalyserQ, &temp, pdFALSE);

    return;
}
