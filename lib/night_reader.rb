require 'pry'
require_relative 'categorize'
require_relative 'braille_to_text_converter'
require_relative 'text_file_writer'
require_relative 'file_reader'

class NightReader
  include Categorize

  attr_reader :file_reader, :file_writer, :converter, :top_line, :middle_line, :bottom_line, :text

  def initialize
    @file_reader = FileReader.new
    @file_writer = TextFileWriter.new
    @converter = BrailleToTextConverter.new
    @top_line = ''
    @middle_line = ''
    @bottom_line = ''
    @text = ''
  end

  # TODO: obviously need to refactor
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

  def slice_braille(str)
    str.chars.each_slice(2).to_a.map { |slice| slice.join }
  end

  def slice_all_lines(top, middle, bottom)
    @top_line = slice_braille(top)
    @middle_line = slice_braille(middle)
    @bottom_line = slice_braille(bottom)
  end

  def get_next_set
    set = []
    set[0] = @top_line.shift
    set[1] = @middle_line.shift
    set[2] = @bottom_line.shift
    set
  end

  def convert_braille_to_text(str)

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
