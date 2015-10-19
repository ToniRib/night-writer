require 'pry'

class NightWriter
  attr_reader :file_reader, :file_writer

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
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

class FileWriter
  def write(text)
      filename = ARGV[1]
      outfile = File.open(filename, 'w')
      outfile.write(text)
      outfile.close
  end
end

writer = NightWriter.new
text = writer.file_reader.read
writer.file_writer.write(text)
puts "Created #{ARGV[1]} containing #{writer.count_all_chars(text)} characters"
