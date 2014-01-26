module Util

  def self.hash_has_nonzero_value(hash)
    hash.each_pair.any?{|name, value| value > 0}
  end

end
