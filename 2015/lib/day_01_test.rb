require 'minitest/autorun'

require_relative './day_01'
require_relative './helpers'

class Day1Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @input = get_input(1)
  end

  def test_part_1
    assert_equal 0, Day01.part_1('(())')
    assert_equal 3, Day01.part_1('(()(()(')
    assert_equal(-3, Day01.part_1(')())())'))

    answer = Day01.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(1, answer, 1)
  end

  def test_part_2
    assert_equal 1, Day01.part_2(')')
    assert_equal 5, Day01.part_2('()())')

    answer = Day01.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(1, answer, 2)
  end
end
