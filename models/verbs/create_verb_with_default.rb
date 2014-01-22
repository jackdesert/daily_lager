class CreateVerbWithDefault < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    RenameVerb
  end

  def appropriate?
    return false unless words.length == 4
    return false unless words.first == 'create'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third == 'default'
    return false unless words.fourth.match ALL_NUMBERS
    true
  end
end
