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
 |perl|```This is perl 5, version 22, subversion 2 (v5.22.2) built for x86_64-linux-gnu-thread-multi
(with 56 registered patches, see perl -V for more detail)

Copyright 1987-2015, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.```|
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
|javascript|1.19|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|1.00|
|python2|1.89|3.00|5.13|9.82|13.76|5.76|11.98|3.24|2.98|5.75|
|python3|2.38|4.00|5.84|9.98|14.98|7.00|14.89|4.08|3.69|7.05|
|ruby|2.64|3.74|3.45|4.20|7.15|3.42|11.07|4.24|3.94|7.59|
|perl|2.00|3.10|3.04|3.07|6.16|2.58|6.11|3.41|3.36|6.51|
|grep|1.00|1.77|1.66|6.80|16.97|1.24|3.54|7.19|8.04|3.60|
|sed|3.21|4.93|5.09|31.09|37.84|5.87|9.39|9.92|9.37|7.89|
|awk|2.96|3.81|3.93|8.69|16.88|3.69|7.54|6.54|7.07|7.72|
|std::regex|6.32|8.21|8.16|9.58|18.09|7.53|16.30|8.62|8.40|15.78|
|boost::regex|1.86|2.95|3.45|10.80|12.39|3.12|6.86|2.84|2.51|4.98|
|boost::xpressive|5.53|7.40|9.06|9.79|19.56|9.18|18.65|7.50|7.26|14.30|
|pcre3|1.19|1.85|5.68|6.09|12.30|1.62|4.02|2.09|1.59|3.03|
|re2|1.19|1.59|2.30|2.07|6.13|1.47|3.10|1.55|1.48|2.94|

Discussion
----
To be done.

Conclusion
----
To be done.
