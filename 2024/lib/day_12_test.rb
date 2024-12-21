require 'minitest/autorun'

require_relative './day_12'
require_relative './helpers'

class Day12Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      RRRRIICCFF
      RRRRIICCCF
      VVRRRCCFFF
      VVRCCCJFFF
      VVVVCJJCFE
      VVIVCCJJEE
      VVIIICJJEE
      MIIIIIJJEE
      MIIISIJEEE
      MMMISSJEEE
    INPUT

    @example_1 = <<~EXAMPLE
      AAAA
      BBCD
      BBCC
      EEEC
    EXAMPLE

    @example_2 = <<~INPUT
      OOOOO
      OXOXO
      OOOOO
      OXOXO
      OOOOO
    INPUT

    @example_3 = <<~INPUT
      EEEEE
      EXXXX
      EEEEE
      EXXXX
      EEEEE
    INPUT

    @example_4 = <<~INPUT
      AAAAAA
      AAABBA
      AAABBA
      ABBAAA
      ABBAAA
      AAAAAA
    INPUT

    @test_input = @test_input.strip
    @example_1 = @example_1.strip
    @example_2 = @example_2.strip
    @example_3 = @example_3.strip
    @example_4 = @example_4.strip

    @input = get_input(12)
  end

  def test_as_plot
    grid = Day12.parse("AA\nBB\n")
    # puts "#{grid}"
    # (0..(grid.rows - 1)).each do |i|
    #   (0..(grid.cols - 1)).each do |j|
    #     print "|#{Day12.as_plot(i, j, grid)}| "
    #   end
    #   puts
    # end

    assert_equal ['A', 0, [1, 9, 3, 7]], Day12.as_plot(0, 0, grid)
    assert_equal ['B', 3, [4, 12, 6, 10]], Day12.as_plot(1, 1, grid)
  end

  def test_part_1_example_1
    assert_equal 140, Day12.part_1(@example_1)
  end

  def test_part_1_example_2
    assert_equal 772, Day12.part_1(@example_2)
  end

  def test_part_1
    skip
    assert_equal 1930, Day12.part_1(@test_input)

    answer = Day12.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(12, answer, 1)
  end

  def test_part_2_example_1
    puts
    puts 'part 2 ex 1'
    puts "#{@example_1}"
    puts
    assert_equal 80, Day12.part_2(@example_1)
  end

  def test_part_2_example_2
    puts
    puts 'part 2 ex 2'
    puts "#{@example_2}"
    puts
    assert_equal 436, Day12.part_2(@example_2)
  end

  def test_part_2_example_3
    puts
    puts 'part 2 ex 3'
    puts "#{@example_3}"
    puts
    assert_equal 236, Day12.part_2(@example_3)
  end

  def test_part_2_example_4
    puts
    puts 'part 2 ex 4'
    puts "#{@example_4}"
    puts
    assert_equal 368, Day12.part_2(@example_4)
  end

  def test_part_2
    skip
    assert_equal 1206, Day12.part_2(@example_3)

    answer = Day12.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(12, answer, 2)
  end
end
