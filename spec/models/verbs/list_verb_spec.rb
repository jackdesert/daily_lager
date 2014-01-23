require 'spec_helper'

describe ListVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:list_verb) { ListVerb.new(words, Human.new) }
    it 'returns a message' do
      mock(list_verb).respond('3 miles entered')
      list_verb.process
    end
  end

  describe '#appropriate?' do
    yesses = [
      ['list'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 

  describe '#process', focus: true do
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

