require 'minitest/autorun'

require_relative './day_04'
require_relative './helpers'

class Day4Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      yzbqklnj
    INPUT

    @test_input = @test_input.strip

    @input = get_input(4)
  end

  def test_part_1
    assert_equal 609_043, Day04.part_1('abcdef')
    assert_equal 1_048_970, Day04.part_1('pqrstuv')

    answer = Day04.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(4, answer, 1)
  end

  def test_part_2
    answer = Day04.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(4, answer, 2)
  end
end
