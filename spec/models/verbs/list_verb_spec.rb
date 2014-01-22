require 'spec_helper'

describe ListVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:list_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(list_verb).respond('3 miles entered')
      list_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['list'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

