class HelpVerb < Verb

  private
  def appropriate?
    words == ['help']
  end

  def process
    "Available commands:\nHELP\nLIST\nTODAY\nYESTERDAY\nCREATE <thing> [DEFAULT <number>]\nRENAME <thing_name> <new_name>\nDELETE <thing>\n\nFull docs: http://sm.sunni.ru/docs"
  end

  def successor
    ListVerb
  end
end
