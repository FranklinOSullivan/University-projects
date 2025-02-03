#include "range_doppler.h"
#include "load_data.h"
#include "store_data.h"
#include "opencl.h"
#include "error_check.h"
#include <iostream>
#include <vector>
#include <complex>
#include <chrono>
#include <numeric>

using namespace std;

int main()
{
    const int N = 1;
    std::cout << "Starting Azimuth Compressions! (" << N << ") ";
    #ifdef KERNEL
    #ifdef SWI
        std::cout << "SWI";
    #else
        std::cout << "NDR";
    #endif
    #else
        std::cout << "CPU";
    #endif

    #ifdef KERNEL
    if (!init())
    {
        return -1;
    }
    #endif

    // Load data from python
    RangeDoppler rd = RangeDoppler("./data/parameters.bin");
    vector2D<std::complex<double>> data(rd.rows(), rd.cols());
    loadComplexBin("./data/data.bin", data);

    std::cout << std::endl;

    for (int i = 0; i < N; i++)
    {
        loadComplexBin("./data/data.bin", data);
        auto fft_start = chrono::high_resolution_clock::now();
        rd.azimuthFFT(data);
        auto fft_end = chrono::high_resolution_clock::now();

        auto rcmc_start = chrono::high_resolution_clock::now();
        
        #ifdef KERNEL  
        rd.rcmc_kernel(data);
        #else
        rd.rcmc(data);
        #endif
        auto rcmc_end = chrono::high_resolution_clock::now();

        auto filter_start = chrono::high_resolution_clock::now();
        rd.azimuthFiltering(data);
        auto filter_end = chrono::high_resolution_clock::now();

        auto ifft_start = chrono::high_resolution_clock::now();
        rd.azimuthIFFT(data);
        auto ifft_end = chrono::high_resolution_clock::now();

        auto total_duration = chrono::duration_cast<chrono::microseconds>(ifft_end - fft_start);
        auto fft_duration = chrono::duration_cast<chrono::microseconds>(fft_end - fft_start);
        auto rcmc_duration = chrono::duration_cast<chrono::microseconds>(rcmc_end - rcmc_start);
        auto filter_duration = chrono::duration_cast<chrono::microseconds>(filter_end - filter_start);
        auto ifft_duration = chrono::duration_cast<chrono::microseconds>(ifft_end - ifft_start);

        cout << "(" << i + 1 << "/" << N << ")" << " Azimuth Compression Done" << endl;
        cout << "FFT: " << fft_duration.count() / 1.0e6 << " s" << endl;
        cout << "RCMC: " << rcmc_duration.count() / 1.0e6 << " s" << endl;
        cout << "Filter: " << filter_duration.count() / 1.0e6 << " s" << endl;
        cout << "IFFT: " << ifft_duration.count() / 1.0e6 << " s" << endl;
        cout << "Total: " << total_duration.count() / 1.0e6 << " s" << endl;
        cout << "--------------------------------" << endl;
    }

    vector2D<std::complex<double>> expected(rd.rows(), rd.cols());
    if (loadComplexBin("./data/ifft.bin", expected))
    {
        std::cout << "Failed to load ifft.bin" << std::endl;
        return 1;
    }

    double error = calculateMAPE(expected, data);
    cout << "MAPE: " << error << " %" << endl;
    storeComplexBin("./data/data_out.bin", data);

    #ifdef KERNEL
    cleanup();
    #endif
    return 0;
}