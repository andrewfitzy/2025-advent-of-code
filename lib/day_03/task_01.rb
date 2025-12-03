# frozen_string_literal: true

module Day03Task01
  def get_greatest_joltage(battery_bank:)
    batteries = battery_bank.chars.map(&:to_i)

    greatest = 0
    (0..(batteries.length - 2)).each do |tens_pointer|
      ((tens_pointer + 1)..(batteries.length - 1)).each do |ones_pointer|
        current_value = (batteries[tens_pointer] * 10) + batteries[ones_pointer]
        greatest = current_value if greatest < current_value
      end
    end

    greatest
  end

  def solve(data:)
    total_joltage = 0
    data.each do |line|
      total_joltage += get_greatest_joltage(battery_bank: line)
    end

    total_joltage
  end
end
