#include "regexps.h"

#include <boost/filesystem.hpp>

#include "utils.h"

using path = boost::filesystem::path;
using ifstream = boost::filesystem::ifstream;

const path RegexpData::CONFIG_PATH = path("config");
const path RegexpData::REGEXPS_FILE = CONFIG_PATH / path("regexps.json");

RegexpData* RegexpData::m_regexpData = nullptr;


RegexpData::RegexpData() {
    Json::Value root = loadJSONFile(RegexpData::REGEXPS_FILE);

    for(const auto& key: root.getMemberNames()) {
        m_regexpMap[key] = root[key].asString();
    }
}

