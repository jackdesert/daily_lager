module Util

  class << self
    def hash_has_nonzero_value(hash)
      hash.each_pair.any?{|name, value| value > 0}
    end

    def current_date_in_california
      DateTime.now.in_time_zone('Pacific Time (US & Canada)').to_date
    end

    def sha1_match?(text, sha1)
      return false if (text.nil? || sha1.nil?)
      sha1(text) == sha1
    end

    def sha1(text)
      raise ArgumentError, 'text must not be nil' if text.nil?
      Digest::SHA1.hexdigest(text)
    end

  end

end
