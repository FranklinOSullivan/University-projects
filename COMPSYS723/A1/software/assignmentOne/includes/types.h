#ifndef TYPES_H_
#define TYPES_H_

#include <stdint.h>
#include "defines.h"

typedef struct
{
    uint8_t switchEnabled;
    uint8_t loadDisabled;
} load_status_t;

typedef struct
{
    unsigned int x1;
    unsigned int y1;
    unsigned int x2;
    unsigned int y2;
} line_t;

typedef struct
{
    double freq[FreqAnalyserMsgSize];
    double rocFreq[FreqAnalyserMsgSize];
    // Add timing data
} output_values_t;

#endif
