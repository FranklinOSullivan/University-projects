#include "dijkstra.h"
#include "constants.h"
#include <stdio.h>

#define VALID_NODE(x, y, width, height) (x < width && x >= 0 && y < height && y >= 0)

uint8_t dijkstra(Map *map, Path *path)
{
    if (map->map[map->start_y][map->start_x] == '#' || map->map[map->end_y][map->end_x] == '#')
    {
        return 0;
    }
    uint8_t current_map[MAX_HEIGHT][MAX_WIDTH];
    uint8_t visited[MAX_HEIGHT][MAX_WIDTH] = {{0}};
    uint16_t distances[MAX_HEIGHT][MAX_WIDTH] = {{0}};

    // Set all obstacles to 255 and normal tiles to 1 (uint8_t max, basically infinity)
    // And set all distances to infinity
    for (uint8_t i = 0; i < map->height; i++)
    {
        for (uint8_t j = 0; j < map->width; j++)
        {
            distances[i][j] = 65535;
        }
    }

    // Set Start and End to 0
    current_map[map->start_y][map->start_x] = 0;
    current_map[map->end_y][map->end_x] = 0;

    // Set Start Distance to 0
    distances[map->start_y][map->start_x] = 0;

    // Initialise current and potential coordinates
    uint8_t potential_x;
    uint8_t potential_y;
    uint8_t current_x = map->start_x;
    uint8_t current_y = map->start_y;
    while (1)
    {
        // For each Direction
        for (uint8_t i = 0; i < 4; i++)
        {
            potential_x = current_x;
            potential_y = current_y;
            switch (i)
            {
            case UP:
                potential_y--;
                break;
            case DOWN:
                potential_y++;
                break;
            case LEFT:
                potential_x--;
                break;
            case RIGHT:
                potential_x++;
                break;
            default:
                break;
            }
            // Check the coordinate is valid
            if (VALID_NODE(potential_x, potential_y, map->width, map->height) && map->map[potential_y][potential_x] != '#')
            {
                // Check if the node has been visited
                if (visited[potential_y][potential_x] == 0)
                {
                    // Check if the distance to the node is shorter than the current distance
                    if (distances[potential_y][potential_x] > distances[current_y][current_x] + 1)
                    {
                        distances[potential_y][potential_x] = distances[current_y][current_x] + 1;
                    }
                }
            }
        }

        // After checking all directions, mark the current node as visited
        visited[current_y][current_x] = 1;

        // Find the mininum not visited node
        uint16_t min_distance = 65535;
        for (uint8_t i = 0; i < map->height; i++)
        {
            for (uint8_t j = 0; j < map->width; j++)
            {
                if (visited[i][j] == 0 && distances[i][j] < min_distance)
                {
                    min_distance = distances[i][j];
                    current_x = j;
                    current_y = i;
                }
            }
        }
        // If the end node is visited, break
        if (current_x == map->end_x && current_y == map->end_y)
        {
            break;
        }
    }

    // initialise best coordiantes, distance and path variables
    uint8_t best_x;
    uint8_t best_y;
    uint16_t best_distance;
    uint8_t node_paths;
    uint8_t previous_direction = NONE;
    uint8_t step_direction = NONE;
    current_x = map->end_x;
    current_y = map->end_y;
    path->path_length = 1;
    path->path[0][0] = current_x;
    path->path[0][1] = current_y;

    while (1)
    {
        // For each Direction
        best_x = current_x;
        best_y = current_y;
        best_distance = 65535;
        node_paths = 0;

        for (uint8_t i = 0; i < 4; i++)
        {
            potential_x = current_x;
            potential_y = current_y;

            switch (i)
            {
            case UP:
                potential_y--;
                break;
            case DOWN:
                potential_y++;
                break;
            case LEFT:
                potential_x--;
                break;
            case RIGHT:
                potential_x++;
                break;
            default:
                break;
            }
            // Check if the potential node is valid
            if (VALID_NODE(potential_x, potential_y, map->width, map->height) && map->map[potential_y][potential_x] != '#')
            {
                // Check if the potential node is not a wall
                if (map->map[potential_y][potential_x] == ' ')
                {
                    node_paths++;
                    // Check if the potential node is the closest to the start than the current node
                    if (best_distance > distances[potential_y][potential_x])
                    {
                        step_direction = i;
                        best_distance = distances[potential_y][potential_x];
                        best_x = potential_x;
                        best_y = potential_y;
                    }
                }
            }
        }

        // If it is a turn or a junction, add the direction to the directions list
        if ((step_direction != previous_direction && previous_direction != NONE) || node_paths > 2)
        {
            // Add direction to path
            uint8_t direction = (4 - (step_direction - previous_direction)) % 4;
            path->directions[path->directions_length++] = direction;
        }

        // Update current node
        current_x = best_x;
        current_y = best_y;
        previous_direction = step_direction;

        // Add current node to path
        path->path[path->path_length][0] = current_x;
        path->path[path->path_length][1] = current_y;
        path->path_length++;

        // if the current node is the start node, break
        if (best_x == map->start_x && best_y == map->start_y)
        {
            break;
        }
    }
    return 1;
}