# frozen_string_literal: true

module Day06Task01
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
      parts = line.split
      line_inputs.push(parts)
    end

    number_calculations = line_inputs[0].length
    number_of_operands = line_inputs.length

    total = 0
    (0..(number_calculations - 1)).each do |calculation|
      operator = line_inputs[number_of_operands - 1][calculation]
      operands = (0..(number_of_operands - 2)).map { |operand| line_inputs[operand][calculation].to_i }
      total += perform_calculation(operands: operands, operator: operator)
    end
    total
  end
end
