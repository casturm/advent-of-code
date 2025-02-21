require 'minitest/autorun'

require_relative './day_14'
require_relative './helpers'

class Day14Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
      Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
    INPUT

    @test_input = @test_input.strip

    @input = get_input(14)
  end

  def test_part_1
    assert Day14.fly?(1, 10, 127)
    assert Day14.fly?(10, 10, 127)
    refute Day14.fly?(11, 10, 127)
    refute Day14.fly?(137, 10, 127)
    assert Day14.fly?(138, 10, 127)

    assert_equal 160, Day14.part_1(@test_input, 10)
    assert_equal 176, Day14.part_1(@test_input, 12)
    assert_equal 176, Day14.part_1(@test_input, 138)
    assert_equal 280, Day14.part_1(@test_input, 148)
    assert_equal 1120, Day14.part_1(@test_input, 1000)

    answer = Day14.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(14, answer, 1)
  end

  def test_part_2
    assert_equal 689, Day14.part_2(@test_input, 1000)

    answer = Day14.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(14, answer, 2)
  end
end
