class HistoryPresenter
  SECONDS_PER_HOUR = 60 * 60
  SECONDS_PER_HALF_DAY = SECONDS_PER_HOUR * 12
  MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

  attr_reader :human

  def initialize(options)
    raise ArgumentError, 'human required' unless options[:human].is_a?(Human)
    @human = options[:human]
  end

  def aggregate_sum_by_date
    # http://sequel.jeremyevans.net/rdoc/files/doc/sql_rdoc.html
    human.things_dataset.join(:occurrences, thing_id: :id).select{ [:name, :date, sum(:value).as('sum_value')] }.group(:date, :thing_id).order(:thing_id, :date).all
  end

  def notes_array
    output = []
    notes = human.notes_dataset.order(:id)
    today = Util.current_date_in_california
    notes.each do |note|
      offset = today - note.date
      element = output[offset] || {}
      element[:date] ||= date_snippet(note.date)
      element[:bodies] ||= []
      element[:bodies] << note.body
      output[offset] = element
    end
    output.reverse!
  end

  def display_as_hash
    hash = {}
    hash[:series] = {}
    hash[:dateOfLastOccurrenceInMilliseconds] = date_of_last_occurrence_in_milliseconds
    hash[:notes] = notes_array
    aggregate_sum_by_date.each do |row|
      name = row[:name]
      hash[:series][name.to_sym] ||= []
      hash[:series][name.to_sym] << row[:sum_value]
    end
    hash
  end

  private
  def date_of_last_occurrence_in_milliseconds
    # Add half a day so that rounding errors stay within the same day
    # when converting from a timestamp to a date
    # (Note Pacific Time Zone is also adding 8 hours)
    recent_date = human.date_of_most_recent_occurrence
    return nil if recent_date.nil?
    (recent_date.to_time.to_i + SECONDS_PER_HALF_DAY) * 1000
  end

  def date_snippet(date)
    raise ArgumentError, 'Date cannot be nil' if date.nil?
    "#{date.day} #{MONTHS[date.month - 1]}"
  end

end

