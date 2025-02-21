require 'minitest/autorun'

require_relative './day_15'
require_relative './helpers'

class Day15Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
      Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    INPUT

    @test_input = @test_input.strip

    @input = get_input(15)
  end

  def test_part_1
    ingredients = Day15.parse(@test_input)
    assert_equal 62_842_880, Day15.calculate(ingredients, [44, 56])
    assert_equal 62_842_880, Day15.part_1(@test_input)

    answer = Day15.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(15, answer, 1)
  end

  def test_part_2
    assert_equal 57600000, Day15.part_2(@test_input)

    answer = Day15.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(15, answer, 2)
  end
end
