#include "utils.h"

#include <algorithm>
#include <exception>
#include <iterator>

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

#include <jsoncpp/json/json.h>

using path = boost::filesystem::path;
using ifstream = boost::filesystem::ifstream;


Json::Value loadJSONFile(const boost::filesystem::path& fileName) {
    ifstream ifs(fileName);
    std::string rawJSON;
    std::copy(
        std::istreambuf_iterator<char>(ifs),
        std::istreambuf_iterator<char>(),
        std::back_inserter(rawJSON));

    Json::Value root;
    Json::Reader reader;
    reader.parse(rawJSON, root);

    return root;
}

std::vector<std::string> loadFileToVector(
        const boost::filesystem::path& fileName) {
    std::vector<std::string> lines;
    boost::filesystem::ifstream ifs(fileName);

    if (!ifs.is_open()) {
        throw std::runtime_error(
            std::string("Cannot file find ") + fileName.string());
    }

    std::string line;
    while(!ifs.eof()) {
        std::getline(ifs, line);
        lines.push_back(line);
    }

    // Remove the extra newline
    lines.pop_back();

    return lines;
}

