require 'spec_helper'

describe UpdateDefaultVerb do
  describe '#appropriate?' do
    # before do
    #   stub(human).backfill
    # end
    
    yesses = [
      ['update', 'mp3', 'default', '40'],
    ]

    nos = [
      ['update', '3', 'default', '40'], # second argument can't be all numbers
      ['update', 'something', 'default', 'hasletters'], # fourth argument must be all numbers
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

