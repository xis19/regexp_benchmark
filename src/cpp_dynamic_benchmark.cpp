#include <iostream>
#include <string>

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

#include <jsoncpp/json/json.h>

#include "benchmark.h"
#include "config.h"
#include "regexps.h"
#include "utils.h"

int main() {
    const auto config = Config::getConfig();
    Json::Value result;

    for(const auto& testData: (*RegexpData::getRegexpData())) {
        const auto TEST_FILENAME = config->scratchDirectory() /
            boost::filesystem::path(testData.first);

        std::vector<std::string> lines = loadFileToVector(TEST_FILENAME);

        try {
            result[testData.first] = performDynamicBenchmark(lines, testData.second);
        } catch (std::runtime_error& err) {
            result[testData.first] = err.what();
        }
    }

    std::cout << Json::StyledWriter().write(result) << std::endl;

    return 0;
}
