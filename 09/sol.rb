inputs = File.readlines("input.txt").map(&:to_i)

x = 0
y = nil
while x < inputs.size + 1
  arr = inputs[x..(x + 25)]
  val = inputs[x + 26]
  y = val
  break unless arr.combination(2).to_a.map(&:sum).include?(val)

  x += 1
end

start_idx = 0
end_idx = inputs.index(y)
temp_sum = 0
short_arr = inputs.slice(start_idx, end_idx)

while temp_sum != y
  temp_sum = short_arr.slice(start_idx, end_idx).sum
  if temp_sum > y
    end_idx -= 1
  elsif temp_sum < y
    start_idx += 1
    end_idx += 1
  end
end

puts y
puts inputs.slice(start_idx, end_idx).min + inputs.slice(start_idx, end_idx).max
