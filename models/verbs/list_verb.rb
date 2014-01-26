class ListVerb < Verb

  def process
    if human.things.present?
      message = 'You have created the following categories:'
      human.things_in_order.each do |thing|
        message += "\n#{thing.name}"
      end
    else
      message = "No categories active. To add one, type CREATE <category>"
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
