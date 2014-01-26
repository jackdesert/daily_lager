require 'spec_helper'

describe MenuVerb do
  describe '#appropriate?' do
    yesses = [
      ['menu'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 

  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:thing2) { Thing.new(name: 'eat', default_value: 2) }
    let(:human) { Human.new(phone_number: '1111111111', things: [thing1, thing2]) }
    subject { described_class.new('', human) }
    it 'returns a message' do
      expected = "Available commands:
MENU
LIST
TODAY
YESTERDAY
CREATE <thing> [DEFAULT <number>]
RENAME <thing_name> <new_name>
DELETE <thing>

Full docs: http://to_be_determined"
      subject.send(:process).should == expected
    end
  end
end

