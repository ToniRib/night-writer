require 'pry'

class NightWriter
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

  def convert_text_to_braille(str)
    str.chars.each do |char|
      braille = converter.get_all_lines(char)
      top_line << braille[:top]
      middle_line << braille[:middle]
      bottom_line << braille[:bottom]
    end
  end
end

class Converter
  TOP_LINE = { "abehkloruvz" => '0.',
               "ijstw" => '.0',
               "cdfgmnpqxy" => '00',
               "!',-.?" => '..'
  }

  MIDDLE_LINE = { "ackmux'-" => '..',
                  "bfilpsv,?" => '0.',
                  "denoyz" => '.0',
                  "ghjqrtw!." => '00'
  }

  BOTTOM_LINE = { "abcdefghij," => '..',
                  "klmnopqrst!'" => '0.',
                  "w." => '.0',
                  "uvxyz-?" => '00'
  }

  SHIFT = [['..'], ['..'], ['.0']]

  SPACE = '..'

  def find_braille_match(line, letter)
    line.find { |k, v| k.include?(letter) }
  end

  def capital?(letter)
    (65..90).to_a.include?(convert_to_byte(letter))
  end

  def space?(letter)
    convert_to_byte(letter) == 32
  end

  def convert_to_byte(letter)
    letter.bytes.first
  end

  def get_top_line(letter)
    return SPACE if space?(letter)
    top = ''
    top << SHIFT[0].first if capital?(letter)
    top << find_braille_match(TOP_LINE, letter.downcase).last
  end

  def get_middle_line(letter)
    return SPACE if space?(letter)
    middle = ''
    middle << SHIFT[1].first if capital?(letter)
    middle << find_braille_match(MIDDLE_LINE, letter.downcase).last
  end

  def get_bottom_line(letter)
    return SPACE if space?(letter)
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
  writer.convert_text_to_braille(text)

  writer.file_writer.write(writer.top_line, writer.middle_line, writer.bottom_line)
  puts "Created #{ARGV[1]} containing #{writer.count_all_chars(text)} characters"
end