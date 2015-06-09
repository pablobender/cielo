require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end
require 'cielo'
require 'fakeweb'
require 'watir-webdriver'

FakeWeb.allow_net_connect = false
