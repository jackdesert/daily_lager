class TodayVerb < Verb

  def process
    hash = {}
    human.things.each do |thing|
      thing.occurrences.select{|f| f.date == Time.now.to_date}.each do |occurrence|
        hash[thing.name] ||= 0
        hash[thing.name] += occurrence.value
      end
    end
    if Util.hash_has_nonzero_value(hash)
      message = "Today's totals:"
      hash.each_pair do  |name, value|
        message += "\n#{value} #{name}"
      end
    else
      message = 'You have not logged anything today.'
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
