#!/bin/bash

# Extract the kernel name from the argument, or default if none is provided
KERNEL_NAME=${1:-"default"}

# Define the compilation command based on the kernel name
case $KERNEL_NAME in
  default)
    aoc -v device/range_doppler_kernel.cl -o bin/range_doppler_kernel.aocx -report -no-interleaving=default
    ;;
  low_usage)
    aoc -v device/range_doppler_kernel_low_usage.cl -o bin/range_doppler_kernel_low_usage.aocx -report -no-interleaving=default
    ;;
  fpc)
    aoc -v device/range_doppler_kernel.cl -o bin/range_doppler_kernel_fpc.aocx -report -no-interleaving=default -fpc
    ;;
  unroll)
    aoc -v device/range_doppler_kernel_unroll.cl -o bin/range_doppler_kernel_unroll.aocx -report -no-interleaving=default
    ;;
  swi)
    aoc -v device/range_doppler_kernel_swi.cl -o bin/range_doppler_kernel_swi.aocx -report -no-interleaving=default -const-cache-bytes=65536
    ;;
  swi_cache)
    aoc -v device/range_doppler_kernel_swi_cache.cl -o bin/range_doppler_kernel_swi_cache.aocx -report -no-interleaving=default
    ;;
  swi_reduction)
    aoc -v device/range_doppler_kernel_swi_reduction.cl -o bin/range_doppler_kernel_swi_reduction.aocx -report -no-interleaving=default
    ;;
  swi_array)
    aoc -v device/range_doppler_kernel_swi_array.cl -o bin/range_doppler_kernel_swi_array.aocx -report -no-interleaving=default
    ;;
  swi_array_p)
    aoc -v device/range_doppler_kernel_swi_array_p.cl -o bin/range_doppler_kernel_swi_array_p.aocx -report -no-interleaving=default -fpc
    ;;
  swi_fpc)
    aoc -v device/range_doppler_kernel_swi.cl -o bin/range_doppler_kernel_swi_fpc.aocx -report -no-interleaving=default -fpc 
    ;;
  swi_unroll)
    aoc -v device/range_doppler_kernel_swi_unroll.cl -o bin/range_doppler_kernel_swi_unroll.aocx -report -no-interleaving=default
    ;;
  swi_unroll_man)
    aoc -v device/range_doppler_kernel_swi_unroll_man.cl -o bin/range_doppler_kernel_swi_unroll_man.aocx -report -no-interleaving=default
    ;;
  test)
    aoc -v device/range_doppler_kernel_test.cl -o bin/range_doppler_kernel_test.aocx -report -no-interleaving=default
    ;;
  test2)
    aoc -v device/range_doppler_kernel_test2.cl -o bin/range_doppler_kernel_test2.aocx -report -no-interleaving=default
    ;;
  test3)
    aoc -v device/range_doppler_kernel_test3.cl -o bin/range_doppler_kernel_test3.aocx -report -no-interleaving=default
    ;;
  *)
    echo "Invalid kernel name: $KERNEL_NAME"
    echo "Valid options are: default, low_usage, fpc, unroll, swi, swi_cache, swi_reduction, swi_array, swi_array_p, swi_fpc, swi_unroll, swi_unroll_man, test, test2, test3"
    exit 1
    ;;
esac

echo "Completed compilation of $KERNEL_NAME"
