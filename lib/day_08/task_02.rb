# frozen_string_literal: true

require 'algorithms'
require_relative '../utils/point_3d'

LightString = Data.define(:from, :to)

module Day08Task02
  include Containers

  def solve(data:)
    points_list = []
    points_set = Set.new

    # Parse the data
    data.each do |line|
      co_ords = line.match(/(?<x>\d+),(?<y>\d+),(?<z>\d+)/)
      point_3d = Point3D.new(x: co_ords[:x].to_i, y: co_ords[:y].to_i, z: co_ords[:z].to_i)
      points_list.append(point_3d)
      points_set.add(point_3d)
    end

    # Calculate and sort by distance
    queue = PriorityQueue.new
    (0..(points_list.length - 1)).each do |i|
      ((i + 1)..(points_list.length - 1)).each do |j|
        from = points_list[i]
        to = points_list[j]
        distance = from.get_distance(other_point: to)
        queue.push(LightString.new(from: from, to: to), -distance)
      end
    end

    # build chains
    chains = []
    until queue.empty?
      string = queue.pop
      matching_chains = []
      chains.each do |chain|
        matching_chains.push(chain) if chain.member?(string.from) || chain.member?(string.to)
      end
      if matching_chains.empty?
        # Both points have not been seen before, add them as a new chain
        chain = Set.new
        chain.add(string.from)
        chain.add(string.to)
        points_set.delete(string.from)
        points_set.delete(string.to)
        chains.push(chain)
      end
      if matching_chains.length == 1
        # At least one of the points has been seen once before, add to the existing set
        matching_chains[0].add(string.from)
        matching_chains[0].add(string.to)
        points_set.delete(string.from)
        points_set.delete(string.to)
        if matching_chains[0].length == points_list.length
          last_pair = string
          break
        end
      end
      next unless matching_chains.length > 1

      # both points have been seen but in different sets, merge sets together
      chain = matching_chains[0]
      (1..(matching_chains.length - 1)).each do |chain_index|
        tmp_chain = matching_chains[chain_index]
        tmp_chain.each do |item|
          chain.add(item)
        end
        tmp_chain.clear
        if chain.length == points_list.length
          last_pair = string
          break
        end
      end
      break unless last_pair.nil?
    end
    last_pair.from.x * last_pair.to.x
  end
end
