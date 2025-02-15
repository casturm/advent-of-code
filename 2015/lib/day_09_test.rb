require 'minitest/autorun'

require_relative './day_09'
require_relative './helpers'

class Day9Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
    INPUT

    @test_input = @test_input.strip

    @input = get_input(9)
  end

  def test_part_1
    assert_equal 605, Day09.part_1(@test_input)

    answer = Day09.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(9, answer, 1)
  end

  def test_part_2
    assert_equal 982, Day09.part_2(@test_input)

    answer = Day09.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(9, answer, 2)
  end
end
