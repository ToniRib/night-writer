require 'pry'

class NightWriter
  attr_reader :file_reader, :file_writer, :converter

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
    @converter = Converter.new
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

class Converter
  attr_reader :top, :mid, :bot

  TOP_LINE = { abehkloruvz: '0.',
               ijstw: '.0',
               cdfgmnpqxy: '00'
  }

  MIDDLE_LINE = { ackmux: '..',
                  bfilpsv: '0.',
                  denoyz: '.0',
                  ghjqrtw: '00'
  }

  BOTTOM_LINE = { abcdefghij: '..',
                  klmnopqrst: '0.',
                  w: '.0',
                  uvxyz: '00'
  }

  def initialize
    @top = ''
    @mid = ''
    @bot = ''
  end

  def find_braille_match(line, letter)
    line.find { |k, v| k.to_s.include?(letter) }
  end

  def capital?(letter)
    byte = letter.bytes.first
    (65..90).to_a.include?(byte)
  end

  def get_top_line(letter)
    @top << find_braille_match(TOP_LINE, letter).last
  end

  def get_middle_line(letter)
    @mid << find_braille_match(MIDDLE_LINE, letter).last
  end

  def get_bottom_line(letter)
    @bot << find_braille_match(BOTTOM_LINE, letter).last
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
      outfile.write(text)
      outfile.write(text)
      outfile.close
  end
end

# writer = NightWriter.new
# text = writer.file_reader.read
# writer.file_writer.write(text)
# puts "Created #{ARGV[1]} containing #{writer.count_all_chars(text)} characters"
