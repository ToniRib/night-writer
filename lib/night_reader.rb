require 'pry'
require_relative 'categorize'
require_relative 'converter'
require_relative 'braille_file_writer'
require_relative 'file_reader'

class NightReader
  include Categorize

  attr_reader :file_reader, :file_writer, :converter, :top_line, :middle_line, :bottom_line, :text

  def initialize
    @file_reader = FileReader.new
    @file_writer = BrailleFileWriter.new
    @converter = Converter.new
    @top_line = ''
    @middle_line = ''
    @bottom_line = ''
    @text = ''
  end

  def reconstruct_braille_lines(str)
    split_str = str.split
    i = 1
    str.split.each do |line|
      if i == 1
        top_line << line
        i = 2
      elsif i == 2
        middle_line << line
        i = 3
      else
        bottom_line << line
        i = 1
      end
    end
  end
end

if __FILE__ == $0
  nr = NightReader.new
  text = nr.file_reader.read
  binding.pry
  # nr.convert_text_to_braille(text)

  # nr.file_writer.write(nr.top_line, nr.middle_line, nr.bottom_line)
  # puts "Created #{ARGV[1]} containing #{nr.count_all_chars(text)} braille characters"
end