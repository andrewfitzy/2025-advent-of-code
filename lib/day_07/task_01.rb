# frozen_string_literal: true

require_relative '../utils/point'

module Day07Task01
  def solve(data:)
    input_grid = data.map(&:chars)

    split_count = 0
    (1..(input_grid.length - 1)).each do |row_pointer|
      previous_row = input_grid[row_pointer - 1]
      row = input_grid[row_pointer]
      (0..(row.length - 1)).each do |cell_pointer|
        # check continue cell
        row[cell_pointer] = '|' if ['|', 'S'].include?(previous_row[cell_pointer]) && row[cell_pointer] == '.'

        # check split cell
        next unless previous_row[cell_pointer] == '|' && row[cell_pointer] == '^'

        row[cell_pointer - 1] = '|'
        row[cell_pointer + 1] = '|'
        split_count += 1
      end
    end
    split_count
  end
end
