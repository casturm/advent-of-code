require 'minitest/autorun'

require_relative './day_21'
require_relative './helpers'

class Day21Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      Hit Points: 12
      Damage: 7
      Armor: 2
    INPUT

    @test_input = @test_input.strip

    @input = get_input(21)
  end

  def test_part_1
    game = {
      player: { points: 8, damage: 5, armor: 5 },
      boss: { points: 12, damage: 7, armor: 2 }
    }
    assert Day21.run_trial(game)

    answer = Day21.part_1(@input, 100)
    puts "Part 1: #{answer}"

    submit_answer(21, answer, 1)
  end

  def test_part_2
    answer = Day21.part_2(@input, 100)
    puts "Part 2: #{answer}"

    submit_answer(21, answer, 2)
  end
end
