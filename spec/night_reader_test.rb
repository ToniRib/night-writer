require 'minitest'
require 'minitest/pride'
require './lib/night_reader'

require 'pry'

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
end
