class CreateVerbWithDefault < Verb

  def process
    if Thing.where(human_id: human.id, name: proposed_thing_name).first
      "You already have a #{Thing::DISPLAY_NAME} named '#{proposed_thing_name}'"
    else
      human.add_thing(name: proposed_thing_name, 
                      default_value: proposed_thing_default_value)
      "#{Thing::DISPLAY_NAME.capitalize} '#{proposed_thing_name}' created with a default value of #{proposed_thing_default_value}."
    end
  end



  private
  def successor
    RenameVerb
  end

  def appropriate?
    return false unless words.length == 4
    return false unless words.first == 'create'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third == 'default'
    return false unless words.fourth.match ALL_NUMBERS
    true
  end

  def proposed_thing_name
    words.second
  end

  def proposed_thing_default_value
    words.fourth
  end


end
