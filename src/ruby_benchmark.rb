#! /usr/bin/env ruby

=begin
Perform a benchmark on matching regexp over strings
=end

require_relative 'lib/benchmark_base'

CONFIG = Utils::config


# Perform the regexp matching test
# @param [Array] lines Array of strings to be matched
# @param [Regexp] regexp Regular expression
def perform_test(lines, regexp)
  matching = 0
  not_matching = 0

  lines.each { |line| line =~ regexp ? matching += 1 : not_matching += 1 }

  unless matching == CONFIG.num_matching_lines
    raise "Expecting #{CONFIG.num_matching_lines} matches, got #{matching} for /#{regexp.to_s}/"
  end
  unless not_matching == CONFIG.num_not_matching_lines
    raise "Expecting #{CONFIG.num_not_matching_lines} not matches, got #{not_matching} for /#{regexp.to_s}/"
  end
end


# Main entry
def main
  STDOUT.print(
    JSON.pretty_generate(
      BenchmarkBase.benchmark_all do |key, regexp_str|
        regexp = Regexp.new(regexp_str)
        regexp_data = File.open(File.join(CONFIG.scratch_directory, key)).readlines.map { |line| line.chomp("\n") }

        time = Utils::get_run_time do
          (0...CONFIG.repeat_times).each { perform_test(regexp_data, regexp) }
        end

        [key, time]
      end
    )
  )
end

main if $0 == __FILE__
