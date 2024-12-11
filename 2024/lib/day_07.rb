class Day07
  def self.evaluate(operand_a, operation, operand_b)
    if operation == '+'
      operand_a + operand_b
    elsif operation == '*'
      operand_a * operand_b
    else
      (operand_a.to_s + operand_b.to_s).to_i
    end
  rescue StandardError => e
    puts "#{e} #{operand_a} #{operation} #{operand_b}"
    raise
  end

  def self.parse(line)
    parts = line.split(': ')
    [parts.first.to_i, parts.last.split(' ').map(&:to_i)]
  end

  def self.gen_equations(operators, n, equation = [])
    return [equation] if equation.length == n

    equations = []
    operators.each do |op|
      equations += gen_equations(operators, n, equation.dup << op)
    end
    equations
  end

  def self.calculate(numbers, equation)
    postfix = [numbers.shift]
    postfix.push(numbers.shift, equation.shift) while !numbers.empty? && !equation.empty?

    begin
      calculator = []
      until postfix.empty?
        token = postfix.shift
        if token.is_a?(Numeric)
          calculator.push token
        else
          calculator.push evaluate(calculator.shift, token, calculator.shift)
        end
      end
      calculator.pop
    rescue StandardError => e
      puts "#{e} #{postfix} #{calculator} #{token}"
      raise
    end
  end

  def self.part_1(input)
    input.lines.sum do |line|
      answer, numbers = parse(line)

      equations = gen_equations(['+', '*'], numbers.length - 1)
      result = 0
      (0..equations.length - 1).each do |i|
        equation = equations[i]
        calculated = calculate(numbers.dup, equation.dup)
        next unless calculated == answer

        result = answer
        break
      end
      result
    rescue StandardError => e
      puts "#{e} #{line}"
      raise
    end
  end

  def self.part_2(input)
    input.lines.sum do |line|
      answer, numbers = parse(line)

      equations = gen_equations(['+', '*', '||'], numbers.length - 1)
      result = 0
      (0..equations.length - 1).each do |i|
        equation = equations[i]
        calculated = calculate(numbers.dup, equation.dup)
        next unless calculated == answer

        result = answer
        break
      end
      result
    rescue StandardError => e
      puts "#{e} #{line}"
      raise
    end
  end
end
