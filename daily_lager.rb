require 'sinatra'
require 'pry'
require 'sequel'

set :port, 8853

# Bind to 0.0.0.0 even in development mode for access from VM
set :bind, '0.0.0.0'


env = ENV['RACK_ENV'] || 'development'
unless env == 'test'
  DB_FILE = "./db/#{env}.db"
  DB = Sequel.connect("sqlite://#{DB_FILE}")
end

# Make sure newer version of sqlite3 is used, so that HAVE_USLEEP was configured during build
if SQLite3.libversion.to_s < "3008002"
  raise 'sqlite3 must be later than 3.8.0 to ensure HAVE_USLEEP was enabled during build'
end


require 'json'
require './models/util'
require './models/human'
require './models/note'
require './models/thing'
require './models/occurrence'
require './models/verb'
require './models/verbs/action_verb'
require './models/verbs/create_verb'
require './models/verbs/history_verb'
require './models/verbs/create_verb_with_default'
require './models/verbs/delete_verb'
require './models/verbs/menu_verb'
require './models/verbs/last_verb'
require './models/verbs/list_verb'
require './models/verbs/nonsense_verb'
require './models/verbs/note_verb'
require './models/verbs/rename_verb'
require './models/verbs/today_verb'
require './models/verbs/update_default_verb'
require './models/verbs/yesterday_verb'
require './presenters/history_presenter'

get '/' do
  html = File.read(File.join('views', 'history', 'index.html'))
  human = Human.find(secret: params[:secret])
  status 404 and return unless human
  presenter = HistoryPresenter.new(human: human)
  data = presenter.display_as_hash.to_json
  html.sub('DATA_FROM_CONTROLLER', data)
end

post '/messages' do
  content_type 'text/plain'
  sms_body = params['Body']
  sms_phone_number = params['From']
  human = Human.find_or_create(phone_number: sms_phone_number)
  return error_message unless human
  return error_message if sms_body.nil?
  responder = Verb.new(sms_body, human).responder
  limit_160_chars(responder.response)
end

private
def limit_160_chars(input)
  return input if (input.length < 161)
  input[0..153] + '[snip]'
end

def error_message
  "Oops. We've encountered an error :("
end

