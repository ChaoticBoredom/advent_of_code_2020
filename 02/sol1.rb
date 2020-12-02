inputs = File.readlines("input.txt")

def valid_password?(password, min, max, letter)
  return false if password.count(letter) < min
  return false if password.count(letter) > max

  true
end

def valid_position?(password, first, second, letter)
  index1 = first - 1
  index2 = second - 1

  if password[index1] == letter
    return false if password[index2] == letter

    return true
  end

  return true if password[index2] == letter

  false
end

count1 = 0
count2 = 0
inputs.each do |line|
  policy, letter, password = line.split
  val1, val2 = policy.split("-").map(&:to_i)
  letter = letter[0]

  count1 += 1 if valid_password?(password, val1, val2, letter)
  count2 += 1 if valid_position?(password, val1, val2, letter)
end

puts count1
puts count2
