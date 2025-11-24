# frozen_string_literal: true

module Day00Task01
  def solve(data:)
    data.map(&:to_i).sum # map data to ints and sum each item, implicit return
  end
end
