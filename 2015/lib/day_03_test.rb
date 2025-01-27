require 'minitest/autorun'

require_relative './day_03'
require_relative './helpers'

class Day3Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(3)
  end

  def test_part_1
    assert_equal 2, Day03.part_1('>')
    assert_equal 4, Day03.part_1('^>v<')
    assert_equal 2, Day03.part_1('^v^v^v^v^v')

    answer = Day03.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(3, answer, 1)
  end

  def test_part_2
    assert_equal 3, Day03.part_2('^v')
    assert_equal 3, Day03.part_2('^>v<')
    assert_equal 11, Day03.part_2('^v^v^v^v^v')

    assert_equal 1, Day03.part_2(@test_input)

    answer = Day03.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(3, answer, 2)
  end
end
