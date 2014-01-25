require 'spec_helper'

describe RenameVerb do

  describe '#appropriate?' do
    thing1 = Thing.new(name: 'mp3', default_value: 6)
    human = Human.new(things: [thing1]) 
    yesses = [
      ['rename', 'mp3', 'm4a'],
      ['rename', 'nonexistent', 'something_else'], # Appropriate even though it will fail due to 'run' not existing
    ]

    nos = [
      ['rename', '3', 'blather'], # second argument must have at least one letter
      ['rename', 'blather', '3'], # new name must have at least one letter
    ]
        
    verify_appropriateness_of(yesses, described_class, human)
    verify_inappropriateness_of(nos, described_class, human)
  end 

  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:human) { Human.new(phone_number: '1111111111', things: [thing1]) }
    subject { described_class.new('rename run miles', human) }
    context 'when Thing exists' do
      it 'returns a message' do
        subject.send(:process).should == "Activity 'run' updated to 'miles'.\nTo use, type '6 miles' without quotes."
      end
    end

    context 'when Thing does not exist' do
      it 'returns a different message' do
        pending
      end
    end
  end

end

