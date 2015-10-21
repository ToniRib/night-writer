class BrailleToTextConverter
  TOP_LINE = { "abehkloruvz" => '0.',
               "ijstw$" => '.0',
               "cdfgmnpqxy" => '00',
               "!',-.? @" => '..'
  }.invert

  MIDDLE_LINE = { "ackmux'- @" => '..',
                  "bfilpsv,?" => '0.',
                  "denoyz$" => '.0',
                  "ghjqrtw!." => '00'
  }.invert

  BOTTOM_LINE = { "abcdefghij, " => '..',
                  "klmnopqrst!'" => '0.',
                  "w.@" => '.0',
                  "uvxyz-?$" => '00'
  }.invert

  def get_character(braille_set)
    matches = []
    matches << find_char_match(TOP_LINE, braille_set[0].first)
    matches << find_char_match(MIDDLE_LINE, braille_set[1].first)
    matches << find_char_match(BOTTOM_LINE, braille_set[2].first)
    find_common_character(matches)
  end

  def find_common_character(matches)
    top_chars = matches[0].chars
    middle_chars = matches[1].chars
    bottom_chars = matches[2].chars
    (top_chars & middle_chars & bottom_chars).first
  end

  def find_char_match(line, set)
    line.find { |k, v| k.include?(set) }.last
  end

end
