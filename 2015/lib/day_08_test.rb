require 'minitest/autorun'

require_relative './day_08'
require_relative './helpers'

class Day8Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      ""
      "abc"
      "aaa\\"aaa"
      "\\x27"
    INPUT

    @test_input = @test_input.strip

    @input = get_input(8)
  end

  def test_part_1
    assert_equal 2, Day08.part_1("\"\"\n")
    assert_equal 12, Day08.part_1(@test_input)

    answer = Day08.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(8, answer, 1)
  end

  def test_part_2
    assert_equal 4, Day08.part_2('""')
    assert_equal 4, Day08.part_2('"abc"')
    assert_equal 6, Day08.part_2('"aaa\"aaa"')
    assert_equal 5, Day08.part_2('"\x27"')
    assert_equal 6, Day08.part_2('"\\""')
    assert_equal 6, Day08.part_2('"\\\\"')
    assert_equal 5, Day08.part_2('"abc\\x27def"')
    assert_equal 19, Day08.part_2(@test_input)

    answer = Day08.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(8, answer, 2)
  end
end
