class Day23
  def self.solve(input, init_a: 0)
    registers = { a: init_a, b: 0 }
    commands = input.lines.map(&:strip)
    i = 0
    while i < commands.size
      case commands[i].split(' ').first
      when 'inc'
        r = commands[i].split(' ').last.to_sym
        registers[r] += 1
        i += 1
      when 'hlf'
        r = commands[i].split(' ').last.to_sym
        registers[r] /= 2
        i += 1
      when 'tpl'
        r = commands[i].split(' ').last.to_sym
        registers[r] *= 3
        i += 1
      when 'jmp'
        offset = commands[i].split(' ').last
        offset = offset[0] == '-' ? offset[1..].to_i * -1 : offset[1..].to_i
        i += offset
      when 'jie'
        r, offset = commands[i].match(/jie (a|b), ([-|+]\d+)/).captures
        if registers[r.to_sym].even?
          offset = offset[0] == '-' ? offset[1..].to_i * -1 : offset[1..].to_i
          i += offset
        else
          i += 1
        end
      when 'jio'
        r, offset = commands[i].match(/jio (a|b), ([-|+]\d+)/).captures
        if registers[r.to_sym] == 1
          offset = offset[0] == '-' ? offset[1..].to_i * -1 : offset[1..].to_i
          i += offset
        else
          i += 1
        end
      end
    end
    registers[:b]
  end

  def self.part_2(_input)
    0
  end
end
