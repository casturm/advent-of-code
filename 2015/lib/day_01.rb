class Day01
  def self.part_1(input)
    input.count('(') - input.count(')')
  end

  def self.part_2(input)
    floor = 0
    input.chars.each_with_index do |direction, i|
      floor += (direction == '(' ? 1 : -1)
      return i + 1 if floor == -1
    end
  end
end
