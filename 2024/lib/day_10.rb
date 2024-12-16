class Day10
  def self.parse(input)
    input.lines.map { |line| line.chomp.chars.map(&:to_i) }
  end

  def self.trailheads(locations)
    heads = []
    for i in 0..(locations.length - 1)
      for j in 0..(locations[i].length - 1)
        heads << [i, j] if locations[i][j] == 0
      end
    end
    heads
  end

  def self.walk_trail(locations, trails, head, tn)
    rows = locations.length
    cols = locations.first.length
    possible_moves = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    trail = trails[head][tn]
    trail.length
    possible_moves.each do |d|
      loc = trail.last
      curr_t = locations[loc[0]][loc[1]]
      next_loc = [loc[0] + d[0], loc[1] + d[1]]
      if next_loc[0] >= 0 && next_loc[1] >= 0 && next_loc[0] < rows && next_loc[1] < cols
        next_t = locations.at(next_loc[0])&.at(next_loc[1])
      end
      next if next_t.nil? || next_t - curr_t != 1

      trails[head] << trail.dup if trails[head].at(tn).nil?

      trails[head][tn] = trail.dup << next_loc
      walk_trail(locations, trails, head, tn)
      tn = trails[head].length + 1
    end

    trails
  end

  def self.to_topo(t, locations)
    t.map { |loc| locations[loc[0]][loc[1]] }
  end

  def self.score(locations, trails, part_2 = false)
    scores = {}
    trails.each do |head, trails_from|
      scores[head] = 0
      summits = []
      trails_from.each do |t|
        summit = [t.last[0], t.last[1]]
        if (part_2 || !summits.include?(summit)) && locations[summit[0]][summit[1]] == 9
          scores[head] += 1
          summits << summit
        end
      end
    end
    scores
  end

  def self.part_1(input)
    locations = parse(input)
    heads = trailheads(locations)
    trails = heads.map { |h| [h, [[h]]] }.to_h

    heads.each do |head|
      walk_trail(locations, trails, head, 0)
    end

    scores = score(locations, trails)
    scores.values.sum
  end

  def self.part_2(input)
    locations = parse(input)
    heads = trailheads(locations)
    trails = heads.map { |h| [h, [[h]]] }.to_h

    heads.each do |head|
      walk_trail(locations, trails, head, 0)
    end

    scores = score(locations, trails, true)
    scores.values.sum
  end
end
