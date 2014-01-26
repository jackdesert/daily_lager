class MenuVerb < Verb

  private
  def appropriate?
    words == ['menu']
  end

  def process
    "Available commands:\nMENU\nLIST\nTODAY\nYESTERDAY\nCREATE <thing> [DEFAULT <number>]\nRENAME <thing_name> <new_name>\nDELETE <thing>\n\nFull docs: http://to_be_determined"
  end

  def successor
    ListVerb
  end
end
