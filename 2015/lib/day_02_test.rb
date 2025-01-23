require 'minitest/autorun'

require_relative './day_02'
require_relative './helpers'

class Day2Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(2)
  end

  def test_part_1
    assert_equal 58, Day02.part_1('2x3x4')
    assert_equal 43, Day02.part_1('1x1x10')

    answer = Day02.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(2, answer, 1)
  end

  def test_part_2
    assert_equal 34, Day02.part_2('2x3x4')
    assert_equal 14, Day02.part_2('1x1x10')

    answer = Day02.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(2, answer, 2)
  end
end
