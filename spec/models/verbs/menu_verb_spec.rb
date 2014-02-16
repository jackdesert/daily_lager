require 'spec_helper'

describe MenuVerb do
  describe '#appropriate?' do
    yesses = [
      ['menu'], ['help'],
    ]
        
    verify_appropriateness_of(yesses, described_class)
  end 

  describe '#process' do
    let(:thing1) { Thing.new(name: 'run', default_value: 6) }
    let(:thing2) { Thing.new(name: 'eat', default_value: 2) }
    let(:human) { create(:human) }
    subject { described_class.new('', human) }

    before do
      human.add_thing(thing1)
      human.add_thing(thing2)
      stub(human).backfill
    end

    it 'returns a message' do
      expected = "Available commands:
MENU
LIST
TODAY
YESTERDAY
CREATE <#{Thing::DISPLAY_NAME}> [DEFAULT <number>]
RENAME <#{Thing::DISPLAY_NAME}> <new_name>
DELETE <#{Thing::DISPLAY_NAME}>
[Y] <number> <#{Thing::DISPLAY_NAME}>"
      subject.send(:process).should == expected
    end
  end
end

