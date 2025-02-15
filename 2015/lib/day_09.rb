require 'set'

class Day09
  def self.part_1(input)
    routes(input).min
  end

  def self.routes(input)
    map = {}
    locations = Set.new

    input.lines.map do |line|
      from, to, distance = line.match(/(\w+) to (\w+) = (\d+)/).captures
      locations.add(from)
      locations.add(to)
      map["#{from} to #{to}"] = distance.to_i
      map["#{to} to #{from}"] = distance.to_i
    end

    routes = locations.to_a.permutation.map do |route|
      total_distance = (1...route.size).sum { |i| map["#{route[i - 1]} to #{route[i]}"] }
      [route, total_distance]
    end

    routes.map(&:last)
  end

  def self.part_2(input)
  routes(input).max
  end
end
