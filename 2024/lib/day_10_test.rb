require 'minitest/autorun'

require_relative './day_10'
require_relative './helpers'

class Day10Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      89010123
      78121874
      87430965
      96549874
      45678903
      32019012
      01329801
      10456732
    INPUT

    @test_input = @test_input.strip

    @input = get_input(10)
  end

  def test_parse
    assert_equal [[1, 0], [1, 1]], Day10.parse("10\n11")
  end

  def test_trailheads
    assert_equal [[0, 1]], Day10.trailheads(Day10.parse("10\n11"))
    assert_equal [[0, 2], [0, 4]], Day10.trailheads(Day10.parse("89010123\n78121874"))
  end

  def show_trail(locations, trail)
    puts "show: #{trail}"
    rows = locations.length - 1
    cols = locations.first.length - 1
    for row in (0..rows)
      for col in (0..cols)
        if trail.include?([row, col])
          step = trail.index([row, col])
          print(step)
        else
          print('.')
        end
      end
      print("\n")
    end
  end

  def test_walk_trail
    input = <<~INPUT
      0123
      ...4
      ...5
      9876
    INPUT
    locations = Day10.parse(input)
    head = [0, 0]
    trails = { head => [[head]] }

    # puts "#{input}"
    Day10.walk_trail(locations, trails, head, 0)
    # puts "#{trails}"
    # trails[head].each { |trail| show_trail(locations, trail) }
    assert_equal({ head => [[[0, 0], [0, 1], [0, 2], [0, 3], [1, 3], [2, 3], [3, 3], [3, 2], [3, 1], [3, 0]]] }, trails)
  end

  def test_score
    input = <<~INPUT
      0123
      1234
      8765
      9876
    INPUT
    locations = Day10.parse(input)
    head = [0, 0]
    trails = { head => [[head]] }

    Day10.walk_trail(locations, trails, head, 0)
    scores = Day10.score(locations, trails)
    assert_equal({ head => 1 }, scores)
    scores = Day10.score(locations, trails, true)
    assert_equal({ head => 16 }, scores)
  end

  def test_part_1
    assert_equal 36, Day10.part_1(@test_input)

    answer = Day10.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(10, answer, 1)
  end

  def test_part_2
    assert_equal 81, Day10.part_2(@test_input)

    answer = Day10.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(10, answer, 2)
  end
end
