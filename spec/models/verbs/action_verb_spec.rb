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
    let(:human) { Human.new(phone_number: '1111111111', things: [thing1]) }
    subject { described_class.new([value, name], human) }

    context 'when the named thing exists' do
      let(:name) { existing_name }
      it 'adds an Occurrence' do
        subject.send(:process)
        occurrences = human.things.first.occurrences
        occurrences.length.should == 1
        occurrences.first.value.should == 3
      end
      it 'returns a message' do
        mock(subject).respond("3 run(s) logged")
        subject.send(:process)
      end
      context 'and the Thing already has an occurrence today' do
        pending
        # mock(subject).respond("6 run logged. Today's total: 6")
      end
    end

    context 'when the named action does not exist' do
      let(:name) { 'original' }
      it 'does not add an Occurrence' do
        subject.send(:process)
        human.things.first.occurrences.should be_empty
      end
      it 'returns a message' do
        mock(subject).respond("You do not have a Thing named 'original'. To create one, type 'create original' (without quotes).")
        subject.send(:process)
      end
    end
  end



end

