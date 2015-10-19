require 'pry'

class NightWriter
  attr_reader :file_reader

  def initialize
    @file_reader = FileReader.new
  end

  def count_lower(str)
    str.each_byte.count do |num|
      (97..122).to_a.include?(num)
    end
  end

  def count_upper(str)
    str.each_byte.count do |num|
      (65..90).to_a.include?(num)
    end
  end

  def count_spaces(str)
    str.each_byte.count do |num|
      num == 32
    end
  end

  def count_all_chars(str)
    count_upper(str) * 2 + count_lower(str) + count_spaces(str)
  end
end

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end

writer = NightWriter.new
text = writer.file_reader.read
puts "Created #{ARGV[1]} containing #{writer.count_all_chars(text)} characters"
