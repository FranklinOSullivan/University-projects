#ifndef MAP_H
#define MAP_H

#include "constants.h"
#include <stdint.h>

typedef struct _map
{
    uint8_t height;
    uint8_t width;
    uint8_t start_x;
    uint8_t start_y;
    uint8_t end_x;
    uint8_t end_y;
    uint8_t map[MAX_HEIGHT][MAX_WIDTH];
} Map;

void generateMap(Map *map, uint8_t layout[MAX_HEIGHT][MAX_WIDTH], uint8_t width, uint8_t height, uint8_t start_X, uint8_t start_Y, uint8_t end_X, uint8_t end_Y);

#endif