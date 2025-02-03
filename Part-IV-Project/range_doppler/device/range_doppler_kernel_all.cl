#define N_INTERP 128

double calculateRangeMigration(double f, double rc, double v, double lam_c,
                               double c, double K) {
  double vts =
      (pow(f, 2) * pow(rc, 2)) / (4 * pow(v, 2) / pow(lam_c, 2) - pow(f, 2));
  double r = sqrt(pow(rc, 2) + vts) - f * c / (2 * K);
  return r;
}

__kernel void
range_doppler_kernel(__global double2 *restrict range_doppler_matrix,
                     __global const double *restrict doppler_axis,
                     __global const double *restrict true_range_axis,
                     const int rows, const int cols,
                     const double radarGeometryAbsV, const double lambdaC,
                     const double c, const double radarPulseRate,
                     const double radarPrf, const double fs) {
  for (int row = 0; row < rows; row++) {

    double2 temp_row[2048];

    for (int col = 0; col < cols; ++col) {
      temp_row[col] = range_doppler_matrix[row * cols + col];
    }

    for (int col = 0; col < cols; col++) {

      double rm = calculateRangeMigration(
          doppler_axis[row], true_range_axis[col], radarGeometryAbsV, lambdaC,
          c, radarPulseRate);
      double tm = fmod((2 * rm / c), (1 / radarPrf));
      double tm_fs = tm * fs;
      int t_idx = ((int)ceil(tm * fs)) % cols;

      int offset = t_idx + cols - N_INTERP / 2;

      double point_r = 0.0;
      double point_i = 0.0;

      for (int n = 0; n < N_INTERP; ++n) {
        int t_n = (offset + n) % cols;
        double sin_arg = M_PI * (tm_fs - t_n);
        double sinc_arg = (sin_arg == 0) ? 1.0 : sin(sin_arg) / sin_arg;

        point_r += temp_row[t_n].x * sinc_arg;
        point_i += temp_row[t_n].y * sinc_arg;
      }

      range_doppler_matrix[rows * cols + col] = (double2)(point_r, point_i);
    }
  }
}