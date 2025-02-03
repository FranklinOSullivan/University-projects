#include "fft.h"
#include <fftw3.h>

using namespace std;

vector<complex<double>> fft(const vector<complex<double>> &in)
{
    fftw_complex *inArray, *outArray;
    fftw_plan plan;
    size_t N = in.size();

    inArray = (fftw_complex *)fftw_malloc(sizeof(fftw_complex) * N);
    outArray = (fftw_complex *)fftw_malloc(sizeof(fftw_complex) * N);

    // Copy input data to inArray
    for (size_t i = 0; i < N; ++i)
    {
        inArray[i][0] = in[i].real(); // Real part
        inArray[i][1] = in[i].imag(); // Imaginary part
    }

    // Create plan and execute FFT
    plan = fftw_plan_dft_1d(N, inArray, outArray, FFTW_FORWARD, FFTW_ESTIMATE);
    fftw_execute(plan);

    // Copy output data to result vector
    vector<complex<double>> result(N);
    for (size_t i = 0; i < N; ++i)
    {
        result[i] = complex<double>(outArray[i][0], outArray[i][1]);
    }

    // Cleanup
    fftw_destroy_plan(plan);
    fftw_free(inArray);
    fftw_free(outArray);

    return result;
}

vector<complex<double>> ifft(const vector<complex<double>> &in)
{
    fftw_complex *inArray, *outArray;
    fftw_plan plan;
    size_t N = in.size();

    inArray = (fftw_complex *)fftw_malloc(sizeof(fftw_complex) * N);
    outArray = (fftw_complex *)fftw_malloc(sizeof(fftw_complex) * N);

    // Copy input data to inArray
    for (size_t i = 0; i < N; ++i)
    {
        inArray[i][0] = in[i].real(); // Real part
        inArray[i][1] = in[i].imag(); // Imaginary part
    }

    // Create plan and execute IFFT
    plan = fftw_plan_dft_1d(N, inArray, outArray, FFTW_BACKWARD, FFTW_ESTIMATE);
    fftw_execute(plan);

    // Copy output data to result vector
    vector<complex<double>> result(N);
    for (size_t i = 0; i < N; ++i)
    {
        result[i] = complex<double>(outArray[i][0], outArray[i][1]);
    }

    // Scale the result by 1/N
    double scale = 1.0 / N;
    for (size_t i = 0; i < N; ++i)
    {
        result[i] *= scale;
    }

    // Cleanup
    fftw_destroy_plan(plan);
    fftw_free(inArray);
    fftw_free(outArray);

    return result;
}

vector<complex<double>> ifftshift(const vector<complex<double>> &in)
{
    size_t N = in.size();
    vector<complex<double>> out(N);
    // For odd and even N, calculate split point differently
    size_t split = (N % 2 == 0) ? N / 2 : (N - 1) / 2;
    for (size_t i = 0; i < N; ++i)
    {
        out[i] = in[(i + split) % N];
    }
    return out;
}

vector<complex<double>> fftshift(const vector<complex<double>> &in)
{
    size_t N = in.size();
    vector<complex<double>> out(N);
    // For odd and even N, calculate split point differently
    size_t split = (N % 2 == 0) ? N / 2 : (N + 1) / 2;
    for (size_t i = 0; i < N; ++i)
    {
        out[i] = in[(i + split) % N];
    }
    return out;
}