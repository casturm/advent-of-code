require 'minitest/autorun'

require_relative './day_08'
require_relative './helpers'

class Day8Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
    INPUT

    @test_input = @test_input.strip

    @input = get_input(8)
  end

  def test_off_map?
    rowlen = 13
    cols = 12
    refute Day08.off_map?([0, 0], rowlen, cols)
    assert Day08.off_map?([0, 12], rowlen, cols)
    assert Day08.off_map?([12, 12], rowlen, cols)
  end

  def test_antinode
    assert_equal([[0, 11]], Day08.antinode([1, 8], [2, 5], 13, 12))
    assert_equal([[3, 2]], Day08.antinode([2, 5], [1, 8], 13, 12))
  end

  def test_part_1
    assert_equal 14, Day08.part_1(@test_input)

    answer = Day08.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(8, answer, 1)
  end

  def test_part_2
    assert_equal 34, Day08.part_2(@test_input)

    answer = Day08.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(8, answer, 2)
  end
end
