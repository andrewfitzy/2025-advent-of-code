module TestUtils
  def get_input(filename)
    File.readlines(filename, chomp: true)
  end
end
