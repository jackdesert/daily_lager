require 'spec_helper'

describe Thing do
  describe '#initialize' do
    let(:name) { 'iron' }
    let(:default_value) { 6 }
    subject { described_class.new(name: name, default_value: default_value) }
    it 'returns an Action' do
      subject.should be_an described_class
    end
    it 'saves the name in the new action' do
      subject.name.should == name
    end
    it 'saves the default value in the new action' do
      subject.default_value.should == default_value 
    end
    it { should be_persisted }
  end

  describe '#occurrences' do
    it 'is an array' do
      described_class.new.occurrences.should be_an Array
    end
  end

  describe '.create_with_name' do
    let(:name) { 'read' }
    subject { described_class.create_with_name(name) }
    it 'has the correct name' do
      subject.name.should == name
    end

    it 'has a default_value of 0' do
      subject.default_value.should == 0
    end
  end



end
