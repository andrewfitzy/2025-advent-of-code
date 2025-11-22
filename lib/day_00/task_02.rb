require_relative '../utils/point'

module Day00Task02
  def solve(data:)
    input_grid = data.map(&:chars)

    start_point = Point.new(x: 0, y: 0)

    target = '0'

    shortest_path = find_shortest_path(start_point: start_point, input_grid: input_grid, target: target)

    return if shortest_path.nil?

    shortest_path.length
  end

  def find_shortest_path(start_point:, input_grid:, target:)
    # Queue stores [point, path_array]
    queue = []
    visited = Set.new

    queue.push([start_point, [start_point]])

    until queue.empty?
      location, path = queue.shift
      visited.add(location)
      return path if input_grid[location.y][location.x] == target

      next_locations = get_available_moves(location: location, grid: input_grid)
      next_locations.each do |next_location|
        next if visited.member?(next_location)

        new_path = path + [next_location]
        queue.push([next_location, new_path])
      end

    end
    nil
  end

  def get_available_moves(location:, grid:)
    # get outer bounds first, 0 to these values.
    rows = grid.length
    cols = grid[0].length

    available_moves = []

    # Movement Deltas (Up, Down, Left, Right)
    movements = [[0, -1], [0, 1], [-1, 0], [1, 0]]

    movements.each do |dx, dy|
      next_x = location.x + dx
      next_y = location.y + dy
      is_in_bounds = next_y >= 0 && next_y < rows && next_x >= 0 && next_x < cols
      if is_in_bounds
        next_point = Point.new(x: next_x, y: next_y)
        available_moves.push(next_point)
      end
    end
    available_moves
  end
end
