# frozen_string_literal: true

Piece = Data.define(:shape, :size)

module Day12Task01
  def solve(data:)
    pieces = {}
    play_spaces = []

    piece_number = 0
    buffer = []
    data.each do |line|
      if line.match?(/(?<x>\d+)x(?<y>\d+):(?<counts>\s+\d?)?/)
        play_spaces.append(line)
        next
      end
      if line.match?(/(?<id>\d+):/)
        matches = line.match(/(?<id>\d+):/)
        piece_number = matches[:id].to_i
        next
      end
      if line.strip == ''
        area_used = 0
        buffer.each do |shape_row|
          shape_row.each do |shape_cell|
            area_used += 1 if shape_cell == '#'
          end
        end
        piece = Piece.new(shape: buffer, size: area_used)
        pieces[piece_number] = piece
        buffer = []
        next
      end
      buffer.append(line.chars)
    end

    # Check the piece area fits, can discount ones that don't.
    # i.e., if the grid is 4x4 but we have 2 pieces of 7 squares each they ain't fitting
    valid_rows = []
    play_spaces.each do |space|
      parts = space.split

      pieces_in_space = 0
      (1..(pieces.length - 1)).each do |index|
        number_of_pieces = parts[index].to_i
        pieces_in_space += number_of_pieces
      end

      dimensions = space.match(/(?<width>\d+)x(?<height>\d+):/)
      area_width = dimensions[:width].to_i
      area_height = dimensions[:height].to_i

      # each piece is 3x3, see how many we can get in a row
      pieces_in_row = area_width / 3
      pieces_in_col = area_height / 3

      max_unjoined_pieces = pieces_in_row * pieces_in_col

      next if pieces_in_space > max_unjoined_pieces

      valid_rows.append(space)
    end
    valid_rows.length
  end
end
