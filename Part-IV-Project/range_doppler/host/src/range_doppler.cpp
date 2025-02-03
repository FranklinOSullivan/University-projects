#include "range_doppler.h"
#include "fft.h"
#include "opencl.h"
#include <fstream>
#include <iostream>
#include <iomanip>

using namespace std;

void RangeDoppler::azimuthCompression(vector2D<complex<double>> &data_range_matrix)
{
    // Azimuth compression function implementation
    azimuthFFT(data_range_matrix);
    rcmc(data_range_matrix);
    azimuthFiltering(data_range_matrix);
    azimuthIFFT(data_range_matrix);
}

void RangeDoppler::azimuthFFT(vector2D<complex<double>> &range_compressed_matrix)
{
    size_t rows = range_compressed_matrix.rows();
    size_t cols = range_compressed_matrix.cols();

    for (size_t i = 0; i < cols; ++i)
    {
        vector<complex<double>> column(rows);
        for (size_t j = 0; j < rows; ++j)
        {
            column[j] = range_compressed_matrix(j, i);
        }
        column = fftshift(fft(ifftshift(column)));
        for (size_t j = 0; j < rows; ++j)
        {
            range_compressed_matrix(j, i) = column[j];
        }
    }

    for (auto &elem : range_compressed_matrix.data())
    {
        elem /= mRadarPrf;
    }
}

void RangeDoppler::rcmc(vector2D<std::complex<double>> &range_doppler_matrix)
{
    size_t rows = range_doppler_matrix.rows();
    size_t cols = range_doppler_matrix.cols();
    std::vector<double> doppler_axis(rows);
    double foffset = std::ceil(mDopplerCentroid / mRadarPrf) * mRadarPrf;
    double start = -mRadarPrf / 2;
    double end = (1 - 1.0 / rows) * mRadarPrf / 2;

    // Calculate doppler_axis
    for (size_t i = 0; i < rows; ++i)
    {
        doppler_axis[i] = start + i * ((end - start) / (rows - 1)) + foffset;
        if (doppler_axis[i] > mDopplerCentroid + mRadarPrf / 2)
            doppler_axis[i] -= mRadarPrf;
        if (doppler_axis[i] < mDopplerCentroid - mRadarPrf / 2)
            doppler_axis[i] += mRadarPrf;
    }

    // Create a temporary vector to store the original row
    std::vector<std::complex<double>> temp_row(cols);

    for (size_t l = 0; l < rows; ++l)
    {
        // Store the original row
        for (size_t r = 0; r < cols; ++r)
        {
            temp_row[r] = range_doppler_matrix(l, r);
        }

        complex<double> *output_data = &(range_doppler_matrix.data()[l * cols]);

        for (size_t r = 0; r < cols; ++r)
        {
            double r_bin = mTrueRangeAxis[r];
            double rm = calculateRangeMigration(doppler_axis[l], r_bin, mRadarGeometryAbsV, mLambdaC, mC, mRadarPulseRate);
            double tm = std::fmod((2 * rm / mC), (1 / mRadarPrf));
            size_t t_idx = static_cast<size_t>(std::ceil(tm * mFs)) % cols;
            const int n_interp = 128;
            double point_r = 0.0;
            double point_i = 0.0;

            for (int n = -n_interp / 2; n < n_interp / 2; ++n)
            {
                size_t t_n = (t_idx + n + cols) % cols;
                double sin_arg = M_PI * mFs * (tm - static_cast<double>(t_n) / mFs);
                double sinc_arg = 0;
                if (sin_arg == 0)
                    sinc_arg = 1.0; // To avoid division by zero
                else
                    sinc_arg = std::sin(sin_arg) / sin_arg;
                point_r += std::real(temp_row[t_n]) * sinc_arg;
                point_i += std::imag(temp_row[t_n]) * sinc_arg;
            }
            range_doppler_matrix(l, r) = std::complex<double>(point_r, point_i);
        }
    }
}

