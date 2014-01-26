class YesterdayVerb < Verb

  def process
    hash = {}
    human.things.each do |thing|
      thing.occurrences.select{|f| f.date == (Time.now.to_date - 1)}.each do |occurrence|
        hash[thing.name] ||= 0
        hash[thing.name] += occurrence.value
      end
    end

    if Util.hash_has_nonzero_value(hash)
      message = "Yesterday's totals:"
      hash.each_pair do  |name, value|
        message += "\n#{value} #{name}"
      end
    else
      message = 'You did not log anything yesterday.'
    end
    message
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    words == ['yesterday']
  end
end
