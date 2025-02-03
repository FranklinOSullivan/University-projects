#include "defines.h"
#include "lwipopts.h"
#include "lwipopts_examples_common.h"


char ssid[] = "DN8245-5423";
char pass[] = "mSrkK9eB";
bool wifi_connected = false;


int wifi_connect();

int wifi_connect() {
    stdio_init_all();   
    
    if (cyw43_arch_init_with_country(CYW43_COUNTRY_NEW_ZEALAND)) {
        printf("Failed to initialise\n");
        return 1;
    }
    
    printf("Initialised\n");
    cyw43_arch_enable_sta_mode();

    if(cyw43_arch_wifi_connect_timeout_ms(ssid, pass, CYW43_AUTH_WPA2_AES_PSK, 100)) {
            printf("Failed to connect\n");
            wifi_connected = false;
            return 1;
    } else {
        // Turn on LED when successful scan
        cyw43_arch_gpio_put(ONBOARD_LED_PIN, 1);
        wifi_connected = true;
        //sendWeight(12.5); // send weight
    }
    return 0;
}