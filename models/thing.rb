class Thing

  attr_accessor :name, :occurrences, :default_value
  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @occurrences ||= []
  end

  def change_name_to(new_name)
    self.name = new_name
  end

  private

  def persisted?
    # Remove this method once durable storage is in place
    true
  end


  class << self
    def create_with_name(name)
      new(name: name)
    end
  end
end
