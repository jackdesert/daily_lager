class Verb
  AT_LEAST_ONE_LETTER = /[a-z]/
  ALL_NUMBERS = /\A\d+$/

  attr_accessor :words

  def initialize(arg)
    @words = convert_to_array(arg)
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

  def convert_to_array(input)
    return input if input.kind_of? Array
    input.strip.gsub(/\t+/, ' ').split
  end
end
