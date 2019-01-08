cmake_minimum_required(VERSION 3.0)
project(guix-tools)

set(CMAKE_CXX_STANDARD 14)

set(LIBNAME _${PROJECT_NAME})
set(EXENAME ${PROJECT_NAME})

add_subdirectory(src)

execute_process(
        COMMAND guile -c "(display (car %load-path))"
        OUTPUT_VARIABLE SCRIPT_PATH
)
install(FILES scripts/packageutils.scm DESTINATION ${SCRIPT_PATH})
