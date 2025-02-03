#include <stdio.h>
#include <stdint.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>
#include <alt_types.h>
#include <sys/alt_irq.h>
#include <inttypes.h>

#define DATAMESSAGE 0x8
#define NIOSADDR 0x0
#define RECOPADDR 0x1
#define NOEXTRA 0x0

int main()
{
    uint16_t currentData = 0;
    uint16_t previousData = 0;
    uint16_t freqVal;
    uint32_t nocMessage;

    IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_ADDR_BASE, RECOPADDR);
    while (1)
    {
        currentData = IORD_ALTERA_AVALON_PIO_DATA(NOC_INPUT_DATA_BASE);
        if (currentData != previousData)
        {
            previousData = currentData;
            freqVal = (uint32_t)16000 / currentData;
            printf("Freq: %d\n", freqVal);
            nocMessage = ((DATAMESSAGE << 28) | (NIOSADDR << 24) | (RECOPADDR << 20) | (NOEXTRA << 16) | freqVal);
            //nocMessage = ((DATAMESSAGE << 28) | (NIOSADDR << 24) | (RECOPADDR << 20) | (NOEXTRA << 16) | 50);
            //printf("Noc message: %x\n", nocMessage);

            IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_DATA_BASE, nocMessage);
        }
        IOWR_ALTERA_AVALON_PIO_DATA(NOC_OUTPUT_DATA_BASE, 0);
    }

    return 0;
}
