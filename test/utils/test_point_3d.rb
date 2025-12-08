# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/utils/point_3d'

class PointTest < Minitest::Test
  def test_create
    # Given
    x = 1
    y = 2
    z = 3

    # When
    point = Point3D.new(x: x, y: y, z: z)

    # Then
    assert_equal x, point.x
    assert_equal y, point.y
    assert_equal z, point.z
  end

  def test_equals
    # Given
    x = 1
    y = 2
    z = 3

    # When
    point_1 = Point3D.new(x: x, y: y, z: z)
    point_2 = Point3D.new(x: x, y: y, z: z)

    # Then
    assert_equal point_1, point_2
  end

  def test_eq_locically_equal
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)
    point_02 = Point3D.new(x: 1, y: 6, z: 9)

    # When
    is_equal = point_01.eql?(point_02)

    # Then
    assert(is_equal)
  end

  def test_eq_object_equal
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)

    # When
    is_equal = point_01.eql?(point_01)

    # Then
    assert(is_equal)
  end

  def test_eq_not_logically_equal
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)
    point_02 = Point3D.new(x: 6, y: 1, z: 9)

    # When
    is_equal = point_01.eql?(point_02)

    # Then
    refute(is_equal)
  end

  def test_eq_type_mismatch
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)
    struct_01 = Struct.new(:x, :y, :z).new(1, 6, 9)

    # When
    is_equal = point_01.eql?(struct_01)

    # Then
    refute(is_equal)
  end

  # rubocop:disable Lint/BinaryOperatorWithIdenticalOperands
  def test_hash_is_consistent_for_same_object
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)

    # When
    is_equal = point_01.hash == point_01.hash

    # Then
    assert(is_equal)
  end
  # rubocop:enable Lint/BinaryOperatorWithIdenticalOperands

  def test_hash_is_consistent_for_different_object
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)
    point_02 = Point3D.new(x: 1, y: 6, z: 9)

    # When
    is_equal = point_01.hash == point_02.hash

    # Then
    assert(is_equal)
  end

  def test_hash_for_logically_different_object
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)
    point_02 = Point3D.new(x: 6, y: 1, z: 9)

    # When
    is_equal = point_01.hash == point_02.hash

    # Then
    refute(is_equal)
  end

  def test_to_s
    # Given
    point_01 = Point3D.new(x: 1, y: 6, z: 9)

    # When
    point_01_str = point_01.to_s

    # Then
    assert_equal '(1, 6, 9)', point_01_str
  end

  def test_get_distance
    # Given
    point_1 = Point3D.new(x: 10, y: 20, z: 30)
    point_2 = Point3D.new(x: 12, y: 23, z: 36)

    # When
    distance = point_1.get_distance(other_point: point_2)

    # Then
    assert_equal 7, distance
  end
end
