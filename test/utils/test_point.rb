require 'minitest/autorun'
require_relative '../../lib/utils/point'

class PointTest < Minitest::Test
  def test_create
    # Given
    x = 1
    y = 2

    # When
    point = Point.new(x: x, y: y)

    # Then
    assert_equal x, point.x
    assert_equal y, point.y
  end

  def test_equals
    # Given
    x = 1
    y = 2

    # When
    point_1 = Point.new(x: x, y: y)
    point_2 = Point.new(x: x, y: y)

    # Then
    assert_equal point_1, point_2
  end

  def test_get_manhattan_distance_positive
    # Given
    point_1 = Point.new(x: 10, y: 10)
    point_2 = Point.new(x: 15, y: 15)

    # When
    distance = point_1.get_manhattan_distance(point_2)

    # Then
    assert_equal 10, distance
  end

  def test_get_manhattan_distance_negative
    # Given
    point_1 = Point.new(x: 10, y: 10)
    point_2 = Point.new(x: -15, y: -15)

    # When
    distance = point_1.get_manhattan_distance(point_2)

    # Then
    assert_equal 50, distance
  end

  def test_is_in_bounds
    # Given
    point = Point.new(x: 1, y: 2)

    # When
    is_in_bounds = point.in_bounds?(start_x: 1, start_y: 2, width: 3, height: 3)

    # Then
    assert(is_in_bounds)
  end

  def test_is_in_bounds_left_of_bounds
    # Given
    point = Point.new(x: 0, y: 2)

    # When
    is_in_bounds = point.in_bounds?(start_x: 1, start_y: 2, width: 3, height: 3)

    # Then
    refute(is_in_bounds)
  end

  def test_is_in_bounds_above_bounds
    # Given
    point = Point.new(x: 1, y: 0)

    # When
    is_in_bounds = point.in_bounds?(start_x: 1, start_y: 2, width: 3, height: 3)

    # Then
    refute(is_in_bounds)
  end

  def test_is_in_bounds_right_of_bounds
    # Given
    point = Point.new(x: 5, y: 2)

    # When
    is_in_bounds = point.in_bounds?(start_x: 1, start_y: 2, width: 3, height: 3)

    # Then
    refute(is_in_bounds)
  end

  def test_is_in_bounds_below_bounds
    # Given
    point = Point.new(x: 1, y: 6)

    # When
    is_in_bounds = point.in_bounds?(start_x: 1, start_y: 2, width: 3, height: 3)

    # Then
    refute(is_in_bounds)
  end

  def test_eq_locically_equal
    # Given
    point_01 = Point.new(x: 1, y: 6)
    point_02 = Point.new(x: 1, y: 6)

    # When
    is_equal = point_01.eql?(point_02)

    # Then
    assert(is_equal)
  end

  def test_eq_object_equal
    # Given
    point_01 = Point.new(x: 1, y: 6)

    # When
    is_equal = point_01.eql?(point_01)

    # Then
    assert(is_equal)
  end

  def test_eq_not_logically_equal
    # Given
    point_01 = Point.new(x: 1, y: 6)
    point_02 = Point.new(x: 6, y: 1)

    # When
    is_equal = point_01.eql?(point_02)

    # Then
    refute(is_equal)
  end

  def test_eq_type_mismatch
    # Given
    point_01 = Point.new(x: 1, y: 6)
    struct_01 = Struct.new(:x, :y).new(1, 5)

    # When
    is_equal = point_01.eql?(struct_01)

    # Then
    refute(is_equal)
  end

  # rubocop:disable Lint/BinaryOperatorWithIdenticalOperands
  def test_hash_is_consistent_for_same_object
    # Given
    point_01 = Point.new(x: 1, y: 6)

    # When
    is_equal = point_01.hash == point_01.hash

    # Then
    assert(is_equal)
  end
  # rubocop:enable Lint/BinaryOperatorWithIdenticalOperands

  def test_hash_is_consistent_for_different_object
    # Given
    point_01 = Point.new(x: 1, y: 6)
    point_02 = Point.new(x: 1, y: 6)

    # When
    is_equal = point_01.hash == point_02.hash

    # Then
    assert(is_equal)
  end

  def test_hash_for_logically_different_object
    # Given
    point_01 = Point.new(x: 1, y: 6)
    point_02 = Point.new(x: 6, y: 1)

    # When
    is_equal = point_01.hash == point_02.hash

    # Then
    refute(is_equal)
  end

  def test_to_s
    # Given
    point_01 = Point.new(x: 1, y: 6)

    # When
    point_01_str = point_01.to_s

    # Then
    assert_equal '(1, 6)', point_01_str
  end
end
