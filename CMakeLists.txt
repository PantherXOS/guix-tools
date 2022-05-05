cmake_minimum_required(VERSION 3.0)
project(guix-tools)

set(CMAKE_CXX_STANDARD 17)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/guix-tools.cpp
    src/guix-packages.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC vendor/CLI11/)
file(COPY ${CMAKE_SOURCE_DIR}/scripts/guixtools DESTINATION ${CMAKE_BINARY_DIR})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

set(SCRIPT_PATH "share/guile/site/3.0/")
add_definitions( -DSCRIPT_PATH="${SCRIPT_PATH}" )
install(DIRECTORY scripts/guixtools DESTINATION ${SCRIPT_PATH})
