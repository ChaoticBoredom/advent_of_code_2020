inputs = File.read("input.txt").split("\n\n")

def valid_byr?(year)
  year.to_i.between?(1920, 2002)
end

def valid_iyr?(year)
  year.to_i.between?(2010, 2020)
end

def valid_eyr?(year)
  year.to_i.between?(2020, 2030)
end

def valid_hgt?(height)
  return height.to_i.between?(59, 76) if height.match?(/in/)
  return height.to_i.between?(150, 193) if height.match?(/cm/)

  false
end

def valid_hcl?(colour)
  colour.match?(/#[0-9a-f]{6}/i)
end

def valid_ecl?(colour)
  ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(colour)
end

def valid_pid?(pid)
  pid.match?(/\A\d{9}\z/)
end

def valid?(passport)
  return false unless passport.match?(/byr:/)
  return false unless passport.match?(/iyr:/)
  return false unless passport.match?(/eyr:/)
  return false unless passport.match?(/hgt:/)
  return false unless passport.match?(/hcl:/)
  return false unless passport.match?(/ecl:/)
  return false unless passport.match?(/pid:/)

  true
end

def better_valid?(passport)
  hash = passport.gsub("\n", " ").split.map { |x| x.split(":") }.to_h
  return false unless valid_byr?(hash["byr"])
  return false unless valid_iyr?(hash["iyr"])
  return false unless valid_eyr?(hash["eyr"])
  return false unless valid_hgt?(hash["hgt"])
  return false unless valid_hcl?(hash["hcl"])
  return false unless valid_ecl?(hash["ecl"])
  return false unless valid_pid?(hash["pid"])

  true
end

def count_valid(inputs)
  valid = 0
  better_valid = 0
  inputs.each do |passport|
    if valid?(passport)
      valid += 1
      better_valid += 1 if better_valid?(passport)
    end
  end
  [valid, better_valid]
end

puts count_valid(inputs)
