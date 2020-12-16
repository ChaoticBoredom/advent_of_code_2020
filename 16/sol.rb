inputs = File.read("input.txt")

bounds, ticket, nearby = inputs.split("\n\n")

bounds = bounds.split("\n").each_with_object({}) do |bound, h|
  data = /(.+): (\d+)-(\d+) or (\d+)-(\d+)/.match(bound)
  h[data[1]] = [[data[2].to_i, data[3].to_i], [data[4].to_i, data[5].to_i]]
end

ticket = ticket.split("\n").last.split(",").map(&:to_i)
nearby = nearby.split("\n").slice(1, nearby.size).map { |t| t.split(",").map(&:to_i) }

def validate_field(field, bound1, bound2)
  field.between?(bound1[0], bound1[1]) ||
    field.between?(bound2[0], bound2[1])
end

def validate_ticket(bounds, ticket)
  bad_fields = []

  ticket.each do |field|
    valid = false
    bounds.values.each do |v1, v2|
      next if valid

      valid = true if validate_field(field, v1, v2)
    end
    bad_fields << field unless valid
  end
  bad_fields
end

def guess_field_index(bounds, tickets)
  field_indices = bounds.keys.each_with_object({}) { |k, h| h[k] = [] }
  options = (0...tickets.first.size).to_a
  options.each do |opt|
    valid_opt = true
    bounds.each do |k, v|
      v1, v2 = v
      tickets.each do |t|
        valid_opt = validate_field(t[opt], v1, v2)
        break unless valid_opt
      end
      field_indices[k] << opt if valid_opt
    end
  end

  field_indices.sort_by { |_, v| v.size }.each do |k1, v1|
    field_indices.each do |k2, _|
      field_indices[k2].delete(v1.first) unless k1 == k2
    end
  end

  field_indices
end

x = []
valid_nearby = []
nearby.each do |t|
  validation = validate_ticket(bounds, t)
  if validation.empty?
    valid_nearby << t
  else
    x << validation
  end
end

puts x.flatten.sum

indices = guess_field_index(bounds, valid_nearby)

short_indices = indices.select { |k, _| /departure/ =~ k }

mult = 1
short_indices.values.each do |v|
  mult *= ticket[v.first]
end

puts mult
