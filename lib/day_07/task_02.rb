# frozen_string_literal: true

require_relative '../utils/point'

RowTracker = Data.define(:index, :previous, :to_process)

module Day07Task02
  def solve(data:)
    input_grid = data.map(&:chars)

    # Find the start as we need to go from there.
    start = nil
    (0..(input_grid.length - 1)).each do |y|
      (0..(input_grid[y].length - 1)).each do |x|
        start = Point.new(x: x, y: y) if input_grid[y][x] == 'S'
      end
    end

    # Get the cost of all left/right path routes from start
    get_path_count_from_point(point: start, grid: input_grid)
  end

  def get_path_count_from_point(point:, grid:)
    # Set up our hash for Memoization, For more details see:
    # https://blog.appsignal.com/2022/12/20/a-guide-to-memoization-in-ruby.html
    @params_hash ||= {}
    if @params_hash.key?(point)
      # We've seen the input before, return the cached cost
      @params_hash[point]
    else
      # We're at the bottom of the drid, return 1
      return 1 if point.y >= grid.length

      # Calculate the cost
      cost = 0
      if ['.', 'S'].include?(grid[point.y][point.x])
        # If we're at start or an enpty space, go to the next cell down
        next_point = Point.new(x: point.x, y: point.y + 1)
        cost = get_path_count_from_point(point: next_point, grid: grid)
      elsif grid[point.y][point.x] == '^'
        #  If we're at a splitter, get the cost of going left...
        next_left_point = Point.new(x: point.x - 1, y: point.y)
        cost_left = get_path_count_from_point(point: next_left_point, grid: grid)

        #  and the cost of going right...
        next_right_point = Point.new(x: point.x + 1, y: point.y)
        cost_right = get_path_count_from_point(point: next_right_point, grid: grid)

        # Add the costs together
        cost = cost_left + cost_right
      end

      # cache the cost from the given point
      @params_hash[point] = cost
    end
  end
end
