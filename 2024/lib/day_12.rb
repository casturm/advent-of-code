class Day12
  def self.parse(input)
    input.split("\n").map { |line| line.chars }
  end

  def self.neighbors(i, j)
    [
      [i + 1, j],
      [i - 1, j],
      [i, j + 1],
      [i, j - 1]
    ]
  end

  def self.walk_region(input, i, j, visited, region = {})
    region[[i, j]] = true
    neighbors(i, j).each do |n_i, n_j|
      next if n_i.negative? ||
              n_i >= input.length ||
              n_j.negative? ||
              n_j >= input.first.length ||
              input[n_i][n_j] != input[i][j] ||
              !visited[[n_i, n_j]].nil?

      visited[[n_i, n_j]] = true
      walk_region(input, n_i, n_j, visited, region)
    end

    region
  end

  def self.walk(input)
    regions = []
    visited = {}
    input.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        next unless visited[[i, j]].nil?

        region = walk_region(input, i, j, visited)

        regions << region
      end
    end
    regions
  end

  def self.count_corners(region, loc)
    up = region[[loc[0] - 1, loc[1]]]
    down = region[[loc[0] + 1, loc[1]]]
    left = region[[loc[0], loc[1] - 1]]
    right = region[[loc[0], loc[1] + 1]]
    up_left = region[[loc[0] - 1, loc[1] - 1]]
    up_right = region[[loc[0] - 1, loc[1] + 1]]
    down_left = region[[loc[0] + 1, loc[1] - 1]]
    down_right = region[[loc[0] + 1, loc[1] + 1]]

    count = 0

    count += 1 if !up && !left
    count += 1 if !down && !left
    count += 1 if !up && !right
    count += 1 if !down && !right

    count += 1 if !up_left && up && left
    count += 1 if !up_right && up && right
    count += 1 if !down_left && down && left
    count += 1 if !down_right && down && right

    count
  end

  def self.calculate_cost(regions, _input)
    regions.map do |region|
      fences = region.map do |k, _v|
        [
          [k[0] + 1, k[1]],
          [k[0] - 1, k[1]],
          [k[0], k[1] + 1],
          [k[0], k[1] - 1]
        ].filter do |n|
          region[n].nil?
        end
      end.flatten(1)

      # puts "cost: #{region.keys.map { |i, j| input[i][j] }}"
      perimeter = fences.length
      area = region.keys.length
      # puts "cost: #{fences} #{fences.length} * #{region.keys.length} = #{perimeter * area}"

      reconstructed_fence = {}

      fences.each { |f| reconstructed_fence[f] = true }

      sides = 0
      region.each do |f, _|
        sides += count_corners(region, f)
      end

      [area * perimeter, area * sides]
    end
  end

  def self.part_1(input)
    input = parse(input)
    regions = walk(input)
    # puts "regions: #{regions.map { |r| r.keys.map { |i, j| input[i][j] } }}"
    calculate_cost(regions, input).map { |c| c[0] }.sum
  end

  def self.part_2(input)
    input = parse(input)
    regions = walk(input)
    calculate_cost(regions, input).map { |c| c[1] }.sum
  end
end
