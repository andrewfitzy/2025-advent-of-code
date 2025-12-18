# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day_11/task_02'
require_relative '../test_utils/get_input'
require_relative '../test_utils/skip_ci'

class Day11Task02Test < Minitest::Test
  include Day11Task02
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_02.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(2, result)
  end

  def test_solve_puzzle
    skip_on_ci
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(380_961_604_031_372, result)
  end
end
