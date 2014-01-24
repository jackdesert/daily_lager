class UpdateDefaultVerb < Verb

  def process
    respond "#{self.class} not yet supported"
    self.class
  end

  private
  def successor
    NonsenseVerb
  end

  def appropriate? 
    return false unless words.length == 4
    return false unless words.first == 'update'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third == 'default'
    return false unless words.fourth.match ALL_NUMBERS
    true
  end
end
