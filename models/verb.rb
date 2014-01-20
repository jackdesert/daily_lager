class Verb

  attr_accessor :words

  def initialize(words)
    @words = words
  end

  def receive
    return no_thanks unless appropriate?
    process
  end

  private
  def successor
    ActionVerb
  end

  def appropriate?
    false
  end

  def respond(message)
  end

  def no_thanks
    if successor
      successor.new(words).receive
    else
      raise 'no successor found'
    end
  end
end
