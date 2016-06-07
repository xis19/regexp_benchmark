#ifndef __REGEXPS_H
#define __REGEXPS_H

#include <map>
#include <string>

#include <boost/filesystem.hpp>


class RegexpData {

    using RegexpMap = std::map<std::string, std::string>;
    using path = boost::filesystem::path;

    static const path CONFIG_PATH;
    static const path REGEXPS_FILE;

    static RegexpData* m_regexpData;

    RegexpMap m_regexpMap;

    RegexpData();

public:
    static const RegexpData* getRegexpData() {
        if (m_regexpData == nullptr) {
            m_regexpData = new RegexpData();
        }
        return m_regexpData;
    }

    auto begin() const -> decltype(m_regexpMap.begin()) {
        return m_regexpMap.begin();
    }

    auto end() const -> decltype(m_regexpMap.end()) {
        return m_regexpMap.end();
    }
};


#endif  // __REGEXPS_H

