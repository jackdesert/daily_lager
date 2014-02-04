require 'spec_helper'

describe DeleteVerb do

#  before do
#    stub(human).backfill
#  end

  describe '#appropriate?' do
    yesses = [
      ['delete', 'mp3'],
    ]

    nos = [
      ['delete', '3'],  # Second argument can't be all numbers
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

