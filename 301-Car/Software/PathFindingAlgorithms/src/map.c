#include "map.h"
#include "constants.h"
#include <stdint.h>
#include <string.h>

void generateMap(Map *map, uint8_t layout[MAX_HEIGHT][MAX_WIDTH], uint8_t width, uint8_t height, uint8_t start_x, uint8_t start_y, uint8_t end_x, uint8_t end_y)
{
    memcpy(map->map, layout, sizeof(map->map));
    map->height = height;
    map->width = width;
    map->start_x = start_x - 1;
    map->start_y = start_y - 1;
    map->end_x = end_x - 1;
    map->end_y = end_y - 1;
}