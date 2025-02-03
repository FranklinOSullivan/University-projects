#include "print.h"
#include "map.h"
#include "path.h"
#include <stdio.h>
#include <string.h>

#define PATH 1

void print_map(Map *map, Path *path)
{
    Map new_map;
    Map *temp_map = &new_map;
    if (path == NULL)
    {
        temp_map = map;
    }
    else
    {
        // Path Exists
        *temp_map = *map;
        for (uint8_t i = 0; i < path->path_length; i++)
        {
            temp_map->map[path->path[i][1]][path->path[i][0]] = PATH;
        }
    }

    // Iterate through the map and print it
    printf("\n   ");
    for (uint8_t j = 0; j < temp_map->width; j++)
    {
        printf(" %2d", j + 1);
    }
    printf("\n");
    for (uint8_t i = 0; i < temp_map->height; i++)
    {
        printf("%2d ", i + 1);
        for (uint8_t j = 0; j < temp_map->width; j++)
        {
            switch (temp_map->map[i][j])
            {
            case (' '):
                printf("   ");
                break;
            case (PATH):
                printf(" * ");
                break;
            case ('#'):
                printf("###");
                break;
            }
        }
        printf("\n");
    }
    printf("\n");
}

void print_map_16(uint16_t map[MAX_HEIGHT][MAX_WIDTH], uint8_t width, uint8_t height)
{
    // Iterate through the map and print it
    printf("\n");
    for (uint8_t i = 0; i < height; i++)
    {
        for (uint8_t j = 0; j < width; j++)
        {
            printf("%5d ", map[i][j]);
        }
        printf("\n");
    }
}

void print_directions(Path *path)
{
    printf("Directions:\n");
    for (uint8_t i = 1; i <= path->directions_length; i++)
    {
        switch (path->directions[path->directions_length - i])
        {
        case FORWARD:
            printf("FORWARD");
            break;
        case LEFT:
            printf("LEFT");
            break;
        case RIGHT:
            printf("RIGHT");
            break;
        case BACKWARD:
            printf("BACKWARD");
            break;
        default:
            break;
        }
        if (i < path->directions_length)
        {
            printf(", ");
        }
    }
    printf("\n\n");
}