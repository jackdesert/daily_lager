class NonsenseVerb < Verb

  def process
    respond "Command '#{words.join(' ')}' not understood. Type 'help' (without quotes) for help."
    self.class
  end

  private
  def successor
    false
  end

  def appropriate?
    true
  end
end

 
