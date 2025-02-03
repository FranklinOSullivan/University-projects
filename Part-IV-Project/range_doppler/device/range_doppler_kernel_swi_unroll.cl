#define N_INTERP 128

__kernel void range_doppler_kernel(__global const double2 *restrict input_row,
                                   __global double2 *restrict output_row,
                                   __global const double *restrict tm_fs_row,
                                   __global const int *restrict t_idx_row,
                                   const int cols) {

  for (int col = 0; col < cols; col++) {
    double tm_fs = tm_fs_row[col];
    int t_idx = t_idx_row[col];

    int offset = t_idx + cols - N_INTERP / 2;

    double point_r = 0.0;
    double point_i = 0.0;

#pragma unroll 2
    for (int n = 0; n < N_INTERP; ++n) {
      int t_n = (offset + n);
      if (t_n >= cols) {
        t_n -= cols;
      }
      float sin_arg = M_PI_F * (tm_fs - t_n);
      float sinc = (sin_arg == 0) ? 1.0 : sin(sin_arg) / (sin_arg);

      point_r += input_row[t_n].x * sinc;
      point_i += input_row[t_n].y * sinc;
    }

    output_row[col] = (double2)(point_r, point_i);
  }
}