#! /usr/bin/env ruby

=begin
Generate test case for regexp benchmark
=end

require 'json'
require 'regexp-examples'

require_relative 'lib/utils'


CONFIG = Utils::config
REGEXPS = Utils::regexps


# Create a random printable character
def random_character
  Random.rand(32...127).chr
end

# Create a random string with given length
# @param [Fixnum] length
def random_string(length=nil)
  length = Random.rand(32) if length.nil?
  (0...length).map { random_character }.join('')
end


# Mutate the string
# @param [String] string The string to be mutated
# @return [String] Result
def mutate(string)
  (0...Random.rand(5)).each do
    index = Random.rand(0...string.length)
    case Random.rand(0...3)
    when 0 then
      string.slice!(index)
    when 1 then
      string.insert(index, random_character)
    when 2 then
      string[index] = random_character
    end
  end
  string
end


# Write the test texts
# @param [IO] stream Stream that accepts the text
# @param [String] regex_str Regular expression in string format
def write_test(stream, regex_str)
  compiled_regexp = Regexp.compile(regex_str)

  generate_matching_regex_strings = -> do
    (0...CONFIG.num_matching_lines).map do
      begin
        example = compiled_regexp.random_example.gsub(/[^[[:print:]]]/, '')
      end until compiled_regexp.match(example)
      random_string + example + random_string
    end
  end


  generate_not_matching_regex_strings = -> do
    (0...CONFIG.num_not_matching_lines).map do
      begin
        example = (random_string +
                   mutate(compiled_regexp.random_example.gsub(/[^[[:print:]]]/, '')) +
                   random_string)
      end until !compiled_regexp.match(example)
      example
    end
  end

  (generate_matching_regex_strings.call() +
      generate_not_matching_regex_strings.call()).shuffle.each do |item|
    stream.printf("%s\n", item)
  end
end


# Main entry
def main
  REGEXPS.each do |k, v|
    STDOUT.printf("Generating test for %s /%s/...\n", k, v)
    write_test(File.open(File.join(CONFIG.scratch_directory, k), 'w'), v)
  end
end

main if $0 == __FILE__
