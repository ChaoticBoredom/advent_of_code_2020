inputs = File.readlines("input.txt")

ruleset = {}

inputs.each do |rule|
  container = /(\w+ \w+) bags contain/.match(rule)[1]
  bags = rule.split("contain")[1]
  ruleset[container] = bags
end

def get_containers(ruleset, bag)
  ruleset.select { |_, value| /#{bag}/.match(value) }
end

def recurse(ruleset, bag, containers)
  new_containers = get_containers(ruleset, bag).keys

  new_containers.each do |c|
    containers |= recurse(ruleset, c, containers)
  end

  containers | new_containers
end

def get_bag_count(ruleset)
  ruleset.transform_values do |bag_list|
    if /no other/ =~ bag_list
      { bags: [], bag_count: 0 }
    else
      clean_list = bag_list.delete(".").split(",").map(&:strip)
      bag_count = clean_list.map { |x| /\d+/.match(x)[0].to_i }.sum
      bags = clean_list.each_with_object({}) do |bag, list|
        count, type = /(\d+) (\w+ \w+)/.match(bag).captures
        list[type] = count.to_i
        list
      end
      { bags: bags, bag_count: bag_count }
    end
  end
end

def do_maths(bag_list, bag)
  bags = bag_list[bag][:bags]

  total = bag_list[bag][:bag_count]

  bags.each do |b, c|
    count = do_maths(bag_list, b)
    total += (c * count)
  end

  total
end

puts recurse(ruleset, "shiny gold", []).size
counts = get_bag_count(ruleset)
puts do_maths(counts, "shiny gold")
