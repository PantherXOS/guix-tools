//
// Created by Reza Alizadeh Majd on 2019-01-05.
//

#include "guix-tools.h"

#include <sstream>

string GUIXTOOLS::exec_guile_command(const char *cmd) {
    string result;
    char buffer[128];

    stringstream str;
    str << "guile -c '" << cmd << "'";

    FILE* pipe = popen(str.str().c_str(), "r");
    if (!pipe) {
        throw std::runtime_error("popen() failed");
    }
    try {
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            result += buffer;
        }
    }
    catch (...) {
        pclose(pipe);
        throw std::runtime_error("read from buffer failed!");
    }
    pclose(pipe);
    return result;
}
