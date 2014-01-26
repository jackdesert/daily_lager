require 'spec_helper'

describe Human do
  context 'validations' do
    context 'valid phone number' do
      valid_numbers = ['1112223333', '9998887777'] 
      invalid_numbers = ['1', '12', '123.456.4444', '&1112223333']
      valid_numbers.each do |number|
        described_class.new(phone_number: number).valid?.should == true
      end
      invalid_numbers.each do |number|
        described_class.new(phone_number: number).valid?.should == false
      end
    end
  end

  describe '#find_or_create_with_phone_number' do
    let(:phone_number) { '1231231234' }
    subject { described_class.find_or_create_with_phone_number(phone_number) }
    it 'returns an Action' do
      subject.should be_an described_class
    end
    it 'saves the name in the new action' do
      subject.phone_number.should == phone_number 
    end
    it { should be_persisted }
  end

  describe '#things' do
    it 'is an array' do
      described_class.new.things.should be_an Array
    end
  end

  describe '#most_recent_occurrence' do
    let(:two_days_ago)   { (Time.now - 2 * 86400).to_date }
    let(:three_days_ago) { (Time.now - 3 * 86400).to_date }
    let(:four_days_ago)  { (Time.now - 4 * 86400).to_date }
    let(:run_occurrences) { [ Occurrence.new(date: four_days_ago), Occurrence.new(date:three_days_ago) ] }
    let(:run_thing) { Thing.new(name: 'run', default_value: 13, occurrences: run_occurrences) }
    let(:walk_thing) { Thing.new(name: 'walk', default_value: 13, occurrences: []) }
    let(:human) { Human.new(phone_number: '1112224444', things: [run_thing, walk_thing])  }

    it 'returns an Occurrence' do
      human.most_recent_occurrence.should be_an Occurrence
    end

    it 'returns the most recent' do
      human.most_recent_occurrence.date.should == three_days_ago
      walk_thing.occurrences << Occurrence.new(date: two_days_ago)
      human.most_recent_occurrence.date.should == two_days_ago
    end
  end


  describe '#backfill' do
    let(:today_occurrence) { Occurrence.new }
    let(:yesterday_occurrence) { Occurrence.new(date: Time.now.to_date - 1) }
    let(:two_days_ago_occurrence) { Occurrence.new(date: Time.now.to_date - 2) }
    let(:three_days_ago_occurrence) { Occurrence.new(date: Time.now.to_date - 3) }
    let(:run_thing) { Thing.new(name: 'run', default_value: 13, occurrences: run_occurrences) }
    let(:walk_thing) { Thing.new(name: 'run', default_value: 7, occurrences: walk_occurrences) }
    let(:human) { Human.new(phone_number: '1112224444', things: [run_thing, walk_thing])  }

    context 'when there is already an entry for today' do
      let(:run_occurrences) { [today_occurrence] }
      let(:walk_occurrences) { [yesterday_occurrence] }
      it 'does nothing' do
        expect {
          human.backfill
        }.to change{ run_occurrences.count }.by(0)
      end
    end

    context 'when the last occurrence was two days ago' do
      let(:run_occurrences) { [two_days_ago_occurrence] }
      let(:walk_occurrences) { [three_days_ago_occurrence, two_days_ago_occurrence] }
      let(:today) { Time.now.to_date }
      let(:yesterday) { today - 1 }
      it 'calls generate_default_occurrence_for_date on all Things for yesterday and today' do
        [walk_thing, run_thing].each do |thing|
          mock(thing).generate_default_occurrence_for_date(today)
          mock(thing).generate_default_occurrence_for_date(yesterday)
        end
        human.backfill
      end
    end
  end
end
