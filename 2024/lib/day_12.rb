class Day12
  Grid = Struct.new(:input, :rows, :cols)

  def self.parse(input)
    input = input.lines.map(&:strip)
    rows = input.length
    cols = input.first.length
    Grid.new(input, rows, cols)
  end

  def self.neighbors(i, j, grid)
    [
      as_plot(i + 1, j, grid),
      as_plot(i - 1, j, grid),
      as_plot(i, j + 1, grid),
      as_plot(i, j - 1, grid)
    ]
  end

  def self.as_plot(i, j, grid)
    rows = grid.rows
    cols = grid.cols
    return if i.negative? || i >= rows || j.negative? || j >= cols

    n = (i * cols) + j + 1
    e = ((rows + 1) * cols) + ((j + 1) * rows) + i + 1
    s = ((i + 1) * cols) + j + 1
    w = ((rows + 1) * cols) + (j * rows) + i + 1

    sides = [n, e, s, w]
    plot = (cols * i) + j
    type = grid.input[i][j]
    [type, plot, sides]
  end

  def self.walk_region(i, j, grid, type, area, visited)
    neighbors(i, j, grid).each do |neighbor|
      next if neighbor.nil? || neighbor[0] != type || visited.include?(neighbor[1])

      visited << neighbor[1]
      area[0] << neighbor[1]
      area[1] += neighbor[2]
      walk_region(neighbor[1] / grid.rows, neighbor[1] % grid.cols, grid, type, area, visited)
    end
  end

  def self.walk(grid)
    areas = []
    rows = grid.rows
    cols = grid.cols
    visited = []
    (0..(rows - 1)).each do |i|
      (0..(cols - 1)).each do |j|
        type, plot, sides = as_plot(i, j, grid)

        next if visited.include?(plot)

        area = [[plot], sides]
        areas += [[type, area]]
        visited << plot
        walk_region(i, j, grid, type, area, visited)
      end
    end
    areas
  end

  def self.calculate_cost(areas)
    costs = Hash.new(0)
    areas.each do |type, area|
      num_a = area[0].length
      num_p = area[1].tally.select { |_p, n| n == 1 }
      # puts "cost: #{type}: #{num_a} * #{num_p.length} = #{num_a * num_p.length}"
      costs[[type, area[0]]] = num_a * num_p.length
    end

    costs.values.sum
  end

  def self.part_1(input)
    # puts "#{input}"
    grid = parse(input)
    areas = walk(grid)
    calculate_cost(areas)
  end

  def self.calculate_cost_2(areas, grid)
    costs = Hash.new(0)
    areas.each do |type, area|
      num_a = area[0].length
      perimeter = area[1].tally.select { |_p, n| n == 1 }.map { |p| p[0] }
      n_s, e_w = perimeter.partition { |p| p > grid.rows * grid.cols }
      n_s.sort!
      e_w.sort!
      # puts "#{n_s} #{e_w}"
      sides = []
      [[n_s, grid.rows], [e_w, grid.cols]].each do |a, edge|
        sides << [a.shift]
        until a.empty?
          last_s = sides.last.last
          if last_s + 1 == a.first && last_s % edge != 0
            sides.last << a.first
          else
            sides << [a.first]
          end
          a.shift
          puts "#{sides}"
        end
      end
      num_s = sides.length
      puts "cost: #{type}: #{num_a} * #{num_s} = #{num_a * num_s}"
      costs[[type, area[0]]] = num_a * num_s
    end

    costs.values.sum
  end

  def self.part_2(input)
    grid = parse(input)
    areas = walk(grid)
    calculate_cost_2(areas, grid)
  end
end
