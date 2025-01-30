class Day06
  def self.parse(line)
    corners = line.scan(/(\d+)/).map { |i| i.first.to_i }
    command = line.split(' ')[1]
    [command.match(/on|off/) ? command : 'toggle', corners]
  end

  def self.part_1(input)
    grid = Array.new(1000) { Array.new(1000, false) }
    input.lines.each do |line|
      command, corners = parse(line)
      corners[0].upto(corners[2]).each do |x|
        corners[1].upto(corners[3]).each do |y|
          grid[x][y] = case command
                       when 'on'
                         true
                       when 'off'
                         false
                       else
                         !grid[x][y]
                       end
        end
      end
    end
    grid.sum { |r| r.count(true) }
  end

  def self.part_2(input)
    grid = Array.new(1000) { Array.new(1000, 0) }
    input.lines.each do |line|
      command, corners = parse(line)
      corners[0].upto(corners[2]).each do |x|
        corners[1].upto(corners[3]).each do |y|
          grid[x][y] += case command
                        when 'on'
                          1
                        when 'off'
                          grid[x][y].zero? ? 0 : -1
                        else
                          2
                        end
        end
      end
    end
    grid.sum(&:sum)
  end
end
