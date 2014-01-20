class CreateVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    CreateVerbWithDefault
  end

end
