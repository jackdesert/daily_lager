require 'spec_helper'

describe CreateVerb do


  describe '#process' do
    let(:existing_name) { 'run' }
    let(:thing1) { Thing.new(name: existing_name, default_value: 6) }
    let(:human) { create(:human) }
    subject { described_class.new(['create', name], human) }

    before do
      human.add_thing(thing1)
      stub(human).backfill
    end

    context 'when the named action does not exist' do


      let(:name) { 'original' }
      it 'adds a Thing to the human' do
        subject.send(:process)
        human.things.length.should == 2
        human.things.second.name.should == name
        human.things.second.default_value.should == 0
      end
      it 'returns a message' do
        subject.send(:process).should == "#{Thing::DISPLAY_NAME.capitalize} 'original' created."
      end

      it 'creates an occurrence for today with the default value' do
        mock.any_instance_of(Thing).create_todays_default_occurrence
        subject.send(:process)
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

 


  describe '#appropriate?' do
    yesses = [
      ['create', 'filter'],
      ['create', 'mp3'],
    ]

    nos = [
      ['create', '335'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 
end

