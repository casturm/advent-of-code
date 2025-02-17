class Day11
  def self.part_1(input)
    new_password = input
    loop do
      new_password = find_next_password(new_password)
      # puts new_password
      break if valid?(new_password)
    end
    new_password
  end

  def self.find_next_password(input)
    (input.size - 1).downto(0).each do |i|
      if input[i] == 'z'
        input[i] = 'a'
      else
        input[i] = input[i].succ
        break
      end
    end
    input
  end

  def self.valid?(input)
    only_allowed_letters?(input) &&
      incrementing_sequence?(input) &&
      non_overlapping_pairs?(input)
  end

  def self.only_allowed_letters?(input)
    !input.match?(/[iol]/)
  end

  def self.non_overlapping_pairs?(input)
    input.scan(/((.)\2)/).map(&:first).uniq.size > 1
  end

  def self.incrementing_sequence?(input)
    input.chars.each_cons(3).any? do |slice|
      slice.each_cons(2).all? { |a, b| a.succ == b }
    end
  end
end
