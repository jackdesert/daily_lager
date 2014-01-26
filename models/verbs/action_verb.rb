class ActionVerb < Verb

  def process 
    if thing = human.things.select{ |f| f.name == thing_name }.first
      thing.occurrences << Occurrence.new(value: occurrence_value)
      message = "#{occurrence_value} #{thing_name}(s) logged."
      total = thing.total_value_today
      message += " Today's total: #{total}" if total > occurrence_value
    else
      message = "You do not have a #{Thing::DISPLAY_NAME} named '#{thing_name}'. To create one, type 'CREATE #{thing_name}' (without quotes)."
    end
    message
  end

  private
  def appropriate?
    return false unless words.first.match ALL_NUMBERS
    return false unless words.length == 2
    true
  end

  def successor
    MenuVerb
  end

  def thing_name
    words.second
  end

  def occurrence_value
    words.first.to_i
  end
end
