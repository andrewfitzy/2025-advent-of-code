# frozen_string_literal: true

require_relative '../utils/point'

module Day04Task01
  def solve(data:)
    input_grid = data.map(&:chars)
    height = input_grid.length
    width = input_grid.length

    movable_rolls = Set.new
    (0..(height - 1)).each do |y|
      (0..(width - 1)).each do |x|
        current_location = Point.new(x: x, y: y)
        next if input_grid[current_location.y][current_location.x] != '@'

        number_of_moves = get_available_moves(location: current_location, grid: input_grid)

        movable_rolls.add(current_location) if number_of_moves.length < 4
      end
    end
    movable_rolls.each do |roll|
      input_grid[roll.y][roll.x] = 'X'
    end
    movable_rolls.length
  end

  def get_available_moves(location:, grid:)
    rows = grid.length
    cols = grid[0].length

    available_moves = []

    # Movement Deltas (Up, Up-Right, Right, Down-Right, Down, Down-Left, Left, Up-Left)
    movements = [[0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1]]

    movements.each do |dx, dy|
      next_x = location.x + dx
      next_y = location.y + dy

      is_in_bounds = next_y >= 0 && next_y < rows && next_x >= 0 && next_x < cols
      if is_in_bounds && grid[next_y][next_x] == '@'
        next_point = Point.new(x: next_x, y: next_y)
        available_moves.push(next_point)
      end
    end
    available_moves
  end
end
