require 'spec_helper'

describe NonsenseVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:nonsense_verb) { ActionVerb.new(words, Human.new) }
    it 'returns a message' do
      mock(nonsense_verb).respond('3 miles entered')
      nonsense_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['nonsense'],
      [],
      ['anything', 'you', 'want', 'under', 'the', 'sun']
    ]
        
    # Can't call the usual verify_appropriateness_of method, because that would verify the inverses as well. 
    # This is the one class that doesn't need that check--because it's at the bottom of the responsibility chain
    it 'accepts any string' do
      ['some nonsense string youve never heard of *&#^#%%^%&$*', ''].each do |string|
        described_class.new(string, Human.new).send(:appropriate?).should be_true
      end
    end

    it 'accepts any array' do
      described_class.new(['some', 'nonsense', 'array', 'that', 'makes', 'no', '&%*#@^%!)'], Human.new).send(:appropriate?).should be_true
    end
  end 
end

