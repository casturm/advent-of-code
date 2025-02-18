require 'minitest/autorun'

require_relative './day_12'
require_relative './helpers'

class Day12Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(12)
  end

  def test_part_1
    assert_equal 6, Day12.part_1('[1,2,3]')
    assert_equal 3, Day12.part_1('[[[3]]]')
    assert_equal 3, Day12.part_1('{"a":{"b":4},"c":-1}')

    answer = Day12.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(12, answer, 1)
  end

  def test_part_2
    assert_equal 4, Day12.part_2('[1,{"c":"red","b":2},3]')
    assert_equal 0, Day12.part_2('{"d":"red","e":[1,2,3,4],"f":5}')
    assert_equal 6, Day12.part_2('[1,"red",5]')
    answer = Day12.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(12, answer, 2)
  end
end
