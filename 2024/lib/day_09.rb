class Day09
  Mem = Struct.new(:id, :size)

  def self.parse(input)
    input.chars.map.with_index do |n, i|
      if i.even?
        Mem.new(i / 2, n.to_i)
      else
        Mem.new(-1, n.to_i)
      end
    end
  end

  def self.pack(disk)
    f = 0
    d = disk.length - 1
    until f >= d
      if disk[f].id == -1 && disk[d].id != -1
        freesize = disk[f].size
        filesize = disk[d].size
        leftover = freesize - filesize
        if filesize == freesize
          disk[f] = disk[d].dup
          disk[d] = Mem.new(-1, freesize)
        elsif leftover > 0
          disk.insert(f, Mem.new(disk[d].id, filesize))
          d += 1
          disk[f + 1].size = leftover
          disk[d] = Mem.new(-1, filesize)
        else
          disk[f] = disk[d].dup
          disk[f].size = freesize
          disk[d].size = filesize - freesize
        end
      elsif disk[f].id != -1
        f += 1
      else
        d -= 1
      end
    end
    disk
  end

  def self.pack_2(disk)
    d = disk.length
    f = nil

    loop do
      return disk if d == 0

      d -= 1
      d -= 1 while d > 0 && disk[d].id == -1

      f = nil
      for i in 0..d
        if disk[i].id == -1 && disk[i].size >= disk[d].size
          f = i
          break
        end
      end

      next unless f

      if disk[f].size == disk[d].size
        disk[f].id = disk[d].id
        disk[d].id = -1
      else
        disk[f].size -= disk[d].size
        disk.insert(f, disk[d].dup)
        disk[d + 1].id = -1
      end
    end
  end

  def self.checksum(input)
    checksum = 0
    i = 0
    input.each do |mem|
      mem.size.times { |j| checksum += mem.id * (i + j) } if mem.id != -1
      i += mem.size
    end
    checksum
  end

  def self.part_1(input)
    disk = parse(input)
    packed = pack(disk)

    checksum(packed)
  end

  def self.part_2(input)
    disk = parse(input)
    packed = pack_2(disk)

    checksum(packed)
  end
end
