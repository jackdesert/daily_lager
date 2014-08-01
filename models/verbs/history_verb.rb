class HistoryVerb < Verb
  WEB_URI = 'http://history.jackdesert.com/'

  def process
    "#{WEB_URI}?secret=#{human.secret}"
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    words == ['history']
  end
end
