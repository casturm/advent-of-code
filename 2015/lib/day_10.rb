require 'stringio'

class Day10
  def self.iterate(input, iterations)
    input.strip!
    iterations.times do
      input = input.gsub(/(.)\1*/) { |match| "#{match.length}#{match[0]}" }
    end
    input
  end

  def self.part_1(input, iterations)
    iterate(input, iterations).size
  end
end
