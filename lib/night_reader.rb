require_relative 'categorize'
require_relative 'converter'
require_relative 'file_writer'
require_relative 'file_reader'

class NightReader
  include Categorize

  attr_reader :file_reader, :file_writer, :converter, :top_line, :middle_line, :bottom_line, :text

  LETTER_TO_NUM = { 'a' => '1',
                    'b' => '2',
                    'c' => '3',
                    'd' => '4',
                    'e' => '5',
                    'f' => '6',
                    'g' => '7',
                    'h' => '8',
                    'i' => '9',
                    'j' => '0'
  }

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
    @converter = Converter.new
    @top_line = ''
    @middle_line = ''
    @bottom_line = ''
    @text = ''
  end

  def reconstruct_braille_lines(str)
    split_str = str.split
    split_str.each_slice(3).to_a.each do |slice|
      top_line << slice[0]
      middle_line << slice[1]
      bottom_line << slice[2]
    end
  end

  def slice_braille(str)
    str.chars.each_slice(2).to_a.map { |slice| slice.join }
  end

  # Can this be run on the instance variables?
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

  def correct_for_capitals(str)
    characters = str.chars
    characters.size.times do |i|
      characters[i + 1].capitalize! if at_sign?(characters[i])
    end
    characters.join.delete("@")
  end

  def correct_for_numbers(str)
    str.split.map do |word|
      convert_to_numbers_if_necessary(word)
    end.join(' ')
  end

  def convert_to_numbers_if_necessary(word)
    if word.include?('#')
      split_nums = word.split('#')
      nums = convert_letters_to_numbers(split_nums.last)
      split_nums[0] + nums
    else
      word
    end
  end

  def convert_letters_to_numbers(word)
    word.chars.map { |l| LETTER_TO_NUM[l] }.join
  end

  def convert_braille_to_text(str)
    reconstruct_braille_lines(str)
    slice_all_lines(@top_line, @middle_line, @bottom_line)
    top_line.length.times do
      @text << converter.get_character_from_braille(get_next_set)
    end
    @text = correct_for_capitals(@text)
    @text = correct_for_numbers(@text)
  end
end

if __FILE__ == $0
  nr = NightReader.new
  text = nr.file_reader.read
  nr.convert_braille_to_text(text)

  nr.file_writer.write_text(nr.text)
  puts "Created #{ARGV[1]} containing #{nr.text.length} English characters"
end
