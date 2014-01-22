require 'spec_helper'

describe CreateVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:create_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(create_verb).respond('3 miles entered')
      create.process
    end
  end

  describe '#appropriate?', focus: true do
    yesses = [
      ['create', 'filter'],
      ['create', 'mp3'],
    ]

    nos = [
      ['create', '335'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

