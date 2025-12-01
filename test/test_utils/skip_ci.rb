# frozen_string_literal: true

require 'minitest/autorun'

module CiSkipper
  def skip_on_ci
    skip 'Skipped due to running in CI environment' if ENV['CI']
  end
end

# Inject the module into Minitest
Minitest::Test.include CiSkipper
