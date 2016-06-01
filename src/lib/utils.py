"""
Utils for benchmarking regular expressions
"""

import json
import os
import os.path
import sys
import time


if sys.version_info[0] == 2:
    range = xrange


_CONFIG_DIRECTORY = 'config'
_CONFIG_FILE = os.path.join(_CONFIG_DIRECTORY, 'config.json')
_REGEXP_FILE = os.path.join(_CONFIG_DIRECTORY, 'regexps.json')


def _config():
    """
    Read the config
    :return: The configuration JSON data
    :type dict:
    """
    return json.load(open(_CONFIG_FILE))


def _regexps():
    """
    Read regular expression definitions
    :return: The regular expressions
    :type dict:
    """
    return json.load(open(_REGEXP_FILE))


CONFIG = _config()
REGEXPS = _regexps()


def get_run_time(func):
    """
    :param func:
    :type function:
    """
    start = time.time()
    func()
    end = time.time()
    return end - start


def perform_test(lines, regexp):
    """
    :param lines: List of strings
    :type list:
    :param regexp: Regexp
    :type _sre.SRE_Pattern:
    """
    for _ in range(0, CONFIG['repeat_times']):
        matching = 0
        not_matching = 0

        for line in lines:
            match = regexp.search(line)
            if match:
                matching += 1
            else:
                not_matching += 1

        assert matching == CONFIG['num_matching_lines'], \
            'Regexp /{}/ expecting {} matchings but got {} matchings'.format(
                regexp.pattern, CONFIG['num_matching_lines'], matching)
        assert not_matching == CONFIG['num_not_matching_lines'], \
            'Regexp /{}/ expecting {} not matchings but got {} matchings'.format(
                regexp.pattern, CONFIG['num_not_matching_lines'], not_matching)
