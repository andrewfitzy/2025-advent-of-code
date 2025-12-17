# frozen_string_literal: true

require_relative '../utils/point'
require 'z3'

Machine = Data.define(:light, :number_of_bulbs, :buttons, :joltage)

module Day10Task02
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
    # Brute forcing didn't work on the real input, it was toooo big. Instead I've taken inspiration
    # from most of the solutions on Reddit and used the Z3 library to solve this as apparently it is
    # a constrained optimization problem. I've used various sources to actually create this solution
    # code, props to HyperNeutrino (https://www.youtube.com/watch?v=OJ4dxrIfDfs) for the excellent
    # explainer.
    #
    minimum_presses = 0

    optimizer = Z3::Optimize.new

    # Create Z3 variables for each input, each machine has a variable number of joltages
    x_vars = machine.buttons.each_with_index.map do |_, i|
      Z3.Int("x#{i}").tap { |var| optimizer.assert var >= 0 }
    end

    # Apply constraints for each bit position
    machine.joltage.length.times do |bit_index|
      # bit_pos is 3, 2, 1, 0 (left to right)
      bit_pos = (machine.joltage.length - 1) - bit_index

      # Build the sum: (val_of_bit * x0) + (val_of_bit * x1) ...
      bit_sum = x_vars.each_with_index.inject(0) do |sum, (var, input_idx)|
        # Get the specific bit (0 or 1) at this position for this input
        bit = (machine.buttons[input_idx] >> bit_pos) & 1
        sum + (bit * var)
      end

      optimizer.assert bit_sum == machine.joltage[bit_index]
    end

    # Minimize the total number of uses
    optimizer.minimize(x_vars.inject(:+))

    # Calculate the answer
    if optimizer.satisfiable?
      x_vars.each do |val|
        minimum_presses += optimizer.model[val].to_i
      end
    else
      # In theory we should never see this... AoC wound't use a duff input.
      puts 'No solution found.'
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
