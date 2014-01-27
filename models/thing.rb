DB = Database.sqlite

class Thing < Sequel::Model

  DISPLAY_NAME = 'category'
  DISPLAY_NAME_PLURAL = 'categories'

  one_to_many :occurrence
  many_to_one :human

#  attr_accessor :name, :occurrences, :default_value, :thing_id
#  def initialize(hash={})
#    super
#    @occurrences ||= []
#    @default_value ||= 0
#  end

#  def save
#    if output = super
#      @occurrences.each do |occurrence|
##        occurrence.values[:thing_id] = id
##        add_occurrence(occurrence)
#      end
#    end
#    output
#  end

  def change_name_to(new_name)
    self.name = new_name
  end

  def generate_default_occurrence_for_date(date)
    raise "Thing '#{name}' already has occurrence(s) for #{date.to_s}" if occurrence_exists_for_date(date)
    occurrences << Occurrence.new(value: default_value, date: date)
  end

  def total_value_today
    occurrences.select{|f| f.date == Time.now.to_date}.map(&:value).inject(:+) || 0
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
