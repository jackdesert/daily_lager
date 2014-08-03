require 'spec_helper'

describe HistoryPresenter do
  let(:presenter) { described_class.new(human: human, things: [:eggplant, :sushi]) }
  let(:human) { create(:human) }
  let(:eggplant_thing) { Thing.new(name: 'eggplant') }
  let(:sushi_thing) { Thing.new(name: 'sushi') }
  let(:today) { Util.current_date_in_california }
  let(:yesterday) { today - 1 }
  describe '#initialize' do
    it 'accepts a hash' do
      described_class.new({human: human})
    end
  end

  describe '#display_as_hash' do
    before do
      one = { date: yesterday, sum_value: 4, name: 'eggplant' }
      two = { date: today, sum_value: 1, name: 'eggplant' }
      three = { date: today, sum_value: 100, name: 'sushi' }
      output = [one, two, three]
      stub(presenter).aggregate_sum_by_date { output }
      stub(presenter).notes_array { ['array of notes'] }
    end

    it 'returns the values as a hash' do
      expected = {
        series: {
          eggplant: [4,1],
          sushi: [100]
        },
        dateOfLastOccurrenceInMilliseconds: nil,
        notes: ['array of notes']

      }
      presenter.display_as_hash.should == expected
    end
  end

  describe '#date_of_last_occurrence_in_milliseconds' do
    subject { presenter.send(:date_of_last_occurrence_in_milliseconds) }
    context 'when no occurrences' do
      it 'is nil' do
        subject.should be_nil
      end
    end

    context 'when occurrences exist' do
      context 'when recent occurrence is at the epoch of time' do
        let(:beginning) { Date.new(1970, 1, 1) }
        it "returns 20 hours worth of milliseconds (half a day plus maybe 8 hours for Pacific Time Zone)" do
          mock(human).date_of_most_recent_occurrence.returns(beginning)
          [3600 * 20 * 1000, 3600 * 12 * 1000].should include(subject)
        end
      end
    end

  end

  describe '#notes_array' do
    subject { presenter.notes_array }
    let(:day) { Date.new(2014, 1, 13) }
    let(:one_day_before) { day - 1 }
    let(:five_days_before) { day - 5 }
    before do
      human.add_note(date: day, body: 'day--first')
      human.add_note(date: one_day_before, body: 'one day before--first')
      human.add_note(date: one_day_before, body: 'one day before--second')
      human.add_note(date: five_days_before, body: 'five days before--first')
    end

    it 'returns an array with the following contents' do
      expected = [
        {date: '8 Jan', bodies: ['five days before--first']},
        nil,
        nil,
        nil,
        {date: '12 Jan', bodies: ['one day before--first', 'one day before--second']},
        {date: '13 Jan', bodies: ['day--first']}
      ]

      # stubbing Util.current_date_in_california to make sure that the presenter knows
      # today is the same day we told it (gets confused somehow with the time_warp gem)
      stub(Util).current_date_in_california.returns(day)

      pretend_now_is(day) do
        subject.should == expected
      end
    end
  end

  describe '#aggregate_sum_by_date' do

    subject { presenter.aggregate_sum_by_date }
    before do
      human.add_thing(eggplant_thing)
      human.add_thing(sushi_thing)

      eggplant_thing.add_occurrence(value: 1, date: today)
      eggplant_thing.add_occurrence(value: 2, date: yesterday)
      eggplant_thing.add_occurrence(value: 2, date: yesterday)

      sushi_thing.add_occurrence(value: 100, date: today)
    end

    it 'returns an array of length 2' do
      subject.should be_an(Array)
      subject.length.should == 3
    end

    it 'has the correct integers as values' do
      first_expected = { date: yesterday, sum_value: 4, name: 'eggplant' }
      second_expected = { date: today, sum_value: 1, name: 'eggplant' }
      third_expected = { date: today, sum_value: 100, name: 'sushi' }

      first_expected.each do |key, value|
        subject.first.values[key].should == value
      end

      second_expected.each do |key, value|
        subject.second.values[key].should == value
      end

      third_expected.each do |key, value|
        subject.third.values[key].should == value
      end
    end
  end

  describe '#date_snippet' do
    context 'when date is nil' do
      it 'raises an error' do
        expect{
          presenter.send(:date_snippet, nil)
        }.to raise_error(ArgumentError)
      end
    end

    context 'when date is Jan 13' do
      it 'returns 13 Jan' do
        jan_13 = Date.new(1971, 1, 13)
        presenter.send(:date_snippet, jan_13).should == '13 Jan'
      end
    end
  end
end

