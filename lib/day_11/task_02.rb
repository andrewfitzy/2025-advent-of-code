# frozen_string_literal: true

require_relative '../utils/point'

module Day11Task02
  OUT = 'out'
  SVR = 'svr'
  DAC = 'dac'
  FFT = 'fft'

  def solve(data:)
    # The approach for this is inspired by HyperNeutrino (https://www.youtube.com/watch?v=tmrO29pe57I&t=366s),
    # I tried several approaches to memoized DFS and tried brute forcing but the result is just too huge to
    # try and determine without some kind of maths.
    device_list = {}

    data.each do |line|
      parts = line.split
      device = parts[0].sub(':', '')
      outputs = (1..(parts.length - 1)).map { |i| parts[i] }
      device_list[device] = outputs
    end

    # Break the paths down so that we're not doing SVR -> OUT for everything, find parts and multiply
    svr_fft = get_paths_between_devices(from_device: SVR, to_device: FFT, device_list: device_list)
    fft_dac = get_paths_between_devices(from_device: FFT, to_device: DAC, device_list: device_list)
    dac_out = get_paths_between_devices(from_device: DAC, to_device: OUT, device_list: device_list)

    svr_dac = get_paths_between_devices(from_device: SVR, to_device: DAC, device_list: device_list)
    dac_fft = get_paths_between_devices(from_device: DAC, to_device: FFT, device_list: device_list)
    fft_out = get_paths_between_devices(from_device: FFT, to_device: OUT, device_list: device_list)

    (svr_fft * fft_dac * dac_out) + (svr_dac * dac_fft * fft_out)
  end

  def get_paths_between_devices(from_device:, to_device:, device_list:)
    # Set up our hash for Memoization, For more details see:
    # https://blog.appsignal.com/2022/12/20/a-guide-to-memoization-in-ruby.html
    #
    # In this case, using the from and to concatenated as the hash key
    key = from_device + to_device
    @params_hash ||= {}
    if @params_hash.key?(key)
      # We've seen the input before, return the cached cost
      @params_hash[key]
    else
      return 1 if from_device == to_device

      # Calculate the cost
      cost = 0
      next_locations = device_list.key?(from_device) ? device_list[from_device] : []
      next_locations.each do |next_location|
        cost += get_paths_between_devices(from_device: next_location, to_device: to_device, device_list: device_list)
      end
      @params_hash[key] = cost
    end
  end
end
