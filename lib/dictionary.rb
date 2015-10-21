class Dictionary
  def initialize
    @top_lines = { "abehkloruvz1258" => '0.',
                 "ijstw09$" => '.0',
                 "cdfgmnpqxy3467" => '00',
                 "!',-.? " => '..'
    }

    @middle_lines = { "ackmux'-13 " => '..',
                    "bfilpsv,?269" => '0.',
                    "denoyz45$" => '.0',
                    "ghjqrtw!.078" => '00'
    }

    @bottom_lines = { "abcdefghij0123456789, " => '..',
                    "klmnopqrst!'" => '0.',
                    "w." => '.0',
                    "uvxyz-?$" => '00'
    }

    @shift = [['..'], ['..'], ['.0']]
  end

  def lookup_braille(line, letter)
    case line
    when :top
      @top_lines.find { |k, v| k.include?(letter) }.last
    when :middle
      @middle_lines.find { |k, v| k.include?(letter) }.last
    when :bottom
      @bottom_lines.find { |k, v| k.include?(letter) }.last
    end
  end

  def lookup_text(line, letter)
    line.invert.find { |k, v| k.include?(letter) }.last
  end
end