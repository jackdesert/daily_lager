class CreateVerb < Verb

  def process
    if Thing.where(human_id: human.id, name: proposed_thing_name).first
      "You already have a #{Thing::DISPLAY_NAME} named '#{proposed_thing_name}'"
    else
      new_thing = human.add_thing(name: proposed_thing_name)
      new_thing.create_todays_default_occurrence
      "#{Thing::DISPLAY_NAME.capitalize} '#{proposed_thing_name}' created."
    end
  end

  private
  def successor
    CreateVerbWithDefault
  end

  def appropriate?
    return false unless words.first == 'create'
    return false unless words.length == 2
    return false unless words.second.match AT_LEAST_ONE_LETTER
    true
  end

  def proposed_thing_name
    words.second
  end

end
