require 'spec_helper'

describe UpdateDefaultVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:update_default_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(update_default_verb).respond('3 miles entered')
      update_default.process
    end
  end

  describe '#appropriate?', focus: true do
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

