require 'net/http'
require 'pry'

class Agent 

  #DEFAULT_URI = 'http://localhost:4567/messages'
  LOCAL_URI = 'http://localhost:8853/messages'
  REMOTE_URI = 'http://sms.jackdesert.com/messages'
  attr_reader :uri
  attr_accessor :body, :phone

  def initialize(body='help')
    @body = body 
    @uri = URI(REMOTE_URI)
  end

  def post(override_text=nil)
    res = Net::HTTP.post_form(uri, From: phone || dummy_phone, Body: override_text || body)
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

  def dummy_phone
    '+19998887777'
  end

end

a = Agent.new
binding.pry
