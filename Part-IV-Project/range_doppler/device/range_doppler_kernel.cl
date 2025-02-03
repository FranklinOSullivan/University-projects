__attribute__((max_work_group_size(2048)))
__kernel void range_doppler_kernel(__global const double2 *restrict input_row,
                                   __global double2 *restrict output_row,
                                   __global const double *restrict tm_fs_row,
                                   __global const int *restrict t_idx_row,
                                   const int cols) {
  int col = get_global_id(0); // Column index

  // Ensure within bounds
  if (col >= cols)
    return;

  double tm_fs = tm_fs_row[col];
  int t_idx = t_idx_row[col];

  const int n_interp = 128;
  double point_r = 0.0;
  double point_i = 0.0;
  int offset = t_idx + cols;

  for (int n = -n_interp / 2; n < n_interp / 2; ++n) {
    int t_n = (offset + n) % cols;
    double sin_arg = M_PI * (tm_fs - (double)t_n);
    double sinc_arg = (sin_arg == 0) ? 1.0 : sin(sin_arg) / sin_arg;

    point_r += input_row[t_n].x * sinc_arg;
    point_i += input_row[t_n].y * sinc_arg;
  }

  output_row[col] = (double2)(point_r, point_i);
}
