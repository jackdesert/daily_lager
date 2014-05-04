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


  describe '#to_hash' do
    before do
      one = { date: yesterday, sum_value: 4, name: 'eggplant' }
      two = { date: today, sum_value: 1, name: 'eggplant' }
      three = { date: today, sum_value: 100, name: 'sushi' }
      output = [one, two, three]
      stub(presenter).aggregate_sum_by_date { output }
    end

    it 'returns the values as a hash' do
      expected = {
        series: {
          eggplant: [4,1],
          sushi: [100]
        },
        dateOfLastOccurrenceInMilliseconds: nil
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
        it "returns 20 hours worth of milliseconds (half a day plus 8 hours for Pacific Time Zone)" do
          mock(human).date_of_most_recent_occurrence.returns(beginning)
          subject.should == 3600 * 20 * 1000
        end
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


end

