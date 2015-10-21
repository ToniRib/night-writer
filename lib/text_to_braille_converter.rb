require_relative 'categorize'
require_relative 'dictionary'

class TextToBrailleConverter
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
end
