#! /usr/bin/env ruby

=begin
Perform the cpp_dynamic_benchmark with corresponding RegExp library
=end

require 'erb'
require 'json'
require 'optparse'
require 'ostruct'

require_relative 'lib/utils'


COMPILE_CXX_COMMAND = ('%{compiler} src/lib/config.cpp src/lib/regexps.cpp src/lib/utils.cpp ' +
                       'src/lib/benchmark.cpp %{engine} ' +
                       '-o %{output_executable} -O3 -Wall -lboost_system -lboost_filesystem ' +
                       '-ljsoncpp %{additional_libraries} -std=c++11 ' +
                       '-Isrc/include %{additional_flags} ')

DEFAULT_COMPILER = 'g++'

CPP_TEMPLATE_CONFIG_FILE = 'config/cpp_templates.json'
REGEXPS_CONFIG_FILE = 'config/regexps.json'

ERB_CPP_TEMPLATE = 'src/templates/benchmark.cpp.erb'
ERB_CPP_TARGET = 'src/lib/benchmark.cpp'

ERB_H_TEMPLATE = 'src/templates/benchmark.h.erb'
ERB_H_TARGET = 'src/include/benchmark.h'

ERB_CPP_MAIN_TEMPLATE = 'src/templates/cpp_static_benchmark.cpp.erb'
ERB_CPP_MAIN_TARGET = 'src/cpp_static_benchmark.cpp'

TEMPLATE_CONFIG = JSON.parse(File.open(CPP_TEMPLATE_CONFIG_FILE).read)
SUPPORTED_REGEXP_LIBRARY = TEMPLATE_CONFIG.keys


def parse_args
  options = {
    compiler: DEFAULT_COMPILER,
    flags: ''
  }

  OptionParser.new do |opts|
    opts.banner = 'Usage: cpp_static_benchmark.rb [options] regexp_library'

    opts.on('-c', '--compiler=C', 'C++ compiler') { |compiler| options[:compiler] = compiler }
    opts.on('-x', '--additional-flags=X', 'Additional flags for the compiler') { |flags| options[:flags] = flags }

    opts.separator('')
    opts.separator('Regexp libraries can be ' + SUPPORTED_REGEXP_LIBRARY.join(', ') + '.')
  end.parse!

  raise ArgumentError, 'Need to specify regexp library.' if ARGV[0].nil?
  raise ArgumentError, 'Unsupported regexp library.' unless SUPPORTED_REGEXP_LIBRARY.include?(ARGV[0])

  options[:regex_library] = ARGV[0]

  options
end


def render_file(render_parameters)
  [ERB_CPP_TEMPLATE, ERB_H_TEMPLATE, ERB_CPP_MAIN_TEMPLATE].zip(
    [ERB_CPP_TARGET, ERB_H_TARGET, ERB_CPP_MAIN_TARGET]).map do |template, target|
      File.open(target, 'w') do |stream|
        stream.write(
          ERB.new(File.open(template, 'r').read)
             .result(OpenStruct.new(render_parameters).instance_eval { binding }))
      end
    end
end


def main
  options = parse_args()

  compiler_parameters = {
    compiler: options[:compiler],
    engine: options[:main],
    additional_libraries: TEMPLATE_CONFIG[options[:regex_library]]['link_library'],
    additional_flags: options[:flags]
  }

  template_parameters = TEMPLATE_CONFIG[options[:regex_library]].select { |k| k.start_with?('regexp') }

  result = Hash.new
  Utils.regexps.each do |name, regexp_str|
    render_file(
      template_parameters.merge(
        {
          regexp_str: regexp_str,
          regexp_file_name: File.join(Utils.config['scratch_directory'], name)
        }
      )
    )

    output_executable = 'cpp_' + options[:regex_library] + '_static_' + name
    compile_command = COMPILE_CXX_COMMAND % compiler_parameters.merge({
      output_executable: output_executable,
      engine: ERB_CPP_MAIN_TARGET
    })

    `#{compile_command}`

    value = `./#{output_executable}`

    result[name] = (value.to_f if Float(value) rescue value)
  end

  puts JSON.pretty_generate(result)
end

main if $0 == __FILE__
