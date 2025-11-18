require 'minitest/autorun'
require_relative '../../lib/day_00/task_02'
require_relative '../test_utils/get_input'

class Day00Task02Test < Minitest::Test
  include Day00Task02
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_01.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(puzzle_input)

    # Then
    assert_equal(362_880_000_000_000, result)
  end

  def test_solve_puzzle
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(puzzle_input)

    # Then
    assert_equal(1_278_767_724_609_375, result)
  end
end
