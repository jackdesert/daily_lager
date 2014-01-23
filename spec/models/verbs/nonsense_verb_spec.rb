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


  describe '#process', focus: true do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:thing2) { Thing.new(name: 'eat', default_value: 2) }
    let(:human) { Human.new(phone_number: '1111111111', things: [thing1, thing2]) }
    subject { described_class.new('blither blather', human) }
    it 'returns a message' do
      mock(subject).respond("Command 'blither blather' not understood. Type 'help' (without quotes) for help.")
      subject.send(:process)
    end
  end

end

