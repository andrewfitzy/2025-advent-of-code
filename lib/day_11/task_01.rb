# frozen_string_literal: true

module Day11Task01
  def solve(data:)
    # aaa: you hhh
    # you: bbb ccc
    # bbb: ddd eee
    # ccc: ddd eee fff
    # ddd: ggg
    # eee: out
    # fff: out
    # ggg: out
    # hhh: ccc fff iii
    # iii: out

    device_list = {}

    data.each do |line|
      parts = line.split
      device = parts[0].sub(':', '')
      outputs = (1..(parts.length - 1)).map { |i| parts[i] }
      device_list[device] = outputs
    end
    device_list.length # return map size for now
  end
end
