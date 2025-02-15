require 'ostruct'

class Day08
  def self.part_1(input)
    counts = counts(input)
    counts.map(&:code_chars).sum - counts.map(&:mem_chars).sum
  end

  def self.counts(input)
    input.strip!
    string_literals = input.lines
    string_literals.map do |literal|
      literal.strip!
      OpenStruct.new(code_chars: literal.size,
                     enc_chars: literal.inspect.size,
                     mem_chars: literal.undump.size)
    end
  end

  def self.part_2(input)
    counts = counts(input)
    counts.map(&:enc_chars).sum - counts.map(&:code_chars).sum
  end
end
