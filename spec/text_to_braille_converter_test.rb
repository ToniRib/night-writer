require 'minitest'
require 'minitest/pride'
require './lib/text_to_braille_converter'

require 'pry'

class TextToBrailleConverterTest < Minitest::Test
  def test_converts_single_letter_to_top_line_of_braille
    converter = TextToBrailleConverter.new
    assert_equal '0.', converter.get_top_line('a')
  end

  def test_converts_single_letter_to_middle_line_of_braille
    converter = TextToBrailleConverter.new
    assert_equal '..', converter.get_middle_line('a')
  end

  def test_converts_single_letter_to_bottom_line_of_braille
    converter = TextToBrailleConverter.new
    assert_equal '..', converter.get_bottom_line('a')
  end

  def test_detects_a_capital_letter
    converter = TextToBrailleConverter.new
    assert converter.capital?('A')
  end

  def test_rejects_a_lowercase_letter
    converter = TextToBrailleConverter.new
    refute converter.capital?('a')
  end

  def test_detects_a_space
    converter = TextToBrailleConverter.new
    assert converter.space?(' ')
  end

  def test_rejects_a_non_space
    converter = TextToBrailleConverter.new
    refute converter.space?('a')
  end

  def test_detects_a_dollar_sign
    converter = TextToBrailleConverter.new
    assert converter.switch?('$')
  end

  def test_rejects_a_non_dollar_sign
    converter = TextToBrailleConverter.new
    refute converter.switch?('*')
  end

  def test_adds_a_shift_character_if_letter_is_capital
    converter = TextToBrailleConverter.new
    assert_equal '..00', converter.get_top_line('N')
    assert_equal '...0', converter.get_middle_line('N')
    assert_equal '.00.', converter.get_bottom_line('N')
  end

  def test_does_not_add_a_shift_character_if_letter_is_lowercase
    converter = TextToBrailleConverter.new
    assert_equal '00', converter.get_top_line('n')
    assert_equal '.0', converter.get_middle_line('n')
    assert_equal '0.', converter.get_bottom_line('n')
  end

  def test_can_write_a_space
    converter = TextToBrailleConverter.new
    assert_equal '..', converter.get_top_line(' ')
    assert_equal '..', converter.get_middle_line(' ')
    assert_equal '..', converter.get_bottom_line(' ')
  end

  def test_can_write_an_exclamation_point
    converter = TextToBrailleConverter.new
    assert_equal '..', converter.get_top_line('!')
    assert_equal '00', converter.get_middle_line('!')
    assert_equal '0.', converter.get_bottom_line('!')
  end

  def test_can_get_all_three_lines_for_lowercase_letter
    converter = TextToBrailleConverter.new
    braille_hash = { top: '00', middle: '.0', bottom: '0.' }
    assert_equal braille_hash, converter.get_all_lines('n')
  end

  def test_can_get_all_three_lines_for_capital_letter
    converter = TextToBrailleConverter.new
    braille_hash = { top: '..0.', middle: '...0', bottom: '.000' }
    assert_equal braille_hash, converter.get_all_lines('Z')
  end

  def test_can_get_all_three_lines_for_space
    converter = TextToBrailleConverter.new
    braille_hash = { top: '..', middle: '..', bottom: '..' }
    assert_equal braille_hash, converter.get_all_lines(' ')
  end

  def test_can_get_all_three_lines_for_switch_dollar_sign
    converter = TextToBrailleConverter.new
    braille_hash = { top: '.0', middle: '.0', bottom: '00' }
    assert_equal braille_hash, converter.get_all_lines('$')
  end
end
