class ActionVerb < Verb

  def process 
    respond '3 miles entered'
    self.class
  end

  private
  def appropriate?
    return false unless words.first.match /\A\d+$/
    return false unless words.length == 2
    true
  end

  def successor
    HelpVerb
  end
end
