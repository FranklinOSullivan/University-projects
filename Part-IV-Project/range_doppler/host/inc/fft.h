#ifndef FFT_H
#define FFT_H

#include <vector>
#include <complex>

std::vector<std::complex<double>> fft(const std::vector<std::complex<double>> &in);
std::vector<std::complex<double>> ifft(const std::vector<std::complex<double>> &in);
std::vector<std::complex<double>> fftshift(const std::vector<std::complex<double>> &in);
std::vector<std::complex<double>> ifftshift(const std::vector<std::complex<double>> &in);

#endif