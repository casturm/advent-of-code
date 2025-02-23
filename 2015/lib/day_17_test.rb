require 'minitest/autorun'

require_relative './day_17'
require_relative './helpers'

class Day17Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      20
      15
      10
      5
      5
    INPUT

    @test_input = @test_input.strip

    @input = get_input(17)
  end

  def test_part_1
    assert_equal 4, Day17.solve(@test_input, 25).first

    answer = Day17.solve(@input).first
    puts "Part 1: #{answer}"

    submit_answer(17, answer, 1)
  end

  def test_part_2
    assert_equal 3, Day17.solve(@test_input, 25).last

    answer = Day17.solve(@input).last
    puts "Part 2: #{answer}"

    submit_answer(17, answer, 2)
  end
end
