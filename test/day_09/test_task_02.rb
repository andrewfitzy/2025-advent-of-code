# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day_09/task_02'
require_relative '../test_utils/get_input'
require_relative '../test_utils/skip_ci'

class Day09Task02Test < Minitest::Test
  include Day09Task02
  include TestUtils

  def test_solve_example_01
    # Given
    input_path = File.join(__dir__, 'example_input_01.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(24, result)
  end

  def test_solve_puzzle
    # uncommenting and running this will take a long time, hee is the output form my run:
    # Finished in 388086.979478s, 0.0000 runs/s, 0.0000 assertions/s.
    #
    # The co-ordinates I found were:
    # (94710,67739)  TO  (4890,50238)
    #
    # It works but is very sloooow.
    #
    skip_on_ci
    # Given
    input_path = File.join(__dir__, 'input.txt')
    puzzle_input = get_input(input_path)

    # When
    result = solve(data: puzzle_input)

    # Then
    assert_equal(1_572_047_142, result)
  end
end
