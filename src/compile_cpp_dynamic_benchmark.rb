#! /usr/bin/env ruby

=begin
Perform the cpp_dynamic_benchmark with corresponding RegExp library
=end

require 'erb'
require 'json'
require 'optparse'
require 'ostruct'


COMPILE_CXX_COMMAND = ('%{compiler} src/lib/config.cpp src/lib/regexps.cpp src/lib/utils.cpp ' +
                       'src/lib/benchmark.cpp %{engine} ' +
                       '-o %{output_executable} -O3 -Wall -lboost_system -lboost_filesystem ' +
                       '-ljsoncpp %{additional_libraries} -std=c++11 ' +
                       '-Isrc/include %{additional_flags} ')

DEFAULT_COMPILER = 'g++'

CPP_TEMPLATE_CONFIG_FILES = 'config/cpp_templates.json'

ERB_CPP_TEMPLATE = 'src/templates/benchmark.cpp.erb'
ERB_CPP_TARGET = 'src/lib/benchmark.cpp'

ERB_H_TEMPLATE = 'src/templates/benchmark.h.erb'
ERB_H_TARGET = 'src/include/benchmark.h'

TEMPLATE_CONFIG = JSON.parse(File.open(CPP_TEMPLATE_CONFIG_FILES).read)
SUPPORTED_REGEXP_LIBRARY = TEMPLATE_CONFIG.keys


def parse_args
  options = {
    main: 'src/cpp_dynamic_benchmark.cpp',
    compiler: DEFAULT_COMPILER,
    flags: ''
  }

  OptionParser.new do |opts|
    opts.banner = 'Usage: cpp_dynamic_benchmark.rb [options] regexp_library'

    opts.on('-m', '--main=M', 'C++ main file') { |main| options[:main] = main }
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
  File.open(ERB_CPP_TARGET, 'w') do |stream|
    stream.write(
      ERB.new(File.open(ERB_CPP_TEMPLATE, 'r').read)
         .result(OpenStruct.new(render_parameters).instance_eval { binding }))
  end
  File.open(ERB_H_TARGET, 'w') do |stream|
    stream.write(
      ERB.new(File.open(ERB_H_TEMPLATE, 'r').read)
         .result(OpenStruct.new(render_parameters).instance_eval { binding }))
  end
end


def main
  options = parse_args()

  compiler_parameters = {
    compiler: options[:compiler],
    engine: options[:main],
    output_executable: 'cpp_' + options[:regex_library] + '_dynamic',
    additional_libraries: TEMPLATE_CONFIG[options[:regex_library]]['link_library'],
    additional_flags: options[:flags]
  }
  compile_command = COMPILE_CXX_COMMAND % compiler_parameters

  template_parameters = TEMPLATE_CONFIG[options[:regex_library]].select { |k| k.start_with?('regexp') }

  render_file(template_parameters)

  puts "Executing #{compile_command}"
  `#{compile_command}`
end

main if $0 == __FILE__
