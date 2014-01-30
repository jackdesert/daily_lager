require 'spec_helper'

describe ActionVerb do

  describe '#appropriate?' do
    yesses = [
      ['2', 'miles'],
      ['273', 'smurfs']
    ]
    nos = [
      ['two'],
      ['2'],
      ['2', 'miles', 'something'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end 



  describe '#process' do
    let(:existing_name) { 'run' }
    let(:value) { 3 }
    let(:thing1) { Thing.new(name: existing_name, default_value: 6) }
    let(:human) { create(:human) }
    subject { described_class.new([value, name], human) }

    before do
      human.add_thing(thing1)
    end

    context 'when the named thing exists' do
      let(:name) { existing_name }
      it 'adds an Occurrence' do
        subject.send(:process)
        occurrences = human.things.first.occurrences
        occurrences.length.should == 1
        occurrences.first.value.should == 3
      end
      it 'returns a message' do
        subject.send(:process).should == '3 run(s) logged.'
      end
      context 'and the Thing already has an occurrence today' do
        before do
          thing1.add_occurrence(value: 13)
        end
        it 'returns the total with the message' do
          subject.send(:process).should == ("3 run(s) logged. Today's total: 16")
        end
      end
    end

    context 'when the named action does not exist' do
      let(:name) { 'original' }
      it 'does not add an Occurrence' do
        subject.send(:process)
        human.things.first.occurrences.should be_empty
      end
      it 'returns a message' do

      "You do not have a #{Thing::DISPLAY_NAME} named '#{name}'. To create one, type CREATE #{name}."
        expected = "You do not have a #{Thing::DISPLAY_NAME} named 'original'. To create one, type 'CREATE original' (without quotes)."
        subject.send(:process).should == expected
      end
    end
  end



end

