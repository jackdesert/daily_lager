require 'spec_helper'

describe Thing do
  describe '#initialize' do

    let(:name) { 'iron' }
    let(:default_value) { 6 }

    subject { described_class.new(name: name, default_value: default_value) }
    it 'returns a Thing' do
      subject.should be_an described_class
    end
    it 'saves the name in the new action' do
      subject.name.should == name
    end

    it { should be_persisted }

    context 'when a default value is given' do
      it 'saves the default value in the new action' do
        subject.default_value.should == default_value 
      end
    end

    context 'when a default value is not given' do
      subject { described_class.new(name: name) }
      it 'has a default value of 0 after saving' do
        subject.save.default_value.should == 0
      end
    end
  end

  context 'associations' do
    let(:today_occurrence) { Occurrence.new(value: 5) }
    subject { described_class.create }
    before do
      subject.add_occurrence(today_occurrence)
    end

    it 'saves associated records when saved' do
      subject.occurrences.first.should == today_occurrence
    end
  end

  describe '#occurrences' do
    it 'is an array' do
      described_class.new.occurrences.should be_an Array
    end
  end

  describe '#generate_default_occurrence_for_date' do
    let(:january_1) { Date.new(2014, 1, 1) }
    let(:existing_occurrence_jan_1) { Occurrence.new(date: january_1, value: 1300) }
    let(:thing) { Thing.create(name: 'run', default_value: 13) }

    before do
      thing.add_occurrence(existing_occurrence_jan_1)
    end

    context 'when an occurrence already exists for that day' do
      it 'raises an exception and does not create an occurrence' do
        expect {
          thing.generate_default_occurrence_for_date(january_1)
        }.to raise_error "Thing 'run' already has occurrence(s) for 2014-01-01"
        thing.occurrences.length.should == 1
      end
    end

    context 'when no occurrence exists for that day' do
      let(:february_1) { Date.new(2014, 2, 1) }
      it 'adds an occurrence with the value matching Thing#default_value' do
        thing.occurrences.length.should == 1
        thing.generate_default_occurrence_for_date(february_1)
        thing.occurrences.length.should == 2
        thing.occurrences.last.value.should == 13
      end
    end

  end


  describe '#total_value_today' do
    context 'when there are no occurrences' do
      subject { Thing.new.total_value_today }
      it 'returns zero' do
        should == 0
      end
    end

    context 'when there are occurrences' do
      let(:yesterday_occurrence) { Occurrence.new(date: Date.today - 1, value: 13) }
      let(:first_occurrence) { Occurrence.new(value: 4) }
      let(:second_occurrence) { Occurrence.new(value: 1) }
      let(:thing) { Thing.create }
      subject { thing.total_value_today }
      before do
        thing.add_occurrence(yesterday_occurrence)
        thing.add_occurrence(first_occurrence)
        thing.add_occurrence(second_occurrence)
      end
      it "returns today's total" do
        should == 5
      end
    end
  end

  describe '.totals_for_human_on_date' do
    let(:correct_date) { Date.today - 35 }
    let(:other_date) { Date.today - 17 }
    let(:yoyo_thing) { Thing.create(name: 'yoyo') }
    let(:music_thing) { Thing.create(name: 'music') }
    let(:other_human_music_thing) { Thing.create(name: 'music') }
    let(:human) { Human.create(phone_number: '2222222222') }
    let(:other_human) { Human.create(phone_number: '3333333333') }
    subject { described_class.totals_for_human_on_date(human, correct_date) }
    before do
      [yoyo_thing, music_thing, other_human_music_thing].each do |t|
        [1,3,7].each do |value|
          t.add_occurrence(value: value, date: correct_date)
          t.add_occurrence(value: value, date: other_date)
        end
      end
      music_thing.add_occurrence(value: 13, date: correct_date)
      human.add_thing(yoyo_thing)
      human.add_thing(music_thing)
      other_human.add_thing(other_human_music_thing)
    end

    it { should be_a(Hash) }
    it { should == {'yoyo' => 11, 'music' => 24} }
  end

end
  











