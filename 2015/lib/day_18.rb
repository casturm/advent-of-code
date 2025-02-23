class Day18
  def self.solve(input, part = 1, steps = 100)
    grid, corners = parse(input, part)
    steps.times { grid = animate(grid, corners) }
    count_on(grid)
  end

  def self.count_on(grid)
    grid.sum { |row| row.count('#') }
  end

  def self.animate(grid, corners)
    grid.map.with_index do |row, r|
      row.map.with_index { |_, c| update(r, c, grid, corners) }
    end
  end

  def self.on_neighbors(row, col, grid)
    (-1..1).sum do |dr|
      (-1..1).count do |dc|
        next if dr.zero? && dc.zero?

        r, c = row + dr, col + dc
        r.between?(0, grid.size - 1) && c.between?(0, grid.first.size - 1) && grid[r][c] == '#'
      end
    end
  end

  def self.corners(grid)
    dim = grid.size - 1
    [[0, 0], [0, dim], [dim, 0], [dim, dim]]
  end

  def self.corner?(row, col, corners)
    corners.include?([row, col])
  end

  def self.update(row, col, grid, corners)
    # puts "#{row} #{col} #{corner?(row, col, corners)}"
    return '#' if corner?(row, col, corners)

    neighbors = on_neighbors(row, col, grid)
    grid[row][col] == '#' ? neighbors.between?(2, 3) ? '#' : '.' : neighbors == 3 ? '#' : '.'
  end

  def self.parse(input, part)
    grid = input.lines.map(&:strip).map(&:chars)
    corners = part == 1 ? [] : corners(grid)
    corners.each { |row, col| grid[row][col] = '#' }
    [grid, corners]
  end
end
