require 'spec_helper'

describe YesterdayVerb do

  describe '#process' do
    let(:today) { Time.now.to_date }
    let(:yesterday) { today - 1 }
    let(:ran_today) { Occurrence.new(date: today, value: 1) }
    let(:ran_yesterday) { Occurrence.new(date: yesterday, value: 3) }
    let(:walked_today) { Occurrence.new(date: today, value: 5) }
    let(:walked_yesterday) { Occurrence.new(date: yesterday, value: 7) }
    let(:thing1) { Thing.create(name: 'run', default_value: 6) }
    let(:thing2) { Thing.create(name: 'walk', default_value: 2) }
    let(:human) { create(:human) }
    subject { described_class.new('rename run miles', human) }
    context 'when occurrences exist for yesterday' do

        before do
          human.add_thing(thing1)
          human.add_thing(thing2)
          stub(human).backfill
          thing1.add_occurrence(ran_today)
          thing1.add_occurrence(ran_yesterday)
          thing2.add_occurrence(walked_today)
          thing2.add_occurrence(walked_yesterday)
        end


      it 'returns a message' do
        subject.send(:process).should == "Yesterday's totals:\n3 run\n7 walk"
      end
    end

    context 'when no occurrences exist for yesterday' do
      before do
        stub(human).backfill
        thing1.add_occurrence(ran_today)
        thing2.add_occurrence(walked_today)
      end

      it 'returns a message' do
        subject.send(:process).should == "You did not log anything yesterday."
      end
    end

    context 'without the stub' do
      before do
        mock(human).backfill
      end
      it 'calls backfill' do
        subject.send(:process)
      end
    end

  end

  describe '#appropriate?' do
    yesses = [
      ['yesterday'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 
end

