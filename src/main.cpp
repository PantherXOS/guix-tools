//
// Created by Reza Alizadeh Majd on 2018-12-29.
//


#include <iostream>
#include <CLI11.hpp>

int main(int argc, char* argv[]) {

    CLI::App app { "guix-tools: Additional tools to work with Guix Package Manager" };

    CLI::App* packageSub =app.add_subcommand("package", "Guix 'package' related commands");

    std::string jsonFile;
    packageSub->add_option("-j,--json", jsonFile, "export guix package list to json");
    packageSub->callback([&]() {
        std::cout << jsonFile << std::endl;
    });

    try {
        app.parse(argc, argv);
    }
    catch (const CLI::ParseError& e) {
        return app.exit(e);
    }

    return 0;
}
