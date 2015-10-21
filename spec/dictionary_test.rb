require 'minitest'
require 'minitest/pride'
require './lib/dictionary'

class DictionaryTest < Minitest::Test
  def test_looks_up_braille_on_top_line
    dictionary = Dictionary.new
    assert_equal '0.', dictionary.lookup_braille(:top, 'a')
  end

  def test_looks_up_braille_on_middle_line
    dictionary = Dictionary.new
    assert_equal '..', dictionary.lookup_braille(:middle, 'a')
  end

  def test_looks_up_braille_on_bottom_line
    dictionary = Dictionary.new
    assert_equal '..', dictionary.lookup_braille(:bottom, 'a')
  end

  def test_looks_up_possible_chars_from_top_line
    dictionary = Dictionary.new
    assert_equal 'abehkloruvz1258', dictionary.lookup_text(:top, '0.')
  end

  def test_looks_up_possible_chars_from_middle_line
    dictionary = Dictionary.new
    assert_equal "ackmux'-13 @", dictionary.lookup_text(:middle, '..')
  end

  def test_looks_up_possible_chars_from_bottom_line
    dictionary = Dictionary.new
    assert_equal 'abcdefghij0123456789, ', dictionary.lookup_text(:bottom, '..')
  end
end
