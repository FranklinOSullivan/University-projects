#define N_INTERP 128
#define REDUCTION_UNROLL N_INTERP / 2

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

    double partial_sum_r[N_INTERP];
    double partial_sum_i[N_INTERP];

    for (int n = 0; n < N_INTERP; ++n) {
      int t_n = (offset + n) % cols;
      double sin_arg = M_PI * (tm_fs - t_n);
      double sinc_arg = (sin_arg == 0) ? 1.0 : sin(sin_arg) / sin_arg;

      partial_sum_r[n] = input_row[t_n].x * sinc_arg;
      partial_sum_i[n] = input_row[t_n].y * sinc_arg;
    }

    // Tree-based parallel reduction
    int stride = N_INTERP / 2;
    while (stride > 0) {
#pragma ivdep
#pragma ii 1
      for (int i = 0; i < stride; ++i) {
        partial_sum_r[i] += partial_sum_r[i + stride];
        partial_sum_i[i] += partial_sum_i[i + stride];
      }
      stride /= 2;
    }

    output_row[col] = (double2)(partial_sum_r[0], partial_sum_i[0]);
  }
}