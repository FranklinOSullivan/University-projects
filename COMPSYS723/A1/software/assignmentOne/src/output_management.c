#include "../includes/output_management.h"
#include "../includes/load_management.h"
#include "../includes/types.h"
#include <altera_avalon_pio_regs.h>


void OutputManagementTask(void *pvParameters)
{
    while (1)
    {
        /*
         * Task retrieves the load status and disable loads global variables 
         * Stores them locally then writes to the green and red LED bases.
         *
         * Executes periodically (100 ms)
         *
         */
        load_status_t loadStatus;

        // set local values to global values 
        xSemaphoreTake(loadStatus_semaphore, portMAX_DELAY);
        loadStatus.switchEnabled = load_status.switchEnabled;
        loadStatus.loadDisabled = load_status.loadDisabled;
        xSemaphoreGive(loadStatus_semaphore);

        //writing to LEDs
        IOWR_ALTERA_AVALON_PIO_DATA(RED_LEDS_BASE, loadStatus.switchEnabled & (loadStatus.loadDisabled ^ 0xFF));
        IOWR_ALTERA_AVALON_PIO_DATA(GREEN_LEDS_BASE, loadStatus.loadDisabled);

        // Delay
        vTaskDelay(100);
    }
}
