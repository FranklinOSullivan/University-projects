#pragma once 

#include <stdio.h>
#include <stdint.h>
#include <pico/stdio_usb.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "pico/cyw43_arch.h"

/* Main externs */
extern const uint ONBOARD_LED_PIN;
extern const uint TARE_BUTTON_PIN;
extern const uint S_AVE_QUANTITY;

/* Include adc functions */
extern void init_adc();
extern void tare_adc();
void get_adc_average();
float get_adc_mean_reading();
float translate_adc_reading(float input);
int32_t take_adc_reading();
void clear_adc_ave_arr();
uint8_t is_uniform_data(float reference);

/* Include wifi functions */
extern int wifi_connect();
extern bool wifi_connected;
