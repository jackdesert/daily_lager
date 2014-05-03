class NoteVerb < Verb

  def process
    if words.length < 2
      return 'Please include words in your note.'
    end
    unless body.match AT_LEAST_ONE_LETTER
      return 'must have at leat one letter'
    end

    human.add_note(body: body)
    "Noted: '#{body}'"
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    return false unless words.first == 'note'
    true
  end

  def body
    words.join(' ').sub(/\Anote /, '')
  end
end
