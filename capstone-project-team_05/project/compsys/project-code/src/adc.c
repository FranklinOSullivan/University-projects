#include "defines.h"
#include "hardware/adc.h"

#define STABLE_AVERAGE_QUANTITY 200
#define STABLE_RANGE 4000

// const int32_t STABLE_RANGE = 70000;
const uint S_AVE_QUANTITY = 200;
const uint ADC_PIN = 26;

const float CONV_FACTOR = 3.3f / (1 << 12);
const float FUNC_M = 0.064;
const float FUNC_C = 0.124;

int32_t adc_ave_arr[STABLE_AVERAGE_QUANTITY];
int32_t adc_ave_arr_index = 0;

int32_t zeroOffset = 0;

void init_adc();
int32_t take_adc_reading();
void get_adc_average();
float get_adc_mean_reading();
void clear_adc_ave_arr();
uint8_t is_uniform_data(float reference);

void init_adc(){
    adc_init();
    adc_gpio_init(ADC_PIN);
    adc_select_input(0);
}

void tare_adc(){
    uint8_t notZero = 1;
    // Take stable_range adc readings
    int32_t adc_arr[STABLE_RANGE];
    for (int32_t i = 0; i < STABLE_RANGE; i++){
        int32_t adc_val = take_adc_reading();
        // printf("ADC val %d: %d\n", i, adc_val);
        adc_arr[i] = adc_val;
    }
    int64_t adc_ave = 0;

    // Find the average
    for (int32_t j=0; j<STABLE_RANGE; j++){
        adc_ave = (adc_ave + adc_arr[j]); 
        // printf("ADC ave %d: %d\n", j, adc_ave);
    }
    int32_t final_adc_ave = adc_ave / (int64_t)STABLE_RANGE; 
    // printf("Final ave %d\n", final_adc_ave);
    // Set the offset
    zeroOffset = final_adc_ave + zeroOffset;
}

void get_adc_average(){
    // Take stable_range adc readings
    int32_t adc_arr[STABLE_RANGE];
    for (int32_t i = 0; i < STABLE_RANGE; i++){
        int32_t adc_val = take_adc_reading();
        // printf("ADC val %d: %d\n", i, adc_val);
        adc_arr[i] = adc_val;
    }
    int64_t adc_ave = 0;

    // Find the average
    for (int32_t j=0; j<STABLE_RANGE; j++){
        adc_ave = (adc_ave + adc_arr[j]); 
        // printf("ADC ave %d: %d\n", j, adc_ave);
    }
    int32_t final_adc_ave = adc_ave / (int64_t)STABLE_RANGE; 
    // printf("Final ave %d\n", final_adc_ave);
    adc_ave_arr[adc_ave_arr_index] = final_adc_ave;
    adc_ave_arr_index++;
    // printf("Index %d\n", adc_ave_arr_index);
    if (adc_ave_arr_index >= S_AVE_QUANTITY) {
        adc_ave_arr_index = 0;
    }
}

void clear_adc_ave_arr() {
    for (int32_t i = 0; i < S_AVE_QUANTITY; i++){
        adc_ave_arr[i] = 0;
    }
    adc_ave_arr_index = 0;
}

float get_adc_mean_reading(){
    printf("Mean reading\n");
    int32_t total_ave = 0;
    for (int i = 0; i < S_AVE_QUANTITY; i++){
        total_ave = total_ave + adc_ave_arr[i];
    }
    float final_total_ave = (float)(total_ave / S_AVE_QUANTITY);
    return final_total_ave;
}

uint8_t is_uniform_data(float reference){
    for (int i = 0; i < S_AVE_QUANTITY; i++){
        if ((adc_ave_arr[i] > reference + 10) || (adc_ave_arr[i] < reference - 10)){
            return 0;
        }
    }
    return 1;
}

float translate_adc_reading(float input){
    // Calculate the voltage equlivalent
    printf("Input: %f\n", input);
    float conv_result = input*CONV_FACTOR; 
    printf("conv: %f\n", conv_result);
    float adjusted_reading = (conv_result - FUNC_C) / FUNC_M;
    printf("Adj: %f\n", adjusted_reading);
    // Find the weight equlivalent
    return adjusted_reading;
    // Use normalising function
}

int32_t take_adc_reading(){
    int32_t reading = adc_read();
    int32_t adjusted_reading = reading - zeroOffset;
    // printf("reading: %d, adjusted: %d, offset: %d\n", reading, adjusted_reading, zeroOffset);
    // float conv_result = result*CONV_FACTOR;
    // printf("Raw value: 0x%03x, voltage: %f V\n", result, conv_result);
    return adjusted_reading;
}