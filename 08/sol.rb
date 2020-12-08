inputs = File.readlines("input.txt")

def run_code(inputs)
  accumulator = 0
  index = 0
  visited_indexes = []
  while index < inputs.size && looping?(visited_indexes)
    line = inputs[index]
    action, count = line.split(" ")
    accumulator, index = do_action(action, count.to_i, accumulator, index)
    visited_indexes << index
  end
  [accumulator, !looping?(visited_indexes)]
end

def looping?(visited)
  visited.detect { |x| visited.count(x) > 1 }.nil?
end

def do_action(action, line, acc, idx)
  case action
  when "nop"
    [acc, idx + 1]
  when "acc"
    [acc + line, idx + 1]
  when "jmp"
    [acc, idx + line]
  end
end

def swapper(inputs)
  inputs.each_with_index do |line, idx|
    new_inputs = inputs.clone
    new_inputs[idx] = line.gsub(/nop/, "jmp") if line =~ /nop/
    new_inputs[idx] = line.gsub(/jmp/, "nop") if line =~ /jmp/

    res, looped = run_code(new_inputs)
    return res unless looped
  end
end

puts run_code(inputs)[0]
puts swapper(inputs)
