require 'minitest'
require 'minitest/pride'
require './lib/braille_to_text_converter'

require 'pry'

class BrailleToTextConverterTest < Minitest::Test
  def test_detects_a_character
    converter = BrailleToTextConverter.new
    a = [['0.'], ['..'], ['..']]
    assert_equal 'a', converter.get_character(a)
  end

  def test_detects_a_different_character
    converter = BrailleToTextConverter.new
    z = [['0.'], ['.0'], ['00']]
    assert_equal 'z', converter.get_character(z)
  end

  def test_detects_a_space
    converter = BrailleToTextConverter.new
    space = [['..'], ['..'], ['..']]
    assert_equal ' ', converter.get_character(space)
  end

  def test_returns_common_character
    converter = BrailleToTextConverter.new
    matches = ['abcde', 'afghi', 'ajklm']
    assert_equal 'a', converter.find_common_character(matches)
  end
end
