#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/cyw43_arch.h"

// #include "sendWeight.c"

char ssid[] = "DN8245-5423";
char pass[] = "mSrkK9eB";

const uint8_t LED_PIN = CYW43_WL_GPIO_LED_PIN;

int main() {
    stdio_init_all();   
    
    if (cyw43_arch_init_with_country(CYW43_COUNTRY_NEW_ZEALAND)) {
        printf("failed to initialise\n");
        return 1;
    }
    
    printf("initialised\n");
    cyw43_arch_enable_sta_mode();

    if(cyw43_arch_wifi_connect_timeout_ms(ssid, pass, CYW43_AUTH_WPA2_AES_PSK, 10000)) {
            printf("failed to connect\n");
            return 1;
    } else {
        // Turn on LED when successful scan
        cyw43_arch_gpio_put(LED_PIN, 1);
        while (true) {
            printf("connected to %s\n", ssid);
            sleep_ms(1000);
        }
        //sendWeight(12.5); // send weight
    }
}