class Day03
  def self.part_1(input)
    houses = Hash.new(0)
    x = 0
    y = 0
    houses[[x, y]] += 1
    input.chars.each do |direction|
      case direction
      when '>'
        x += 1
      when '<'
        x -= 1
      when '^'
        y += 1
      else
        y -= 1
      end
      houses[[x, y]] += 1
    end
    houses.keys.size
  end

  def self.part_2(input)
    houses = Hash.new(0)
    l = [[0, 0], [0, 0]]
    t = 0
    houses[l[t].join(',')] += 1
    input.chars.each do |direction|
      t = (t + 1) % 2
      case direction
      when '>'
        l[t][0] += 1
      when '<'
        l[t][0] -= 1
      when '^'
        l[t][1] += 1
      else
        l[t][1] -= 1
      end
      houses[l[t].join(',')] += 1
    end
    houses.keys.size
  end
end