void RangeDoppler::rcmc_kernel(vector2D<std::complex<double>> &range_doppler_matrix)
{
    size_t rows = range_doppler_matrix.rows();
    size_t cols = range_doppler_matrix.cols();
    std::vector<double> doppler_axis(rows);
    double foffset = std::ceil(mDopplerCentroid / mRadarPrf) * mRadarPrf;
    double start = -mRadarPrf / 2;
    double end = (1 - 1.0 / rows) * mRadarPrf / 2;

    // Calculate doppler_axis
    for (size_t i = 0; i < rows; ++i)
    {
        doppler_axis[i] = start + i * ((end - start) / (rows - 1)) + foffset;
        if (doppler_axis[i] > mDopplerCentroid + mRadarPrf / 2)
            doppler_axis[i] -= mRadarPrf;
        if (doppler_axis[i] < mDopplerCentroid - mRadarPrf / 2)
            doppler_axis[i] += mRadarPrf;
    }

    // Create a temporary vector to store the original row
    std::vector<double> tm_fs_values(cols);
    std::vector<size_t> t_idx_values(cols);
    std::vector<std::complex<double>> temp_row(cols);

    for (size_t l = 0; l < rows; ++l)
    {
        // Store the original row
        for (size_t r = 0; r < cols; ++r)
        {
            double r_bin = mTrueRangeAxis[r];
            double rm = calculateRangeMigration(doppler_axis[l], r_bin, mRadarGeometryAbsV, mLambdaC, mC, mRadarPulseRate);
            double tm = std::fmod((2 * rm / mC), (1 / mRadarPrf));
            size_t t_idx = static_cast<size_t>(std::ceil(tm * mFs)) % cols;

            tm_fs_values[r] = tm * mFs;
            t_idx_values[r] = t_idx;
            temp_row[r] = range_doppler_matrix(l, r);
        }

        complex<double> *output_data = &(range_doppler_matrix.data()[l * cols]);
        run_kernel(temp_row.data(), output_data, tm_fs_values.data(), t_idx_values.data(), cols);
    }
}

void RangeDoppler::azimuthFiltering(vector2D<complex<double>> &doppler_range_compressed_matrix_rcmc)
{
    size_t rows = doppler_range_compressed_matrix_rcmc.rows();
    size_t cols = doppler_range_compressed_matrix_rcmc.cols();
    // vector2D<complex<double>> out(rows, cols);

    std::vector<double> doppler_axis = computeDopplerAxis();
    vector2D<complex<double>> azimuth_filter_matrix(rows, cols);
    createAzimuthFilter(azimuth_filter_matrix, doppler_axis, false);
    // Applying the azimuth filter matrix
    for (size_t i = 0; i < rows; ++i)
    {
        for (size_t j = 0; j < cols; ++j)
        {
            doppler_range_compressed_matrix_rcmc(i, j) *= azimuth_filter_matrix(i, j);
        }
    }

    // 3.1 pattern equalization
    // doppler_range_compressed_matrix_rcmc = patternEqualization(doppler_range_compressed_matrix_rcmc);

    // 3.2 Doppler windowing
    if (mDopplerBandwidth != 0)
    {
        std::vector<int> doppler_window(doppler_axis.size());
        // Create the doppler window
        for (size_t i = 0; i < doppler_axis.size(); ++i)
        {
            if (std::abs(doppler_axis[i] - mDopplerCentroid) <= mDopplerBandwidth / 2)
                doppler_window[i] = 1;
            else
                doppler_window[i] = 0;
        }

        // Apply the window to the matrix
        for (size_t i = 0; i < rows; ++i)
        {
            for (size_t j = 0; j < cols; ++j)
            {
                doppler_range_compressed_matrix_rcmc(i, j) *= doppler_window[i];
            }
        }
    }
}

void RangeDoppler::azimuthIFFT(vector2D<complex<double>> &range_compressed_matrix)
{
    size_t rows = range_compressed_matrix.rows();
    size_t cols = range_compressed_matrix.cols();

    for (size_t i = 0; i < cols; ++i)
    {
        vector<complex<double>> column(rows);
        for (size_t j = 0; j < rows; ++j)
        {
            column[j] = range_compressed_matrix(j, i);
        }
        column = fftshift(ifft(ifftshift(column)));
        for (size_t j = 0; j < rows; ++j)
        {
            range_compressed_matrix(j, i) = column[j];
        }
    }

    for (auto &elem : range_compressed_matrix.data())
    {
        elem *= mRadarPrf;
    }
}

double RangeDoppler::calculateRangeMigration(double f, double rc, double v, double lam_c, double c, double K)
{
    double vts = (std::pow(f, 2) * std::pow(rc, 2)) / (4 * std::pow(v, 2) / std::pow(lam_c, 2) - std::pow(f, 2));
    double r = std::sqrt(std::pow(rc, 2) + vts) - f * c / (2 * K);
    return r;
}

void RangeDoppler::createAzimuthFilter(vector2D<complex<double>> &filter_matrix, const vector<double> doppler_axis, bool linearFMapprox)
{
    std::vector<double> f_range_axis(mCols);

    for (size_t i = 0; i < mCols; ++i)
    {
        f_range_axis[i] = std::fmod(mTrueRangeAxis[i], mC / (2 * mRadarPrf));
    }

    // Compute filter matrix
    for (size_t r = 0; r < mCols; ++r)
    {
        double rng = mTrueRangeAxis[r];
        double frng = f_range_axis[r];
        double Ka = -2 / mLambdaC * std::pow(mRadarGeometryAbsV, 2) / rng;
        std::complex<double> G;

        for (size_t i = 0; i < mRows; ++i)
        {
            if (linearFMapprox)
            {
                G = std::exp(std::complex<double>(0, -M_PI / 4 + M_PI * std::pow(doppler_axis[i], 2) / Ka + 4 * M_PI * frng * doppler_axis[i] / mC));
            }
            else
            {
                G = std::exp(std::complex<double>(0, 4 * M_PI * rng / mLambdaC * std::sqrt(1 - std::pow(mLambdaC, 2) * std::pow(doppler_axis[i], 2) / (4 * std::pow(mRadarGeometryAbsV, 2))) - M_PI / 4 - 4 * M_PI * frng * doppler_axis[i] / mC));
            }
            filter_matrix(i, r) = G;
        }
    }
}

