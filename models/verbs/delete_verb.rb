class DeleteVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    UpdateDefaultVerb
  end
end
