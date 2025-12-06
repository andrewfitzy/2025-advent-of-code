# frozen_string_literal: true

module Day05Task02
  def reduce_ranges(ranges:)
    changed = false
    # keep a list of ranges
    reduced_ranges = []
    ranges.each_with_index do |range, index|
      already_covered = false
      reduced_ranges.each do |tmp_range|
        #  if range is in the current range
        if tmp_range.include?(range.min) && tmp_range.include?(range.max)
          already_covered = true
          break
        end
      end
      next if already_covered

      min = range.min
      max = range.max

      ((index + 1)..(ranges.length - 1)).each do |index|
        tmp_range = ranges[index]

        if tmp_range.min < min && tmp_range.max > max
          min = tmp_range.min
          max = tmp_range.max
          changed = true
        end

        next unless tmp_range.include?(min) || tmp_range.include?(max)

        # range starts earlier than temp, increase min and add
        if tmp_range.min < min && tmp_range.max <= max
          min = tmp_range.min
          changed = true
          break
        end

        # range ends later than temp, increase max and add
        next unless min <= tmp_range.min && max < tmp_range.max

        max = tmp_range.max
        changed = true
        break
      end

      reduced_ranges.push(Range.new(min, max))
    end
    [changed, reduced_ranges]
  end

  def solve(data:)
    ranges = []

    data.each do |line|
      next unless line.include? '-'

      range_parts = line.match(/(?<start>\d+)-(?<end>\d+)/)
      start_val = range_parts[:start].to_i
      end_val = range_parts[:end].to_i
      ranges.push(Range.new(start_val, end_val))
    end

    # keep a list of ranges
    loop do
      changed, reduced_ranges = reduce_ranges(ranges: ranges)
      break unless changed

      ranges = reduced_ranges
    end

    # sum up the sizes of the ranges
    total = 0
    ranges.each do |range|
      total += range.size
    end

    total
  end
end
