require 'spec_helper'

describe YesterdayVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:yesterday_verb) { ActionVerb.new(words, Human.new) }
    it 'returns a message' do
      mock(yesterday_verb).respond('3 miles entered')
      yesterday_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['yesterday'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

