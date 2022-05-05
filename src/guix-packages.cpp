//
// Created by Reza Alizadeh Majd on 2019-01-05.
//

#include "guix-packages.h"

#include "guix-tools.h"

void HandlePackageCommands(CLI::App* pApp) {
    std::string jsonFile;

    pApp->add_flag_function(
        "-j,--json", [&](int count) {
            string result = ExportPackagesAsJSONString();
            cout << result << endl;
        },
        "Export guix package list as json");

    //    pApp->add_option("-j,--json", [&](CLI::results_t res)-> bool {
    //        string jsonPath = res[0];
    //        return  ExportPackagesAsJSON(jsonPath);
    //    }, "Export `guix` package list to JSON file", false);

    //    CLI::Option*  jsonOpt = pApp->add_option("-j,--json", jsonFile, "export guix package list to json");
    //    pApp->callback([&]() {
    //    });
}

string ExportPackagesAsJSONString() {
    try {
        auto jsonStr = GUIXTOOLS::exec_on_guix_repl("package");
        return jsonStr;
    } catch (const runtime_error& err) {
        cout << "Error: " << err.what() << endl;
    } catch (...) {
        perror("Error!!!");
    }
    return "";
}
