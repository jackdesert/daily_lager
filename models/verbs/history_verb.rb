class HistoryVerb < Verb
  HISTORY_URI = 'http://history.jackdesert.com/'
  WEB_URI = 'http://jackdesert.com/messages/'

  def process
    <<EOF
history: #{HISTORY_URI}?secret=#{human.secret}
web interface: #{WEB_URI}?secret=#{human.secret}
EOF
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    return false unless words.length == 1
    ['history', 'web'].include? words.first
  end

end
