class RenameVerb < Verb

  def process
    if thing = Thing.where(human_id: human.id, name: old_name).first
      thing.update(name: new_name)
      "#{Thing::DISPLAY_NAME.capitalize} '#{old_name}' updated to '#{new_name}'.\nTo use, type '6 #{new_name}' without quotes."
    else
      "You do not have a #{Thing::DISPLAY_NAME} named '#{old_name}'. To create one, type 'CREATE #{old_name}' (without quotes)"
    end
  end

  private
  def successor
    DeleteVerb
  end

  def old_name
    words.second
  end

  def new_name
    words.third
  end

  def appropriate?
    return false unless words.length == 3
    return false unless words.first == 'rename'
    return false unless words.second.match AT_LEAST_ONE_LETTER
    return false unless words.third.match AT_LEAST_ONE_LETTER
    true
  end
end
