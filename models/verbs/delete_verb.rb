class DeleteVerb < Verb

  def process
    '3 miles entered'
    self.class
  end

  private
  def successor
    UpdateDefaultVerb
  end

  def appropriate?
    return false unless words.length == 2
    return false unless words.first == 'delete'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    true
  end
end
