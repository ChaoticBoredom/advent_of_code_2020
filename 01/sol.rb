inputs = File.readlines("input.txt")
nums = inputs.map(&:strip).map(&:to_i)

def find_two(nums)
  nums.each do |x|
    nums.each do |y|
      return x * y if (x + y) == 2020
    end
  end
end

def find_three(nums)
  nums.each do |x|
    nums.each do |y|
      nums.each do |z|
        return x * y * z if (x + y + z) == 2020
      end
    end
  end
end

puts find_two(nums)
puts find_three(nums)
