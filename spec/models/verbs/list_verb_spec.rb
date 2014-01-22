require 'spec_helper'

describe ListVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:list_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(list_verb).respond('3 miles entered')
      listhelp_verb.process
    end
  end

  describe '#appropriate?', focus: true do
    yesses = [
      ['list'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

