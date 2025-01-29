class Day05
  def self.good?(line, part = 1)
    line.chomp!
    case part
    when 1
      !line.match(/ab|cd|pq|xy/) &&
        line.scan(/a|e|i|o|u/).count >= 3 &&
        line.match(/([a-zA-Z])\1/)
    when 2
      line.match(/([a-zA-Z]{2}).*\1/) && line.match(/([a-zA-Z]).\1/)
    end
  end

  def self.part_1(input)
    input.lines.map.select { |line| good?(line) }.count
  end

  def self.part_2(input)
    input.lines.select { |line| good?(line, 2) }.count
  end
end
