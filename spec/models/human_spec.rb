require 'spec_helper'

describe Human do
  context 'validations' do
    context 'valid phone number' do
      valid_numbers = ['1112223333', '9998887777'] 
      invalid_numbers = ['1', '12', '123.456.4444', '&1112223333']
      valid_numbers.each do |number|
        described_class.new(phone_number: number).valid?.should == true
      end
      invalid_numbers.each do |number|
        described_class.new(phone_number: number).valid?.should == false
      end
    end
  end

  describe '#find_or_create_with_phone_number' do
    let(:phone_number) { '1231231234' }
    subject { described_class.find_or_create_with_phone_number(phone_number) }
    it 'returns an Action' do
      subject.should be_an described_class
    end
    it 'saves the name in the new action' do
      subject.phone_number.should == phone_number 
    end
    it { should be_persisted }
  end

  describe '#things' do
    it 'is an array' do
      described_class.new.things.should be_an Array
    end
  end

  describe '#backfill' do
    let(:thing) { Thing.new(name: 'run', default_value: 13, occurrences: occurrences) }
    let(:human) { Human.new(phone_number: '1112224444', things: [thing])  }

    context 'when there is already an entry for today' do
      let(:occurrences) { [Occurrence.new] }
      it 'does nothing' do
        human.backfill
        thing.occurrences.should == occurrences
      end
    end

    context 'when the last occurrence was yesterday' do
      let(:yesterday) { (Time.now - 86400).to_date }
      let(:occurrences) { [Occurrence.new(date: yesterday)] }
      it 'adds an Occurrence for today with value 13' do
        human.backfill
        thing.occurrences.length.should == 2
        thing.occurrences.last.value.should == 13
      end
    end


  end
end
