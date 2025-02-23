require 'minitest/autorun'

require_relative './day_18'
require_relative './helpers'

class Day18Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      .#.#.#
      ...##.
      #....#
      ..#...
      #.#..#
      ####..
    INPUT

    @test_input = @test_input.strip

    @input = get_input(18)
  end

  def test_part_1
    grid, corners = Day18.parse(@test_input, 1)
    assert_equal '#', grid[0][1]
    assert_equal '.', grid[1][2]
    assert_equal 1, Day18.on_neighbors(0, 0, grid)
    assert_equal 0, Day18.on_neighbors(0, 1, grid)
    assert_equal 3, Day18.on_neighbors(1, 2, grid)
    assert_equal 4, Day18.on_neighbors(1, 4, grid)
    assert_equal '.', Day18.update(0, 0, grid, corners)
    assert_equal '#', Day18.update(1, 2, grid, corners)
    next_state = [
      ['.', '.', '#', '#', '.', '.'],
      ['.', '.', '#', '#', '.', '#'],
      ['.', '.', '.', '#', '#', '.'],
      ['.', '.', '.', '.', '.', '.'],
      ['#', '.', '.', '.', '.', '.'],
      ['#', '.', '#', '#', '.', '.']
    ]
    assert_equal next_state, Day18.animate(grid, corners)
    assert_equal 4, Day18.solve(@test_input, 1, 4)

    answer = Day18.solve(@input)
    puts "Part 1: #{answer}"

    submit_answer(18, answer, 1)
  end

  def test_part_2
    initial_state = [
      ['#', '#', '.', '#', '.', '#'],
      ['.', '.', '.', '#', '#', '.'],
      ['#', '.', '.', '.', '.', '#'],
      ['.', '.', '#', '.', '.', '.'],
      ['#', '.', '#', '.', '.', '#'],
      ['#', '#', '#', '#', '.', '#']
    ]

    next_state = [
      ['#', '.', '#', '#', '.', '#'],
      ['#', '#', '#', '#', '.', '#'],
      ['.', '.', '.', '#', '#', '.'],
      ['.', '.', '.', '.', '.', '.'],
      ['#', '.', '.', '.', '#', '.'],
      ['#', '.', '#', '#', '#', '#']
    ]

    grid, corners = Day18.parse(@test_input, 2)
    assert_equal([[0, 0], [0, 5], [5, 0], [5, 5]], corners)
    assert_equal initial_state, grid
    assert_equal next_state, Day18.animate(grid, corners)
    assert_equal 17, Day18.solve(@test_input, 2, 5)

    answer = Day18.solve(@input, 2)
    puts "Part 2: #{answer}"

    submit_answer(18, answer, 2)
  end
end
