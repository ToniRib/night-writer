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

  def get_character_from_braille(braille_set)
    matches = []
    matches << find_possible_char_matches(TOP_LINE, braille_set[0])
    matches << find_possible_char_matches(MIDDLE_LINE, braille_set[1])
    matches << find_possible_char_matches(BOTTOM_LINE, braille_set[2])
    find_common_character(matches)
  end

  def find_common_character(matches)
    top_chars = matches[0].chars
    middle_chars = matches[1].chars
    bottom_chars = matches[2].chars
    (top_chars & middle_chars & bottom_chars).first
  end

  def find_possible_char_matches(line, set)
    line.find { |k, v| k.include?(set) }.last
  end
end
