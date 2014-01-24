class Human 

  attr_accessor :phone_number, :things

  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @things ||= []
    def @things.find_by_name(name)
      self.select {|f| f.name == name}.first
    end
  end

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
