require 'minitest/autorun'

require_relative './day_01'
require_relative './helpers'

class Day1Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
     INPUT

    @test_input = @test_input.strip

    @input = get_input(1)
  end

  def test_part_1
    assert_equal 142, Day01.part_1(@test_input)

    answer = Day01.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(1, answer, 1)
  end

  def test_a_value_of
    puts 'test'
    assert_equal 18, Day01.part_2_value_of('onegcgcrccvsxzvkpfqdj4oneightrgd')
  end

  def test_part_2
    @test_input2 = <<~INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    INPUT

    @test_input2 = @test_input2.strip
    assert_equal 281, Day01.part_2(@test_input2)

    answer = Day01.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(1, answer, 2)
  end
end
