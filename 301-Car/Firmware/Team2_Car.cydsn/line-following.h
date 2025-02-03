/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
 */
// Includes
#include <project.h>

// Defines
#define NONE 0
#define DRIVEFORWARD 1
#define CORRECTLEFT 2
#define CORRECTRIGHT 3
#define WAITTURNLEFT 4
#define WAITTURNRIGHT 5
#define TURNCARLEFT 6
#define TURNCARRIGHT 7

#define FLSENSOR 0
#define FMSENSOR 1
#define FRSENSOR 2
#define BLSENSOR 3
#define BRSENSOR 4
#define BMSENSOR 5

//#define ONLINE(reg) ((reg >> FMSENSOR) & 1)
#define ONLINE(reg) ((((reg >> FMSENSOR) & 1) && (((reg >> FLSENSOR) & 1) == 0) && (((reg >> FRSENSOR) & 1) == 0)))
#define OFFONLEFT(reg) ((((reg >> FRSENSOR) & 1) && (((reg >> FMSENSOR) & 1) == 0)))
#define OFFONRIGHT(reg) ((((reg >> FLSENSOR) & 1) && (((reg >> FMSENSOR) & 1) == 0)))
#define TURNLEFT(reg) (((reg >> BLSENSOR) & 1) && ((((reg >> FMSENSOR) & 1) == 0) && (((reg >> FLSENSOR) & 1) == 0)))
#define TURNRIGHT(reg) (((reg >> BRSENSOR) & 1) && ((((reg >> FMSENSOR) & 1) == 0) && (((reg >> FRSENSOR) & 1) == 0)))

#define MOVE_CM_S 17
#define MOVE_SPEED MOVE_CM_S * 60 / 20.4
// #define MOVE_SPEED 50
#define CONTROL_SPEED 40 // changed to 50 
#define TURN_COUNT 111
#define METRE_COUNT 1118
#define ENDLESS -1

// External variables
extern uint8_t currentState;

// Function definitions
void follow_line();

/* [] END OF FILE */
