cmake_minimum_required(VERSION 3.0)
project(guix-tools)

set(CMAKE_CXX_STANDARD 14)

add_subdirectory(src)

set(SCRIPT_PATH "share/guile/site/2.2/")
install(DIRECTORY scripts/guixtools DESTINATION ${SCRIPT_PATH})
