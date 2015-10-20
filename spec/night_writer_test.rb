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
    assert_equal 0, writer.count_capital('')
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
    assert_equal 5, writer.count_capital('ABCDE')
  end

  def test_counts_entire_range_of_upper_chars
    writer = NightWriter.new
    assert_equal 2, writer.count_capital('AZ')
  end

  def test_does_not_include_at_or_left_square_bracket_in_count
    writer = NightWriter.new
    assert_equal 1, writer.count_capital('@A[')
  end

  def test_counts_upper_characters_in_mixed_string
    writer = NightWriter.new
    assert_equal 5, writer.count_capital('ABCDEfg')
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

  def test_adds_dollar_sign_in_front_of_single_digit
    writer = NightWriter.new
    assert_equal '$1', writer.add_number_switch_chars('1')
  end

  def test_adds_dollar_sign_for_number_switch_character
    writer = NightWriter.new
    str = "This 1234 is 456 a23 string 1 with numbers."
    switch_str = "This $1234 is $456 a$23 string $1 with numbers."
    assert_equal switch_str, writer.add_number_switch_chars(str)
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

  def test_converts_entire_string_to_three_lines_of_braille
    writer = NightWriter.new
    top = '..0.0.0.0.0......00.00.0'
    middle = '..00.00.0..0....00.0.00.'
    bottom = '.0....0.0.0....00.0.0...'
    str = 'Hello Toni'
    writer.convert_text_to_braille(str)
    assert_equal top, writer.top_line
    assert_equal middle, writer.middle_line
    assert_equal bottom, writer.bottom_line
  end

  def test_converts_string_with_numbers_into_three_lines_of_braille
    writer = NightWriter.new
    top = '..0.0.0.0.0......00.00.0...00...0...0..00.'
    middle = '..00.00.0..0....00.0.00....0........0..00.'
    bottom = '.0....0.0.0....00.0.0.....00..........00..'
    str = 'Hello Toni 1 a b2'
    writer.convert_text_to_braille(str)
    assert_equal top, writer.top_line
    assert_equal middle, writer.middle_line
    assert_equal bottom, writer.bottom_line
  end

  def test_splits_string_into_40_char_arrays
    writer = NightWriter.new
    str = 'aaaaaaaaaabbbbbbbbbbccccccccccdddddddddd' +
          'eeeeeeeeeeffffffffffgggggggggghhhhhhhhhh' +
          'iiiiiiiiiijjjjjjjjjjkkkkkkkkkkllllllllll'
    broken_str = ['aaaaaaaaaabbbbbbbbbbccccccccccdddddddddd',
                  'eeeeeeeeeeffffffffffgggggggggghhhhhhhhhh',
                  'iiiiiiiiiijjjjjjjjjjkkkkkkkkkkllllllllll'
    ]
    assert_equal broken_str, writer.split_long_lines(str)
  end
end
