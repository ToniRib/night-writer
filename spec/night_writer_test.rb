require 'minitest'
require 'minitest/pride'
require './lib/night_writer'

require 'pry'

class NightWriterTest < Minitest::Test
  def test_returns_zero_lower_case_chars_if_string_is_empty
    writer = NightWriter.new
    assert_equal 0, writer.count_lower('')
  end

  def test_returns_zero_upper_case_chars_if_string_is_empty
    writer = NightWriter.new
    assert_equal 0, writer.count_upper('')
  end

  def test_counts_number_of_lower_case_characters
    writer = NightWriter.new
    assert_equal 5, writer.count_lower('abcde')
  end

  def test_does_not_include_backtick_or_left_curly_brace_in_count
    writer = NightWriter.new
    assert_equal 1, writer.count_lower('`a{')
  end

  def test_counts_entire_range_of_lower_chars
    writer = NightWriter.new
    assert_equal 2, writer.count_lower('az')
  end

  def test_counts_lower_characters_in_mixed_string
    writer = NightWriter.new
    assert_equal 2, writer.count_lower('ABCDEfg')
  end

  def test_counts_number_of_upper_case_characters
    writer = NightWriter.new
    assert_equal 5, writer.count_upper('ABCDE')
  end

  def test_counts_entire_range_of_upper_chars
    writer = NightWriter.new
    assert_equal 2, writer.count_upper('AZ')
  end

  def test_does_not_include_at_or_left_square_bracket_in_count
    writer = NightWriter.new
    assert_equal 1, writer.count_upper('@A[')
  end

  def test_counts_upper_characters_in_mixed_string
    writer = NightWriter.new
    assert_equal 5, writer.count_upper('ABCDEfg')
  end

  def test_counts_number_of_characters_plus_shifts
    writer = NightWriter.new
    assert_equal 9, writer.count_all_chars('AbCdEf')
  end

  def test_counts_number_of_spaces
    writer = NightWriter.new
    assert_equal 2, writer.count_spaces('hello there toni')
  end

  def test_counts_all_spaces_shifts_and_chars
    writer = NightWriter.new
    assert_equal 18, writer.count_all_chars('Hello there Toni')
  end

  def test_converts_lower_case_string_to_three_lines_of_braille
    writer = NightWriter.new
    top = '0.0.0.0.0.'
    middle = '00.00.0..0'
    bottom = '....0.0.0.'
    str = 'hello'
    writer.convert_text_to_braille(str)
    assert_equal top, writer.top_line
    assert_equal middle, writer.middle_line
    assert_equal bottom, writer.bottom_line
  end
end

class ConverterTest < Minitest::Test
  def test_converts_single_letter_to_top_line_of_braille
    writer = NightWriter.new
    assert_equal '0.', writer.converter.get_top_line('a')
  end

  def test_converts_single_letter_to_middle_line_of_braille
    writer = NightWriter.new
    assert_equal '..', writer.converter.get_middle_line('a')
  end

  def test_converts_single_letter_to_bottom_line_of_braille
    writer = NightWriter.new
    assert_equal '..', writer.converter.get_bottom_line('a')
  end

  def test_detects_a_capital_letter
    writer = NightWriter.new
    assert writer.converter.capital?('A')
  end

  def test_rejects_a_lowercase_letter
    writer = NightWriter.new
    refute writer.converter.capital?('a')
  end

  def test_detects_a_space
    writer = NightWriter.new
    assert writer.converter.space?(' ')
  end

  def test_rejects_a_non_space
    writer = NightWriter.new
    refute writer.converter.space?('a')
  end

  def test_adds_a_shift_character_if_letter_is_capital
    writer = NightWriter.new
    assert_equal '..00', writer.converter.get_top_line('N')
    assert_equal '...0', writer.converter.get_middle_line('N')
    assert_equal '.00.', writer.converter.get_bottom_line('N')
  end

  def test_does_not_add_a_shift_character_if_letter_is_lowercase
    writer = NightWriter.new
    assert_equal '00', writer.converter.get_top_line('n')
    assert_equal '.0', writer.converter.get_middle_line('n')
    assert_equal '0.', writer.converter.get_bottom_line('n')
  end

  def test_can_write_a_space
    writer = NightWriter.new
    assert_equal '..', writer.converter.get_top_line(' ')
    assert_equal '..', writer.converter.get_middle_line(' ')
    assert_equal '..', writer.converter.get_bottom_line(' ')
  end

  def test_can_get_all_three_lines_for_lowercase_letter
    writer = NightWriter.new
    braille_hash = { top: '00', middle: '.0', bottom: '0.' }
    assert_equal braille_hash, writer.converter.get_all_lines('n')
  end

  def test_can_get_all_three_lines_for_capital_letter
    writer = NightWriter.new
    braille_hash = { top: '..0.', middle: '...0', bottom: '.000' }
    assert_equal braille_hash, writer.converter.get_all_lines('Z')
  end

  def test_can_get_all_three_lines_for_space
    writer = NightWriter.new
    braille_hash = { top: '..', middle: '..', bottom: '..' }
    assert_equal braille_hash, writer.converter.get_all_lines(' ')
  end
end
