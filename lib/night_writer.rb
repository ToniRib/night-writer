require 'pry'

class NightWriter
  attr_reader :file_reader

  def initialize
    @file_reader = FileReader.new
  end

  def get_file_text
    file_reader.read
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
end

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
