require 'minitest/autorun'

require_relative './day_12'
require_relative './helpers'

class Day12Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      RRRRIICCFF
      RRRRIICCCF
      VVRRRCCFFF
      VVRCCCJFFF
      VVVVCJJCFE
      VVIVCCJJEE
      VVIIICJJEE
      MIIIIIJJEE
      MIIISIJEEE
      MMMISSJEEE
    INPUT

    @test_input = @test_input.strip

    @input = get_input(12)
  end

  def test_part_1_example
    @example = <<~EXAMPLE
      AAAA
      BBCD
      BBCC
      EEEC
    EXAMPLE

    assert_equal 140, Day12.part_1(@example)
  end

  def test_part_1_example_2
    @example_2 = <<~INPUT
      OOOOO
      OXOXO
      OOOOO
      OXOXO
      OOOOO
    INPUT

    assert_equal 772, Day12.part_1(@example_2)
  end

  def test_part_1
    assert_equal 1930, Day12.part_1(@test_input)

    answer = Day12.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(12, answer, 1)
  end

  def test_part_2
    skip('Part 2 not yet implemented')
    assert_equal 1, Day12.part_2(@test_input)

    answer = Day12.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(12, answer, 2)
  end
end
