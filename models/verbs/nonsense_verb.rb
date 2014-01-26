class NonsenseVerb < Verb

  def process
    "Command '#{words.join(' ')}' not understood. Type 'menu' (without quotes) for a list of available commands."
  end

  private
  def successor
    false
  end

  def appropriate?
    true
  end
end

 
