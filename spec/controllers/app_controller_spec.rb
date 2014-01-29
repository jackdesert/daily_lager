# encoding: UTF-8

require 'spec_helper'
require 'rack/test'
require_relative '../../app'

def sample_params  
  {
    "AccountSid"=>"ACadd1d93921579bcdadb4d3d1e9aa9af3",
    "MessageSid"=>"SM00799c7b44c66c116d07622cb96887a6",
    "Body"=>"Hi6",
    "ToZip"=>"83647",
    "ToCity"=>"MT HOME",
    "FromState"=>"ID",
    "ToState"=>"ID",
    "SmsSid"=>"SM00799c7b44c66c116d07622cb96887a6",
    "To"=>"+12086960499",
    "ToCountry"=>"US",
    "FromCountry"=>"US",
    "SmsMessageSid"=>"SM00799c7b44c66c116d07622cb96887a6",
    "ApiVersion"=>"2010-04-01",
    "FromCity"=>"GLENNS FERRY",
    "SmsStatus"=>"received",
    "NumMedia"=>"0",
    "From"=>"+12083666059",
    "FromZip"=>"83633"
  } 
end

def browser 
  Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
end

describe '/messages' do
  it 'returns 200' do
    browser.post '/messages', sample_params
  end
end

