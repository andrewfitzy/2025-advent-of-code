# frozen_string_literal: true

Point = Data.define(:x, :y) do
  def get_manhattan_distance(other_point)
    # .abs gets the absolute value (positive number)
    (x - other_point.x).abs + (y - other_point.y).abs
  end

  def get_rectangular_area(other_point:)
    # .abs gets the absolute value (positive number)
    ((x - other_point.x).abs + 1) * ((y - other_point.y).abs + 1)
  end

  def in_bounds?(start_x:, start_y:, width:, height:)
    x >= start_x and y >= start_y and x < start_x + width and y < start_y + height
  end

  def eql?(other)
    self.class == other.class && x == other.x && y == other.y
  end

  def hash
    # Apparently, this is a common Ruby idiom: create an array from the key attributes
    # and use the Array's hashingfunction.
    [x, y].hash
  end

  def to_s
    "(#{x}, #{y})"
  end
end
