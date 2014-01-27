DB = Database.sqlite

class Human < Sequel::Model

#  attr_accessor :phone_number, :things

  one_to_many :thing

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
    while date_counter <= Occurrence.new.date 
      things.each do |thing|
        thing.generate_default_occurrence_for_date(date_counter)
      end
      date_counter += 1
    end
  end

  def most_recent_occurrence
    things.map do |thing|
      thing.occurrences
    end.flatten.max{ |a,b| a.date <=> b.date}
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
