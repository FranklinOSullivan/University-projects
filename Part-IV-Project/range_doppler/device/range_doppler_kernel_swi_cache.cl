#define N_INTERP 128
#define MAX_COLS 1771
__kernel void range_doppler_kernel(__global const double2 *restrict input_row,
                                   __global double2 *restrict output_row,
                                   __global const double *restrict tm_fs_row,
                                   __global const int *restrict t_idx_row,
                                   const int cols) {
  __local double2 local_input_row[MAX_COLS];

#pragma unroll 16
  for (int i = 0; i < cols; i++) {
    local_input_row[i] = input_row[i]; // Copy input_row to local memory
  }

  for (int col = 0; col < cols; col++) {
    double tm_fs = tm_fs_row[col];
    int t_idx = t_idx_row[col];

    int offset = t_idx + cols - N_INTERP / 2;

    double point_r = 0.0;
    double point_i = 0.0;

    for (int n = 0; n < N_INTERP; ++n) {
      int t_n = (offset + n) % cols;
      double sin_arg = M_PI * (tm_fs - t_n);
      double sinc_arg = (sin_arg == 0) ? 1.0 : sin(sin_arg) / sin_arg;

      point_r += local_input_row[t_n].x * sinc_arg;
      point_i += local_input_row[t_n].y * sinc_arg;
    }

    output_row[col] = (double2)(point_r, point_i);
  }
}