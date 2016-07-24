=begin
Perform a benchmark on matching regexp over strings
=end

require_relative 'utils'

module BenchmarkBase
  CONFIG = Utils::config
  REGEXPS = Utils::regexps


  class << self
    def benchmark_all
      REGEXPS.map do |key, regexp_str|
        yield key, regexp_str
      end.to_h
    end

    def benchmark_all_using_external_script
      benchmark_all do |key, regexp_str|
        regexp_file_name = File.join(CONFIG.scratch_directory, key)

        cmd = yield regexp_str, regexp_file_name

        # Verify the matching first
        matching = `#{cmd} | wc -l`.to_i
        unless matching == CONFIG.num_matching_lines
          raise "Expecting #{CONFIG.num_matching_lines} matches, got #{matching} for /#{regexp_str}/"
        end

        time = Utils::get_run_time { (0...CONFIG.repeat_times).each { `#{cmd}` } }

        [key, time]
      end.to_h
    end
  end
end
