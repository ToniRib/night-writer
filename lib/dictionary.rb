class Dictionary
  def initialize
    @top_line = { "abehkloruvz1258" => '0.',
                 "ijstw09$" => '.0',
                 "cdfgmnpqxy3467" => '00',
                 "!',-.? @" => '..'
    }

    @middle_line = { "ackmux'-13 @" => '..',
                    "bfilpsv,?269" => '0.',
                    "denoyz45$" => '.0',
                    "ghjqrtw!.078" => '00'
    }

    @bottom_line = { "abcdefghij0123456789, " => '..',
                    "klmnopqrst!'" => '0.',
                    "w.@" => '.0',
                    "uvxyz-?$" => '00'
    }

    @shift = [['..'], ['..'], ['.0']]
  end

  def lookup_braille(line, letter)
    case line
    when :top
      @top_line.find { |k, v| k.include?(letter) }.last
    when :middle
      @middle_line.find { |k, v| k.include?(letter) }.last
    when :bottom
      @bottom_line.find { |k, v| k.include?(letter) }.last
    end
  end

  def lookup_text(line, letter)
    case line
    when :top
      @top_line.invert.find { |k, v| k.include?(letter) }.last
    when :middle
      @middle_line.invert.find { |k, v| k.include?(letter) }.last
    when :bottom
      @bottom_line.invert.find { |k, v| k.include?(letter) }.last
    end
  end
end