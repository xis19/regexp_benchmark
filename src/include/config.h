#ifndef __CONFIG_H
#define __CONFIG_H

#include <boost/filesystem.hpp>


class Config {

    using path = boost::filesystem::path;

    static const path CONFIG_PATH;
    static const path CONFIG_FILE;

    static Config* m_config;

    int m_numMatchingLines;
    int m_numNotMatchingLines;;

    int m_repeatTimes;

    path m_scratchDirectory;

    Config();

public:

    static const Config* getConfig() {
        if (m_config == nullptr) {
            m_config = new Config();
        }
        return m_config;
    }
    const path& scratchDirectory() const {
        return m_scratchDirectory;
    }

    int numMatchingLines() const {
        return m_numMatchingLines;
    }

    int numNotMatchingLines() const {
        return m_numNotMatchingLines;
    }

    int repeatTimes() const {
        return m_repeatTimes;
    }
};


#endif  // __CONFIG_H
