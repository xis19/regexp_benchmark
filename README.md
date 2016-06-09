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
|javascript|1.58|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|
|python2|1.96|3.10|5.34|10.16|15.07|9.05|6.96|3.36|3.21|2.97|
|python3|2.34|3.88|6.87|9.81|15.18|7.15|7.45|4.06|3.73|3.60|
|ruby|3.80|3.87|3.60|4.20|7.12|3.43|5.42|4.22|3.96|3.75|
|perl|2.01|3.39|3.07|3.15|6.17|2.59|5.37|3.87|3.34|3.29|
|grep|1.00|1.84|1.65|6.71|17.83|1.26|1.78|7.44|8.90|1.89|
|sed|3.18|5.00|4.89|31.92|46.94|4.35|4.79|11.59|9.61|4.00|
|awk|2.93|4.03|4.00|8.58|16.17|5.91|4.35|6.89|8.14|4.17|
|std::regex|6.38|8.26|8.20|9.58|18.41|7.41|8.27|8.75|8.22|8.10|
|boost::regex|1.88|2.89|3.48|10.92|12.50|3.18|3.46|2.93|2.59|2.48|
|boost::xpressive|5.48|7.32|9.04|9.79|19.59|9.16|9.41|7.48|7.24|7.25|
|pcre3|1.18|1.86|5.69|6.09|11.71|1.62|1.97|2.07|1.61|1.65|
|re2|1.18|1.58|2.32|2.04|6.07|1.47|1.55|1.56|1.51|1.49|

Discussion
----
To be done.

Conclusion
----
To be done.
