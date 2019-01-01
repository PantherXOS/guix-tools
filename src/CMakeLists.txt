cmake_minimum_required(VERSION 3.0)


add_executable(${EXENAME} main.cpp)
target_include_directories(${EXENAME} PUBLIC ../vendor/CLI11/)
