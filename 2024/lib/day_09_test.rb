require 'minitest/autorun'

require_relative './day_09'
require_relative './helpers'

class Day9Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      2333133121414131402
    INPUT

    @test_input = @test_input.strip

    @input = get_input(9)
  end

  def as_str(disk)
    disk.map { |mem| mem.id == -1 ? '.' * mem.size : mem.id.to_s * mem.size }.join
  end

  def test_parse
    assert_equal '00...111...2...333.44.5555.6666.777.888899',
                 as_str(Day09.parse(@test_input))
  end

  def test_part_1
    assert_equal 1928, Day09.part_1(@test_input)

    answer = Day09.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(9, answer, 1)
  end

  def test_part_2
    assert_equal 2858, Day09.part_2(@test_input)

    answer = Day09.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(9, answer, 2)
  end
end
