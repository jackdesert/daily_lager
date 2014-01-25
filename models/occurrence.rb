require 'active_support/core_ext/date_time/zones' # adds support for DateTime#in_time_zone
require 'active_support/core_ext/date_time/calculations' #adds support for DateTime#utc, used by DateTime#in_time_zone

class Occurrence


  attr_accessor :value, :date

  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
    @date ||= current_date_in_california
  end

  def valid?
    return false unless value.kind_of? Fixnum
    return false unless date.kind_of? Date
    true
  end

  private
  def current_date_in_california
    DateTime.now.in_time_zone('Pacific Time (US & Canada)').to_date
  end
end
