#ifndef PATH_H
#define PATH_H

#include "constants.h"
#include <stdint.h>

typedef struct _path
{
    uint8_t path_length;
    uint8_t path[MAX_PATH_LENGTH][2];
    uint8_t directions_length;
    uint8_t directions[MAX_PATH_LENGTH];
} Path;

#endif