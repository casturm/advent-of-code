require 'digest'

class Day04
  def self.part_1(input)
    input.chomp!
    seed = 1
    seed += 1 while Digest::MD5.hexdigest("#{input}#{seed}") [0..4] != '00000'
    seed
  end

  def self.part_2(input)
    input.chomp!
    seed = 1
    seed += 1 while Digest::MD5.hexdigest("#{input}#{seed}") [0..5] != '000000'
    seed
  end
end
