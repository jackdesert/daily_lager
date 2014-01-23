require 'spec_helper'

describe TodayVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:today_verb) { ActionVerb.new(words, Human.new) }
    it 'returns a message' do
      mock(today_verb).respond('3 miles entered')
      today_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['today'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

