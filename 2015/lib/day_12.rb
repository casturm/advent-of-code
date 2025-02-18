require 'json'

class Day12
  def self.sum_numbers(json)
    case json
    when Integer
      json
    when Array
      json.sum { |el| sum_numbers(el) }
    when Hash
      json.values.sum { |v| sum_numbers(v) }
    else
      0
    end
  end

  def self.sum_numbers_excluding_red(json)
    case json
    when Integer
      json
    when Array
      json.sum { |el| sum_numbers_excluding_red(el) }
    when Hash
      return 0 if json.values.include?('red')

      json.values.sum { |v| sum_numbers_excluding_red(v) }
    else
      0
    end
  end

  def self.part_1(input)
    sum_numbers(JSON.parse(input))
  end

  def self.part_2(input)
    sum_numbers_excluding_red(JSON.parse(input))
  end
end
