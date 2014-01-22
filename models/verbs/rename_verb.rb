class RenameVerb < Verb

  def process
    '3 miles entered'
    self.class
  end

  private
  def successor
    DeleteVerb
  end

  def appropriate?
    return false unless words.length == 3
    return false unless words.first == 'rename'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third.match AT_LEAST_ONE_LETTER
    true
  end
end
