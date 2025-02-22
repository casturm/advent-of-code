require 'minitest/autorun'

require_relative './day_16'
require_relative './helpers'

class Day16Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @sample = {
      children: 3,
      cats: 7,
      samoyeds: 2,
      pomeranians: 3,
      akitas: 0,
      vizslas: 0,
      goldfish: 5,
      trees: 3,
      cars: 2,
      perfumes: 1
    }

    @input = get_input(16)
  end

  def test_part_1
    assert_equal '40', Day16.solve(@input, @sample)

    answer = Day16.solve(@input, @sample)
    puts "Part 1: #{answer}"

    submit_answer(16, answer, 1)
  end

  def test_part_2
    answer = Day16.solve(@input, @sample, part_1: false)
    puts "Part 2: #{answer}"

    submit_answer(16, answer, 2)
  end
end
