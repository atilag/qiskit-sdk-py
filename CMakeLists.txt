cmake_minimum_required (VERSION 3.5 FATAL_ERROR)
project (QISKit LANGUAGES CXX)

# Verbose!!
set(CMAKE_VERBOSE_MAKEFILE True)

# Add util functions
# Check if compiler flag exists
include(CheckCXXCompilerFlag)
function(_enable_cxx_compiler_flag_if_supported flag)
    string(FIND "${CMAKE_CXX_FLAGS}" "${flag}" flag_already_set)
    if(flag_already_set EQUAL -1)
        check_cxx_compiler_flag("${flag}" flag_supported)
        if(flag_supported)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}" PARENT_SCOPE)
        endif()
        unset(flag_supported CACHE)
    endif()
endfunction()

# Add C++ Qiskit Simulator
add_subdirectory(${PROJECT_SOURCE_DIR}/qiskit/backends/qiskit-simulator)
