require 'minitest/autorun'
require_relative '../../lib/day_00/task_01'
require_relative '../test_utils/get_input'

class Day00Task01Test < Minitest::Test
  include Day00Task01
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_01.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(puzzle_input)

    # Then
    assert_equal(450, result)
  end

  def test_solve_puzzle
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(puzzle_input)

    # Then
    assert_equal(495, result)
  end
end
