cmake_minimum_required(VERSION 3.0)


add_executable(${EXENAME} main.cpp
        guix-tools.cpp
        guix-packages.cpp)
target_include_directories(${EXENAME} PUBLIC ../vendor/CLI11/)
configure_file(../scripts/packageutils.scm ${CMAKE_BINARY_DIR} COPYONLY)
install(TARGETS ${EXENAME} DESTINATION bin)
