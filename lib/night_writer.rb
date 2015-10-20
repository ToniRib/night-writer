require 'pry'
require_relative 'categorize'
require_relative 'converter'
require_relative 'braille_file_writer'
require_relative 'file_reader'

class NightWriter
  include Categorize

  attr_reader :file_reader, :file_writer, :converter, :top_line, :middle_line, :bottom_line

  def initialize
    @file_reader = FileReader.new
    @file_writer = BrailleFileWriter.new
    @converter = Converter.new
    @top_line = ''
    @middle_line = ''
    @bottom_line = ''
  end

  def count_capital(str)
    str.chars.count do |char|
      capital?(char)
    end
  end

  def count_non_capital(str)
    str.chars.count do |char|
      !capital?(char)
    end
  end

  def count_all_chars(str)
    str = add_number_switch_chars(str)
    count_capital(str) * 2 + count_non_capital(str)
  end

  # TODO: refactor this
  def add_number_switch_chars(str)
    num_trigger = false
    new_str = str.chars.map do |char|
      if number?(char) && num_trigger == false
        num_trigger = true
        char.prepend('$')
      elsif space?(char) && num_trigger == true
        num_trigger = false
        char
      else
        char
      end
    end
    new_str.join
  end

  def convert_text_to_braille(str)
    str = add_number_switch_chars(str)
    str.chars.each do |char|
      braille = converter.get_all_lines(char)
      top_line << braille[:top]
      middle_line << braille[:middle]
      bottom_line << braille[:bottom]
    end
    split_all_lines
  end

  def split_all_lines
    @top_line = split_long_lines(@top_line)
    @middle_line = split_long_lines(@middle_line)
    @bottom_line = split_long_lines(@bottom_line)
  end

  def split_long_lines(str)
    str.chars.each_slice(80).to_a.map do |slice|
      slice.join
    end
  end
end

if __FILE__ == $0
  nw = NightWriter.new
  text = nw.file_reader.read
  nw.convert_text_to_braille(text)

  nw.file_writer.write(nw.top_line, nw.middle_line, nw.bottom_line)
  puts "Created #{ARGV[1]} containing #{nw.count_all_chars(text)} braille characters"
end