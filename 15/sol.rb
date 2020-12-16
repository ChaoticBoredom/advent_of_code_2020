inputs = [14, 8, 16, 0, 1, 17]

def get_next_number(inputs, num)
  # indices = inputs.map.with_index { |a, i| a == num ? i : nil }.compact
  # return 0 if indices.one?

  # indices.last - indices[-2]
  indices = inputs[num]
  return 0 if indices.one?

  indices[-1] - indices[-2]
end

def cycle(inputs, idx)
  count = inputs.size
  h = {}
  inputs.each.with_index { |v, i| h[v] = [i] }
  curr_val = inputs.last

  while count < idx
    curr_val = get_next_number(h, curr_val)
    if h.key?(curr_val)
      h[curr_val] << count
    else
      h[curr_val] = [count]
    end
    count += 1
  end

  curr_val
end

puts cycle(inputs, 2020)
puts cycle(inputs, 30_000_000)
