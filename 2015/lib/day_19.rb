require 'set'

class Day19
  def self.part_1(input)
    molecule, replacements = parse(input)
    run_replacements(molecule, replacements)
  end

  def self.parse(input)
    lines = input.lines
    molecule = lines.pop.strip
    lines.pop
    replacements = lines.map { |line| line.strip.split(' => ') }
    [molecule, replacements]
  end

  def self.run_replacements(molecule, replacements)
    created = Set.new
    replacements.each do |from, to|
      molecule.enum_for(:scan, /#{Regexp.escape(from)}/).map { Regexp.last_match.begin(0) }.each do |index|
        created.add(molecule[0...index] + to + molecule[(index + from.length)..])
      end
    end
    created.to_a
  end

  def self.part_2(input)
    molecule, replacements = parse(input)

    reverse_replacements = replacements.map { |from, to| [to, from] }
    reverse_replacements.sort_by! { |to, _from| -to.length }

    steps = 0
    while molecule != 'e'
      found = false

      reverse_replacements.each do |to, from|
        if molecule.include?(to)
          molecule.sub!(to, from)
          steps += 1
          found = true
          break
        end
      end

      break unless found
    end

    steps
  end
end
