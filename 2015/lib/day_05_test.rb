require 'minitest/autorun'

require_relative './day_05'
require_relative './helpers'

class Day5Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
      ugknbfddgicrmopn
      aaa
      jchzalrnumimnmhp
      haegwjzuvuyypxyu
      dvszwmarrgswjxmb
    INPUT

    @test_input = @test_input.strip

    @input = get_input(5)
  end

  def test_part_1_good
    refute Day05.good?('ab')
    refute Day05.good?('cd')
    refute Day05.good?('pq')
    refute Day05.good?('xy')
    assert Day05.good?('ugknbfddgicrmopn')
    refute Day05.good?('jchzalrnumimnmhp')
    refute Day05.good?('haegwjzuvuyypxyu')
    refute Day05.good?('dvszwmarrgswjxmb')
  end

  def test_part_1
    assert_equal 2, Day05.part_1(@test_input)

    answer = Day05.part_1(@input)
    puts "Part 1: #{answer}"

    submit_answer(5, answer, 1)
  end

  def test_part_2_good
    assert Day05.good?('qjhvhtzxzqqjkmpb', 2)
    assert Day05.good?('xxyxx', 2)
    refute Day05.good?('uurcxstgmygtbstg', 2)
    refute Day05.good?('ieodomkazucvgmuy', 2)
  end

  def test_part_2
    @test_input_2 = <<~TEST_INPUT
      qjhvhtzxzqqjkmpb
      xxyxx
      uurcxstgmygtbstg
      ieodomkazucvgmuy
    TEST_INPUT
    @test_input_2 = @test_input_2.strip

    assert_equal 2, Day05.part_2(@test_input_2)

    answer = Day05.part_2(@input)
    puts "Part 2: #{answer}"

    submit_answer(5, answer, 2)
  end
end
