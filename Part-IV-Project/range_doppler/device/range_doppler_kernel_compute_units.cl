__attribute__((num_compute_units(2))) __kernel void
range_doppler_kernel(__global const double2 *restrict input_row,
                     __global double2 *restrict output_row,
                     __global const float *restrict tm_fs_row,
                     __global const int *restrict t_idx_row, const int cols) {
  int col = get_global_id(0); // Column index

  // Ensure within bounds
  if (col >= cols)
    return;

  float tm_fs = tm_fs_row[col];
  int t_idx = t_idx_row[col];

  const int n_interp = 128;
  double point_r = 0.0;
  double point_i = 0.0;
  int offset = t_idx + cols;

  for (int n = -n_interp / 2; n < n_interp / 2; ++n) {
    int t_n = (offset + n) % cols;

    float sin_arg = M_PI_F * (tm_fs - t_n);

    float sin_val = sin(sin_arg);

    float sinc_val = (sin_arg == 0) ? 1.0f : sin_val / sin_arg;

    point_r += input_row[t_n].x * sinc_val;
    point_i += input_row[t_n].y * sinc_val;
  }

  output_row[col] = (double2)(point_r, point_i);
}
