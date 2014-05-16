class ActionVerb < Verb

  def process
    if thing = Thing.where(human_id: human.id, name: thing_name).first
      thing.add_occurrence(value: occurrence_value, date: effective_date)
      message = "#{occurrence_value} #{thing_name}(s) logged"
      message += ' for yesterday' if for_yesterday?
      message += '.'
      total = thing.total_value_for_date(effective_date)
      day_string = for_yesterday? ? 'Yesterday' : 'Today'
      message += " #{day_string}'s total: #{total}" if total != occurrence_value
    else
      message = "You do not have a #{Thing::DISPLAY_NAME} named '#{thing_name}'. To create one, type 'CREATE #{thing_name}' (without quotes)."
    end
    message
  end

  private
  def appropriate?
    return false unless mod_words.first.match INTEGER
    return false unless mod_words.length == 2
    true
  end

  def appropriate_as_single_word_action?
    return false unless mod_words.length == 1
    return false if RESERVED_WORDS.include? mod_words.first.to_sym

  def successor
    MenuVerb
  end

  def mod_words
    if for_yesterday?
      words[1..-1]
    else
      words
    end
  end

  def for_yesterday?
    words.first == 'y'
  end

  def effective_date
    today = Util.current_date_in_california
    if for_yesterday?
      today - 1
    else
      today
    end
  end


  def thing_name
    mod_words.second
  end

  def occurrence_value
    mod_words.first.to_i
  end
end
