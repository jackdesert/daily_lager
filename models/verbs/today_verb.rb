class TodayVerb < Verb

  def process
    totals = Thing.totals_for_human_on_date(human, Util.current_date_in_california)
    if Util.hash_has_nonzero_value(totals)
      message = "Today's totals:"
      totals.each_pair do  |name, value|
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
