class Human 

  attr_accessor :phone_number, :things

  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @things = []
  end

  def valid?
    if phone_number.match /\A\d{10}\Z/
      true
    else
      false
    end
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