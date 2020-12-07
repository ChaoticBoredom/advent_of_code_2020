inputs = File.read("input.txt").split("\n\n")

part1 = 0
part2 = 0

inputs.each do |group|
  part1 += group.chars.reject { |x| x == "\n" }.uniq.count
  part2 += group.split("\n").map(&:chars).reduce { |x, y| x & y }.size
end

puts part1
puts part2
