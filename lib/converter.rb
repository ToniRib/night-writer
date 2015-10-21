require_relative 'categorize'
require_relative 'dictionary'

class Converter
  include Categorize

  def initialize
    @dictionary = Dictionary.new
  end

  def get_line(which_line, letter)
    line = ''
    line << @dictionary.lookup_braille(which_line, '@') if capital?(letter)
    line << @dictionary.lookup_braille(which_line, letter.downcase)
  end

  def get_all_lines(letter)
    top_line = get_line(:top, letter)
    middle_line = get_line(:middle, letter)
    bottom_line = get_line(:bottom, letter)

    { top: top_line, middle: middle_line, bottom: bottom_line }
  end

  def get_character_from_braille(braille_set)
    matches = []
    matches << @dictionary.lookup_text(:top, braille_set[0])
    matches << @dictionary.lookup_text(:middle, braille_set[1])
    matches << @dictionary.lookup_text(:bottom, braille_set[2])
    find_common_character(matches)
  end

  def find_common_character(matches)
    top_chars = matches[0].chars
    middle_chars = matches[1].chars
    bottom_chars = matches[2].chars
    (top_chars & middle_chars & bottom_chars).first
  end
end
