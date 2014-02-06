require 'spec_helper'

describe ListVerb do

  describe '#appropriate?' do
    yesses = [
      ['list'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 

  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:thing2) { Thing.new(name: 'eat', default_value: 2) }
    let(:human_with_things) { create(:human) }
    let(:human_without_things) { create(:human) }
    subject { described_class.new('', human) }

    before do
      human_with_things.add_thing(thing1)
      human_with_things.add_thing(thing2)
      stub(human_with_things).backfill
      stub(human_without_things).backfill
    end

    context 'when things are present' do
      it 'returns a message' do
        verb = described_class.new('', human_with_things)
        verb.send(:process).should == "Your Categories (default value in parens):\nEat (2)\nRun (6)"
      end
    end
    context 'when things is empty' do
      it 'returns a message' do
        verb = described_class.new('', human_without_things)
        verb.send(:process).should == "No categories active. To add one, type CREATE <category>"
      end
    end
  end
end

