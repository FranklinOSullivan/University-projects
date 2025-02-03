#include "map.h"
#include "test.h"
#include <stdio.h>
#include <windows.h>

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

int main(int argc, char **argv)
{
    test_all();

    Map map_s;
    Map *map = &map_s;

    generateMap(map, maze, 19, 15, 1, 14, 18, 1);
    test_map(map);

    return 0;
}
