class Day07
  def self.part_1(input, wire)
    instructions = parse(input)
    solve(instructions, wire)
  end

  def self.parse(input)
    instructions = {}

    input.lines.each do |circuit|
      operation, wire_name = circuit.chomp.split(' -> ')
      instructions[wire_name] = operation.split(' ')
    end

    instructions
  end

  def self.solve(instructions, wire, signals = {})
    until signals.key?(wire)
      instructions.each do |wire_name, operation|
        next if signals.key?(wire_name) # Skip resolved signals

        if operation.size == 1 # Direct assignment
          value = resolve_value(operation.first, signals)
          signals[wire_name] = value unless value.nil?

        elsif operation.size == 2 && operation.first == 'NOT' # NOT operation
          value = resolve_value(operation.last, signals)
          signals[wire_name] = (~value & 0xFFFF) unless value.nil?

        elsif operation.size == 3 # Binary operations
          left, gate, right = operation
          left_val = resolve_value(left, signals)
          right_val = resolve_value(right, signals)

          if !left_val.nil? && !right_val.nil?
            signals[wire_name] = case gate
                                 when 'AND' then left_val & right_val
                                 when 'OR' then left_val | right_val
                                 when 'LSHIFT' then (left_val << right_val) & 0xFFFF
                                 when 'RSHIFT' then left_val >> right_val
                                 end
          end
        end
      end
    end

    signals[wire]
  end

  def self.resolve_value(value, signals)
    return value.to_i if value.match(/^\d+$/)
    return signals[value] if signals.key?(value)

    nil
  end

  def self.part_2(input, wire)
    instructions = parse(input)
    solve(instructions, wire, 'b' => 956)
  end
end
