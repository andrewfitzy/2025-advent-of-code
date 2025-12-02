# frozen_string_literal: true

require_relative '../utils/point'

module Day02Task02
  def repeating_chars?(id:)
    id_str = id.to_s

    (1..id_str.length).each do |length|
      # 1. check that the length of the substring fits into the overall string when repeated.
      next if id_str.length % length != 0

      # 2. check that the length of the string is at least twice the lenth of the subscring length
      next unless id_str.length / length > 1

      # 3. now check for repetition
      check_string = id_str[0, length]
      a_regex = /\A(#{check_string})+\z/
      matches = id_str.match(a_regex)
      return true if matches
    end
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
