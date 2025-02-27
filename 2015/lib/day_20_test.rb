require 'minitest/autorun'

require_relative './day_20'
require_relative './helpers'

class Day20Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      10
    INPUT

    @test_input = @test_input.strip

    @input = get_input(20)
  end

  def test_part_1
    assert_equal 10, Day20.count(1)
    assert_equal 30, Day20.count(2)
    assert_equal 40, Day20.count(3)
    assert_equal 70, Day20.count(4)
    assert_equal 60, Day20.count(5)
    assert_equal 120, Day20.count(6)
    assert_equal 80, Day20.count(7)
    assert_equal 150, Day20.count(8)
    assert_equal 130, Day20.count(9)
    assert_equal 1, Day20.part_1(@test_input)

    answer = Day20.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(20, answer, 1)
  end

  def test_part_2
    answer = Day20.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(20, answer, 2)
  end
end
