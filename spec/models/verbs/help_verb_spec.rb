require 'spec_helper'

describe HelpVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:help_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(help_verb).respond('3 miles entered')
      help_verb.process
    end
  end

  describe '#appropriate?', focus: true do
    yesses = [
      ['help'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

