require 'net/http'
require 'pry'

class Agent 

  DEFAULT_URI = 'http://localhost:4567/messages'
  attr_reader :uri
  attr_accessor :params

  def initialize(params={})
    @params = params
    @uri = URI(DEFAULT_URI)
  end

  def post
    res = Net::HTTP.post_form(uri, 'q' => ['ruby', 'perl'], 'max' => '50')
    res.body
  end

  def uri=(input)
    @uri = URI(input)
  end
end

a = Agent.new
binding.pry
