# frozen_string_literal: true

require 'geometry'
require 'algorithms'

module Day09Task02
  include Containers

  def get_edge_points(point_1:, point_2:)
    points = []
    if point_1.x == point_2.x
      start_y = point_1.y
      end_y = point_2.y
      if start_y > end_y
        start_y = point_2.y
        end_y = point_1.y
      end
      (start_y..end_y).each do |y|
        points.push(Geometry::Point[point_1.x, y])
      end
    end
    if point_1.y == point_2.y
      start_x = point_1.x
      end_x = point_2.x
      if start_x > end_x
        start_x = point_2.x
        end_x = point_1.x
      end
      (start_x..end_x).each do |x|
        points.push(Geometry::Point[x, point_1.y])
      end
    end
    points
  end

  def get_area(rectangle:)
    width = (rectangle.max.x - rectangle.min.x).abs + 1
    height = (rectangle.max.y - rectangle.min.y).abs + 1
    width * height
  end

  def solve(data:)
    points_list = []

    # Parse the data
    data.each do |line|
      co_ords = line.match(/(?<x>\d+),(?<y>\d+)/)
      point = Geometry::Point[co_ords[:x].to_i, co_ords[:y].to_i]
      points_list.append(point)
    end

    # Create a polygon of the points, this is our shape
    polygon = Geometry::Polygon.new(*points_list)

    # Create rectangles of pairs of points, need rectangles to find the vertices that lie outside the polygon
    rectangles = []
    (0..(points_list.length - 1)).each do |i|
      from = points_list[i]
      ((i + 1)..(points_list.length - 1)).each do |j|
        to = points_list[j]
        next if from.x == to.x || from.y == to.y

        rectangle_points = [[from.x, from.y], [to.x, from.y], [to.x, to.y], [from.x, to.y]]
        rectangle = Geometry::Polygon.new(*rectangle_points)
        rectangles.push(rectangle)
      end
    end

    # check that the corners are in the polygon, if they are keep them
    # Use a priority queue ordered by area so that we pop from biggest to smallest
    candidate_queue = PriorityQueue.new
    rectangles.each do |rectangle|
      all_corners_inside = rectangle.vertices.all? do |vertex|
        status = polygon <=> vertex
        status >= 0
      end
      if all_corners_inside
        area = get_area(rectangle: rectangle)
        candidate_queue.push(rectangle, area)
      end
    end

    # Check if the rectangle fits in the polygon, if it does it will be the biggest as we are
    # popping bigest to smallest areas.
    largest_rectangle = nil
    until candidate_queue.empty?
      rectangle = candidate_queue.pop
      in_polygon = rectangle.edges.all? do |edge|
        max = edge.max
        min = edge.min
        points = get_edge_points(point_1: max, point_2: min)
        points.all? do |point|
          status = polygon <=> point
          status >= 0
        end
      end
      if in_polygon
        largest_rectangle = rectangle
        break
      end
    end

    # puts largest_rectangle
    get_area(rectangle: largest_rectangle)
  end
end
