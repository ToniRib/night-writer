require 'minitest'
require 'minitest/pride'
require './lib/night_reader'

require 'pry'

class NightReaderTest < Minitest::Test
  def test_reconstructs_long_string_into_three_lines_of_braille
    reader = NightReader.new
    str = "....\n.0.0\n0.0.\n....\n.0.0\n0.0.\n"
    top = '........'
    middle = '.0.0.0.0'
    bottom = '0.0.0.0.'
    reader.reconstruct_braille_lines(str)
    assert_equal top, reader.top_line
    assert_equal middle, reader.middle_line
    assert_equal bottom, reader.bottom_line
  end
end