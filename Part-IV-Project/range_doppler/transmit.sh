#!/bin/bash

scp ./bin/host fpga:~/range_doppler/

# Extract the kernel name from the argument, or default if none is provided
KERNEL_NAME=${1:-"default"}

# Define the compilation command based on the kernel name
case $KERNEL_NAME in
  default)
    scp ./bin/range_doppler_kernel.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  low_usage)
    scp ./bin/range_doppler_kernel_low_usage.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  fpc)
    scp ./bin/range_doppler_kernel_fpc.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  unroll)
    scp ./bin/range_doppler_kernel_unroll.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi)
    scp ./bin/range_doppler_kernel_swi.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_cache)
    scp ./bin/range_doppler_kernel_swi_cache.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_reduction)
    scp ./bin/range_doppler_kernel_swi_reduction.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_array)
    scp ./bin/range_doppler_kernel_swi_array.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_array_p)
    scp ./bin/range_doppler_kernel_swi_array_p.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_fpc)
    scp ./bin/range_doppler_kernel_swi_fpc.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_unroll)
    scp ./bin/range_doppler_kernel_swi_unroll.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  swi_unroll_man)
    scp ./bin/range_doppler_kernel_swi_unroll_man.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  test)
    scp ./bin/range_doppler_kernel_test.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  test2)
    scp ./bin/range_doppler_kernel_test2.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  test3)
    scp ./bin/range_doppler_kernel_test3.aocx fpga:~/range_doppler/range_doppler_kernel.aocx
    ;;
  *)
    echo "Invalid kernel name: $KERNEL_NAME"
    echo "Valid options are: default, low_usage, fpc, unroll, swi, swi_cache, swi_reduction, swi_array, swi_array_p, swi_fpc, swi_unroll, swi_unroll_man, test, test2, test3"
    exit 1
    ;;
esac

echo "Transmit complete"