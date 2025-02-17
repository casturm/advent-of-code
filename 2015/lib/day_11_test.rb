require 'minitest/autorun'

require_relative './day_11'
require_relative './helpers'

class Day11Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(11)
  end

  def test_part_1
    input = 'hijklmmn'
    refute Day11.only_allowed_letters?(input)
    assert Day11.incrementing_sequence?(input)
    refute Day11.non_overlapping_pairs?(input)
    refute Day11.valid?(input)

    assert_equal 'xy', Day11.find_next_password('xx')
    assert_equal 'xz', Day11.find_next_password('xy')
    assert_equal 'ya', Day11.find_next_password('xz')

    assert Day11.only_allowed_letters?('abcdffaa')
    assert Day11.incrementing_sequence?('abcdffaa')
    assert Day11.non_overlapping_pairs?('abcdffaa')
    assert Day11.valid?('abcdffaa')

    assert_equal 'abcdffaa', Day11.part_1('abcdefgh')
    assert_equal 'ghjaabcc', Day11.part_1('ghijklmn')

    answer = Day11.part_1(@input.strip)
    puts "Part 1: #{answer}"

    submit_answer(11, answer, 1)
  end

  def test_part_2
    answer = Day11.part_1(Day11.part_1('hepxcrrq'))
    puts "Part 2: #{answer}"

    submit_answer(11, answer, 2)
  end
end
