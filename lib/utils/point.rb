Point = Data.define(:x, :y) do
  def get_manhattan_distance(other_point)
    # .abs gets the absolute value (positive number)
    (x - other_point.x).abs + (y - other_point.y).abs
  end

  def in_bounds?(start_x:, start_y:, width:, height:)
    x >= start_x and y >= start_y and x < start_x + width and y < start_y + height
  end
end
