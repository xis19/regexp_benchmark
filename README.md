The Benchmark of Regular Expression Libraries
====

Introduction
----

Regular epxressions (regexp) are widely used in text parsing. When processing
large text files, the performance of the regexp engine will greatly affect the
efficiency of the parser. In this project, various regexp engines are compared
using different regexps and corresponding texts.

Computational Details
----
The following languages/tools/libraries with regular expression are included
in this benchmark test:

| Engine | Version |
|--------|---------|
|javascript|```v4.4.4```|
|python2|```Python 2.7.11+```|
|python3|```Python 3.5.1+```|
|ruby|```ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]```|
|perl|```This is perl 5```|
|grep|```grep (GNU grep) 2.25```|
|sed|```sed (GNU sed) 4.2.2```|
|awk|```GNU Awk 4.1.3, API: 1.1 (GNU MPFR 3.1.4-p2, GNU MP 6.1.0)```|
|std::regex|```g++ (Debian 5.3.1-21) 5.3.1 20160528```|
|boost::regex|```1.58.0.1```|
|boost::xpressive|```1.58.0.1```|
|pcre3|```2:8.38-3.1```|
|re2|```20160501+dfsg-1```|

 The regular expressions used in this benchmark are listed below:

| Name | Regular expression |
|------|--------------------|
|plain|/```plain_text```/|
|single_dot|/```test.string```/|
|matching_character|/```[asdfgh]ghijkl[qwerty]```/|
|excluding_character|/```[^asdfgh]ghijkl[qwerty]```/|
|character_range|/```[a-z]tesi[^0-9]```/|
|repeat|/```b{3}lyp```/|
|repeat_range|/```8{3,8}7654```/|
|repeat_star|/```test[a-z]*value```/|
|repeat_plus|/```value[1-9]+test```/|
|optional_value|/```valuec?test```/|

Results
----

The results of the timing for each regexp under the given engine is normalized
so that the minimal time is 1.00.

|Engine|plain|single_dot|matching_character|excluding_character|character_range|repeat|repeat_range|repeat_star|repeat_plus|optional_value|
|------|------| ------| ------| ------| ------| ------| ------| ------| ------| ------|  
|javascript|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|
|python2|2.32|3.50|6.08|11.51|8.77|7.45|6.96|3.56|3.42|3.45|
|python3|2.89|4.66|7.08|11.75|9.71|9.10|8.13|4.29|4.25|4.39|
|ruby|3.50|4.39|4.55|5.00|4.95|4.81|4.86|5.15|5.02|5.23|
|perl|2.43|3.64|3.62|3.59|3.84|4.02|3.41|4.05|3.80|3.83|
|grep|1.24|2.15|1.95|8.16|11.03|1.60|2.00|7.86|9.69|2.13|
|sed|3.96|6.05|5.94|37.41|24.48|5.54|5.25|10.98|11.10|4.77|
|awk|3.61|4.68|4.94|10.12|10.57|4.87|4.39|7.16|8.03|4.71|
|std::regex|7.90|9.90|10.72|12.17|13.52|10.45|11.79|9.47|11.01|11.35|
|boost::regex|2.31|3.46|4.49|12.84|8.08|4.13|3.95|3.00|3.47|2.97|
|boost::xpressive|7.60|8.70|10.95|11.66|12.53|12.02|10.74|8.00|8.66|8.55|
|pcre3|1.48|2.25|6.89|7.10|7.49|2.09|2.29|2.18|1.89|1.87|
|re2|1.41|1.87|2.77|2.31|3.86|1.89|1.72|1.61|1.80|1.73|

Discussion
----
To be done.

Conclusion
----
To be done.
