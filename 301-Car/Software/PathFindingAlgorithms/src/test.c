#include "test.h"
#include "dijkstra.h"
#include "a_star.h"
#include "print.h"
#include "map.h"
#include <stdio.h>
#include <windows.h>

int test_map(Map *map)
{
    LARGE_INTEGER frequency;
    LARGE_INTEGER start;
    LARGE_INTEGER end;
    double interval;
    QueryPerformanceFrequency(&frequency);

    // Initialise path
    Path path_s = {0};
    Path *path = &path_s;

    printf("-----------------------------------------------------------------\n");
    print_map(map, NULL);

    // A* Soloution
    printf("A* Soloution:\n");

    QueryPerformanceCounter(&start); // Start Time

    a_star(map, path);

    QueryPerformanceCounter(&end);                                           // End Time
    print_map(map, path);                                                    // Print map with soloution
    interval = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart; // Calculate time taken
    printf("Completion time: %f\n", interval);
    print_directions(path);

    // Reset Path
    path_s = (Path){0};

    // Dijkstra Soloution
    printf("Dijkstra Soloution:\n");

    QueryPerformanceCounter(&start); // Start Time

    dijkstra(map, path);

    QueryPerformanceCounter(&end);                                           // End Time
    print_map(map, path);                                                    // Print map with soloution
    interval = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart; // Calculate time taken
    printf("Completion time: %f\n", interval);
    print_directions(path);
}

int8_t test_a_star(Map *map, uint8_t *path_length, double *time_taken)
{
    LARGE_INTEGER frequency;
    LARGE_INTEGER start;
    LARGE_INTEGER end;
    uint8_t solved;
    QueryPerformanceFrequency(&frequency);

    Path path_s;
    Path *path = &path_s;
    if (VERBOSE)
    {
        printf("A* Soloution:\n");
    }

    *time_taken = 0.0;
    for (uint16_t i = 0; i < TEST_ITERATIONS; i++)
    {
        path_s = (Path){0};
        QueryPerformanceCounter(&start); // Start Time

        solved = a_star(map, path);

        QueryPerformanceCounter(&end);

        if (!solved)
        {
            return 0;
        }

        *time_taken += (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart; // Calculate time taken
    }
    *time_taken /= TEST_ITERATIONS;
    if (VERBOSE)
    {
        print_map(map, path);
        printf("Completion time: %f\n", *time_taken);
        print_directions(path);
    }

    return path->path_length == *path_length;
}

int8_t test_dijkstra(Map *map, uint8_t *path_length, double *time_taken)
{
    LARGE_INTEGER frequency;
    LARGE_INTEGER start;
    LARGE_INTEGER end;
    uint8_t solved;
    QueryPerformanceFrequency(&frequency);

    Path path_s;
    Path *path = &path_s;
    if (VERBOSE)
    {
        printf("Dijkstra Soloution:\n");
    }
    *time_taken = 0.0;
    for (uint16_t i = 0; i < TEST_ITERATIONS; i++)
    {
        path_s = (Path){0};
        QueryPerformanceCounter(&start); // Start Time

        solved = dijkstra(map, path);

        QueryPerformanceCounter(&end);

        if (!solved)
        {
            return 0;
        }

        *time_taken += (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart; // Calculate time taken
    }
    *time_taken /= TEST_ITERATIONS;
    if (VERBOSE)
    {
        print_map(map, path);
        printf("Completion time: %f\n", *time_taken);
        print_directions(path);
    }
    return path->path_length == *path_length;
}

void test_algs(Map *map, uint8_t *path_length, uint8_t *total_maps, uint8_t *solved_a_star, uint8_t *solved_dijkstra, double *total_time_taken_a_star, double *total_time_taken_dijkstra)
{
    double time_taken_a_star = 0.0;
    double time_taken_dijkstra = 0.0;

    (*total_maps)++;
    if (test_a_star(map, path_length, &time_taken_a_star))
    {
        (*solved_a_star)++;
        (*total_time_taken_a_star) += time_taken_a_star;
    }
    else
    {
        print_map(map, NULL);
        printf("ERROR: A* failed to solve maze %d\n", *total_maps);
    }
    if (test_dijkstra(map, path_length, &time_taken_dijkstra))
    {
        (*solved_dijkstra)++;
        (*total_time_taken_dijkstra) += time_taken_dijkstra;
    }
    else
    {
        print_map(map, NULL);
        printf("ERROR: Dijkstra failed to solve maze %d\n", *total_maps);
    }
}

void test_all()
{
    printf("Testing all mazes...\n");
    Map map_s;
    Map *map = &map_s;
    uint8_t path_length;

    double total_time_taken_a_star = 0.0;
    double total_time_taken_dijkstra = 0.0;

    uint8_t total_maps = 0;
    uint8_t solved_a_star = 0;
    uint8_t solved_dijkstra = 0;

    // Maze 1
    uint8_t maze[MAX_HEIGHT][MAX_WIDTH] = {
        "################# #",
        "#     #       #   #",
        "### # # # ### # # #",
        "# #     # #     # #",
        "# # # ### # ### # #",
        "#   #     #     # #",
        "# #######   ### # #",
        "#   #     #   # # #",
        "###   ##### # # # #",
        "#   #     # #     #",
        "# #######   ##### #",
        "#     #   # #   # #",
        "##### # ### # # # #",
        "        #     #   #",
        "###################"};

    generateMap(map, maze, 19, 15, 1, 14, 18, 1);
    path_length = 31;
    test_algs(map, &path_length, &total_maps, &solved_a_star, &solved_dijkstra, &total_time_taken_a_star, &total_time_taken_dijkstra);

    // Maze 2
    uint8_t maze2[MAX_HEIGHT][MAX_WIDTH] = {
        "# #############",
        "# ####         ",
        "#  #   #       ",
        "#  #   #       ",
        "#      #       ",
        "########       ",
    };
    generateMap(map, maze2, 15, 6, 2, 1, 15, 6);
    path_length = 25;
    test_algs(map, &path_length, &total_maps, &solved_a_star, &solved_dijkstra, &total_time_taken_a_star, &total_time_taken_dijkstra);

    // Maze 3
    uint8_t maze3[MAX_HEIGHT][MAX_WIDTH] = {
        "# #################",
        "#     #       #   #",
        "### # ### ### # ###",
        "# #     # #     # #",
        "# # # ### # ### # #",
        "#   #     #       #",
        "# ####### # ##### #",
        "#   #     #   # # #",
        "###   ##### ### ###",
        "#   #     # #     #",
        "# #######   ##### #",
        "#     #   # #   # #",
        "# ### # ### # # # #",
        "#       #     #   #",
        "################# #"};
    generateMap(map, maze3, 19, 15, 2, 1, 18, 15);
    path_length = 39;
    test_algs(map, &path_length, &total_maps, &solved_a_star, &solved_dijkstra, &total_time_taken_a_star, &total_time_taken_dijkstra);

    // Stats
    printf("Stats:\n");
    printf("Total Maps: %d\n", total_maps);
    printf("Solved A*: %d/%d\n", solved_a_star, total_maps);
    printf("Average A* soloution time: %f\n", total_time_taken_a_star / solved_a_star);
    printf("Solved Dijkstras: %d/%d\n", solved_dijkstra, total_maps);
    printf("Average Dijkstra soloution time: %f\n", total_time_taken_dijkstra / solved_dijkstra);
}
