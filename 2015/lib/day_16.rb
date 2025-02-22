class Day16
  def self.solve(input, sample, part_1: true)
    answers = []
    input.lines.each do |line|
      num = line.match(/^Sue (\d+):/)
      deets = line[num.end(0)..].scan(/(\w+): (\d+)/).map do |match|
        [match[0].to_sym, match[1].to_i]
      end.to_h

      matching = if part_1
        deets.select { |k, v| sample[k] == v }
      else
        deets.select do |k, v|
          case k
          when :cats
            v > sample[k]
          when :trees
            v > sample[k]
          when :pomeranians
            v < sample[k]
          when :goldfish
            v < sample[k]
          else
            sample[k] == v 
          end
        end
      end

      answers << [matching.size, num[1]] if matching.size.positive?
    end
    answers.min { |a1, a2| a2[0] <=> a1[0] }[1]
  end
end
