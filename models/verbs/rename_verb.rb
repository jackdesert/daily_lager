class RenameVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    DeleteVerb
  end
end
