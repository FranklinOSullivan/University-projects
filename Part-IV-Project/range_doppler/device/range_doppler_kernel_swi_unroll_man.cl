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

    for (int n = 0; n < N_INTERP; n += 2) {
      int t_n1 = (offset + n);
      if (t_n1 >= cols) {
        t_n1 -= cols;
      }

      int t_n2 = (offset + (n + 1));
      if (t_n2 >= cols) {
        t_n2 -= cols;
      }

      double2 input_element1 = input_row[t_n1];
      double2 input_element2 = input_row[t_n2];

      float sin_arg1 = M_PI_F * (tm_fs - t_n1);
      float sinc1 = (sin_arg1 == 0) ? 1.0 : sin(sin_arg1) / (sin_arg1);
      float sin_arg2 = M_PI_F * (tm_fs - t_n2);
      float sinc2 = (sin_arg2 == 0) ? 1.0 : sin(sin_arg2) / (sin_arg2);

      point_r += ((input_element1.x * sinc1) + (input_element2.x * sinc2));
      point_i += ((input_element1.y * sinc1) + (input_element2.y * sinc2));
    }

    output_row[col] = (double2)(point_r, point_i);
  }
}