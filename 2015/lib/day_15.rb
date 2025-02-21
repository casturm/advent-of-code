class Day15
  def self.part_1(input)
    ingredients = parse(input)
    max = 0
    distribute(100, ingredients.size) do |distribution|
      amount = calculate(ingredients, distribution)
      max = amount if amount > max
    end
    max
  end

  def self.parse(input)
    input.lines.map do |line|
      match = line.match(/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/)
      {
        name: match[1],
        qualities: {
          capacity: match[2].to_i,
          durability: match[3].to_i,
          flavor: match[4].to_i,
          texture: match[5].to_i,
          calories: match[6].to_i
        }
      }
    end
  end

  def self.sum(dist, ingredients, quality)
    total = dist.map.with_index { |d, i| d * ingredients[i][:qualities][quality] }.sum
    total.positive? ? total : 0
  end

  def self.calculate(ingredients, dist)
    # p "#{sum(dist, ingredients, :capacity)}
    #   #{sum(dist, ingredients, :durability)}
    #   #{sum(dist, ingredients, :flavor)}
    #   #{sum(dist, ingredients, :texture)}"

    sum(dist, ingredients, :capacity) *
      sum(dist, ingredients, :durability) *
      sum(dist, ingredients, :flavor) *
      sum(dist, ingredients, :texture)
  end

  def self.distribute(total, ingredients, current_distribution = [], &block)
    if ingredients == 1
      # Only one ingredient left, so it must take the remaining amount
      yield current_distribution + [total]
    else
      (0..total).each do |i|
        distribute(total - i, ingredients - 1, current_distribution + [i], &block)
      end
    end
  end

  def self.part_2(input)
    ingredients = parse(input)
    max = 0
    distribute(100, ingredients.size) do |distribution|
      amount = calculate(ingredients, distribution)
      max = amount if amount > max && sum(distribution, ingredients, :calories) == 500
    end
    max
  end
end
