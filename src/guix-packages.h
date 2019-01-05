//
// Created by Reza Alizadeh Majd on 2019-01-05.
//

#ifndef GUIX_TOOLS_GUIX_PACKAGES_H
#define GUIX_TOOLS_GUIX_PACKAGES_H

#include <iostream>
#include <CLI11.hpp>

using namespace std;

void HandlePackageCommands(CLI::App *pApp);

string ExportPackagesAsJSONString();


#endif //GUIX_TOOLS_GUIX_PACKAGES_H
