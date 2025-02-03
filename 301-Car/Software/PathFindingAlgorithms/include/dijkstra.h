#ifndef DIJKSTRA_H
#define DIJKSTRA_H

#include "map.h"
#include "path.h"
#include "constants.h"
#include <stdint.h>

uint8_t dijkstra(Map *map, Path *path);

#endif