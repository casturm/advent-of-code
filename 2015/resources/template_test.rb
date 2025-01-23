require 'minitest/autorun'

require_relative './day_ZPDAY'
require_relative './helpers'

class DayDAYTest < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(DAY)
  end

  def test_part_1
    assert_equal 1, DayZPDAY.part_1(@test_input)

    answer = DayZPDAY.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(DAY, answer, 1)
  end

  def test_part_2
    skip('Part 2 not yet implemented')
    assert_equal 1, DayZPDAY.part_2(@test_input)

    answer = DayZPDAY.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(DAY, answer, 2)
  end
end
