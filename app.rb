require 'sinatra'
require 'pry'
require 'sequel'

set :port, 8853

unless ENV['RACK_ENV'] == 'test' 
  DB_FILE = './db/development.db'
  DB = Sequel.connect("sqlite://#{DB_FILE}")
end



require './models/util'
require './models/human'
require './models/thing'
require './models/occurrence'
require './models/verb'
require './models/verbs/action_verb'
require './models/verbs/create_verb'
require './models/verbs/create_verb_with_default'
require './models/verbs/delete_verb'
require './models/verbs/menu_verb'
require './models/verbs/list_verb'
require './models/verbs/nonsense_verb'
require './models/verbs/rename_verb'
require './models/verbs/today_verb'
require './models/verbs/update_default_verb'
require './models/verbs/yesterday_verb'

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
