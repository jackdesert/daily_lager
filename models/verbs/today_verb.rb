class TodayVerb < Verb

  def process
    hash = {}
    human.things.each do |thing|
      thing.occurrences.select{|f| f.date == 1}.each do |occurrence|
        hash[thing.name] ||= 0
        hash[thing.name] += occurrence.value
      end
    end
    message = "Today's totals:"
    hash.each_pair do  |name, value|
      message += "\n#{value} #{name}"
    end
    message
  end

  private
  def successor
    YesterdayVerb
  end

  def appropriate?
    words == ['today']
  end

end
