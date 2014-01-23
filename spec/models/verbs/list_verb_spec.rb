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
    let(:human) { Human.new(phone_number: '1111111111', things: [thing1, thing2]) }
    subject { described_class.new('', human) }
    it 'returns a message' do
      mock(subject).respond("You have the following activities active:\neat\nrun")
      subject.send(:process)
    end
  end
end

