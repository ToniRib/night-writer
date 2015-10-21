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

  def switch?(char)
    convert_to_byte(char) == 36
  end

  def at_sign?(char)
    convert_to_byte(char) == 64
  end
end
