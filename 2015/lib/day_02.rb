class Day02
  def self.part_1(input)
    input.lines.sum do |line|
      l, w, h = line.scan(/\d+/).map(&:to_i)
      sqft = [l * w, w * h, h * l]
      sqft.map { |d| d * 2 }.sum + sqft.min
    end
  end

  def self.part_2(input)
    input.lines.sum do |line|
      l, w, h = line.scan(/\d+/).map(&:to_i)
      faces = [[l, w], [w, h], [h, l]]
      min_face = faces.min { |a, b| a.first * a.last <=> b.first * b.last }
      min_face.reduce(0) { |sum, num| sum + num + num } + (l * w * h)
    end
  end
end
