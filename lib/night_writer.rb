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
    return 0 if str.empty?
    total = 0
    str.each_byte do |num|
      total += 1 if (97..122).to_a.include?(num)
    end
    total
  end
end

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
