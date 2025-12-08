# frozen_string_literal: true

Point3D = Data.define(:x, :y, :z) do
  # def get_manhattan_distance(other_point)
  #
  # end
  #
  # def in_bounds?(start_x:, start_y:, start_z:, width:, height:, depth:)
  #   x >= start_x and y >= start_y and x < start_x + width and y < start_y + height
  # end

  def get_distance(other_point:)
    return unless other_point.is_a?(self.class)

    # puts self.class
    # puts other_point.class
    dx = other_point.x - x
    dy = other_point.y - y
    dz = other_point.z - z

    dx_sq = dx * dx
    dy_sq = dy * dy
    dz_sq = dz * dz

    Math.sqrt(dx_sq + dy_sq + dz_sq)
  end

  def eql?(other)
    self.class == other.class && x == other.x && y == other.y && z == other.z
  end

  def hash
    # Apparently, this is a common Ruby idiom: create an array from the key attributes
    # and use the Array's hashingfunction.
    [x, y, z].hash
  end

  def to_s
    "(#{x}, #{y}, #{z})"
  end
end
