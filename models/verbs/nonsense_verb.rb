class NonsenseVerb < Verb

  def process
    "Command '#{words.join(' ')}' not understood. Type 'help' (without quotes) for help."
  end

  private
  def successor
    false
  end

  def appropriate?
    true
  end
end

 
