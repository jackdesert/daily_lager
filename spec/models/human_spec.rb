require 'spec_helper'

describe Human do
  context 'validations' do
    context 'phone number' do
      context 'format' do
        context 'valid phone numbers' do
          valid_numbers = ['+11112223333', '+19998887777'] 
          valid_numbers.each do |number|
            subject { described_class.new(phone_number: number) }
            context "when the phone number is #{number}" do
              it { should_not have_error_on(:phone_number) }
            end
          end
        end

        context 'invalid phone numbers' do
          invalid_numbers = ['1', '12', '+123.456.4444', '&1112223333', '11112223333']
          invalid_numbers.each do |number|
            subject { described_class.new(phone_number: number) }
            context "when the phone number is #{number}" do
              it { should have_error_on(:phone_number) }
            end
          end
        end
      end
      context 'uniqueness' do
        let(:number) { '+12222222222' }
        let!(:first_human) { Human.create(phone_number: number) }
        let(:second_human) { Human.new(phone_number: number) }
        it 'marks the second human as invalid' do
          first_human.should be_valid
          second_human.should have_error_on(:phone_number)
        end
      end
    end
  end

  describe '#things' do
    it 'is an array' do
      described_class.new.things.should be_an Array
    end
  end

  describe '#most_recent_occurrence' do
    let(:human) { create(:human)  }
    context 'when there are no occurrences' do
      subject { human.most_recent_occurrence }
      it { should be_nil }
    end

    context 'when there are occurrences' do

      let(:two_days_ago)   { Date.today - 2 }
      let(:three_days_ago) { Date.today - 3 }
      let(:four_days_ago)  { Date.today - 4 }
      let(:run_occurrences) { [ Occurrence.new(date: four_days_ago), Occurrence.new(date:three_days_ago) ] }
      let(:run_thing) { Thing.new(name: 'run', default_value: 13) }
      let(:walk_thing) { Thing.new(name: 'walk', default_value: 13) }

      before do
        run_thing.occurrences << run_occurrences
        human.things << run_thing
        human.things << walk_thing
      end

      it 'returns an Occurrence' do
        human.most_recent_occurrence.should be_an Occurrence
      end

      it 'returns the most recent' do
        human.most_recent_occurrence.date.should == three_days_ago
        walk_thing.occurrences << Occurrence.new(date: two_days_ago)
        human.most_recent_occurrence.date.should == two_days_ago
      end
    end
  end

  describe '#backfill' do
    let(:today_occurrence) { Occurrence.create(value: 10) }
    let(:yesterday_occurrence) { Occurrence.create(value: 11, date: Date.today - 1) }
    let(:two_days_ago_occurrence) { Occurrence.create(value: 12, date: Date.today - 2) }
    let(:three_days_ago_occurrence) { Occurrence.create(value: 15, date: Date.today - 3) }
    let(:run_thing) { Thing.create(name: 'run', default_value: 13) }
    let(:walk_thing) { Thing.create(name: 'run', default_value: 7) }
    let(:human) { create(:human)  }

    before do
      human.add_thing(run_thing)
      human.add_thing(walk_thing)
    end

    context 'when there is already an entry for today' do
      before do
        run_thing.add_occurrence(today_occurrence)
        walk_thing.add_occurrence(yesterday_occurrence)
      end

      it 'does nothing' do
        expect {
          human.backfill
        }.to change{ run_thing.occurrences.count }.by(0)
      end
    end

    context 'when the last occurrence was two days ago' do
      before do
        run_thing.add_occurrence(two_days_ago_occurrence)
        walk_thing.add_occurrence(three_days_ago_occurrence)
        walk_thing.add_occurrence(two_days_ago_occurrence)
      end

      let(:today) { Date.today }
      let(:yesterday) { today - 1 }
      it 'calls generate_default_occurrence_for_date on all Things for yesterday and today' do
        human.things.count.should == 2
        human.things.each do |thing|
          mock(thing).generate_default_occurrence_for_date(today)
          mock(thing).generate_default_occurrence_for_date(yesterday)
        end
        human.backfill
      end
    end
  end

  describe '.demo_instance' do
    context 'when the demo human has not been created' do
      subject { described_class.demo_instance }
      it { should be_a(Human) }
    end

    context 'when the demo human has already been created' do
      let(:demo_human) { Human.demo_instance }
      let(:demo_human_2) { Human.demo_instance }

      it 'returns the same instance each time' do
        demo_human.phone_number.should == demo_human_2.phone_number
      end
    end
  end

end
