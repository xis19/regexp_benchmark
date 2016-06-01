#! /usr/bin/env python

"""
Perform a benchmark on matching regexp over strings
"""

from __future__ import print_function

import json
import os.path
import re

import lib.utils


def main():
    """ main entry """
    benchmark = dict()

    for key, regexp_str in lib.utils.REGEXPS.items():
        file_name = os.path.join(lib.utils.CONFIG['scratch_directory'], key)
        with open(file_name) as test_file:
            # We need to explicitly remove the newline character
            lines = [line[0:-1] for line in test_file.readlines()]
        regexp = re.compile(regexp_str)

        benchmark[key] = lib.utils.get_run_time(
            lambda: lib.utils.perform_test(lines, regexp))

    print(json.dumps(benchmark, indent=2))

if __name__ == '__main__':
    main()
