#include "defines.h"

const uint ONBOARD_LED_PIN = 15;
const uint TARE_BUTTON_PIN = 7;
const uint REGULATOR_PIN = 5;

const uint DEVICE_ID = 1;

float child_weight;

// Function definitions
void init_gpio();

enum State {
    deepSleep, tare, weigh, transmit
};

int main()
{
    stdio_init_all();
    init_gpio();
    init_adc();
    
    enum State current_state = deepSleep;

    while(!stdio_usb_connected()){
        ;
    }
    
    sleep_ms(200);

    printf("Plunket baby weighing scale\n");
    printf("Device id: %d\n", DEVICE_ID);
    printf("Deep sleep state\n");

    uint8_t averages_recorded = 0;

    // Run tare_adc to stall while gpio turns on
    // Main loop
    for(;;){
        switch(current_state) {
            case deepSleep:
                // Wake on button press
                if (!gpio_get(TARE_BUTTON_PIN)){ // if button is pressed
                    current_state = tare;
                    printf("Tare state\n");
                }
            break;
            case tare:
                gpio_put(ONBOARD_LED_PIN, 1);
                tare_adc();
                gpio_put(ONBOARD_LED_PIN, 0);
                averages_recorded = 0;
                clear_adc_ave_arr();
                current_state = weigh;
                printf("Weigh state\n");
            break;
            case (weigh):
                if (!gpio_get(TARE_BUTTON_PIN)){ // if button is pressed
                    current_state = tare;
                    // If we get a unique data point
                    // 3kg baby  is approx 614.4 (Voltage at 3kg = 0.495)
                } else if (take_adc_reading() > 100) {
                    get_adc_average();
                    averages_recorded++;
                    if (averages_recorded > S_AVE_QUANTITY) {
                        int32_t mean_reading = get_adc_mean_reading();
                        if (is_uniform_data(mean_reading)){
                            child_weight = translate_adc_reading(get_adc_mean_reading());
                            printf("Child weight: %.2f\n", child_weight);
                            current_state = transmit;
                        } else {
                            averages_recorded = 0;
                            clear_adc_ave_arr();
                        }
                    }
                }
            break;
            case transmit:
                // TODO: Transmit data
                wifi_connect();
            break;
        }
    }
}

void init_gpio()
{
    stdio_usb_init();

    gpio_init(REGULATOR_PIN);
    gpio_set_dir(REGULATOR_PIN, GPIO_OUT);
    gpio_put(REGULATOR_PIN, 1);

    gpio_init(TARE_BUTTON_PIN); 
    gpio_set_dir(TARE_BUTTON_PIN, GPIO_IN); 
    gpio_pull_up(TARE_BUTTON_PIN); 

    gpio_init(ONBOARD_LED_PIN);
    gpio_set_dir(ONBOARD_LED_PIN, GPIO_OUT);
}
