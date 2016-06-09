#! /usr/bin/env ruby

=begin
Run all the regular expression tests
=end

require 'erb'
require 'json'
require 'ostruct'
require 'set'


RUN_TEST_CONFIG_FILE = 'config/run_test.json'
RUN_TEST_CONFIG = JSON.parse(File.open(RUN_TEST_CONFIG_FILE, 'r').read)
REGEXP_ENGINE_TESTS = RUN_TEST_CONFIG['tests']

REGULAR_EXPRESSIONS_FILE = 'config/regexps.json'
REGULAR_EXPRESSIONS = JSON.parse(
  File.open(REGULAR_EXPRESSIONS_FILE, 'r').read).map do |k, v|
    {name: k, regexp: v}
  end

README_TEMPLATE_FILE = 'src/templates/README.md.erb'
README_OUTPUT_FILE = 'README.md'

Result = Struct.new(:engine, :version, :result, :normalized)


class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end


def main
  tests = Set.new
  results = Array.new

  `ruby src/generate_tests.rb`

  REGEXP_ENGINE_TESTS.each do |name, instructions|
    STDOUT.print("Benchmarking #{name}...\n")
    result = Result.new

    result.engine = name
    result.version = instructions['version'].nil? ? nil : `#{instructions['version']} 2>&1`.strip

    `#{instructions['compile']}` if instructions['compile']

    result.result = JSON.parse(`#{instructions['execute']}`)
    result.normalized = Hash.new

    results.push(result)
  end

  minimum_time = Hash.new
  REGULAR_EXPRESSIONS.map { |i| i[:name] }.each do |key|
    minimum_time[key] = results.map { |r| r.result[key] }.min
  end
  results.each do |result|
    REGULAR_EXPRESSIONS.map { |i| i[:name] }.each do |key|
      result.normalized[key] = result.result[key] / minimum_time[key]
    end
  end


  File
    .open(README_OUTPUT_FILE, 'w')
    .write(
      ErbalT
        .new({results: results, regexps: REGULAR_EXPRESSIONS})
        .render(File.open(README_TEMPLATE_FILE, 'r').read)
    )
end

main if $0 == __FILE__
