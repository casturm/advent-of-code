require 'minitest/autorun'

require_relative './day_06'
require_relative './helpers'

class Day6Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      turn on 0,0 through 999,999
      toggle 0,0 through 999,0
      turn off 499,499 through 500,500
    INPUT

    @test_input = @test_input.strip

    @input = get_input(6)
  end

  def test_part_1
    assert_equal 1_000_000, Day06.part_1('turn on 0,0 through 999,999')
    assert_equal 4, Day06.part_1('turn on 499,499 through 500,500')
    assert_equal 998_996, Day06.part_1(@test_input)

    answer = Day06.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(6, answer, 1)
  end

  def test_part_2
    assert_equal 1, Day06.part_2('turn on 0,0 through 0,0')
    assert_equal 2, Day06.part_2('toggle 0,0 through 0,0')
    assert_equal 0, Day06.part_2('turn off 0,0 through 0,0')
    assert_equal 1, Day06.part_2("toggle 0,0 through 0,0\nturn off 0,0 through 0,0")
    assert_equal 2_000_000, Day06.part_2('toggle 0,0 through 999,999')

    answer = Day06.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(6, answer, 2)
  end
end
