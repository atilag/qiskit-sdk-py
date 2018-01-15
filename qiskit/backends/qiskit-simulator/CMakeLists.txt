# Set the output folder where your program will be created
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/out/${CMAKE_BUILD_TYPE}/qiskit-simulator/)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

set(QISKIT_SIMULATOR_DIR
    "${PROJECT_SOURCE_DIR}/qiskit/backends/qiskit-simulator")
set(QISKIT_SIMULATOR_SRC_DIR "${QISKIT_SIMULATOR_DIR}/src")
set(QISKIT_SIMULATOR_SRC
    "${QISKIT_SIMULATOR_SRC_DIR}/main.cpp")

# Target definition
add_executable(qiskit_simulator ${QISKIT_SIMULATOR_SRC})

# Target properties: C++ program
set_target_properties(qiskit_simulator PROPERTIES LINKER_LANGUAGE CXX)

target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR})
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/backends)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/engines)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/utilities)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/third-party)

# Toolchain options
set_property(TARGET qiskit_simulator PROPERTY CXX_STANDARD 14)

# Compiler flags
_enable_cxx_compiler_flag_if_supported("-O3")
_enable_cxx_compiler_flag_if_supported("-march=native")
_enable_cxx_compiler_flag_if_supported("-fopenmp")

# Warnings and Errors
_enable_cxx_compiler_flag_if_supported("-pedantic")
_enable_cxx_compiler_flag_if_supported("-Wall")
_enable_cxx_compiler_flag_if_supported("-Wfloat-equal")
_enable_cxx_compiler_flag_if_supported("-Wundef")
_enable_cxx_compiler_flag_if_supported("-Wcast-align")
_enable_cxx_compiler_flag_if_supported("-Wwrite-strings")
_enable_cxx_compiler_flag_if_supported("-Wmissing-declarations")
_enable_cxx_compiler_flag_if_supported("-Wredundant-decls")
_enable_cxx_compiler_flag_if_supported("-Wshadow")
_enable_cxx_compiler_flag_if_supported("-Woverloaded-virtual")

# Looking for external libraries
find_library(LIB_LAPACK lapack)
if(NOT LIB_LAPACK)
    message(FATAL_ERROR "LAPACK library not found!")
endif()
find_library(LIB_BLAS blas)
if(NOT LIB_BLAS)
    message(FATAL_ERROR "BLAS library not found!")
endif()
find_library(LIB_THREADS pthread)
if(NOT LIB_THREADS)
    message(FATAL_ERROR "Pthreads library not found!")
endif()

set(LIBRARIES PRIVATE ${LIB_BLAS}
                      ${LIB_LAPACK}
                      ${LIB_THREADS})

# Linking
target_link_libraries(qiskit_simulator ${LIBRARIES})

# Tests
# TODO: Enable them when ready
#add_subdirectory(${QISKIT_SIMULATOR_DIR}/test)

