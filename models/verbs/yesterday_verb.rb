class YesterdayVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    CreateVerb
  end
end
