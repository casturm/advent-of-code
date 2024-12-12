require_relative './helpers'

class Day08
  def self.off_map?(pos, rowlen, cols)
    pos[0].negative? ||
      pos[1].negative? ||
      pos[0] >= cols ||
      pos[1] >= rowlen - 1
  end

  def self.antinode(a, b, rowlen, cols, part_2 = false)
    locs = []
    a = a.dup
    b = b.dup
    dx = a[0] - b[0]
    dy = a[1] - b[1]
    locs << [a[0] + dx, a[1] + dy]

    return locs unless part_2

    locs << a.dup
    until off_map?(a, rowlen, cols)
      a[0] += dx
      a[1] += dy
      locs << a.dup
    end

    locs
  end

  def self.parse(input)
    lines = input.lines
    rowlen = lines.first.index("\n") + 1
    antennae = {}
    input.scan(/([a-zA-Z0-9])/) do
      match = Regexp.last_match
      antennae[match[0]] = antennae[match[0]] || []
      antennae[match[0]].push [match.begin(0) / rowlen, match.begin(0) % rowlen]
    end
    [antennae, rowlen, lines.count]
  end

  def self.part_1(input)
    antennae, rowlen, colnum = parse(input)
    n = []
    antennae.each_value do |locations|
      locations.combination(2) do |a, b|
        n += antinode(a, b, rowlen, colnum)
        n += antinode(b, a, rowlen, colnum)
      end
    end
    n.reject { |a| off_map?(a, rowlen, colnum) }.uniq.count
  end

  def self.part_2(input)
    antennae, rowlen, colnum = parse(input)
    n = []
    antennae.each_value do |locations|
      locations.combination(2) do |a, b|
        n += antinode(a, b, rowlen, colnum, true)
        n += antinode(b, a, rowlen, colnum, true)
      end
    end
    n.reject { |a| off_map?(a, rowlen, colnum) }.uniq.count
  end
end
