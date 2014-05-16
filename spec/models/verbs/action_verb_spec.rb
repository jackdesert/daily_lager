require 'spec_helper'

describe ActionVerb do

  before do
    # Make sure Util.current_date_in_california is not used to initialize anything, since it
    # really should be using Util.current_date_in_california
    mock(Date).today.never
  end



  describe '#appropriate?' do
    yesses = [
      ['sex'],
      ['draw'],
      ['anything_else_single_word'],
      ['2', 'miles'],
      ['273', 'smurfs'],
      ['-500', 'towns'],
      ['y', '-500', 'towns'],
    ]
    nos = [
      ['two'],
      ['2'],
      ['2', 'miles', 'something']
    ] | Verb::RESERVED_WORDS.map(&:to_s).each_slice(1).to_a

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
      stub(human).backfill
      human.add_thing(thing1)
    end

    context 'when the named thing exists' do
      context 'today' do

        let(:name) { existing_name }
        it 'adds an Occurrence' do
          subject.send(:process)
          occurrences = human.things.first.occurrences
          occurrences.length.should == 1
          occurrences.first.value.should == 3
          occurrences.first.date.should == Util.current_date_in_california
        end
        it 'returns a message' do
          subject.send(:process).should == '3 run(s) logged.'
        end
        context 'and the Thing already has an occurrence today' do
          before do
            thing1.add_occurrence(value: -13)
          end
          it 'returns the total with the message' do
            subject.send(:process).should == ("3 run(s) logged. Today's total: -10")
          end
        end
      end
      context 'yesterday' do
        let(:name) { existing_name }
        subject { described_class.new(['y', value, name], human) }
        it 'adds an Occurrence' do
          subject.send(:process)
          occurrences = human.things.first.occurrences
          occurrences.length.should == 1
          occurrences.first.value.should == 3
          occurrences.first.date.should == Util.current_date_in_california - 1
        end
        it 'returns a message' do
          subject.send(:process).should == '3 run(s) logged for yesterday.'
        end
        context 'and the Thing already has an occurrence yesterday' do
          before do
            thing1.add_occurrence(value: -13, date: Util.current_date_in_california - 1)
          end
          it 'returns the total with the message' do
            subject.send(:process).should == ("3 run(s) logged for yesterday. Yesterday's total: -10")
          end
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

  describe '#effective_date' do
    let(:human) { create(:human) }
    subject { described_class.new(words, human) }
    context "when first word is 'y'" do
      let(:words) { ['y', '3', 'blah'] }
      its(:effective_date) { should == Util.current_date_in_california - 1}
    end

    context "when first word is an integer" do
      let(:words) { ['3', 'blah'] }
      its(:effective_date) { should == Util.current_date_in_california }
    end
  end

end

