cmake_minimum_required (VERSION 3.5 FATAL_ERROR)
project (QISKit VERSION 0.5.0 LANGUAGES CXX)

# Verbose!!
set(CMAKE_VERBOSE_MAKEFILE True)
set(QISKIT_VERSION ${PROJECT_VERSION} CACHE INTERNAL "VERSION OF QISKIT")

include(defaults.cmake)

# Add Toolchain utilities for C++ sources
include(toolchain-utils.cmake)

# Add C++ Qiskit Simulator
add_subdirectory(${PROJECT_SOURCE_DIR}/src/qiskit-simulator)

# Add Python distributable package generator
include(python-build.cmake)

add_pypi_package_target(pypi_package)
