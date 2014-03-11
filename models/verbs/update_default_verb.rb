class UpdateDefaultVerb < Verb

  def process
    if thing = Thing.where(human_id: human.id, name: name).first
      thing.update(default_value: new_default_value)
      "#{Thing::DISPLAY_NAME.capitalize} '#{name}' has new default value of #{new_default_value}"
    else
      "You do not have a #{Thing::DISPLAY_NAME} named '#{name}'. To create one, type 'CREATE #{name}' (without quotes)"
    end
  end

  private
  def successor
    NonsenseVerb
  end

  def name
    words.second
  end

  def new_default_value
    words.fourth
  end

  def appropriate? 
    return false unless words.length == 4
    return false unless words.first == 'update'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third == 'default'
    return false unless words.fourth.match INTEGER 
    true
  end
end
