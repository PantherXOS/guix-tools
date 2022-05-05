//
// Created by Reza Alizadeh Majd on 2019-01-05.
//

#include "guix-tools.h"

#include <limits.h>
#include <unistd.h>

#include <filesystem>
#include <sstream>

#ifndef SCRIPT_PATH
#define SCRIPT_PATH ""
#endif

#define SCRIPT_MODULE "guixtools"

namespace fs = std::filesystem;

fs::path script_path(const string &scriptName) {
    char buffer[PATH_MAX];
    int count = readlink("/proc/self/exe", buffer, PATH_MAX);
    fs::path path = string(buffer, count > 0 ? count : 0);
    stringstream sstream;
    sstream << path.parent_path().parent_path().u8string()                  // package folder
            << string("/") << string(SCRIPT_PATH) << string(SCRIPT_MODULE)  // folder that scripts are located on
            << string("/") << scriptName << ".scm";
    return sstream.str();
}

std::string GUIXTOOLS::exec_on_guix_repl(const std::string &command) {
    stringstream result;

    auto scriptPath = script_path(command);
    auto cmd = string("guix repl -- ") + scriptPath.u8string() + " 2>/dev/null";

    FILE *pipe = popen(cmd.c_str(), "r");
    if (!pipe) {
        throw std::runtime_error("popen() failed");
    }
    try {
        char buffer[1024];
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            result << buffer;
        }
    } catch (...) {
        throw std::runtime_error("read from buffer failed!");
    }
    pclose(pipe);

    return result.str();
}