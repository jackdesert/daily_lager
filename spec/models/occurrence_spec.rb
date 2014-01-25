require 'spec_helper'

describe Occurrence do
  context 'validations' do
    valid_values = [-30, 15, 49998]
    valid_values.each do |value|
      context "when value is #{value}" do
        it 'is valid' do
          described_class.new(value: value, date: Date.new).valid?.should == true
        end
      end
    end

    invalid_values = ['', Object.new]
    invalid_values.each do |value|
      context "when value is #{value}" do
        it 'is invalid' do
          described_class.new(value: value, date: Date.new).valid?.should == false
        end
      end
    end
  end

  describe '#date' do
    subject { described_class.new }
    context 'Time Zone defaults to Pacific' do
      context 'at 7:59am Jan 5th on a server in London' do
        it 'returns Jan 4th' do
          pretend_now_is(Time.utc(2014, 1, 5, 7, 59, 0)) do 
            described_class.new.date.should == Date.new(2014, 1, 4)
          end
        end
      end
      context 'at 8:00am Jan 5th on a server in London' do
        it 'returns Jan 5th' do
          binding.pry
          pretend_now_is(Time.utc(2014, 1, 5, 8, 0, 0)) do
            described_class.new.date.should == Date.new(2014, 1, 5)
          end
        end
      end
    end
  end

end

