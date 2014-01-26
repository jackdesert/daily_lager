require 'sinatra'
# The web dev part is TBD
#require 'mongoid'
#
#Mongoid.load!("config/mongoid.yml")
#require './models/search_result'
#require './models/search'
#require 'pry'
#
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
