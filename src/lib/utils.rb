=begin
Utility functions for Regexp benchmark
=end

require 'json'
require 'ostruct'


module Utils
  CONFIG_DIRECTORY = 'config'
  CONFIG_FILE = File.join(CONFIG_DIRECTORY, 'config.json')
  REGEXP_FILE = File.join(CONFIG_DIRECTORY, 'regexps.json')

  @@config = nil
  @@regexps = nil

  class << self
    # @return [OpenStruct] The config 
    def config
      if @@config.nil?
        @@config = OpenStruct.new
        read_json_file(CONFIG_FILE, @@config)
      end
      @@config
    end

    # @return [Hash] The regular expressions to be tested
    def regexps
      if @@regexps.nil?
        @@regexps = Hash.new
        read_json_file(REGEXP_FILE, @@regexps)
      end
      @@regexps
    end

    private
    def read_json_file(file_name, struct)
      JSON.parse(File.open(file_name).read).map { |k, v| struct[k] = v }
      struct
    end
  end
end
