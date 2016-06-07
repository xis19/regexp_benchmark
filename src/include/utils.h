#ifndef __UTILS_H
#define __UTILS_H

#include <string>
#include <vector>

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

#include <jsoncpp/json/json.h>


Json::Value loadJSONFile(const boost::filesystem::path&);
std::vector<std::string> loadFileToVector(const boost::filesystem::path&);


#endif  // __UTILS_H
