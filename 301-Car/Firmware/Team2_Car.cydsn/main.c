/* ========================================
 * Fully working code:
 * PWM      :
 * Encoder  :
 * ADC      :
 * USB      : port displays speed and position.
 * CMD: "PW xx"
 * Copyright Univ of Auckland, 2016
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF Univ of Auckland.
 *
 * ========================================
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <project.h>
//* ========================================
#include "defines.h"
#include "motorPID.h"
#include "print.h"
#include "line-following.h"
//* ========================================
void usbPutString(char *s);
void usbPutChar(char c);
void handle_usb();
//* ========================================
void handleInput();

int main()
{
    // --------------------------------
    // ----- INITIALIZATIONS ----------
    CYGlobalIntEnable;

// ------USB SETUP ----------------
#ifdef USE_USB
    USBUART_Start(0, USBUART_5V_OPERATION);
    RF_BT_SELECT_Write(0);
    usbPutString(displaystring);
    usbPutString("Input a Command\n\r");
    usbPutString("> ");
#endif
    PID_ISR_StartEx(MOTOR_PID_ISR);
    motorPIDInit();
    // Initial car state
    currentState = DRIVEFORWARD;
    // Set the distance the car will drive
    setDistance(ENDLESS);
    // Delay 5s
    CyDelay(2000);
    
    while (1)
    {
        /* Place your application code here. */
#ifdef USE_USB
        handle_usb();
        if (flag_KB_string == 1)
        {
            usbPutString("\n\r");
            flag_KB_string = 0;
            handleInput(line);
        }
#endif
        if (flag_PID == 1)
        {
            motorPID();
            flag_PID = 0;
        }
        // Run the line following methods
        follow_line();
    }
}

// Function to handle the USB input
void handleInput(char *userInput)
{
    /*
        Basic Command Passer
    */
    if (!strncasecmp(userInput, "LEFT", 4))
    {
        int16 result;
        result = atoi(userInput + 4);
        setTargetRPM(result, LEFT);
        sprintf(displaystring, "Set Left Motor Target to %d RPM\n\r", result);
        usbPutString(displaystring);
    }
    else if (!strncasecmp(userInput, "RIGHT", 5))
    {
        int16 result;
        result = atoi(userInput + 5);
        setTargetRPM(result, RIGHT);
        sprintf(displaystring, "Set Right Motor Target to %d RPM\n\r", result);
        usbPutString(displaystring);
    }
    else if (!strncasecmp(userInput, "FORWARD", 4))
    {
        int16 result;
        result = atoi(userInput + 4);
        setTargetRPM(result, FORWARD);
        sprintf(displaystring, "Set Both Motors Target to %d RPM\n\r", result);
        usbPutString(displaystring);
    }
    else if (!strncasecmp(userInput, "REVERSE", 4))
    {
        int16 result;
        result = atoi(userInput + 4);
        setTargetRPM(result, REVERSE);
        sprintf(displaystring, "Set Both Motors Target to %d RPM\n\r", result);
        usbPutString(displaystring);
    }
    else if (!strncasecmp(userInput, "STATS", 5))
    {
        float rpmL = (filter_countL * 60.0 * F_SAMPLE) / COUNTS_PER_ROTATION;
        float rpmR = (filter_countR * 60.0 * F_SAMPLE) / COUNTS_PER_ROTATION;
        sprintf(displaystring, "CL: %d CR: %d\n\r", delta_countL, delta_countR);
        usbPutString(displaystring);
        sprintf(displaystring, "FL: %d FR: %d\n\r", (int16)filter_countL, (int16)filter_countR);
        usbPutString(displaystring);
        sprintf(displaystring, "rpmL: %d rpmR: %d\n\r", (int16)rpmL, (int16)rpmR);
        usbPutString(displaystring);
        sprintf(displaystring, "PWML: %d PWMR: %d\n\r", pwmL, pwmR);
        usbPutString(displaystring);
        sprintf(displaystring, "EL: %d ER: %d\n\r", (int16)errorL, (int16)errorR);
        usbPutString(displaystring);
    }
    else if (!strncasecmp(userInput, "KP", 2))
    {
        int16 result;
        result = atoi(userInput + 4);
        KP = (float)result;
        sprintf(displaystring, "Set KP to %d\n\r", result);
    }
    else if (!strncasecmp(userInput, "KI", 2))
    {
        int16 result;
        result = atoi(userInput + 4);
        KI = (float)result;
        sprintf(displaystring, "Set KP to %d\n\r", result);
    }
    else if (!strncasecmp(userInput, "KD", 2))
    {
        int16 result;
        result = atoi(userInput + 4);
        KD = (float)result;
        sprintf(displaystring, "Set KP to %d\n\r", result);
    }
    else
    {
        usbPutString("Command not recognised!\n\r");
    }
    usbPutString("> ");
}
/* [] END OF FILE */
