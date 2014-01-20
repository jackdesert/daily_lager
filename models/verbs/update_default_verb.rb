class UpdateDefaultVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    NonsenseVerb
  end
end
