class HistoryPresenter

  attr_reader :human

  def initialize(options)
    raise ArgumentError, 'human required' unless options[:human].is_a?(Human)
    @human = options[:human]
  end

  def aggregate_sum_by_date
    # http://sequel.jeremyevans.net/rdoc/files/doc/sql_rdoc.html
    human.things_dataset.join(:occurrences, thing_id: :id).select{ [:name, :date, sum(:value).as('sum_value')] }.group(:date, :thing_id).order(:thing_id, :date).all
  end

  def display_as_hash
    hash = {}
    aggregate_sum_by_date.each do |row|
      name = row[:name]
      hash[name] ||= []
      hash[name] << row[:sum_value]
    end
    hash
  end

end

