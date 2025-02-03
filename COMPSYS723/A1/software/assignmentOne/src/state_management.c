#include "../includes/state_management.h"
#include "../includes/defines.h"
#include "../includes/types.h"
#include "../includes/freq_analysing_unit.h"
#include "../includes/vga.h"
#include "../includes/defines.h"
#include "../includes/load_management.h"
#include "../includes/button.h"
#include <stdint.h>
#include <altera_avalon_pio_regs.h>

uint8_t currentState = StartUp_S;
TickType_t startTime = 0;
TickType_t taskStartTime = 0;
TickType_t taskEndTime = 0;
TickType_t upTime = 0;
xSemaphoreHandle outputValues_semaphore;

uint8_t stability = 0;
uint8_t firstLoadDropped = 0;
uint8_t maintenanceFlag = 0;
int8_t drop_load = 0;
FILE *fp;

void StateManagementTask(void *pvParameters)
{
    while (1)
    {
        /*
         * Manages the current state of the LCFR
         * and performs frequency calculations.
         * This includes the states: Start-up,
         * Normal Operation and Maintenance.
         *
         * Executes Periodically 100ms 
         *
         * Calculates frequency ROC 
         * Pushes ROC and Frequency to circular buffer 
         * 
         * Identifies current state and proceeds with appropriate opperations
         */

        uint8_t buttonVal;
        double freq[FreqAnalyserMsgSize];
        double rocFreq[FreqAnalyserMsgSize];
        int i = 0;
        static double last_freq = 0;

        // Perform frequency calculations
        // receive frequency data from queue
        while (uxQueueMessagesWaiting(freqAnalyserQ) != 0)
        {
            // Retrieve frequency from Queue 
            xQueueReceive(freqAnalyserQ, freq + i, 0);
           
            // calculate frequency RoC
            if (i == 0) // first value in array 
            {
                rocFreq[0] = (freq[0] - last_freq) * 2.0 * freq[0] * last_freq / (freq[0] + last_freq);
            }
            else // every other value of i 
            {
                rocFreq[i] = (freq[i] - freq[i - 1]) * 2.0 * freq[i] * freq[i - 1] / (freq[i] + freq[i - 1]);
            }
            ++i;
        }
        last_freq = freq[i - 1]; // set the last freq 

        
        // Handle semaphore
        xSemaphoreTake(outputValues_semaphore, portMAX_DELAY);
        for (int j = 0; j < i; j++)
        {
            //push to circular buffer
            circ_buf_push(&freq_buf, freq[j]);
            circ_buf_push(&rocFreq_buf, rocFreq[j]);
        }
        xSemaphoreGive(outputValues_semaphore);

        // State machine
        if (currentState == NormalOperation_S)
        {
            if ((freq[i - 1] < freqComp) || (rocFreq[i - 1] > rocComp) || (rocFreq[i - 1] < -rocComp))
            {
                //Get start time to get to measure response and stability time 
                startTime = xTaskGetTickCount();
                taskStartTime = xTaskGetTickCount();


                // set state to load management state
                currentState = LoadManagement_S; 
                fprintf(fp, "%c%sLoad Managing\n\n", esc, "[2j");

                //set drop load flag 
                xSemaphoreTake(dropLoad_semaphore, portMAX_DELAY);
                drop_load = 1;
                xSemaphoreGive(dropLoad_semaphore);
            }
        }
        else if (currentState == LoadManagement_S)
        {
            // get current tick count 
            TickType_t ticks = xTaskGetTickCount();

            // previous stability is added load back 
            static int8_t previousStability = -1;

            // if comparison values are breached (absolute for ROC )
            if ((freq[i - 1] < freqComp) || (rocFreq[i - 1] > rocComp) || (rocFreq[i - 1] < -rocComp))
            {
                stability = 0; 
            }
            else
            {
                stability = 1;
            }


            if (stability != previousStability && previousStability != -1)
            {
                //get start tick count 
                startTime = xTaskGetTickCount();
            }
            previousStability = stability;

            if ((ticks - startTime >= 500)) // if number of ticks exceeds or equals the 500ms boundary 
            {
                startTime = xTaskGetTickCount();
                if ((freq[i - 1] < freqComp) || (rocFreq[i - 1] > rocComp) || (rocFreq[i - 1] < -rocComp))
                {
                    drop_load = 1; // flag to drop load 
                }
                else
                {
                    drop_load = -1;
                    if (one_load_remaining == 1)
                    {
                        //set the current state to normal operation 
                        currentState = NormalOperation_S;
                        fprintf(fp, "%c%sNormal Operation\n\n", esc, "[2j");

                        
                        xSemaphoreTake(dropLoad_semaphore, portMAX_DELAY);
                        firstLoadDropped = 0; // clear first load dropped flag 
                        xSemaphoreGive(dropLoad_semaphore);
                    }
                }
            }
        }
        // Startup or other
        else
        {
            // Clear interrupt register
            IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTON_BASE, 0b111);
            // Enable interrupts
            IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PUSH_BUTTON_BASE, 0b1);
            // Register ISR
            alt_irq_register(PUSH_BUTTON_IRQ, (void *)&buttonVal, buttonISR);

            // Enable freq isr
            alt_irq_register(FREQUENCY_ANALYSER_IRQ, 0, freqRelayISR);

            currentState = NormalOperation_S;
            fprintf(fp, "%c%sNormal Operation\n\n", esc, "[2j");
        }

        // If button was pressed 
        if (buttonVal == 1) 
        {
            buttonVal = 0;
            if (maintenanceFlag)
            {
                maintenanceFlag = 0; // clear flag 
                currentState = NormalOperation_S; // set current state 
                fprintf(fp, "%c%sNormal Operation\n\n", esc, "[2j");// print to LCD 
            }
            else
            {
                maintenanceFlag = 1; // set flag 
                currentState = LoadManagement_S; // set current state to load management 
                fprintf(fp, "%c%sMaintenance\n\n", esc, "[2j"); // print to LCD 
            }
        }


        //set task to run periodically at every 100ms 
        vTaskDelay(100);
    }
}
