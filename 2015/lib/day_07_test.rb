require 'minitest/autorun'

require_relative './day_07'
require_relative './helpers'

class Day7Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      123 -> x
      456 -> y
      x AND y -> d
      x OR y -> e
      x LSHIFT 2 -> f
      y RSHIFT 2 -> g
      NOT x -> h
      NOT y -> i
    INPUT

    @test_input = @test_input.strip

    @input = get_input(7)
  end

  def test_part_1
    assert_equal 123, Day07.part_1(@test_input, 'x')
    assert_equal 456, Day07.part_1(@test_input, 'y')
    assert_equal 72, Day07.part_1(@test_input, 'd')

    answer = Day07.part_1(@input, 'a')
    puts "Part 1: #{answer}"

    submit_answer(7, answer, 1)
  end

  def test_part_2
    answer = Day07.part_2(@input, 'a')
    puts "Part 2: #{answer}"

    submit_answer(7, answer, 2)
  end
end
