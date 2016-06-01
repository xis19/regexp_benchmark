#! /usr/bin/env node

/**
 * Perform a benchmark on matching regexp over strings
 */

const
    assert = require('assert'),
    fs = require('fs'),
    path = require('path');

var main = (function() {
    'use strict';

    const
        CONFIG_PATH = 'config',
        CONFIG_FILE_NAME = path.join(CONFIG_PATH, 'config.json'),
        CONFIG = JSON.parse(fs.readFileSync(CONFIG_FILE_NAME)),
        REGEXPS_FILE_NAME = path.join(CONFIG_PATH, 'regexps.json'),
        REGEXPS = JSON.parse(fs.readFileSync(REGEXPS_FILE_NAME));

    /**
     * @param {Array} lines
     * @param {RegExp} regexp
     */
    function performTest(lines, regexp) {
        var
            matching = 0,
            not_matching = 0;
        lines.forEach((line) => {
            if (regexp.test(line)) {
                ++matching;
            } else {
                ++not_matching;
            }
        });

        assert(matching === CONFIG.num_matching_lines);
        assert(not_matching === CONFIG.num_not_matching_lines);

        return matching;
    }

    function main() {
        var benchmark = new Object();
        for(let key in REGEXPS) {
            let start, end, lines, regexp;

            lines = fs
                .readFileSync(path.join(CONFIG.scratch_directory, key))
                .toString()
                .split('\n')
                .slice(0, 20000);   // Remove the tailing newline
            regexp = new RegExp(REGEXPS[key]);

            start = (Date.now() / 1000);
            for(let _ = 0; _ < CONFIG.repeat_times; ++_) {
                performTest(lines, regexp);
            }
            end = (Date.now() / 1000);

            benchmark[key] = end - start;
        }

        console.log(JSON.stringify(benchmark, null, 4));
    }   // function main

    return main;
}).call(this);  // var main

main();
