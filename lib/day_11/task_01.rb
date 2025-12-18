# frozen_string_literal: true

module Day11Task01
  OUT = 'out'
  YOU = 'you'

  def solve(data:)
    device_list = {}

    data.each do |line|
      parts = line.split
      device = parts[0].sub(':', '')
      outputs = (1..(parts.length - 1)).map { |i| parts[i] }
      device_list[device] = outputs
    end
    paths = find_paths(device_list: device_list)
    paths.length
  end

  def find_paths(device_list:)
    queue = []

    queue.push([YOU, [YOU]])

    e2e_paths = []
    until queue.empty?
      location, path = queue.shift
      if location == OUT
        e2e_paths.append(path)
        next
      end

      next_locations = device_list[location]
      next_locations.each do |next_location|
        new_path = path + [next_location]
        queue.push([next_location, new_path])
      end
    end
    e2e_paths
  end
end
