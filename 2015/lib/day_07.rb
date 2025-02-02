class Day07
  def self.construct(circuit, signals)
    if !circuit.is_a?(Array)
      if circuit.is_a?(Numeric)
        circuit
      elsif circuit.match(/\d+/)
        circuit.to_i
      elsif !signals[circuit].is_a?(Array) && signals[circuit].is_a?(Numeric)
        signals[circuit]
      else
        signals[circuit] = construct(signals[circuit], signals)
        signals[circuit]
      end
    elsif circuit.size == 3
      left, gate, right = circuit
      case gate
      when 'AND'
        construct(left, signals) & construct(right, signals)
      when 'OR'
        construct(left, signals) | construct(right, signals)
      when 'LSHIFT'
        construct(left, signals) << construct(right, signals)
      when 'RSHIFT'
        construct(left, signals) >> construct(right, signals)
      end
    elsif circuit.size == 2
      construct(~construct(circuit.last, signals), signals)
    else
      construct(circuit.first, signals)
    end
  end

  def self.part_1(input, wire)
    signals = {}
    input.lines.each do |circuit|
      operation, wire_name = circuit.chomp.split(' -> ')
      signals[wire_name] = operation.split(' ')
    end
    construct(signals[wire], signals)
  end

  def self.part_2(_input)
    0
  end
end
