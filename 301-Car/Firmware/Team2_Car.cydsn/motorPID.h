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

#include <math.h>
#include <project.h>

#define F_CUTOFF 20
#define F_SAMPLE 2000

#define K_P 100000 
#define K_I 400 // 0.15
#define K_D 700

#define FORWARD 0
#define LEFT 1
#define REVERSE 2
#define RIGHT 3
#define CORRECTTOLEFT 4
#define CORRECTTORIGHT 5
// ---------------------------------------------
#define COUNTS_PER_ROTATION 228
#define MAX_RPM 200
#define MAX_PWM 65535
#define MIN_PWM 0

#define DELTA_TIME (1.0 / F_SAMPLE)
#define OMEGA_CUTOFF (2 * M_PI * F_CUTOFF)
#define DISABLE_PID flag_PID_ON = 0
#define FILTER_A ((OMEGA_CUTOFF * DELTA_TIME) / (OMEGA_CUTOFF * DELTA_TIME + 2))
#define FILTER_B (-(OMEGA_CUTOFF * DELTA_TIME - 2) / (OMEGA_CUTOFF * DELTA_TIME + 2))

#define LEFT_MOTOR 0
#define RIGHT_MOTOR 1
#define MOTOR_ENABLE(side) MOTOR_DISABLE_Write(MOTOR_DISABLE_Read() & ~(1 << side))
#define MOTORS_ENABLE MOTOR_DISABLE_Write(0)
#define MOTOR_DISABLE(side) MOTOR_DISABLE_Write(MOTOR_DISABLE_Read() | (1 << side))
#define MOTORS_DISABLE MOTOR_DISABLE_Write(255)

#define MOTOR_FORWARD(side) MOTOR_DIR_Write(MOTOR_DIR_Read() & ~(1 << side))
#define MOTOR_REVERSE(side) MOTOR_DIR_Write(MOTOR_DIR_Read() | (1 << side))

CY_ISR_PROTO(MOTOR_PID_ISR);

extern uint8 flag_PID, flag_PID_ON;
extern uint16 pwmL, pwmR;
extern int16 delta_countL, delta_countR;
extern float filter_countL, filter_countR;
extern float errorL, errorR;
extern uint8 targetReached;
extern float KP, KI, KD;

void setTargetRPM(float targetRPM, uint8 direction);
void setDistance(int32 target);
void motorPIDInit();
void motorPID();
void reset_pid();

/* [] END OF FILE */
