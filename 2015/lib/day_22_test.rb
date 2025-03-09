require 'minitest/autorun'

require_relative './day_22'
require_relative './helpers'

class Day22Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(22)
  end

  def test_part_1
    answer = Day22.solve(@input)
    puts "Part 1: #{answer}"

    submit_answer(22, answer, 1)
  end

  def test_part_2
    answer = Day22.solve(@input, hard_mode: true)
    puts "Part 2: #{answer}"

    submit_answer(22, answer, 2)
  end
end
