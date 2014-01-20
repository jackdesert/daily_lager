ENV['RACK_ENV'] = 'test'

require 'sinatra'
require 'pry'
require 'rspec'
require 'rr'
require_relative '../models/search'
require_relative '../models/search_result'

Mongoid.load!("config/mongoid.yml")

RSpec.configure do |config|
  config.mock_with :rr

  # Allow running one test at a time
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true



end

def expect_error_on(thing, attribute, reverse=nil)
  thing.valid?
  it = thing.errors.messages[attribute]
  if reverse
    it.should be_nil
  else
    it.should_not be_nil
  end

end

def expect_no_errors_on(thing, attribute)
  expect_error_on(thing, attribute, true)
end
