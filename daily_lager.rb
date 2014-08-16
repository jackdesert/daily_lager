require 'sinatra'
require 'pry'
require 'sequel'
require 'json'

# Note you must connect to Sequel before requiring any models that inherit from Sequel::Model
unless settings.test?
  DB_FILE = "./db/#{settings.environment}.db"
  DB = Sequel.connect("sqlite://#{DB_FILE}")
end

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


set :port, 8853
set :raise_errors, true

# Bind to 0.0.0.0 even in development mode for access from VM
set :bind, '0.0.0.0'

# Make sure newer version of sqlite3 is used, so that HAVE_USLEEP was configured during build
if settings.production? && (SQLite3.libversion.to_s < "3008002")
  raise 'sqlite3 must be later than 3.8.0 to ensure HAVE_USLEEP was enabled during build'
end

class DailyLager < Sinatra::Base

  LOG_FILE = settings.root + "/log/#{settings.environment}.log"
  error_logger = File.new(LOG_FILE, 'a')
  error_logger.sync = true

  before do
    # Note this is in a different scope than the other methods in this file
    # Link: http://spin.atomicobject.com/2013/11/12/production-logging-sinatra/
    env['rack.errors'] = error_logger if settings.production?
  end

  get '/' do
    html = File.read(File.join('views', 'history', 'index.html'))
    human = Human.find(secret: params[:secret])

    unless human
      log "404---Human not found. params: #{params}"
      halt 404, '404 Not Found---Did you type the correct secret?'
    end

    presenter = HistoryPresenter.new(human: human)
    data = presenter.display_as_hash.to_json
    html.sub('DATA_FROM_CONTROLLER', data)
  end

  post '/messages' do
    log_params
    content_type 'text/plain'
    sms_body = params['Body']
    sms_phone_number = params['From']
    human = Human.find_or_create(phone_number: sms_phone_number)
    return error_message unless human
    return error_message if sms_body.nil?
    responder = Verb.new(sms_body, human).responder
    limit_160_chars(responder.response)
  end

  get '/message' do
    File.read(File.join('views', 'messages', 'index.html'))
  end

  private
  def limit_160_chars(input)
    return input if (input.length < 161)
    input[0..153] + '[snip]'
  end

  def error_message
    "Oops. We've encountered an error :("
  end

  def log(text)
    text = "#{text}\n"
    # In development mode, this will be written to STDOUT
    # In prouction mode, this writes to LOG_FILE
    env['rack.errors'].write(text)
  end

  def log_params
    hash = { Body: params[:Body],
             From: params[:From]}
    log("params: #{hash}")
  end
end

