require_relative 'categorize'

class TextToBrailleConverter
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