// vector2D<std::complex<double>> RangeDoppler::patternEqualization(vector2D<std::complex<double>> &doppler_range_compressed_matrix_rcmc, vector<double> doppler_axis)
// {
//     // Pattern equalization function implementation
//     auto rdgain = create_azimuth_equalization_matrix(doppler_axis);
//     return doppler_range_compressed_matrix_rcmc * mBroadsideGain / rDGain;
// }

int RangeDoppler::loadParams(const std::string &filename)
{
    std::ifstream file(filename, std::ios::binary);
    if (!file.is_open())
    {
        std::cerr << "Error opening file!" << std::endl;
        return 1;
    }

    // Load parameters from file
    file.read(reinterpret_cast<char *>(&mRows), sizeof(uint64_t));                        // Read rows
    file.read(reinterpret_cast<char *>(&mCols), sizeof(uint64_t));                        // Read cols
    file.read(reinterpret_cast<char *>(&mRadarPrf), sizeof(mRadarPrf));                   // Read radarPrf
    file.read(reinterpret_cast<char *>(&mRadarGeometryAbsV), sizeof(mRadarGeometryAbsV)); // Read radarGeometryAbsV
    file.read(reinterpret_cast<char *>(&mRadarGeometryFSA), sizeof(mRadarGeometryFSA));   // Read radarGeometryFSA
    file.read(reinterpret_cast<char *>(&mRadarFC), sizeof(mRadarFC));                     // Read radarFC
    file.read(reinterpret_cast<char *>(&mRadarPulseRate), sizeof(mRadarPulseRate));
    file.read(reinterpret_cast<char *>(&mRadarGeometryHeight), sizeof(mRadarGeometryHeight));
    file.read(reinterpret_cast<char *>(&mRadarGeometrySideLookingAngle), sizeof(mRadarGeometrySideLookingAngle));
    file.read(reinterpret_cast<char *>(&mFs), sizeof(mFs));
    file.read(reinterpret_cast<char *>(&mDopplerBandwidth), sizeof(mDopplerBandwidth));

    return 0;
}

int RangeDoppler::initParams()
{
    mLambdaC = mC / mRadarFC;
    mDopplerCentroid = 2 * mRadarGeometryAbsV * mRadarFC * sin(mRadarGeometryFSA) / mC;
    mR0 = mRadarGeometryHeight / cos(mRadarGeometrySideLookingAngle);
    mTrueRangeAxis = computeTrueRangeAxis();
    return 0;
}

std::vector<double> RangeDoppler::computeTrueRangeAxis()
{
    int numElements = std::round(mFs / mRadarPrf);
    std::vector<double> time_ax(numElements);
    std::vector<double> true_fast_time_axis(numElements);
    std::vector<double> true_range_axis(numElements);

    double timeStep = 1 / mRadarPrf - 1 / mFs;
    for (int i = 0; i < numElements; ++i)
    {
        time_ax[i] = i * timeStep / (numElements - 1);
    }

    double min_delay = std::floor((mR0 * 2 / mC) * mRadarPrf) / mRadarPrf;
    for (int i = 0; i < numElements; ++i)
    {
        true_fast_time_axis[i] = time_ax[i] + min_delay;
    }

    for (int i = 0; i < numElements; ++i)
    {
        true_range_axis[i] = true_fast_time_axis[i] * mC / 2;
    }
    return true_range_axis;
}

std::vector<double> RangeDoppler::computeDopplerAxis()
{
    std::vector<double> doppler_axis(mRows);
    double foffset = std::ceil(mDopplerCentroid / mRadarPrf) * mRadarPrf;

    double start = -mRadarPrf / 2;
    double end = (mRows % 2 == 0) ? (1 - 1.0 / mRows) * mRadarPrf / 2 : mRadarPrf / 2;
    for (size_t i = 0; i < mRows; ++i)
    {
        doppler_axis[i] = start + i * ((end - start) / (mRows - 1)) + foffset;
        if (doppler_axis[i] > mDopplerCentroid + mRadarPrf / 2)
            doppler_axis[i] -= mRadarPrf;
        if (doppler_axis[i] < mDopplerCentroid - mRadarPrf / 2)
            doppler_axis[i] += mRadarPrf;
    }
    return doppler_axis;
}