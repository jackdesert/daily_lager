require 'sinatra'
require 'pry'
require 'sequel'
require 'json'
require 'yaml'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/object/blank'

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

  TWILIO_CONFIG_FILE      = File.expand_path('config/twilio.yml', File.dirname(__FILE__))
  TWILIO_ACCOUNT_SID_HASH = YAML.load_file(TWILIO_CONFIG_FILE)[settings.environment.to_s].try(:[], 'account_sid_hash')

  before do
    # Note this is in a different scope than the other methods in this file
    # Link: http://spin.atomicobject.com/2013/11/12/production-logging-sinatra/
    env['rack.errors'] = error_logger if settings.production?
  end

  before do
    # Angular sends data as a bonafide POST with a JSON body, so we must catch it
    # http://stackoverflow.com/questions/12131763/sinatra-controller-params-method-coming-in-empty-on-json-post-request
    if request.request_method == "POST"
      body_parameters = request.body.read
      params.merge!(JSON.parse(body_parameters))
    end
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

    if sms_phone_number = params['From']
      return error_message('invalid secret') unless from_twilio?
      human = Human.find_or_create(phone_number: sms_phone_number)
    elsif secret = params[:secret]
      human = Human.find(secret: secret)
      return error_message('please provide the correct secret') unless human
    end

    sms_body = params['Body']
    return error_message('no body') if sms_body.nil?

    responder = Verb.new(sms_body, human).responder
    limit_160_chars(responder.response)
  end

  get '/message' do
    secret = params[:secret]
    human = Human.find(secret: secret)

    return error_message('please provide the correct secret') unless human

    erb :'messages/index', locals: { human: human }
  end

  private
  def limit_160_chars(input)
    return input if (input.length < 161)
    input[0..153] + '[snip]'
  end

  def error_message(message=nil)
    output = "Oops. We've encountered an error: '#{message}'"
    limit_160_chars(output)
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

  def from_twilio?
    # Verify that this request came from Twilio by comparing the 'AccountSid' parameter
    # with the hashed version in the config file
    return true if settings.development?
    raise ArgumentError, 'TWILIO_ACCOUNT_SID_HASH not set' if TWILIO_ACCOUNT_SID_HASH.nil?

    account_sid = params['AccountSid']

    Util.sha1_match?(account_sid, TWILIO_ACCOUNT_SID_HASH)
  end
end

