require 'spec_helper'

describe DeleteVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:delete_verb) { ActionVerb.new(words, Human.new) }
    it 'returns a message' do
      mock(delete_verb).respond('3 miles entered')
      delete_verb.process
    end
  end

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

