require 'spec_helper'

describe HistoryVerb do

  describe '#appropriate?' do
    yesses = [
      ['history'],
    ]

    verify_appropriateness_of(yesses, described_class)
  end

  describe '#process' do
    let(:human) { create(:human) }
    subject { described_class.new('', human) }
    it 'returns a link to returns a message' do
      human.secret.should_not be_blank
      verb = described_class.new('', human)
      verb.send(:process).should == "history: http://history.jackdesert.com/?secret=#{human.secret}\nweb interface: http://jackdesert.com/messages/?secret=#{human.secret}\n"
    end
  end
end

