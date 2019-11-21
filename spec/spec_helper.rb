RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)

require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')].each(&method(:require))

require 'simplecov'

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '..'))
  coverage_dir 'reports/coverage'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/admin/'
  add_filter '/db/'
  add_filter '/config/'
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara
  OrderRepository.new.delete_all
  ClientRepository.new.delete_all
  DeliveryRepository.new.delete_all
  UserRepository.new.delete_all
end

def app
  DeliveryApi::App.tap { |app| }
  DeliveryApi::App.set :protect_from_csrf, false
end
