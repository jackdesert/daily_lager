require 'spec_helper'

describe ActionVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    let(:action_verb) { ActionVerb.new(words) }
    it 'returns a message' do
      mock(action_verb).respond('3 miles entered')
      action_verb.process
    end
  end

  describe '#appropriate?' do
    hash = {
      '2 miles' => true,
      "\t 3\t chores\t\t " => true,
      '2 miles t' => false,
      'miles 2' => false,
      'two miles' => false,
    }
    hash.each_pair do |words, appropriateness|
      it "returns #{appropriateness} for the words '#{words}'" do
        described_class.new(words).send(:appropriate?).should == appropriateness
      end
    end
  end

end

