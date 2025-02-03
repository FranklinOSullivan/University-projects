#define N_INTERP 128
#define REDUCTION_UNROLL N_INTERP / 2

__kernel void range_doppler_kernel(__global const double2 *restrict input_row,
                                   __global double2 *restrict output_row,
                                   __global const double *restrict tm_fs_row,
                                   __global const int *restrict t_idx_row,
                                   const int cols) {

  for (int col = 0; col < cols; col++) {
    output_row[col] = input_row[col];
  }
}