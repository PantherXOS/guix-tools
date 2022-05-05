//
// Created by Reza Alizadeh Majd on 2018-12-29.
//

#include <CLI11.hpp>

#include "guix-packages.h"

int main(int argc, char* argv[]) {
    CLI::App app{"guix-tools: Additional tools to work with Guix Package Manager"};

    CLI::App* pkgApp = app.add_subcommand("package", "Guix 'package' related commands");
    HandlePackageCommands(pkgApp);

    try {
        app.parse(argc, argv);
    } catch (const CLI::ParseError& e) {
        return app.exit(e);
    }

    return 0;
}
