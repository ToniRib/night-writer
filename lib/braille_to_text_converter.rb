class BrailleToTextConverter
  TOP_LINE = { "abehkloruvz" => '0.',
               "ijstw" => '.0',
               "cdfgmnpqxy" => '00',
               "!',-.?" => '..'
  }.invert

  MIDDLE_LINE = { "ackmux'-" => '..',
                  "bfilpsv,?" => '0.',
                  "denoyz" => '.0',
                  "ghjqrtw!." => '00'
  }.invert

  BOTTOM_LINE = { "abcdefghij," => '..',
                  "klmnopqrst!'" => '0.',
                  "w." => '.0',
                  "uvxyz-?" => '00'
  }.invert

  SHIFT = [['..'], ['..'], ['.0']]

  SPACE = [['..'], ['..'], ['..']]

  SWITCH = [['.0'], ['.0'], ['00']]
end
