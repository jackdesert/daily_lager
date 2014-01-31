require 'spec_helper'

describe CreateVerbWithDefault do
  describe '#appropriate?' do
    yesses = [
      ['create', 'filter', 'default', '10'],
      ['create', 'mp3', 'default', '335'],
    ]

    nos = [
      ['create', '335', 'default', '110'], # Can't have all numbers in second word
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 


  describe '#process' do
    let(:existing_name) { 'run' }
    let(:thing1) { Thing.new(name: existing_name, default_value: 6) }
    let(:human) { create(:human) }
    subject { described_class.new("create #{name} default 3", human) }

    before do
      human.add_thing(thing1)
    end

    context 'when the named action does not exist' do
      let(:name) { 'original' }
      it 'adds a Thing to the human' do
        subject.send(:process)
        human.things.length.should == 2
        second = human.things.second
        second.name.should == name
        human.things.second.default_value.should == 3
      end
      it 'returns a message' do
        subject.send(:process).should == "#{Thing::DISPLAY_NAME.capitalize} 'original' created with a default value of 3."
      end
    end

    context 'when the named thing already exists' do
      let(:name) { existing_name }
      it 'does not add a Thing to the human' do
        subject.send(:process)
        human.things.length.should == 1
        human.things.first.name.should == name
      end
      it 'returns a message' do
        subject.send(:process).should == "You already have a #{Thing::DISPLAY_NAME} named '#{name}'"
      end
    end
  end
end

