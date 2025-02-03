#include "../includes/button.h"
#include <system.h>
#include <altera_avalon_pio_regs.h>

/* Setting up button ISR for enabling maintenance mode*/
void buttonISR(void *context, alt_u32 id)
{
    //set temp to context pointer 
    int *temp = (int *)context;
    // Read the button values
    (*temp) = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTON_BASE);
    // Clear the register
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTON_BASE, 0b111);
}
