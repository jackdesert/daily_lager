require 'spec_helper'

describe ActionVerb do
  describe '#receive' do
    let(:words) { '3 miles' }
    it 'returns a message' do
      ActionVerb.receive(words).should == '3 miles entered'
    end
  end
end

