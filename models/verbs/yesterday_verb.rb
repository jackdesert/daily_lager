class YesterdayVerb < Verb

  def process
    yesterday = Util.current_date_in_california - 1
    totals = Thing.totals_for_human_on_date(human, yesterday)
    if Util.hash_has_nonzero_value(totals)
      message = "Yesterday's totals:"
      totals.each_pair do  |name, value|
        message += "\n#{name.capitalize}: #{value}"
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
