require 'minitest/autorun'

require_relative './day_24'
require_relative './helpers'

class Day24Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      1
      2
      3
      4
      5
      7
      8
      9
      10
      11
    INPUT

    @test_input = @test_input.strip

    @input = get_input(24)
  end

  def test_part_1
    assert_equal 99, Day24.part_1(@test_input)

    puts 99
    answer = Day24.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(24, answer, 1)
  end

  def test_part_2
    skip('Part 2 not yet implemented')
    assert_equal 1, Day24.part_2(@test_input)

    answer = Day24.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(24, answer, 2)
  end
end
