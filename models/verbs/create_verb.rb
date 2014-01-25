class CreateVerb < Verb

  def process
    if human.things.any? { |f| f.name == proposed_thing_name }
      "You already have a thing called '#{proposed_thing_name}'"
    else
      human.things << Thing.create_with_name(proposed_thing_name)
      "Thing '#{proposed_thing_name}' created"
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
