# frozen_string_literal: true

require_relative '../utils/point'

TileArea = Data.define(:from, :to, :area)

module Day09Task01
  def solve(data:)
    points_list = []
    # points_set = Set.new

    # Parse the data
    data.each do |line|
      co_ords = line.match(/(?<x>\d+),(?<y>\d+)/)
      point = Point.new(x: co_ords[:x].to_i, y: co_ords[:y].to_i)
      points_list.append(point)
      # points_set.add(point_3d)
    end

    # Calculate areas
    areas = []
    (0..(points_list.length - 1)).each do |i|
      from = points_list[i]

      ((i + 1)..(points_list.length - 1)).each do |j|
        to = points_list[j]
        area = from.get_rectangular_area(other_point: to)
        areas.push(TileArea.new(from: from, to: to, area: area))
      end
    end

    greatest_area = 0
    areas.each do |area|
      greatest_area = area.area if area.area > greatest_area
    end
    greatest_area
  end
end
