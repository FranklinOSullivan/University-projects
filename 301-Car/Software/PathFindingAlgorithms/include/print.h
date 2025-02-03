#ifndef PRINT_H
#define PRINT_H

#include "constants.h"
#include "map.h"
#include "path.h"
#include <stdint.h>
#include <stdlib.h>

void print_map(Map *map, Path *path);
void print_map_16(uint16_t map[MAX_HEIGHT][MAX_WIDTH], uint8_t width, uint8_t height);
void print_directions(Path *path);
#endif