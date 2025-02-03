cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(test_project C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()


if (TARGET tinyusb_device)
  add_executable(test
    src/main.c
    src/adc.c
    src/wifi.c
  )
  pico_enable_stdio_usb(test 1)
  pico_enable_stdio_uart(test 0)
  pico_add_extra_outputs(test)
  target_include_directories(test PRIVATE 
    ${CMAKE_CURRENT_LIST_DIR}/inc
    ${CMAKE_CURRENT_LIST_DIR}/src
    )
  target_link_libraries(
    test
    pico_cyw43_arch_lwip_threadsafe_background
    pico_stdlib
    hardware_adc
    )

    # create map/bin/hex file etc.
    pico_add_extra_outputs(test)
elseif(PICO_ON_DEVICE)
    message(WARNING "not building because TinyUSB submodule is not initialized in sdk")
endif()
