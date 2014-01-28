# Note that Sequel gets the plural of human wrong, so must specify the table name here
class Human < Sequel::Model(:humans)

#  attr_accessor :phone_number, :things

  one_to_many :things

#  def initialize(hash={})
#    hash.each_pair do |key, value|
#      self.send("#{key}=", value)
#    end
#    @things ||= []
#    def @things.find_by_name(name)
#      self.select {|f| f.name == name}.first
#    end
#  end

  def valid?
    if phone_number.match /\A\d{10}\Z/
      true
    else
      false
    end
  end

  def things_in_order
    things.sort do |x,y|
      x.name <=> y.name
    end
  end

  def backfill
    date_counter = most_recent_occurrence.date + 1
    while date_counter <= Date.today
      things.each do |thing|
        thing.generate_default_occurrence_for_date(date_counter)
      end
      date_counter += 1
    end
  end

  def most_recent_occurrence
    all_occurrences = things.map do |thing|
      thing.occurrences
    end.flatten
    return Date.today if all_occurrences.empty?
    all_occurrences.max{ |a,b| a.date <=> b.date}
  end

  private
  def persisted?
    # Remove this method once durable storage is in place
    true
  end





  class << self
    def find_or_create_with_phone_number(phone_number)
      Human.new(phone_number: phone_number)
    end
  end
end
