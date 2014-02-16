class MenuVerb < Verb

  private
  def appropriate?
    ['menu', 'help'].include? words.first
  end

  def process
    "Available commands:\nMENU\nLIST\nTODAY\nYESTERDAY\nCREATE <#{Thing::DISPLAY_NAME}> [DEFAULT <number>]\nRENAME <#{Thing::DISPLAY_NAME}> <new_name>\nDELETE <#{Thing::DISPLAY_NAME}>\n[Y] <number> <#{Thing::DISPLAY_NAME}>"
  end

  def successor
    ListVerb
  end
end
