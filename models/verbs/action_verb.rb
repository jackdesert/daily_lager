class ActionVerb < Verb

  def process 
    respond '3 miles entered'
    self.class
  end

  private
  def appropriate?
    array = words.split /\t+/
      binding.pry
    array.count == 2 && (array.first.match /\d/)
  end

  def successor
    HelpVerb
  end
end
