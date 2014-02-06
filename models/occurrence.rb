require 'active_support/core_ext/date_time/zones' # adds support for DateTime#in_time_zone
require 'active_support/core_ext/date_time/calculations' #adds support for DateTime#utc, used by DateTime#in_time_zone

class Occurrence < Sequel::Model


  many_to_one :thing


#  attr_accessor :value, :date
#  def initialize(hash={})
#    super
#    @date ||= current_date_in_california
#  end

#  def valid?
#    return false unless value.kind_of? Fixnum
#    return false unless date.kind_of? Date
#    true
#  end

  private

  def before_validation
    self.date ||= Util.current_date_in_california
  end

  def validate
    super
    errors.add(:date, 'Must be a Date') unless date.kind_of? Date
    errors.add(:value, 'Must be an Integer') unless value.kind_of? Fixnum
  end

end
