# frozen_string_literal: true

module Day01Task01
  def solve(data:)
    pointer_position = 50
    zero_counter = 0
    data.each do |line|
      operation = line.match(/(?<direction>[LR]+)(?<count>\d+)/)
      pointer_position = if operation[:direction] == 'L'
                           (pointer_position - operation[:count].to_i) % 100
                         else
                           (pointer_position + operation[:count].to_i) % 100
                         end
      zero_counter += 1 if pointer_position.zero?
    end
    zero_counter
  end
end
