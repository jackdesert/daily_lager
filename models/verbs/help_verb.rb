class HelpVerb < Verb

  def process
    no_thanks and return if unable_to_process
    if words == '3 miles'
      send('3 miles entered')
    else
      no_thanks
    end
  end

  private
  def successor
    ListVerb
  end
end
