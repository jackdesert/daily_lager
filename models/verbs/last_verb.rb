class LastVerb < Verb

  def process
    thing = Thing.where(human_id: human.id, name: thing_name).first
    return "#{Thing::DISPLAY_NAME.capitalize} '#{thing_name}' does not exist." if thing.nil?

    last_occurrence = thing.occurrences_dataset.where('value != 0').order(:date).last
    if last_occurrence.nil?
      "No #{thing.name}s recorded yet."
    else
      offset = (Util.current_date_in_california - last_occurrence.date).to_i
      value = thing.total_value_for_date(last_occurrence.date)
      "#{offset} day(s) ago you logged #{value} #{thing.name}(s)"
    end
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    return false unless words.first == 'last'
    return false unless words.length == 2
    return false unless words.second.match AT_LEAST_ONE_LETTER
    true
  end

  def thing_name
    words.second
  end

end
