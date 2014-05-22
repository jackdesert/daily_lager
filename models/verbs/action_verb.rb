class ActionVerb < Verb
  ENDS_WITH_X = /x\z/

  def process
    if thing = Thing.where(human_id: human.id, name: thing_name).first
      thing.add_occurrence(value: occurrence_value, date: effective_date)
      message = "#{ess(thing_name, occurrence_value)} logged"
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
    return true if length_two? && integer_first?
    return true if length_two? && integer_last?
    return true if appropriate_as_shortcut?
    false
  end

  def integer_first?
    mod_words.first.match INTEGER
  end

  def integer_last?
    mod_words.last.match INTEGER
  end

  def integer_last?
    mod_words.last.match INTEGER
  end

  def length_two?
    mod_words.length == 2
  end

  def length_one?
    mod_words.length == 1
  end

  def appropriate_as_shortcut?
    return false unless length_one?
    return false if RESERVED_WORDS.include? mod_words.first.to_sym
    shortcut_words.include? mod_words.first
  end

  def shortcut_words
    @shortcut_words ||= human.thing_names
  end

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
    words.first == 'y' && words.length > 1
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
    if appropriate_as_shortcut?
      mod_words.first
    elsif integer_first?
      mod_words.second
    elsif integer_last?
      mod_words.first
    end
  end

  def occurrence_value
    if appropriate_as_shortcut?
      1
    elsif integer_first?
      mod_words.first.to_i
    elsif integer_last?
      mod_words.last.to_i
    end
  end

  def ess(word, value)
    return "1 #{word}" if value == 1
    return "#{value} #{word}es" if word.match(ENDS_WITH_X)
    "#{value} #{word}s"
  end
end
