require 'minitest'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < Minitest::Test
  def test_returns_zero_lower_case_chars_if_string_is_empty
    writer = NightWriter.new
    assert_equal 0, writer.count_lower('')
  end

  def test_counts_number_of_lower_case_characters
    writer = NightWriter.new
    assert_equal 5, writer.count_lower('abcde')
  end

  def test_counts_lower_characters_in_mixed_string
    writer = NightWriter.new
    assert_equal 2, writer.count_lower('ABCDEfg')
  end

  def test_counts_number_of_upper_case_characters
    skip
    writer = NightWriter.new
    assert_equal 5, writer.count_upper('ABCDE')
  end

  def test_counts_upper_characters_in_mixed_string
    skip
    writer = NightWriter.new
    assert_equal 5, writer.count_lower('ABCDEfg')
  end

  def test_counts_number_of_characters_plus_shifts
    skip
    writer = NightWriter.new
    assert_equal 9, writer.count_chars_and_shifts('AbCdEf')
  end
end
