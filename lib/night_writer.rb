require 'pry'
require_relative 'categorize'

class NightWriter
  include Categorize

  attr_reader :file_reader, :file_writer, :converter, :top_line, :middle_line, :bottom_line

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
    @converter = Converter.new
    @top_line = ''
    @middle_line = ''
    @bottom_line = ''
  end

  def count_lower(str)
    str.chars.count do |char|
      lower?(char)
    end
  end

  def count_capital(str)
    str.chars.count do |char|
      capital?(char)
    end
  end

  def count_spaces(str)
    str.chars.count do |char|
      space?(char)
    end
  end

  def count_all_chars(str)
    count_capital(str) * 2 + count_lower(str) + count_spaces(str)
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
    str.chars.each do |char|
      braille = converter.get_all_lines(char)
      top_line << braille[:top]
      middle_line << braille[:middle]
      bottom_line << braille[:bottom]
    end
  end

  def split_long_lines(str)
    str.chars.each_slice(40).to_a.map do |slice|
      slice.join
    end
  end
end

class Converter
  include Categorize

  TOP_LINE = { "abehkloruvz1258" => '0.',
               "ijstw09" => '.0',
               "cdfgmnpqxy3467" => '00',
               "!',-.?" => '..'
  }

  MIDDLE_LINE = { "ackmux'-13" => '..',
                  "bfilpsv,?269" => '0.',
                  "denoyz45" => '.0',
                  "ghjqrtw!.078" => '00'
  }

  BOTTOM_LINE = { "abcdefghij0123456789," => '..',
                  "klmnopqrst!'" => '0.',
                  "w." => '.0',
                  "uvxyz-?" => '00'
  }

  SHIFT = [['..'], ['..'], ['.0']]

  SPACE = '..'

  SWITCH = [['.0'], ['.0'], ['00']]

  def find_braille_match(line, letter)
    line.find { |k, v| k.include?(letter) }
  end

  def get_top_line(letter)
    return SPACE if space?(letter)
    return SWITCH[0].first if switch?(letter)
    top = ''
    top << SHIFT[0].first if capital?(letter)
    top << find_braille_match(TOP_LINE, letter.downcase).last
  end

  def get_middle_line(letter)
    return SPACE if space?(letter)
    return SWITCH[1].first if switch?(letter)
    middle = ''
    middle << SHIFT[1].first if capital?(letter)
    middle << find_braille_match(MIDDLE_LINE, letter.downcase).last
  end

  def get_bottom_line(letter)
    return SPACE if space?(letter)
    return SWITCH[2].first if switch?(letter)
    bottom = ''
    bottom << SHIFT[2].first if capital?(letter)
    bottom << find_braille_match(BOTTOM_LINE, letter.downcase).last
  end

  def get_all_lines(letter)
    top_line = get_top_line(letter)
    middle_line = get_middle_line(letter)
    bottom_line = get_bottom_line(letter)

    { top: top_line, middle: middle_line, bottom: bottom_line }
  end
end

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end

class FileWriter
  def write(top, middle, bottom)
    filename = ARGV[1]
    outfile = File.open(filename, 'w')
    outfile.write(top << "\n")
    outfile.write(middle << "\n")
    outfile.write(bottom << "\n")
    outfile.close
  end
end

if __FILE__==$0
  writer = NightWriter.new
  text = writer.file_reader.read
  text = writer.add_number_switch_chars(text)
  writer.convert_text_to_braille(text)

  writer.file_writer.write(writer.top_line, writer.middle_line, writer.bottom_line)
  puts "Created #{ARGV[1]} containing #{writer.count_all_chars(text)} characters"
end