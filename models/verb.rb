require 'active_support/core_ext/array/access'

class Verb
  AT_LEAST_ONE_LETTER = /[a-z]/
  ALL_NUMBERS = /\A\d+$/

  attr_accessor :words, :human

  def initialize(string_or_array, human)
    @words = convert_to_array(string_or_array)
    @human = human
  end

  def receive
    return no_thanks unless appropriate?
    process
  end

  def process
    raise 'Verb#process called, when expected to be called on a subclass'
  end

  private
  def successor
    ActionVerb
  end

  def appropriate?
    false
  end

  def respond(message)
    puts message
  end

  def no_thanks
    if successor
      successor.new(words, human).receive
    else
      raise 'no successor found'
    end
  end

  def convert_to_array(input)
    return input if input.kind_of? Array
    input.strip.gsub(/\t+/, ' ').split
  end
end
