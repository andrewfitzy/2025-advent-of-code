module Day00Task02
  def solve(data)
    data.map(&:to_i).reduce(1, :*) # map data to ints and multiply by each item, implicit return
  end
end
