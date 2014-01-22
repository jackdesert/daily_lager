require 'spec_helper'

describe ActionVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:action_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(action_verb).respond('3 miles entered')
      action_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['2', 'miles'],
      ['273', 'smurfs']
    ]
    nos = [
      ['two'],
      ['2'],
      ['2', 'miles', 'something'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

