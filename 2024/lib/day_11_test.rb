require 'minitest/autorun'

require_relative './day_11'
require_relative './helpers'

class Day11Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      125 17
    INPUT

    @test_input = @test_input.strip

    @input = get_input(11)
  end

  def test_blink
    stones = Day11.blink(@test_input, 5)
    assert_equal 13, stones.values.sum
    assert_equal 2, stones[4048]
    assert_equal '1036288 7 2 20 24 4048 1 8096 28 67 60 32', stones.keys.map(&:to_s).join(' ')
  end

  def test_part_1
    assert_equal 55_312, Day11.part_1(@test_input)

    answer = Day11.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(11, answer, 1)
  end

  def test_part_2
    answer = Day11.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(11, answer, 2)
  end
end
