require 'spec_helper'

describe LastVerb do
  before do
    # Make sure Date.today is not used to initialize anything, since it
    # really should be using Util.current_date_in_california
    mock(Date).today.never
  end

  describe '#appropriate?' do
    yesses = [
      ['last', 'miles'],
    ]

    nos = [
      ['last'],
      ['last', 'miles', 'miles'],
      ['last', '3', 'miles'],
      ['last', '3'],
    ]

    verify_appropriateness_of(yesses, described_class)
    verify_inappropriateness_of(nos, described_class)
  end


  describe '#process' do

    let(:today) { Util.current_date_in_california }
    let(:one_day_ago) { today - 1 }
    let(:two_days_ago) { today - 2 }
    let(:run_thing) { Thing.new(name: 'run') }
    let(:walk_thing) { Thing.new(name: 'walk') }
    let(:human) { create(:human) }
    subject { described_class.new(words, human) }

    before do
      human.add_thing(run_thing)
      human.add_thing(walk_thing)
      walk_thing.add_occurrence(value: 1, date: today)
    end

    context 'when thing does not exist' do
      let(:words) { 'last unknown' }

      it 'responds with error' do
        subject.send(:process).should == "#{Thing::DISPLAY_NAME.capitalize} 'unknown' does not exist."
      end
    end


    context 'when thing exists' do
      let(:words) { 'last run' }

      context 'but occurrence does not exist' do
        before do
          run_thing.add_occurrence(value: 0, date: today)
        end
        it do
          subject.send(:process).should == "No runs recorded yet."
        end
      end

      context 'and occurrence exists for today' do
        before do
          run_thing.add_occurrence(value: 3, date: today)
          run_thing.add_occurrence(value: 3, date: today)
        end
        it 'returns the correct message' do
          subject.send(:process).should == "0 day(s) ago you logged 6 run(s)"
        end
      end

      context 'and occurrence exists for two days ago' do
        before do
          run_thing.add_occurrence(value: 0, date: today)
          run_thing.add_occurrence(value: 0, date: one_day_ago)
          run_thing.add_occurrence(value: 2, date: two_days_ago)
        end

        it 'returns the correct message' do
          subject.send(:process).should == "2 day(s) ago you logged 2 run(s)"
        end
      end
    end
  end
end

