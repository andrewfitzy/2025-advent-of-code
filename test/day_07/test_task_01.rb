# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day_07/task_01'
require_relative '../test_utils/get_input'
require_relative '../test_utils/skip_ci'

class Day07Task01Test < Minitest::Test
  include Day07Task01
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_01.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(21, result)
  end

  def test_solve_puzzle
    skip_on_ci
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(1573, result)
  end
end
