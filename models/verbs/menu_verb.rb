class MenuVerb < Verb

  private
  def appropriate?
    words == ['menu']
  end

  def process
    "Available commands:\nMENU\nLIST\nTODAY\nYESTERDAY\nCREATE <#{Thing::DISPLAY_NAME}> [DEFAULT <number>]\nRENAME <#{Thing::DISPLAY_NAME}> <new_name>\nDELETE <#{Thing::DISPLAY_NAME}>\n\nFull docs: http://to_be_determined"
  end

  def successor
    ListVerb
  end
end
