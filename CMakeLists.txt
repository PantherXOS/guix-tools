cmake_minimum_required(VERSION 3.0)
project(guix-tools)

set(CMAKE_CXX_STANDARD 14)

# Check Guile Existance and its version:
find_package(PkgConfig REQUIRED)
pkg_check_modules(GUILE22 guile-2.2 QUIET)
if (GUILE22_FOUND)
    SET(GUILE_EFFECTIVE_VERSION 2.2)
else (GUILE22_FOUND)
    pkg_check_modules(GUILE2 guile-2.0 QUIET)
    if (GUILE2_FOUND)
        set(GUILE_EFFECTIVE_VERSION 2.0)
    else(GUILE2_FOUND)
        message (FATAL_ERROR "Neither guile 2.2 nor guile 2.0 were found. can't install guix-tools")
    endif(GUILE2_FOUND)
endif(GUILE22_FOUND)


add_subdirectory(src)

set(SCRIPT_PATH "share/guile/site/${GUILE_EFFECTIVE_VERSION}/")
install(DIRECTORY scripts/guixtools DESTINATION ${SCRIPT_PATH})