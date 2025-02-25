require 'minitest/autorun'

require_relative './day_19'
require_relative './helpers'

class Day19Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      H => HO
      H => OH
      O => HH

      HOH
    INPUT

    @test_input = @test_input.strip

    @input = get_input(19)
  end

  def test_part_1
    assert_equal 4, Day19.part_1(@test_input).size
    expected_created = %w[HOOH HOHO OHOH HHHH]
    assert_equal expected_created, Day19.part_1(@test_input)

    molecule, replacements = 'HOHOHO', [%w[H HO], %w[H OH], %w[O HH]]
    assert_equal 7, Day19.run_replacements(molecule, replacements).size
    expected_created = %w[HOOHOHO HOHOOHO HOHOHOO OHOHOHO HHHHOHO HOHHHHO HOHOHHH]
    assert_equal expected_created, Day19.run_replacements(molecule, replacements)
    answer = Day19.part_1(@input).size
    puts "Part 1: #{answer}"

    submit_answer(19, answer, 1)
  end

  def test_part_2
    @test_input = <<~INPUT
      e => H
      e => O
      H => HO
      H => OH
      O => HH

      HOH
    INPUT
    @test_input = @test_input.strip

    assert_equal 3, Day19.part_2(@test_input)

    @test_input = <<~INPUT
      e => H
      e => O
      H => HO
      H => OH
      O => HH

      HOHOHO
    INPUT
    @test_input = @test_input.strip

    assert_equal 6, Day19.part_2(@test_input)

    answer = Day19.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(19, answer, 2)
  end
end
