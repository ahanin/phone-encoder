unless ARGV.length == 2
    puts "Usage: ruby #{$0} <dictionary> <numbers>"
    exit 1
end

unless File.exists? dict_filepath = ARGV[0]
    puts "Dictionary file #{dict_filepath} does not exist"
    exit 1
end

unless File.exists? numbers_filepath = ARGV[1]
    puts "Numbers file #{numbers_filepath} does not exist"
    exit 1
end

require 'dictionary'
require 'encoder'

dictionary = Dictionary.load_from(dict_filepath)

File.open(numbers_filepath) do |numbers_file|
    Encoder.new(dictionary).for_each_in numbers_file do |number, encoded|
        puts "#{number}: #{encoded}"
    end
end