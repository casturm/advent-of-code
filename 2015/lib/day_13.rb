require 'ostruct'
require 'set'

class Day13
  def self.part_1(input)
    guests, happiness_map = parse(input)
    find_max(guests, happiness_map)
  end

  def self.find_max(guests, happiness_map)
    (0...guests.size).to_a.permutation.map do |a|
      (0...guests.size).sum do |i|
        p1 = guests[a[i - 1]]
        p2 = guests[a[i]]
        happiness_map[[p1, p2]] + happiness_map[[p2, p1]]
      end
    end.max
  end

  def self.parse(input)
    guests = Set.new
    map = input.lines.map do |line|
      match = line.match(/(?<guest>\w+) would (?<op>\w+) (?<units>\d+) happiness units by sitting next to (?<neighbor>\w+)/)
      guests << match[:guest]
      [[match[:guest], match[:neighbor]], match[:units].to_i * (match[:op] == 'gain' ? 1 : -1)]
    end
    [guests.to_a, map.to_h]
  end

  def self.part_2(input)
    guests, happiness_map = parse(input)
    guests.each do |guest|
      happiness_map[[guest, 'me']] = 0
      happiness_map[['me', guest]] = 0
    end
    guests << ('me')
    find_max(guests, happiness_map)
  end
end
