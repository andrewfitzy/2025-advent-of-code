# frozen_string_literal: true

Machine = Data.define(:light, :buttons, :joltage)

module Day10Task01
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

  def get_minimum_presses(machine:)
    minimum_presses = 1_000_000 # large number we should always get lower than
    found = false
    (1..machine.light.length).each do |iteration|
      # Get the permutations of button presses for a given length
      button_permutations = machine.buttons.permutation(iteration).to_a

      # For each of the permutations
      button_permutations.each do |permutation|
        # The light starts with all bulbs out
        light = Array.new(machine.light.length) { 0 }

        # process each item in the permutation, this is one button press
        permutation.each do |button_press|
          # apply button press to light
          (0..(button_press.length - 1)).each do |index|
            next unless button_press[index] == 1

            if light[index] == 1
              light[index] = 0
              next
            end
            light[index] = 1
          end
        end

        found = true if light == machine.light
      end
      if found
        minimum_presses = iteration
        break
      end
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
