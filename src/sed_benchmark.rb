#! /usr/bin/env ruby

=begin
Benchmark standard grep.

NOTE: This benchmark may not be fair, because all other benchmarks exclude the
time the program starts and the time the file loaded to memory.
=end

require_relative 'lib/benchmark_base'

def main
  STDOUT.print(
    JSON.pretty_generate(
      BenchmarkBase.benchmark_all_using_external_script do  |regexp_str, regexp_file_name|
        sed_regexp_str = regexp_str.gsub(/\+/, '\\\\+').gsub(/\?/, '\?').gsub(/\{/, '\{').gsub(/\}/, '\}')
        sprintf("sed -n '/%s/p' %s", sed_regexp_str, regexp_file_name)
      end
    )
  )
end

main if $0 == __FILE__
