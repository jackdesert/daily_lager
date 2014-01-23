class Occurrence


  attr_accessor :value, :date

  def initialize(hash={})
    hash.each_pair do |key, value|
      self.send("#{key}=", value)
    end
  end

  def valid?
    return false unless value.kind_of? Fixnum
    return false unless date.kind_of? Date
    true
  end
end
