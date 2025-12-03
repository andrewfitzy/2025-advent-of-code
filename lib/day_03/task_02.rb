# frozen_string_literal: true

module Day03Task02
  # def the_pain(battery_bank:)
  #   # Unused, just added for giggles, works with the example but didn't return in 200 seconds with the real input
  #   batteries = battery_bank.chars.map(&:to_i)

  #   greatest = 0
  #   (0..(batteries.length - 12)).each do |i_0|
  #     ((i_0 + 1)..(batteries.length - 11)).each do |i_1|
  #       ((i_1 + 1)..(batteries.length - 10)).each do |i_2|
  #         ((i_2 + 1)..(batteries.length - 9)).each do |i_3|
  #           ((i_3 + 1)..(batteries.length - 8)).each do |i_4|
  #             ((i_4 + 1)..(batteries.length - 7)).each do |i_5|
  #               ((i_5 + 1)..(batteries.length - 6)).each do |i_6|
  #                 ((i_6 + 1)..(batteries.length - 5)).each do |i_7|
  #                   ((i_7 + 1)..(batteries.length - 4)).each do |i_8|
  #                     ((i_8 + 1)..(batteries.length - 3)).each do |i_9|
  #                       ((i_9 + 1)..(batteries.length - 2)).each do |i_10|
  #                         ((i_10 + 1)..(batteries.length - 1)).each do |i_11|
  #                           current_value =
  #                             (batteries[i_0] * 100_000_000_000) +
  #                             (batteries[i_1] * 10_000_000_000) +
  #                             (batteries[i_2] * 1_000_000_000) +
  #                             (batteries[i_3] * 100_000_000) +
  #                             (batteries[i_4] * 10_000_000) +
  #                             (batteries[i_5] * 1_000_000) +
  #                             (batteries[i_6] * 100_000) +
  #                             (batteries[i_7] * 10_000) +
  #                             (batteries[i_8] * 1000) +
  #                             (batteries[i_9] * 100) +
  #                             (batteries[i_10] * 10) +
  #                             batteries[i_11]
  #                           greatest = current_value if greatest < current_value
  #                         end
  #                       end
  #                     end
  #                   end
  #                 end
  #               end
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  #   greatest
  # end

  def get_greatest_joltage(battery_bank:)
    batteries = battery_bank.chars.map(&:to_i)
    number_to_process = batteries.length - 12
    process_stack = []

    (0..(batteries.length - 1)).each do |pointer|
      current_digit = batteries[pointer]
      while !process_stack.empty? && number_to_process.positive? && process_stack.last < current_digit
        process_stack.pop
        number_to_process -= 1
      end
      process_stack.push(current_digit)
    end
    process_stack.pop while process_stack.length > 12

    (process_stack[0] * 100_000_000_000) +
      (process_stack[1] * 10_000_000_000) +
      (process_stack[2] * 1_000_000_000) +
      (process_stack[3] * 100_000_000) +
      (process_stack[4] * 10_000_000) +
      (process_stack[5] * 1_000_000) +
      (process_stack[6] * 100_000) +
      (process_stack[7] * 10_000) +
      (process_stack[8] * 1000) +
      (process_stack[9] * 100) +
      (process_stack[10] * 10) +
      process_stack[11]
  end

  def solve(data:)
    total_joltage = 0
    data.each do |line|
      total_joltage += get_greatest_joltage(battery_bank: line)
    end

    total_joltage
  end
end
