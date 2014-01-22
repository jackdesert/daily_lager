require 'spec_helper'

describe TodayVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:today_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(today_verb).respond('3 miles entered')
      today.process
    end
  end

  describe '#appropriate?', focus: true do
    yesses = [
      ['today'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

