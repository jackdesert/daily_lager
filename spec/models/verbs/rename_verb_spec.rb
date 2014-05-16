require 'spec_helper'

describe RenameVerb do
  let(:human) { create(:human) }

  describe '#appropriate?' do
    human = create(:human)
    thing1 = Thing.new(name: 'mp3', default_value: 6)
    human.add_thing(thing1)

    yesses = [
      ['rename', 'mp3', 'm4a'],
      ['rename', 'nonexistent', 'something_else'], # Appropriate even though it will fail due to 'run' not existing
    ]

    nos = [
      ['rename', '3', 'blather'], # second argument must have at least one letter
      ['rename', 'blather', '3'], # new name must have at least one letter
    ]

    verify_appropriateness_of(yesses, described_class, human: human)
    verify_inappropriateness_of(nos, described_class, human: human)
  end

  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    subject { described_class.new(text, human) }

    before do
      human.add_thing(thing1)
      stub(human).backfill
    end

    context 'when Thing exists' do
      let(:text) { 'rename run miles' }
      it 'returns a message' do
        subject.send(:process).should == "Category 'run' updated to 'miles'.\nTo use, type '6 miles' without quotes."
      end
      it 'renames' do
        subject.send(:process)
        thing1.reload.name.should == 'miles'
      end
    end

    context 'when Thing does not exist' do
      let(:text) { 'rename bizarre miles' }
      it 'returns a different message' do
        subject.send(:process).should == "You do not have a #{Thing::DISPLAY_NAME} named 'bizarre'. To create one, type 'CREATE bizarre' (without quotes)"
      end
    end
  end

end

