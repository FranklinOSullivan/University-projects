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
#include "print.h"

uint8 ts = 0;
uint16 ts_enc = 0;
uint16 ts_update = 0;
uint16 ts_speed = 0;
uint16 ts_display = 0;

uint8 flag_ts_enc = 0;
uint8 flag_ts_update = 0;
uint8 flag_ts_speed = 0;
uint8 flag_ts_display = 0;

uint8 flag_rx = 0;
uint8 flag_packet = 0;
uint8 flag_KB_string = 0;

uint8 dataready_flag = 0;

uint8 flag_rf_transmission_active = UNKNOWN; // [TRUE if receieving data, FALSE is not, UNKNOWN at startup]

char line[BUF_SIZE], entry[BUF_SIZE];
uint8 usbBuffer[BUF_SIZE];
char displaystring[BUF_SIZE] = "CS301 2023\n\n\r";

void usbPutString(char *s)
{
    // !! Assumes that *s is a string with allocated space >=64 chars
    //  Since USB implementation retricts data packets to 64 chars, this function truncates the
    //  length to 62 char (63rd char is a '!')

#ifdef USE_USB
    while (USBUART_CDCIsReady() == 0)
        ;
    s[63] = '\0';
    s[62] = '!';
    USBUART_PutData((uint8 *)s, strlen(s));
#endif
}
//* ========================================
void usbPutChar(char c)
{
#ifdef USE_USB
    while (USBUART_CDCIsReady() == 0)
        ;
    USBUART_PutChar(c);
#endif
}
//* ========================================
void handle_usb()
{
    // handles input at terminal, echos it back to the terminal
    // turn echo OFF, key emulation: only CR
    // entered string is made available in 'line' and 'flag_KB_string' is set

    static uint8 usbStarted = FALSE;
    static uint16 usbBufCount = 0;
    uint8 c;

    if (!usbStarted)
    {
        if (USBUART_GetConfiguration())
        {
            USBUART_CDC_Init();
            usbStarted = TRUE;
        }
    }
    else
    {
        if (USBUART_DataIsReady() != 0)
        {
            c = USBUART_GetChar();

            if ((c == 13) || (c == 10))
            {
                //                if (usbBufCount > 0)
                {
                    entry[usbBufCount] = '\0';
                    strcpy(line, entry);
                    usbBufCount = 0;
                    flag_KB_string = 1;
                }
            }
            else
            {
                if (((c == CHAR_BACKSP) || (c == CHAR_DEL)) && (usbBufCount > 0))
                    usbBufCount--;
                else
                {
                    if (usbBufCount > (BUF_SIZE - 2)) // one less else strtok triggers a crash
                    {
                        USBUART_PutChar('!');
                    }
                    else
                        entry[usbBufCount++] = c;
                }
            }
            usbPutChar(c);
        }
    }
}


/* [] END OF FILE */
