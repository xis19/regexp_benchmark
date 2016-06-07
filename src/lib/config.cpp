#include "config.h"

#include <boost/filesystem.hpp>

#include "utils.h"

using path = boost::filesystem::path;
using ifstream = boost::filesystem::ifstream;

const path Config::CONFIG_PATH = path("config");
const path Config::CONFIG_FILE = CONFIG_PATH / path("config.json");

Config* Config::m_config = nullptr;


Config::Config() {
    Json::Value root = loadJSONFile(Config::CONFIG_FILE);

    m_numMatchingLines = root["num_matching_lines"].asInt();
    m_numNotMatchingLines = root["num_not_matching_lines"].asInt();
    m_repeatTimes = root["repeat_times"].asInt();
    m_scratchDirectory = path(root["scratch_directory"].asString());
}

