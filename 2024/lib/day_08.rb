require_relative './helpers'

class Day08
  def self.off_map?(loc, cols, rows)
    loc[0].negative? ||
      loc[1].negative? ||
      loc[0] >= rows ||
      loc[1] >= cols - 1
  end

  def self.antinode(a, b, cols, rows, part_2 = false)
    locs = []
    a = a.dup
    b = b.dup
    dx = a[0] - b[0]
    dy = a[1] - b[1]
    locs << [a[0] + dx, a[1] + dy]

    return locs unless part_2

    locs << a.dup
    until off_map?(a, cols, rows)
      a[0] += dx
      a[1] += dy
      locs << a.dup
    end

    locs
  end

  def self.parse(input)
    lines = input.lines
    cols = lines.first.index("\n") + 1
    antennae = {}
    input.scan(/([a-zA-Z0-9])/) do
      match = Regexp.last_match
      antennae[match[0]] = antennae[match[0]] || []
      antennae[match[0]].push [match.begin(0) / cols, match.begin(0) % cols]
    end
    [antennae, cols, lines.count]
  end

  def self.part_1(input)
    antennae, cols, rows = parse(input)
    n = []
    antennae.each_value do |locations|
      locations.combination(2) do |a, b|
        n += antinode(a, b, cols, rows)
        n += antinode(b, a, cols, rows)
      end
    end
    n.reject { |a| off_map?(a, cols, rows) }.uniq.count
  end

  def self.part_2(input)
    antennae, cols, rows = parse(input)
    n = []
    antennae.each_value do |locations|
      locations.combination(2) do |a, b|
        n += antinode(a, b, cols, rows, true)
        n += antinode(b, a, cols, rows, true)
      end
    end
    n.reject { |a| off_map?(a, cols, rows) }.uniq.count
  end
end
