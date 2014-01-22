class NonsenseVerb < Verb

  def process
    ''
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

 
