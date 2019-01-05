cmake_minimum_required(VERSION 3.0)


add_executable(${EXENAME} main.cpp
        guix-tools.cpp
        guix-packages.cpp)
target_include_directories(${EXENAME} PUBLIC ../vendor/CLI11/)
configure_file(../scripts/packageutils.scm ${CMAKE_BINARY_DIR} COPYONLY)
execute_process(
        COMMAND guile -c "(display (car %load-path))"
        OUTPUT_VARIABLE SCRIPT_PATH
)
install(TARGETS ${EXENAME} DESTINATION bin)
install(FILES ../scripts/packageutils.scm DESTINATION ${SCRIPT_PATH})
