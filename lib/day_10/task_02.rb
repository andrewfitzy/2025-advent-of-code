# frozen_string_literal: true

require_relative '../utils/point'

Machine = Data.define(:light, :buttons, :joltage)

module Day10Task02
  def process_input(input:)
    parts = input.split
    light = []
    buttons = []
    joltage = []

    parts.each do |part|
      if part.start_with? '['
        # light array with 1s and 0s
        light_parts = part.sub('[', '').sub(']', '').chars
        light_parts.each do |bulb|
          if bulb == '.'
            light.append(0)
            next
          end
          light.append(1)
        end
      end
      if part.start_with? '('
        # create a light array sized array with 1s and 0s in the given places
        button = Array.new(light.length) { 0 }
        button_parts = part.sub('(', '').sub(')', '').split(',').map(&:to_i)
        button_parts.each do |bulb_affected|
          button[bulb_affected] = 1
        end
        buttons.append(button)
      end
      joltage = part.sub('{', '').sub('}', '').split(',').map(&:to_i) if part.start_with? '{'
    end
    Machine.new(light: light, buttons: buttons, joltage: joltage)
  end

  def solve(data:)
    # [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    # [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    # [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    machines = data.map { |line| process_input(input: line) }
    machines.length # return number of machiens for now
  end
end
