# frozen_string_literal: true

module Day02Task01
  def repeating_chars?(id:)
    id_str = id.to_s
    if id_str.length.odd?
      # has to be repeating chars,2N is always even
      return false
    end

    mid_point = id_str.length / 2
    left = id_str[0, mid_point]
    right = id_str[mid_point, mid_point]
    return true if left.eql?(right)

    false
  end

  def solve(data:)
    raise 'Expected a single line of input' if data.length != 1

    ranges = data[0].split(',')
    invalid_ids = []
    ranges.each do |range|
      range_parts = range.match(/(?<start>\d+)-(?<end>\d+)/)
      start_val = range_parts[:start].to_i
      end_val = range_parts[:end].to_i

      (start_val..end_val).each do |id|
        invalid_ids.push(id) if repeating_chars?(id: id)
      end
    end
    total = 0
    invalid_ids.each do |invalid_id|
      total += invalid_id
    end
    total
  end
end
