$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cran'
require 'webmock/rspec'
require "pry"
WebMock.disable_net_connect!(allow_localhost: true)
