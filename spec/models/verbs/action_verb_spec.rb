require 'spec_helper'

describe ActionVerb do

  before do
    # Make sure Util.current_date_in_california is not used to initialize anything, since it
    # really should be using Util.current_date_in_california
    mock(Date).today.never
  end



  describe '#appropriate?' do
    shortcut_words = ['sex', 'draw']
    yesses = [
      ['sex'],
      ['y', 'sex'],
      ['draw'],
      ['y', 'draw'],
      ['2', 'miles'],
      ['miles', '2'],
      ['273', 'smurfs'],
      ['smurfs', '273'],
      ['-500', 'towns'],
      ['towns', '-500'],
      ['y', '-500', 'towns'],
      ['y', 'towns', '-500'],
    ]
    nos = [
      ['a_word_not_in_thing_shortcut_words'],
      ['two'],
      ['2'],
      ['2', 'miles', 'something']
    ] | Verb::RESERVED_WORDS.map(&:to_s).each_slice(1).to_a

    verify_appropriateness_of(yesses, described_class, shortcut_words: shortcut_words)
    verify_inappropriateness_of(nos, described_class, shortcut_words: shortcut_words)
  end


  context 'private methods' do
    let(:human) { create(:human) }
    let(:thing_name) { 'fun' }
    before do
      human.add_thing(name: thing_name)
    end

    describe '#thing_name' do
      [['y', 'fun'],
        ['y', 'fun', '3005'],
        ['fun'],
        ['fun', '3005']].each do |words|
        context "when words are #{words}" do
          it 'returns the thing name' do
            described_class.new(words, human).send(:thing_name).should == thing_name
          end
        end
      end
    end

    describe '#occurrence_value' do
      # Note symbols and strings as keys so they do not overwrite each other
      {:'1' => ['y', 'fun'],
        '1' => ['fun'],
        :'3005' => ['y', 'fun', '3005'],
        '3005' => ['fun', '3005']
      }.each_pair do |value, words|
        context "when words are #{words}" do
          it "value is #{value}" do
            described_class.new(words, human).send(:occurrence_value).should == value.to_s.to_i
          end
        end
      end
    end
  end


  describe '#process' do
    let(:today) { Util.current_date_in_california }
    let(:yesterday) { today - 1 }
    let(:existing_name) { 'run' }
    let(:value) { 3 }
    let(:thing1) { Thing.new(name: existing_name, default_value: 6) }
    let(:human) { create(:human) }
    let(:words) { [value.to_s, name] }
    subject { described_class.new(words, human) }

    before do
      stub(human).backfill
      human.add_thing(thing1)
    end

    context 'when a shortcut word is used' do
      context 'today' do
        let(:words) { existing_name }
        it 'adds an occurrence' do
          expect{
            subject.send(:process)
          }.to change{ thing1.reload.occurrences.length }.by(1)
          thing1.occurrences.last.date.should == today
          thing1.occurrences.last.value.should == 1
        end
      end
      context 'yesterday' do
        let(:words) { ['y', existing_name] }
        it 'adds an occurrence' do
          expect{
            subject.send(:process)
          }.to change{ thing1.reload.occurrences.length }.by(1)
          thing1.occurrences.last.date.should == yesterday
          thing1.occurrences.last.value.should == 1
        end
      end
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
        subject { described_class.new(['y', value.to_s, name], human) }
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

