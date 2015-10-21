require 'minitest'
require 'minitest/pride'
require './lib/night_reader'

class NightReaderTest < Minitest::Test
  def test_reconstructs_long_string_into_three_lines_of_braille
    reader = NightReader.new
    str = ".0..\n.0..\n0...\n....\n.0.0\n0.0.\n"
    top = '.0......'
    middle = '.0...0.0'
    bottom = '0...0.0.'
    reader.reconstruct_braille_lines(str)
    assert_equal top, reader.top_line
    assert_equal middle, reader.middle_line
    assert_equal bottom, reader.bottom_line
  end

  def test_slices_line_of_braille_into_sections_of_two
    reader = NightReader.new
    line = '.0...0.0'
    line_sliced = ['.0', '..', '.0', '.0']
    assert_equal line_sliced, reader.slice_braille(line)
  end

  def test_slices_all_lines_into_sections_of_two
    reader = NightReader.new
    top = '0.0.0.0.0.'
    middle = '00.00.0..0'
    bottom = '....0.0.0.'
    top_sliced = ['0.', '0.', '0.', '0.', '0.']
    middle_sliced = ['00', '.0', '0.', '0.', '.0']
    bottom_sliced = ['..', '..', '0.', '0.', '0.']
    reader.slice_all_lines(top, middle, bottom)
    assert_equal top_sliced, reader.top_line
    assert_equal middle_sliced, reader.middle_line
    assert_equal bottom_sliced, reader.bottom_line
  end

  def test_gets_next_braille_character_set
    reader = NightReader.new
    top = '0.0.0.0.0.'
    middle = '00.00.0..0'
    bottom = '....0.0.0.'
    reader.slice_all_lines(top, middle, bottom)
    assert_equal ['0.', '00', '..'], reader.get_next_set
    assert_equal ['0.', '.0', '..'], reader.get_next_set
  end

  def test_converts_braille_with_no_caps_or_numbers_to_text
    reader = NightReader.new
    hello_toni = "0.0.0.0.0....00.00.0..\n" +
                 "00.00.0..0..00.0.00.00\n" +
                 "....0.0.0...0.0.0...0.\n"
    reader.convert_braille_to_text(hello_toni)
    assert_equal "hello toni!", reader.text
  end

  def test_converts_to_numbers_if_word_contains_dollar_sign
    reader = NightReader.new
    word = '#abc'
    assert_equal '123', reader.convert_to_numbers_if_necessary(word)
  end

  def test_does_not_convert_to_numbers_if_word_does_not_contain_dollar_sign
    reader = NightReader.new
    word = 'abc'
    assert_equal word, reader.convert_to_numbers_if_necessary(word)
  end

  def test_replaces_letters_after_at_signs_with_capital_letters
    reader = NightReader.new
    str = '@toni @rib'
    assert_equal 'Toni Rib', reader.correct_for_capitals(str)
  end

  def test_replaces_letters_after_pound_signs_with_numbers
    reader = NightReader.new
    str = '#abc hello hi#d'
    assert_equal '123 hello hi4', reader.correct_for_numbers(str)
  end

  def test_converts_all_letters_to_numbers
    reader = NightReader.new
    str = 'abcdefghij'
    assert_equal '1234567890', reader.convert_letters_to_numbers(str)
  end

  def test_converts_braille_to_text
    reader = NightReader.new
    braille = "..0.0.0.0.0........00.00.0......0.0..0...0...0.0..000..00000......000.0...0.0...\n" +
                "..00.00.0..00.....00.0.00.00....00.000..0...0.00..00.00..0000......0.0....00.0..\n" +
                ".0....0.0.0......00.0.0...0....0..0..00.0.....0.....0...0...00...0000.000.0.....\n" +
                ".00.00...00.000.00..\n.00.0...00.0.0...000\n00......0.0.....00.0\n"
    text =  "Hello, Toni! How's it going? You're 26 today."
    reader.convert_braille_to_text(braille)
    assert_equal text, reader.text
  end
end
