require 'net/http'
require 'pry'

class Agent 

  #DEFAULT_URI = 'http://localhost:4567/messages'
  LOCAL_URI = 'http://localhost:4567/messages'
  REMOTE_URI = 'http://sms.jackdesert.com/messages'
  attr_reader :uri
  attr_accessor :body

  def initialize(body='help')
    @body = body 
    @uri = URI(REMOTE_URI)
  end

  def post(override_text=nil)
    res = Net::HTTP.post_form(uri, Body: override_text || body)
    res.body
  end

  def uri=(input)
    @uri = URI(input)
  end

  def local
    @uri = URI(LOCAL_URI)
  end

  def remote
    @uri = URI(RACKSPACE_URI)
  end
end

a = Agent.new
binding.pry
