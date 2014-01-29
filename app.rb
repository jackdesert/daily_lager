require 'sinatra'
require 'pry'
require 'sequel'

set :port, 8853

unless ENV['RACK_ENV'] == 'test' 
  DB_FILE = './db/development.db'
  DB = Sequel.connect("sqlite://#{DB_FILE}")
end



require_relative './models/util'
require_relative './models/human'
require_relative './models/thing'
require_relative './models/occurrence'
require_relative './models/verb'
require_relative './models/verbs/action_verb'
require_relative './models/verbs/create_verb'
require_relative './models/verbs/create_verb_with_default'
require_relative './models/verbs/delete_verb'
require_relative './models/verbs/menu_verb'
require_relative './models/verbs/list_verb'
require_relative './models/verbs/nonsense_verb'
require_relative './models/verbs/rename_verb'
require_relative './models/verbs/today_verb'
require_relative './models/verbs/update_default_verb'
require_relative './models/verbs/yesterday_verb'

post '/messages' do
  binding.pry
  'hi there'
end
#get '/' do
#  prepend = "<h1>Existing Searches</h1>
#  <ul>"
#  postpend = "</ul>
#  <a href='/new'>New</a>"
#  output = []
#  Search.all.each do |search|
#    output << "<li>#{search.query_string}</li>"
#  end
#  prepend + output.join("\n") + postpend
#end
#
#get '/new' do
#  "<h1>Add a search</h1>
#  <ol>
#    <li>Go to http://craigslist.org and search for
#     whatever it is you are interested in.</li>
#     <li>Copy the url from the browser and paste it in here:</li>
#  <form id='new_search' action='catch' method='post'>
#    <label for='query_string'>URL:</label>
#    <input type='text' id='query_string' name='search[query_string]' />
#    <input type='submit' value='Add'>
#  </form>
#  <a href='/'>Top</a>"
#end
#
#post '/catch' do
#  search = Search.new(query_string: params['search']['query_string'])
#  if search.valid?
#    search.populate_search_results
#    search.save
#    redirect '/'
#  else
#    redirect '/new'
#  end
#end
