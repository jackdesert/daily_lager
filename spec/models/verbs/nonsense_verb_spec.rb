require 'spec_helper'

describe NonsenseVerb do
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


  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:thing2) { Thing.new(name: 'eat', default_value: 2) }
    let(:human) { Human.create(phone_number: '1111111111') }
    subject { described_class.new('blither blather', human) }

    before do
      human.add_thing(thing1)
      human.add_thing(thing2)
    end

    it 'returns a message' do
      expected = "Command 'blither blather' not understood. Type 'menu' (without quotes) for a list of available commands."
      subject.send(:process).should == expected
    end
  end

end

