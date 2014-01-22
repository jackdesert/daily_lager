class TodayVerb < Verb

  def process
    '3 miles entered'
    self.class
  end

  private
  def successor
    YesterdayVerb
  end

  def appropriate?
    words == ['today']
  end

end
