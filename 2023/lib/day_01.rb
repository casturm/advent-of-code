class Day01
  def self.integer_from(digit)
    case digit
    when 'one'
      '1'
    when 'two'
      '2'
    when 'three'
      '3'
    when 'four'
      '4'
    when 'five'
      '5'
    when 'six'
      '6'
    when 'seven'
      '7'
    when 'eight'
      '8'
    when 'nine'
      '9'
    else
      digit
    end
  end

  def self.part_1_value_of(line)
    nums = line.scan(/\d/)
    "#{nums.first}#{nums.last}".to_i
  end

  def self.part_1(input)
    lines = input.lines
    lines.sum { |line| part_1_value_of(line) }
  end

  def self.part_2_value_of(line)
    regex = /\d|one|two|three|four|five|six|seven|eight|nine/
    first_d = line.scan(regex).first
    r_idx = line.rindex(regex)
    last_d = line[r_idx..].scan(regex).first
    "#{integer_from(first_d)}#{integer_from(last_d)}".to_i
    # puts "#{line} #{first_d} #{r_idx} #{last_d} = #{i}"
  end

  def self.part_2(input)
    lines = input.lines
    lines.sum { |line| part_2_value_of(line) }
  end
end
