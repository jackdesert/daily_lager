require 'spec_helper'

describe Util do

  describe '.hash_has_nonzero_value' do
    subject { described_class.hash_has_nonzero_value(hash) }
    context 'when all zeros' do
      let(:hash) { {a: 0, b: 0, c: 0} }
      it { should be_false }
    end

    context 'when some nonzero' do
      let(:hash) { {a: 0, b: 15, c: 0} }
      it { should be_true }
    end
  end
end

