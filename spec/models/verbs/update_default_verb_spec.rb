require 'spec_helper'

describe UpdateDefaultVerb do
  describe '#appropriate?' do
    # before do
    #   stub(human).backfill
    # end
    
    yesses = [
      ['update', 'mp3', 'default', '40'],
      ['update', 'boo', 'default', '-10'],
    ]

    nos = [
      ['update', '3', 'default', '40'], # second argument can't be all numbers
      ['update', 'something', 'default', 'hasletters'], # fourth argument must be all numbers
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 


  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:human) { create(:human) }
    subject { described_class.new(text, human) }
    
    before do
      human.add_thing(thing1)
      stub(human).backfill
    end

    context 'when Thing exists' do
      let(:text) { 'update run default 5' }
      it 'returns a message' do
        subject.send(:process).should == "Category 'run' has new default value of 5"
      end
      it 'updates the default value' do
        subject.send(:process)
        thing1.reload.default_value.should == 5
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

