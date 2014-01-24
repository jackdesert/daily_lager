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

  describe '#generate_default_occurrence_for_date' do
    let(:january_1) { Date.new(2014, 1, 1) }
    let(:existing_occurrence_jan_1) { Occurrence.new(date: january_1) }
    let(:thing) { Thing.new(name: 'run', default_value: 13, occurrences: [existing_occurrence_jan_1]) }

    context 'when an occurrence already exists for that day' do
      it 'raises an exception and does not create an occurrence' do
        expect {
          thing.generate_default_occurrence_for_date(january_1)
        }.to raise_error "Thing 'run' already has occurrence(s) for 2014-01-01"
        thing.occurrences.length.should == 1
      end
    end

    context 'when no occurrence exists for that day' do
      let(:february_1) { Date.new(2014, 2, 1) }
      it 'adds an occurrence with the value matching Thing#default_value' do
        thing.generate_default_occurrence_for_date(february_1)
      end
    end

  end



end
