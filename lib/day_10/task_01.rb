# frozen_string_literal: true

Machine = Data.define(:light, :number_of_bulbs, :buttons, :joltage)

module Day10Task01
  def process_input(input:)
    parts = input.split
    light = []
    buttons = []
    joltage = []

    light_bin = 0b0
    buttons_bin = []
    number_of_bulbs = 0

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
        number_of_bulbs = light.length
        # Convert the light to binary
        light_bin = light.join.to_i(2)
      end
      if part.start_with? '('
        # create a light array sized array with 1s and 0s in the given places
        button = Array.new(light.length) { 0 }
        button_parts = part.sub('(', '').sub(')', '').split(',').map(&:to_i)
        button_parts.each do |bulb_affected|
          button[bulb_affected] = 1
        end
        buttons.append(button)
        # Convert the button to binary
        button_bin = button.join.to_i(2)
        buttons_bin.append(button_bin)
      end
      joltage = part.sub('{', '').sub('}', '').split(',').map(&:to_i) if part.start_with? '{'
    end
    Machine.new(light: light_bin, number_of_bulbs: number_of_bulbs, buttons: buttons_bin, joltage: joltage)
  end

  def get_minimum_presses(machine:)
    minimum_presses = 1_000_000 # large number we should always get lower than
    found = false

    button_presses = 1
    until found
      # Get the permutations of button presses for a given length
      button_permutations = machine.buttons.permutation(button_presses).to_a

      # For each of the permutations
      button_permutations.each do |permutation|
        # The light starts with all bulbs out
        light = Array.new(machine.number_of_bulbs) { 0 }.join.to_i(2)

        # process each item in the permutation, this is one button press
        permutation.each do |button_press|
          # the current light is binary and the button is binary so xor
          light ^= button_press
        end

        found = true if light == machine.light
      end
      if found
        minimum_presses = button_presses
        break
      end
      button_presses += 1
    end
    minimum_presses
  end

  def solve(data:)
    machines = data.map { |line| process_input(input: line) }

    total_minimum_presses = 0
    machines.each do |machine|
      total_minimum_presses += get_minimum_presses(machine: machine)
    end

    total_minimum_presses
  end
end
