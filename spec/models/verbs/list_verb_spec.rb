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
    let(:human_with_things) { Human.create(phone_number: '1111111111') }
    let(:human_without_things) { Human.new(phone_number: '1111111111') }
    subject { described_class.new('', human) }

    before do
      human_with_things.add_thing(thing1)
      human_with_things.add_thing(thing2)
    end

    context 'when things are present' do
      it 'returns a message' do
        verb = described_class.new('', human_with_things)
        verb.send(:process).should == "You have created the following categories:\neat\nrun"
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

