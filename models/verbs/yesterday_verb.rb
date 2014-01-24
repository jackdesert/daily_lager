class YesterdayVerb < Verb

  def process
    hash = {}
    human.things.each do |thing|
      thing.occurrences.select{|f| f.date == 2}.each do |occurrence|
        hash[thing.name] ||= 0
        hash[thing.name] += occurrence.value
      end
    end
    message = "Yesterday's totals:"
    hash.each_pair do  |name, value|
      message += "\n#{value} #{name}"
    end
    respond message

    self.class
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    words == ['yesterday']
  end
end
