class CreateVerbWithDefault < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    RenameVerb
  end
end
