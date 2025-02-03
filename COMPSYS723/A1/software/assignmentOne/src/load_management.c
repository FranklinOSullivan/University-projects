#include "../includes/load_management.h"
#include "../includes/defines.h"
#include "../includes/state_management.h"
#include "../freertos/FreeRTOS.h"
#include "../freertos/semphr.h"
#include "../freertos/timers.h"

#include <system.h>
#include <altera_avalon_pio_regs.h>

xSemaphoreHandle dropLoad_semaphore;
xSemaphoreHandle loadStatus_semaphore;
uint8_t one_load_remaining = 0;
load_status_t load_status = {0};

void LoadManagementTask(void *pvParameters)
{
    while (1)
    {
        /*
         * Manages the state of each load (on/off)
         * and handles instability based on Frequency
         * and Frequency Rate of Change values.
         * Executes periodically (50 ms)
         *
         * Reads Maintenance Flag
         * Reads / Writes Output Values
         *
         *
         */

        /* If all values are fine */
        static uint8_t keys = 0;
        static uint8_t disabled_loads = 0;
        uint8_t new_keys = IORD_ALTERA_AVALON_PIO_DATA(SLIDE_SWITCH_BASE) & 0b1111111;

        if (currentState == LoadManagement_S)
        {
            // Add new keys to disabled.
            disabled_loads |= new_keys ^ keys;
        }

        keys = new_keys;
        // Normal operation
        if (!maintenanceFlag)
        {
            disabled_loads &= keys;
            int lowestLoad = 0;
            // 1 means loads are being dropped. -1 means add loads
            if (drop_load == 1)
            {
                xSemaphoreTake(dropLoad_semaphore, portMAX_DELAY);
                drop_load = 0;
                xSemaphoreGive(dropLoad_semaphore);

                // searching from the LSB to the MSB of the keys
                for (int i = 0; i < 7; i++)
                {
                    // if current bit is 1 and is not currently disabled
                    if ((((keys >> i) & 1) == 1) && (((disabled_loads >> i) & 1) != 1))
                    {
                        // we have identified the lowest load
                        lowestLoad = i;
                        // disable the load
                        disabled_loads |= (1 << lowestLoad);
                        // Load has been dropped

                        // if this is the first load to be dropped
                        if (firstLoadDropped == 0)
                        {
                            // get the end time/ time it took to shed this first load.
                            taskEndTime = xTaskGetTickCount();
                        }
                        // access the shared resoruce first load dropped flag and set to 1
                        xSemaphoreTake(dropLoad_semaphore, portMAX_DELAY);
                        firstLoadDropped = 1;
                        xSemaphoreGive(dropLoad_semaphore);

                        break;
                    }
                }
            }
            // if we then need to add a load
            else if (drop_load == -1)
            {
                // clear the flag
                drop_load = 0;

                // search for the LSB in keys that has been disabled
                for (int i = 7 - 1; i >= 0; i--)
                {
                    if ((((keys >> i) & 1) == 1) && (((disabled_loads >> i) & 1) == 1))
                    {
                        lowestLoad = i;
                        // not-ing the disable from before to now enable the load
                        disabled_loads &= ~(1 << lowestLoad);

                        break;
                    }
                }
            }
            // set the number of loads remaining
            one_load_remaining = disabled_loads && !(disabled_loads & (disabled_loads - 1));
        }
        else
        {
            disabled_loads = 0;
        }

        // Keep only the lowest seven loads
        //semaphore critical section sets the enabled loads and disabled loads to the local keys and disabled loads calculated above.
        xSemaphoreTake(loadStatus_semaphore, portMAX_DELAY);
        load_status.switchEnabled = keys;
        load_status.loadDisabled = disabled_loads;
        xSemaphoreGive(loadStatus_semaphore);

        // Task runs every 50ms periodically 
        vTaskDelay(50);
    }
}
