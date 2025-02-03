#ifndef MATRIX_H
#define MATRIX_H

#include <vector>
#include <cstddef>

template <class T>
class vector2D
{
    std::vector<T> mData;
    size_t mRows, mCols;

public:
    vector2D(size_t rows, size_t cols) : mData(rows * cols), mCols(cols), mRows(rows) {}
    vector2D() : mCols(0), mRows(0) {}

    vector2D(const std::vector<std::vector<T>> &data) : mRows(data.size()), mCols(data[0].size())
    {
        mData.reserve(mRows * mCols);
        for (const auto &row : data)
        {
            mData.insert(mData.end(), row.begin(), row.end());
        }
    }

    void resize(size_t rows, size_t cols)
    {
        mRows = rows;
        mCols = cols;
    }

    const T &operator()(size_t row, size_t col) const
    {
        return mData[row * mCols + col];
    }

    T &operator()(size_t row, size_t col)
    {
        return mData[row * mCols + col];
    }

    std::vector<T> &data()
    {
        return mData;
    }

    size_t size() const
    {
        return mData.size();
    }

    size_t rows() const
    {
        return mRows;
    }

    size_t cols() const
    {
        return mCols;
    }
};

#endif
