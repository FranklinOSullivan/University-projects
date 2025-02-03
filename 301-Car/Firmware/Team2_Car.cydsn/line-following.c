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
#include "line-following.h"
#include "motorPID.h"

// External variables
uint8_t currentAct;
uint8_t currentState;
uint8_t sensorVal;

// Function prototypes
void follow_line();
void check_sensors();
void drive_forward();
void correct_left();
void correct_right();
void turn_left();
void turn_right();
void stop_car();

void follow_line()
{
    // FL, FM, FR
    // BL,   , BR
    //   , MB,
    // Read status register of sensors
    float rpmL, rpmR;
    sensorVal = InputStatusReg_Read();
    switch (currentState)
    {
    case DRIVEFORWARD:      
        // If we have a no value
        drive_forward();
        if (OFFONLEFT(sensorVal))
        {
            currentState = CORRECTLEFT;
        }
        else if (OFFONRIGHT(sensorVal))
        {
            currentState = CORRECTRIGHT;
        }
        else if (TURNLEFT(sensorVal))
        {
            currentState = TURNCARLEFT;
            stop_car();
        }
        else if (TURNRIGHT(sensorVal))
        {
            currentState = TURNCARRIGHT;
            stop_car();
        }

        break;

    case CORRECTLEFT:
        correct_left();
        if (ONLINE(sensorVal))
        {
            currentState = DRIVEFORWARD;
        }
        else if (OFFONRIGHT(sensorVal))
        {
            currentState = CORRECTRIGHT;
        }
        else if (TURNLEFT(sensorVal))
        {
            currentState = TURNCARLEFT;
            stop_car();
        }
        else if (TURNRIGHT(sensorVal))
        {
            currentState = TURNCARRIGHT;
            stop_car();
        }
        break;
    case CORRECTRIGHT:
        correct_right();
        if (ONLINE(sensorVal))
        {
            currentState = DRIVEFORWARD;
        }
        else if (OFFONLEFT(sensorVal))
        {
            currentState = CORRECTLEFT;
        }
        else if (TURNLEFT(sensorVal))
        {
            currentState = TURNCARLEFT;
            stop_car();
        }
        else if (TURNRIGHT(sensorVal))
        {
            currentState = TURNCARRIGHT;
            stop_car();
        }
        break;
    case TURNCARLEFT:
        rpmR = (filter_countR * 60) / (COUNTS_PER_ROTATION  * DELTA_TIME);
        rpmL = (filter_countL * 60) / (COUNTS_PER_ROTATION  * DELTA_TIME);
        if (OFFONRIGHT(sensorVal) || ONLINE(sensorVal))
        {
            reset_pid();
            stop_car();
            if ((rpmL < 1) && (rpmR < 1))
            {   
                currentState = DRIVEFORWARD;
            }
            break;
        }

        if ((rpmL < 1) && (rpmR < 1))
        {
            turn_left();
        }        
        break;
    case TURNCARRIGHT:
        rpmL = (filter_countL * 60) / (COUNTS_PER_ROTATION  * DELTA_TIME);
        rpmR = (filter_countR * 60) / (COUNTS_PER_ROTATION  * DELTA_TIME);
        if (OFFONLEFT(sensorVal) || ONLINE(sensorVal))
        {
            reset_pid();
            stop_car();
            if ((rpmL < 1) && (rpmR < 1))
            {   
                currentState = DRIVEFORWARD;
            }
            break;
        }

        if ((rpmL < 1) && (rpmR < 1))
        {
            turn_right();
        }
        break;
    default:
        currentState = DRIVEFORWARD;
        break;
    }
}

void drive_forward()
{
    setTargetRPM(MOVE_SPEED, FORWARD);
}

void correct_left()
{
    setTargetRPM(MOVE_SPEED, CORRECTTOLEFT);
}

void correct_right()
{
    setTargetRPM(MOVE_SPEED, CORRECTTORIGHT);
}

void stop_car(){
    MOTORS_DISABLE;
    setTargetRPM(0, FORWARD);
}

void turn_left()
{
    PWM_1_WriteCompare(25500);
    PWM_2_WriteCompare(25500);
    MOTOR_FORWARD(RIGHT_MOTOR);
    MOTOR_REVERSE(LEFT_MOTOR);
    DISABLE_PID;
    //setTargetRPM(CONTROL_SPEED, LEFT);
}

void turn_right()
{
    PWM_1_WriteCompare(25500);
    PWM_2_WriteCompare(25500);
    MOTOR_FORWARD(LEFT_MOTOR);
    MOTOR_REVERSE(RIGHT_MOTOR);
    DISABLE_PID;
    //setTargetRPM(CONTROL_SPEED, RIGHT);
}

/* [] END OF FILE */
