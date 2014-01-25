class ListVerb < Verb

  def process
    message = 'You have the following activities active:'
    human.things_in_order.each do |thing|
      message += "\n#{thing.name}"
    end
    message
  end

  private
  def successor
    TodayVerb
  end

  def appropriate?
    words == ['list']
  end
end
