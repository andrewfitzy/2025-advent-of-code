# frozen_string_literal: true

require_relative '../utils/point'

module Day06Task02
  def perform_calculation(operands:, operator:)
    result = 0
    if operator == '*'
      result = 1
      operands.each do |operand|
        result *= operand
      end
    end
    if operator == '+'
      operands.each do |operand|
        result += operand
      end
    end
    result
  end

  def solve(data:)
    line_inputs = []

    data.each do |line|
      parts = line.chars.reverse
      line_inputs.push(parts)
    end

    cols = line_inputs[0].length
    rows = line_inputs.length

    total = 0
    operands = []
    (0..(cols - 1)).each do |col|
      is_break = true
      (0..(rows - 1)).each do |row|
        unless line_inputs[row][col] == ' '
          is_break = false
          break
        end
      end

      next if is_break

      num = ''
      (0..(rows - 2)).each do |row|
        num += line_inputs[row][col]
      end
      operands.push(num.to_i)

      operator = line_inputs[rows - 1][col]
      if ['*', '+'].include?(operator)
        total += perform_calculation(operands: operands, operator: operator)
        operands = []
      end
    end
    total
  end
end
