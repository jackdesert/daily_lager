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
end

