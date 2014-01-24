class ActionVerb < Verb

  def process 
    if thing = human.things.select{ |f| f.name == thing_name }.first
      thing.occurrences << Occurrence.new(date: 1, value: occurrence_value)
      respond "#{occurrence_value} #{thing_name}(s) logged"
    else
      respond "You do not have a Thing named '#{thing_name}'. To create one, type 'create #{thing_name}' (without quotes)."
    end
    self.class
  end

  private
  def appropriate?
    return false unless words.first.match ALL_NUMBERS
    return false unless words.length == 2
    true
  end

  def successor
    HelpVerb
  end

  def thing_name
    words.second
  end

  def occurrence_value
    words.first.to_i
  end
end
