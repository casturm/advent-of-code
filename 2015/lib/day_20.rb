class Day20
  def self.part_1(input)
    input = input.strip.to_i
    max_house = input / 10
    houses = Array.new(max_house + 1, 0)

    (1..max_house).each do |elf|
      (elf..max_house).step(elf) do |house|
        houses[house] += elf * 10
      end
    end

    houses.find_index { |presents| presents >= input }
  end

  def self.part_1_divisors(input)
    input = input.strip.to_i
    house = 0
    presents = 0
    while presents < input
      house += 1
      presents = count(house)
    end
    house
  end

  def self.count(house)
    presents = 0
    sqrt = Math.sqrt(house).to_i
    (1..sqrt).each do |h|
      next unless (house % h).zero?

      presents += h * 10
      other = house / h
      presents += other * 10 unless other == h
    end
    presents
  end

  def self.part_2(input)
    input = input.strip.to_i
    max_house = input / 10
    houses = Array.new(max_house + 1, 0)

    (1..max_house).each do |elf|
      (elf..elf^2).step(elf) do |house|
        houses[house] += elf * 11
      end
    end

    houses.find_index { |presents| presents >= input }
  end
end
