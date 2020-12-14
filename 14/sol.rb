require "pry"

inputs = File.readlines("input.txt").map(&:chomp)

def run_mask(mask, input)
  input = input.to_i.to_s(2).rjust(36, "0")
  mask.chars.each_with_index do |char, idx|
    next if char == "X"

    input[idx] = char
  end
  input
end

def run_loc_mask(mask, addr)
  addr = addr.to_i.to_s(2).rjust(36, "0")
  mask.chars.each_with_index do |char, idx|
    next if char == "0"

    addr[idx] = char
  end

  return [addr] if addr.count("X").zero?

  get_variations(addr).map { |a| a.to_i(2) }
end

def get_variations(addr)
  return addr if addr.count("X").zero?

  [get_variations(addr.sub("X", "0")), get_variations(addr.sub("X", "1"))].flatten
end

def run_init(inputs)
  mask = ""
  mem = {}
  inputs.each do |line|
    if line.match?(/mask =/)
      mask = line.split(" ").last
    else
      addr, num = /mem\[(\d+)\] = (\d+)/.match(line).captures
      mem[addr.to_i] = run_mask(mask, num).to_i(2)
    end
  end
  mem
end

def run_v2_init(inputs)
  mask = ""
  mem = {}
  inputs.each do |line|
    if line.match?(/mask =/)
      mask = line.split(" ").last
    else
      addr, num = /mem\[(\d+)\] = (\d+)/.match(line).captures
      addrs = run_loc_mask(mask, addr)
      addrs.each do |a|
        mem[a] = num
      end
    end
  end
  mem
end

puts run_init(inputs).values.map(&:to_i).sum
puts run_v2_init(inputs).values.map(&:to_i).sum
