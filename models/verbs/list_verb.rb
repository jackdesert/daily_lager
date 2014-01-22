class ListVerb < Verb

  def process
    '3 miles entered'
    successor
  end

  private
  def successor
    TodayVerb
  end

  def appropriate?
    words == ['list']
  end
end
