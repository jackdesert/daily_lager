require 'spec_helper'

describe CreateVerbWithDefault do
  describe '#appropriate?' do
    yesses = [
      ['create', 'filter', 'default', '10'],
      ['create', 'mp3', 'default', '335'],
    ]

    nos = [
      ['create', '335', 'default', '110'], # Can't have all numbers in second word
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

