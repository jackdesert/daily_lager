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
    let(:human_with_things) { Human.new(phone_number: '1111111111', things: [thing1, thing2]) }
    let(:human_without_things) { Human.new(phone_number: '1111111111', things: []) }
    subject { described_class.new('', human) }
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

