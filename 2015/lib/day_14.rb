require 'ostruct'

class Day14
  def self.parse(input)
    input.lines.map do |line|
      name = line.split(' ').first
      speed, go, rest = line.scan(/\d+/).to_a
      {
        name: name,
        distance: 0,
        points: 0,
        stats: OpenStruct.new(speed: speed.to_i, go: go.to_i, rest: rest.to_i)
      }
    end
  end

  def self.race(tracker, race_time)
    (1..race_time).each do |second|
      track(tracker, second)
    end
  end

  def self.track(tracker, second)
    tracker.each do |racer|
      stats = racer[:stats]
      racer[:distance] += stats.speed if fly?(second, stats.go, stats.rest) 
    end
    best_distance = tracker.max_by { |racer| racer[:distance] }[:distance]
    tracker.each do |racer|
      racer[:points] += 1 if racer[:distance] == best_distance
    end
  end

  def self.fly?(second, go, rest)
    leg_sec = second % (go + rest)
    leg_sec.positive? && leg_sec <= go
  end

  def self.part_1(input, race_time = 2503)
    tracker = parse(input)
    race(tracker, race_time)
    tracker.max_by { |v| v[:distance] }[:distance]
  end

  def self.part_2(input, race_time = 2503)
    tracker = parse(input)
    race(tracker, race_time)
    tracker.max_by { |v| v[:points] }[:points]
  end
end
