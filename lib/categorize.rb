module Categorize
  def convert_to_byte(char)
    char.bytes.first
  end

  def number?(char)
    (48..57).to_a.include?(char.bytes.first)
  end

  def capital?(char)
    (65..90).to_a.include?(convert_to_byte(char))
  end

  def space?(char)
    convert_to_byte(char) == 32
  end

  def lower?(char)
    (97..122).to_a.include?(convert_to_byte(char))
  end

  def switch?(char)
    convert_to_byte(char) == 36
  end

  def punctuation?(char)
    # ! ' , - . ?
    [33, 39, 44, 45, 46, 63].include?(convert_to_byte(char))
  end
end
