class Verb

  attr_accessor :words

  def initialize(words)
    words = words
  end

  def receive(words)
    no_thanks(words)
  end

  private
  def successor
    ActionVerb
  end


  def no_thanks(words)
    if successor
      successor.new(words).receive
    else
      raise 'no successor found'
    end
  end
end
