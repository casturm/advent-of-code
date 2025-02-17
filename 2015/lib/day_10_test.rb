require 'minitest/autorun'

require_relative './day_10'
require_relative './helpers'

class Day10Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      3113322113
    INPUT

    @test_input = @test_input.strip

    @input = get_input(10)
  end

  def test_part_1
    assert_equal '11', Day10.iterate('1', 1)
    assert_equal '21', Day10.iterate('1', 2)
    assert_equal '1211', Day10.iterate('1', 3)
    assert_equal '111221', Day10.iterate('1', 4)
    assert_equal '312211', Day10.iterate('1', 5)
    assert_equal '33', Day10.iterate('333', 1)

    assert_equal '132123222113', Day10.iterate(@input, 1)
    assert_equal '111312111213322113', Day10.iterate(@input, 2)
    assert_equal '3113111231121123222113', Day10.iterate(@input, 3)

    answer = Day10.part_1(@input, 40)
    puts "Part 1: #{answer}"

    submit_answer(10, answer, 1)
  end

  def test_part_2
    answer = Day10.part_1(@input, 50)
    puts "Part 2: #{answer}"

    submit_answer(10, answer, 2)
  end
end
