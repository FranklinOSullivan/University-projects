#include "range_doppler.h"
#include "load_data.h"
#include "store_data.h"
#include <iostream>
#include <vector>
#include <complex>
#include <chrono>
#include <numeric>

using namespace std;

int main()
{
    std::cout << "Starting Azimuth Compressions! " << std::endl;

    // Load data from python
    RangeDoppler rd("../../data/parameters.bin");

    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    if (loadComplexBin("../../data/data.bin", data))
    {
        std::cout << "Failed to load data.bin" << std::endl;
        return 1;
    }

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    if (loadComplexBin("../../data/ifft.bin", expected))
    {
        std::cout << "Failed to load ifft.bin" << std::endl;
        return 1;
    }

    vector2D<std::complex<double>> initital(rd.rows(), rd.cols());
    if (loadComplexBin("../../data/data.bin", initital))
    {
        std::cout << "Failed to load data.bin" << std::endl;
        return 1;
    }

    // Azimuth compression
    const int N = 1;
    vector<uint64_t> total_times(N);
    vector<uint64_t> fft_times(N);
    vector<uint64_t> rcmc_times(N);
    vector<uint64_t> filter_times(N);
    vector<uint64_t> ifft_times(N);

    for (int i = 0; i < N; i++)
    {
        // loadComplexBin("../../data/data.bin", data);
        auto start = chrono::high_resolution_clock::now();
        rd.azimuthCompression(data);
        auto end = chrono::high_resolution_clock::now();
        auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
        total_times[i] = duration.count();

        // loadComplexBin("../../data/data.bin", data);
        // auto fft_start = chrono::high_resolution_clock::now();
        // rd.azimuthFFT(data);
        // auto fft_end = chrono::high_resolution_clock::now();
        // auto fft_duration = chrono::duration_cast<chrono::microseconds>(fft_end - fft_start);
        // fft_times[i] = fft_duration.count();

        // auto rcmc_start = chrono::high_resolution_clock::now();
        // rd.rcmc(data);
        // auto rcmc_end = chrono::high_resolution_clock::now();
        // auto rcmc_duration = chrono::duration_cast<chrono::microseconds>(rcmc_end - rcmc_start);
        // rcmc_times[i] = rcmc_duration.count();

        // auto filter_start = chrono::high_resolution_clock::now();
        // rd.azimuthFiltering(data);
        // auto filter_end = chrono::high_resolution_clock::now();
        // auto filter_duration = chrono::duration_cast<chrono::microseconds>(filter_end - filter_start);
        // filter_times[i] = filter_duration.count();

        // auto ifft_start = chrono::high_resolution_clock::now();
        // rd.azimuthIFFT(data);
        // auto ifft_end = chrono::high_resolution_clock::now();
        // auto ifft_duration = chrono::duration_cast<chrono::microseconds>(ifft_end - ifft_start);
        // ifft_times[i] = ifft_duration.count();

        cout << "(" << i + 1 << "/" << N << ")" << " Azimuth Compression Done" << endl;
    }

    cout << "Avg Total time: " << accumulate(total_times.begin(), total_times.end(), 0) / total_times.size() / 1.0e6 << " s" << endl;
    // cout << "Avg FFT time: " << accumulate(fft_times.begin(), fft_times.end(), 0) / fft_times.size() / 1.0e6 << " s" << endl;
    // cout << "Avg RCMC time: " << accumulate(rcmc_times.begin(), rcmc_times.end(), 0) / rcmc_times.size() / 1.0e6 << " s" << endl;
    // cout << "Avg Filter time: " << accumulate(filter_times.begin(), filter_times.end(), 0) / filter_times.size() / 1.0e6 << " s" << endl;
    // cout << "Avg IFFT time: " << accumulate(ifft_times.begin(), ifft_times.end(), 0) / ifft_times.size() / 1.0e6 << " s" << endl;

    // Compare results
    double error = calculateMAPE(expected, data);
    cout << "MAPE: " << error << " %" << endl;

    // TODO: Store image for python
    storeComplexBin("../../data/data_out.bin", data);
    return 0;
}