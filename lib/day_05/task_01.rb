# frozen_string_literal: true

module Day05Task01
  def solve(data:)
    ranges = []
    inputs = []

    data.each do |line|
      next if line.empty?

      if line.include? '-'
        range_parts = line.match(/(?<start>\d+)-(?<end>\d+)/)
        start_val = range_parts[:start].to_i
        end_val = range_parts[:end].to_i
        # range is good, inclusive at the end by default
        ranges.push(Range.new(start_val, end_val))
        next
      end
      inputs.push(line.to_i)
    end

    # now work out what is fresh
    fresh_ingredient_counter = 0
    inputs.each do |ingredient|
      ranges.each do |ingredient_range|
        if ingredient_range.include? ingredient
          fresh_ingredient_counter += 1
          break
        end
      end
    end
    fresh_ingredient_counter
  end
end
