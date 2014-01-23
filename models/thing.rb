class Thing

  attr_accessor :name, :occurrences
  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @occurrences = []
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
