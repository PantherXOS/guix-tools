cmake_minimum_required(VERSION 3.0)


add_executable(${PROJECT_NAME} main.cpp
        guix-tools.cpp
        guix-packages.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC ../vendor/CLI11/)
file(COPY ${CMAKE_SOURCE_DIR}/scripts/guixtools DESTINATION ${CMAKE_BINARY_DIR})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)
