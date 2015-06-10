require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'webmock'
require 'watir-webdriver'
require 'cielo'

# inhibits real network connections and fail on unstubed requests
WebMock.disable_net_connect!

RSpec.configure do |config|
  config.include WebMock::API
end