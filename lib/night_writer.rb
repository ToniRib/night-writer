require 'pry'

class NightWriter
  attr_reader :file_reader

  def initialize
    @file_reader = FileReader.new
  end

  def get_file_text
    file_reader.read
  end
end

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
