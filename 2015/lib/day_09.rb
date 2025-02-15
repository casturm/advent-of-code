require 'set'

class Day09
  def self.part_1(input)
    routes(input).min
  end

  def self.routes(input)
    distances = {}
    cities = Set.new

    input.lines.each do |line|
      parts = line.strip.split(' ')
      city1, city2, distance = parts[0], parts[2], parts[4].to_i

      distances[[city1, city2]] = distance
      distances[[city2, city1]] = distance
      cities << city1
      cities << city2
    end

    cities.to_a.permutation.map do |route|
      route.each_cons(2).sum { |a, b| distances[[a, b]] }
    end
  end

  def self.part_2(input)
    routes(input).max
  end
end
