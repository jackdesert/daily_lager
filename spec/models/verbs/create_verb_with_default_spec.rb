require 'spec_helper'

describe CreateVerbWithDefault do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:create_verb_with_default) { CreateVerbWithDefault.new(words) }
    it 'returns a message' do
      mock(create_verb_with_default).respond('3 miles entered')
      create_verb_with_default.process
    end
  end

  describe '#appropriate?', focus: true do
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

