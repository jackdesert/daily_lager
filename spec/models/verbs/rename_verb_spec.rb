require 'spec_helper'

describe RenameVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:rename_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(rename_verb).respond('3 miles entered')
      renamehelp_verb.process
    end
  end

  describe '#appropriate?', focus: true do
    yesses = [
      ['rename', 'mp3', 'm4a'],
    ]

    nos = [
      ['rename', '3', 'blather'],
      ['rename', 'blather', '3'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

