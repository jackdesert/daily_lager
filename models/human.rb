# Note that Sequel gets the plural of human wrong, so must specify the table name here
class Human < Sequel::Model(:humans)
  DEMO_PHONE_NUMBER = '+11111111111'

  plugin :validation_helpers


#  attr_accessor :phone_number, :things

  one_to_many :things
  one_to_many :notes

#  def initialize(hash={})
#    hash.each_pair do |key, value|
#      self.send("#{key}=", value)
#    end
#    @things ||= []
#    def @things.find_by_name(name)
#      self.select {|f| f.name == name}.first
#    end
#  end

#  def valid?
#    if phone_number.match /\A\d{10}\Z/
#      true
#    else
#      false
#    end
#  end

  def validate
    super
    validates_unique :phone_number
    validates_format /\A\+1\d{10}\Z/, :phone_number, :message=>'format required: +1dddddddddd where d is a digit'
  end

  def things_in_order
    things.sort do |x,y|
      x.name <=> y.name
    end
  end

  def thing_names
    things.map(&:name)
  end

  def backfill
    today = Util.current_date_in_california
    recent_date = date_of_most_recent_occurrence
    if recent_date.nil?
      date_counter = today
    else
      date_counter = recent_date + 1
    end

    while date_counter <= today
      things.each do |thing|
        thing.generate_default_occurrence_for_date(date_counter)
      end
      date_counter += 1
    end
  end

  def date_of_most_recent_occurrence
    things_dataset.join(:occurrences, thing_id: :id).reverse_order(:date).limit(1).first.try(:values).try(:[], :date)
  end

  private
  def persisted?
    # Remove this method once durable storage is in place
    true
  end





  class << self
    def demo_instance
      find_or_create(phone_number: DEMO_PHONE_NUMBER)
    end
  end

end
