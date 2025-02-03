#ifndef A_STAR_H
#define A_STAR_H

#include "constants.h"
#include "map.h"
#include "path.h"
#include <stdint.h>

uint8_t a_star(Map *map, Path *path);

#endif