class Thing

  attr_accessor :name, :occurrences, :default_value
  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @occurrences ||= []
    @default_value ||= 0
  end

  def change_name_to(new_name)
    self.name = new_name
  end

  def generate_default_occurrence_for_date(date)
    raise "Thing '#{name}' already has occurrence(s) for #{date.to_s}" if occurrence_exists_for_date(date)
    occurrences << Occurrence.new(value: default_value, date: date)
  end
    

  private

  def occurrence_exists_for_date(date)
    occurrences.any? { |f| f.date == date }
  end

  def persisted?
    # Remove this method once durable storage is in place
    true
  end


  class << self
    def create_with_name(name)
      new(name: name, default_value: 0)
    end
  end
end
