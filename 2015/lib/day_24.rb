class Day24
  def self.part_1(input)
    packages = input.lines.map(&:strip).map(&:to_i)
    # puts "#{packages.sum} #{packages.sum / 3}"
    w = packages.sum / 3
    min = [packages.size, 9999]
    packages.permutation(packages.size).each do |perm|
      groups = [[], [], []]
      g = 0
      until perm.empty?
        p = perm.pop
        g += 1 if groups[g].sum >= w
        break if g.positive? && groups[g - 1].sum != w

        groups[g] << p
      end
      if groups.map(&:sum).all?(w)
        min = [min, [groups.first.size, groups.first.reduce(&:*)]].min
      end
    end
    min.last
  end

  def self.part_2(_input)
    0
  end
end
