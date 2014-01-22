class HelpVerb < Verb

  private
  def appropriate?
    words == ['help']
  end

  def process
    return no_thanks unless appropriate?
    respond 'lotsa help'
    self.class
  end

  def successor
    ListVerb
  end
end
