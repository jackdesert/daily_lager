require 'spec_helper'

describe Thing do
  describe '#create_with_name' do
    let(:name) { 'iron' }
    subject { described_class.create_with_name(name) }
    it 'returns an Action' do
      subject.should be_an described_class
    end
    it 'saves the name in the new action' do
      subject.name.should == name
    end
    it { should be_persisted }
  end

  describe '#occurrences' do
    it 'is an array' do
      described_class.new.occurrences.should be_an Array
    end
  end


end
