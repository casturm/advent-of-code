require 'minitest/autorun'

require_relative './day_23'
require_relative './helpers'

class Day23Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(23)
  end

  def test_part_1
    answer = Day23.solve(@input)
    puts "Part 1: #{answer}"

    submit_answer(23, answer, 1)
  end

  def test_part_2
    answer = Day23.solve(@input, init_a: 1)
    puts "Part 2: #{answer}"

    submit_answer(23, answer, 2)
  end
end
