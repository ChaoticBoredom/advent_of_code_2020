require "pry"

inputs = File.readlines("input.txt").map(&:strip)

def traverse(inputs, diagx, diagy)
  x = 0
  y = 0

  trees = 0
  while y < inputs.size - 1
    x += diagx
    x -= inputs[0].size if x >= inputs[0].size
    y += diagy

    # puts "#{x}, #{y}, #{inputs[y][x]}"
    trees += 1 if inputs[y][x] == "#"
  end

  trees
end

puts traverse(inputs, 3, 1)

puts traverse(inputs, 1, 1) *
  traverse(inputs, 3, 1) *
  traverse(inputs, 5, 1) *
  traverse(inputs, 7, 1) *
  traverse(inputs, 1, 2)
