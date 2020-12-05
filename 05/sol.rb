require "pry"

inputs = File.readlines("input.txt").map(&:chomp).map(&:chars)

def find_next(min, max, input)
  diff = ((max - min) / 2.0).ceil

  max -= diff if ["F", "L"].include?(input)
  min += diff if ["B", "R"].include?(input)
  [min, max]
end

def find_value(min, max, input)
  input.each do |letter|
    min, max = find_next(min, max, letter)
  end
  min
end

def find_seat_id(seat)
  row_data, column_data = seat.each_slice(7).to_a

  row = find_value(0, 127, row_data)
  column = find_value(0, 7, column_data)

  row * 8 + column
end

def find_missing_seat(seats)
  seat = seats.min
  while seats.include?(seat)
    seat += 1
  end
  seat
end

seats = []
inputs.each do |seat|
  seats << find_seat_id(seat)
end

puts seats.max
puts find_missing_seat(seats)
