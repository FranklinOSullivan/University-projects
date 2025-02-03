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

/* [] END OF FILE */
#include "motorPID.h"
#include "print.h"
#include <stdlib.h>

int32 distanceCountL, distanceCountR = 0;
int32 distanceTarget;
uint8 flag_PID = 0;
uint8 flag_PID_ON = 0;
uint8 targetReached = 0;

uint16 pwmL;
int16 countL, current_countL, stateL, delta_countL;
float filter_countL, errorL, error_I_L, error_D_L, target_countL;

uint16 pwmR;
int16 countR, current_countR, stateR, delta_countR;
float filter_countR, errorR, error_I_R, error_D_R, target_countR;
uint8 target_RPM;

float KP, KI, KD;

// Runs 4000hz based on a timer
CY_ISR(MOTOR_PID_ISR)
{
    current_countL = QuadDec_M1_GetCounter();
    stateL = QuadDec_M1_GetEvents();
    current_countR = QuadDec_M2_GetCounter();
    stateR = QuadDec_M2_GetEvents();
    PID_Timer_ReadStatusRegister();
    flag_PID = flag_PID_ON;
}

void setDistance(int32 target)
{
    if (target < 0)
    {
        target = INT_MAX;
    }
    targetReached = 0;
    distanceCountL = 0;
    distanceCountR = 0;
    distanceTarget = target;
}

void setTargetRPM(float targetRPM, uint8 direction)
{
    float target_count;

    if (targetRPM > MAX_RPM)
    {
        targetRPM = MAX_RPM;
    }

    target_RPM = targetRPM;
    target_count = (targetRPM * COUNTS_PER_ROTATION / 60.0 * DELTA_TIME);

    switch (direction)
    {
    case (FORWARD):
        target_countL = target_count;
        target_countR = target_count;
        break;
    case (LEFT):
        target_countL = -target_count;
        target_countR = target_count;
        break;
    case (RIGHT):
        target_countL = target_count;
        target_countR = -target_count;
        break;
    //case (REVERSE):
    //    target_countL = -target_count;
    //    target_countR = -target_count;
    //    break;
    case (CORRECTTOLEFT):
        target_countL = ((targetRPM*1.3 ) * COUNTS_PER_ROTATION / 60.0 * DELTA_TIME);
        target_countR = (targetRPM * COUNTS_PER_ROTATION / 60.0 * DELTA_TIME);
        break;
    case (CORRECTTORIGHT):
    
        target_countR = ((targetRPM*1.3) * COUNTS_PER_ROTATION / 60.0 * DELTA_TIME);
        target_countL = (targetRPM * COUNTS_PER_ROTATION / 60.0 * DELTA_TIME);
        break;
    default:
        target_countL = target_count;
        target_countR = target_count;
        break;
    }
    MOTORS_ENABLE;
    flag_PID_ON = 1;
}

void reset_pid()
{
    QuadDec_M1_SetCounter(0);
    QuadDec_M2_SetCounter(0);
    countL = 0;
    delta_countL = 0;
    filter_countL = 0;
    errorL = 0;
    error_I_L = 0;
    error_D_L = 0;

    countR = 0;
    delta_countR = 0;
    filter_countR = 0;
    errorR = 0;
    error_I_R = 0;
    error_D_R = 0;
}

void motorPIDInit()
{
    flag_PID_ON = 0;
    MOTORS_DISABLE;
    INVL_Write(0);
    INVR_Write(0);
    PWM_1_Start();
    PWM_1_WriteCompare(0);
    QuadDec_M1_Start();

    PWM_2_Start();
    PWM_2_WriteCompare(0);
    QuadDec_M2_Start();

    PID_Timer_WritePeriod(100000 / F_SAMPLE);
    PID_Timer_Start();

    countL = 0;
    delta_countL = 0;
    filter_countL = 0;
    errorL = 0;
    error_I_L = 0;
    error_D_L = 0;

    countR = 0;
    delta_countR = 0;
    filter_countR = 0;
    errorR = 0;
    error_I_R = 0;
    error_D_R = 0;

    KP = K_P;
    KD = K_D;
    KI = K_I;
}

void motorPID()
{
    // Calculate the change in count
    float pwm_L, prev_errorL;
    int16 prev_delta_countL = delta_countL;

    float pwm_R, prev_errorR;
    int16 prev_delta_countR = delta_countR;

    delta_countL = current_countL - countL;
    delta_countL += ((stateL & QuadDec_M1_COUNTER_OVERFLOW) != 0) * 32767;
    delta_countL += ((stateL & QuadDec_M1_COUNTER_UNDERFLOW) != 0) * -32768;
    countL = current_countL;

    delta_countR = current_countR - countR;
    delta_countR += ((stateR & QuadDec_M2_COUNTER_OVERFLOW) != 0) * 32767;
    delta_countR += ((stateR & QuadDec_M2_COUNTER_UNDERFLOW) != 0) * -32768;
    countR = current_countR;

    distanceCountL += delta_countL;
    distanceCountR += delta_countR;
    int32 asjustedTarget = distanceTarget - (target_RPM * 3 / 10);
    if (distanceCountL >= asjustedTarget || distanceCountL <= -asjustedTarget || distanceCountR >= asjustedTarget || distanceCountR <= -asjustedTarget)
    {
        target_countL = 0;
        target_countR = 0;
        targetReached = 1;
    }

    // Filter the count
    filter_countL = FILTER_B * filter_countL + FILTER_A * (delta_countL + prev_delta_countL);
    filter_countR = FILTER_B * filter_countR + FILTER_A * (delta_countR + prev_delta_countR);

    // Calculate the error
    prev_errorL = errorL;
    errorL = target_countL - filter_countL;

    prev_errorR = errorR;
    errorR = target_countR - filter_countR;

    // Calculate the integral and the derivative
    error_I_L += errorL;
    error_D_L = (errorL - prev_errorL);

    error_I_R += errorR;
    error_D_R = (errorR - prev_errorR);

    // Calculate the new PWM
    pwm_L = KP * errorL + KI * error_I_L + KD * error_D_L;
    pwm_R = KP * errorR + KI * error_I_R + KD * error_D_R;

    if (pwm_L >= 0)
    {
        MOTOR_FORWARD(LEFT_MOTOR);
        if (pwm_L > (MAX_PWM - MIN_PWM))
        {
            pwmL = MAX_PWM;
        }
        else
        {
            pwmL = (uint16)pwm_L + MIN_PWM;
        }
    }
    else
    {
        MOTOR_REVERSE(LEFT_MOTOR);
        if (pwm_L < -(MAX_PWM - MIN_PWM))
        {
            pwmL = MAX_PWM;
        }
        else
        {
            pwmL = (uint16)-pwm_L + MIN_PWM;
        }
    }

    if (pwm_R >= 0)
    {
        MOTOR_FORWARD(RIGHT_MOTOR);
        if (pwm_R > (MAX_PWM - MIN_PWM))
        {
            pwmR = MAX_PWM;
        }
        else
        {
            pwmR = (uint16)pwm_R + MIN_PWM;
        }
    }
    else
    {
        MOTOR_REVERSE(RIGHT_MOTOR);
        if (pwm_R < -(MAX_PWM - MIN_PWM))
        {
            pwmR = MAX_PWM;
        }
        else
        {
            pwmR = (uint16)-pwm_R + MIN_PWM;
        }
    }

    PWM_1_WriteCompare(pwmL);
    PWM_2_WriteCompare(pwmR);
}