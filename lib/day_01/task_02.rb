# frozen_string_literal: true

module Day01Task02
  def solve(data:)
    pointer_position = 50
    zero_counter = 0
    data.each do |line|
      operation = line.match(/(?<direction>[LR]+)(?<count>\d+)/)
      clicks = operation[:count].to_i
      incrementer = 1
      incrementer = -1 if operation[:direction] == 'L'
      clicks.times do
        pointer_position = (pointer_position + incrementer) % 100
        zero_counter += 1 if pointer_position.zero?
      end
    end
    zero_counter
  end
end
