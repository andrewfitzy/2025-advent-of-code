# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day_05/task_02'
require_relative '../test_utils/get_input'
require_relative '../test_utils/skip_ci'

class Day05Task02Test < Minitest::Test
  include Day05Task02
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_01.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(14, result)
  end

  def test_solve_puzzle
    skip_on_ci
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(352_509_891_817_881, result)
  end
end
