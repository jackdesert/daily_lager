ENV['RACK_ENV'] = 'test'

require 'sinatra'
require 'pry'
require 'rspec'
require 'rr'
require_relative '../models/verb'
require_relative '../models/human'
require_relative '../models/thing'
require_relative '../models/occurrence'
require_relative '../models/verbs/action_verb'
require_relative '../models/verbs/create_verb'
require_relative '../models/verbs/create_verb_with_default'
require_relative '../models/verbs/delete_verb'
require_relative '../models/verbs/help_verb'
require_relative '../models/verbs/list_verb'
require_relative '../models/verbs/nonsense_verb'
require_relative '../models/verbs/rename_verb'
require_relative '../models/verbs/today_verb'
require_relative '../models/verbs/update_default_verb'
require_relative '../models/verbs/yesterday_verb'
require_relative './support/helper_methods'


require 'mongoid'
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
