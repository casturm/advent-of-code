require 'minitest/autorun'

require_relative './day_13'
require_relative './helpers'

class Day13Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      Alice would gain 54 happiness units by sitting next to Bob.
      Alice would lose 79 happiness units by sitting next to Carol.
      Alice would lose 2 happiness units by sitting next to David.
      Bob would gain 83 happiness units by sitting next to Alice.
      Bob would lose 7 happiness units by sitting next to Carol.
      Bob would lose 63 happiness units by sitting next to David.
      Carol would lose 62 happiness units by sitting next to Alice.
      Carol would gain 60 happiness units by sitting next to Bob.
      Carol would gain 55 happiness units by sitting next to David.
      David would gain 46 happiness units by sitting next to Alice.
      David would lose 7 happiness units by sitting next to Bob.
      David would gain 41 happiness units by sitting next to Carol.
    INPUT

    @test_input = @test_input.strip

    @input = get_input(13)
  end

  def test_part_1
    assert_equal 330, Day13.part_1(@test_input)

    answer = Day13.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(13, answer, 1)
  end

  def test_part_2
    answer = Day13.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(13, answer, 2)
  end
end
