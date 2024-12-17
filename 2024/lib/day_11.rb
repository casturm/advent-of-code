require 'ostruct'

class Day11
  def self.blink(input, n)
    stones = Hash.new(0)

    input.split.each do |num|
      stones[num.to_i] += 1
    end

    n.times do |_i|
      new_stones = Hash.new(0)
      stones.each do |stone, count|
        if stone == 0
          new_stones[1] += count
        elsif stone.to_s.length.even?
          str = stone.to_s
          left = str[0..((str.length / 2) - 1)]
          right = str[(str.length / 2)..]
          new_stones[left.to_i] += count
          new_stones[right.to_i] += count
        else
          new_stones[stone * 2024] += count
        end
      end
      stones = new_stones
    end
    stones
  end

  def self.part_1(input)
    stones = blink(input, 25)
    stones.values.sum
  end

  def self.part_2(input)
    stones = blink(input, 75)
    stones.values.sum
  end
end
