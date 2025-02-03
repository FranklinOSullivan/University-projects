cmake_minimum_required(VERSION 3.10)
project(RangeDoppler CXX)

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Set source directories
set(SRC_PATH ${CMAKE_SOURCE_DIR}/host/src)
set(INC_PATH ${CMAKE_SOURCE_DIR}/host/inc)
set(COMMON_SRC_PATH ${CMAKE_SOURCE_DIR}/common/src/AOCLUtils)
set(COMMON_INC_PATH ${CMAKE_SOURCE_DIR}/common/inc)

# Find all source files
file(GLOB_RECURSE SOURCES "${SRC_PATH}/*.cpp")

# Include directories
include_directories(${INC_PATH})

# Find the FFTW3 library
find_package(FFTW3 REQUIRED)

# Executable target
add_executable(${PROJECT_NAME} ${SOURCES})

# Link FFTW3 to your target
target_link_libraries(${PROJECT_NAME} ${FFTW3_LIBRARIES})

# Ensure C++11 standard
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)