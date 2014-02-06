module Util

  class << self
    def hash_has_nonzero_value(hash)
      hash.each_pair.any?{|name, value| value > 0}
    end

    def current_date_in_california
      DateTime.now.in_time_zone('Pacific Time (US & Canada)').to_date
    end
  end

end
