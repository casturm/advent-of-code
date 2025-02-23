require 'set'

class Day17
  def self.solve(input, total = 150)
    containers = input.lines.map { |line| line.strip.to_i }
    combos = 0
    min = []
    (0...containers.size).each do |n|
      containers.combination(n).each do |c|
        if c.sum == total
          combos += 1
          min << n if min.last.nil? || min.last == n
        end
      end
    end
    [combos, min.size]
  end
end
