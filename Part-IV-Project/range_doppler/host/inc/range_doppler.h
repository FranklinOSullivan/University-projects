#ifndef RANGE_DOPPLER_H
#define RANGE_DOPPLER_H

#include "vector2D.h"
#include <complex>
#include <iostream>

class RangeDoppler
{
private:
    double mC = 299792458;

    size_t mRows;
    size_t mCols;
    double mRadarPrf = 6e3;
    double mRadarGeometryAbsV;
    double mRadarGeometryFSA;
    double mRadarFC;
    double mRadarPulseRate;
    double mRadarGeometryHeight;
    double mRadarGeometrySideLookingAngle;
    double mFs;
    double mDopplerBandwidth;

    double mLambdaC;
    double mDopplerCentroid;

    double mR0;
    std::vector<double> mTrueRangeAxis;

public:
    double c() const { return mC; }
    int rows() const { return mRows; }
    int cols() const { return mCols; }
    double radarPrf() const { return mRadarPrf; }
    double radarGeometryAbsV() const { return mRadarGeometryAbsV; }
    double radarGeometryFSA() const { return mRadarGeometryFSA; }
    double radarFC() const { return mRadarFC; }
    double radarPulseRate() const { return mRadarPulseRate; }
    double radarGeometryHeight() const { return mRadarGeometryHeight; }
    double radarGeometrySideLookingAngle() const { return mRadarGeometrySideLookingAngle; }
    double fs() const { return mFs; }

    double lambdaC() const { return mLambdaC; }
    double dopplerCentroid() const { return mDopplerCentroid; }
    double r0() const { return mR0; }

    RangeDoppler(size_t rows, size_t cols, double radarPrf, double radarGeometryAbsV = 0, double radarGeometryFSA = 0, double radarFC = 0, double radarPulseRate = 0, double radarGeometryHeight = 0, double radarGeometrySideLookingAngle = 0, double fs = 0)
        : mRows(rows), mCols(cols), mRadarPrf(radarPrf), mRadarGeometryAbsV(radarGeometryAbsV), mRadarGeometryFSA(radarGeometryFSA), mRadarFC(radarFC), mRadarPulseRate(radarPulseRate), mRadarGeometryHeight(radarGeometryHeight), mRadarGeometrySideLookingAngle(radarGeometrySideLookingAngle), mFs(fs)
    {
        initParams();
    };

    RangeDoppler(const std::string &filename)
    {
        loadParams(filename);
        initParams();
    };

    int loadParams(const std::string &filename);
    int initParams();

    // Main Functions
    void azimuthCompression(vector2D<std::complex<double>> &data_range_matrix);
    void azimuthFFT(vector2D<std::complex<double>> &range_compressed_matrix);
    void rcmc(vector2D<std::complex<double>> &range_doppler_matrix);
    void rcmc_kernel(vector2D<std::complex<double>> &range_doppler_matrix);
    void azimuthFiltering(vector2D<std::complex<double>> &doppler_range_compressed_matrix_rcmc);
    void azimuthIFFT(vector2D<std::complex<double>> &range_compressed_matrix);

    // Initialization Functions
    std::vector<double> computeTrueRangeAxis();
    std::vector<double> computeDopplerAxis();

    // Helper Functions
    double calculateRangeMigration(double f, double rc, double v, double lam_c, double c, double K);
    void createAzimuthFilter(vector2D<std::complex<double>> &filter_matrix, const std::vector<double> doppler_axis, bool linearFMapprox);
};

#endif