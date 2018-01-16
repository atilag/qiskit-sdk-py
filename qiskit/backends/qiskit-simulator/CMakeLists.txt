project(qiskit_simulator VERSION 1.0 LANGUAGES CXX)

# Set the output folder where your program will be created
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/out/${CMAKE_BUILD_TYPE}/qiskit-simulator/)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

set(QISKIT_SIMULATOR_SRC_DIR "${PROJECT_SOURCE_DIR}/src")
set(QISKIT_SIMULATOR_SRC
    "${QISKIT_SIMULATOR_SRC_DIR}/main.cpp")
set(QISKIT_SIMULATOR_EXTERNAL_LIBS
    "${QISKIT_SIMULATOR_SRC_DIR}/third-party/headers"
    "${QISKIT_SIMULATOR_SRC_DIR}/third-party/win64/lib"
	"${USER_LIB_PATH}")

# Target definition
add_executable(qiskit_simulator ${QISKIT_SIMULATOR_SRC})

# Target properties: C++ program
set_target_properties(qiskit_simulator PROPERTIES LINKER_LANGUAGE CXX)

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

target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR})
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/backends)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/engines)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/utilities)
target_include_directories(qiskit_simulator PRIVATE ${QISKIT_SIMULATOR_SRC_DIR}/third-party/headers)

if(MINGW)
    SET(CMAKE_FIND_LIBRARY_PREFIXES "" "lib")
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" ".hpp")
endif()

# Looking for external libraries
find_library(LIB_JSON
	NAMES json
	PATHS ${QISKIT_SIMULATOR_EXTERNAL_LIBS})
if(NOT LIB_JSON)
    message(FATAL_ERROR "JSON library not found!. Please provide with a USER_LIB_PATH to CMake so it can be searched there")
endif()

find_library(LIB_LAPACK
	NAMES lapack
	PATHS ${QISKIT_SIMULATOR_EXTERNAL_LIBS})
if(NOT LIB_LAPACK)
    message(FATAL_ERROR "LAPACK library not found!. Please provide with a USER_LIB_PATH to CMake so it can be searched there")
endif()

find_library(LIB_BLAS
	NAMES blas
	PATHS ${QISKIT_SIMULATOR_EXTERNAL_LIBS})
if(NOT LIB_BLAS)
    message(FATAL_ERROR "BLAS library not found!. Please provide with a USER_LIB_PATH to CMake so it can be searched there")
endif()

find_library(LIB_THREADS
	NAMES pthread
	PATHS ${QISKIT_SIMULATOR_EXTERNAL_LIBS})
if(NOT LIB_THREADS)
    message(FATAL_ERROR "Pthreads library not found!. Please provide with a USER_LIB_PATH to CMake so it can be searched there")
endif()

set(LIBRARIES PRIVATE ${LIB_JSON}
					  ${LIB_BLAS}
                      ${LIB_LAPACK}
					  ${LIB_THREADS})

# Linking
target_link_libraries(qiskit_simulator ${LIBRARIES})

# Tests
# TODO: Enable them when ready
#add_subdirectory(${QISKIT_SIMULATOR_DIR}/test)

