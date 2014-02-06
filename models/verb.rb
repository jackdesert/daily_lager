require 'active_support/core_ext/array/access'

class Verb
  AT_LEAST_ONE_LETTER = /[a-z]/
  INTEGER = /\A-?\d+$/

  attr_reader :words, :human

  def initialize(string_or_array, human)
    @words = convert_to_array(string_or_array)
    @human = human
  end

  def responder
    return some_other_verb unless appropriate?
    self
  end

  def response
    return @response if @response
    backfill
    @response = process
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

  def backfill
    human.backfill
  end

  def some_other_verb 
    if successor
      successor.new(words, human).responder
    else
      raise 'no successor found'
    end
  end

  def convert_to_array(input)
    return input if input.kind_of? Array
    return [input] if input.blank?
    input.downcase.strip.gsub(/\t+/, ' ').split
  end
end
