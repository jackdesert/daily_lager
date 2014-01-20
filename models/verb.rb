class Verb
  class << self

    def receive
      no_thanks
    end

    private
    def successor
      ActionVerb
    end


    def no_thanks
      if successor
        successor.receive words
      else
        raise 'no successor found'
      end
    end
  end
end
