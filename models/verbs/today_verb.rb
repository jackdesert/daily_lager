class TodayVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    YesterdayVerb
  end

  def appropriate?
    words == ['today']
  end

end
