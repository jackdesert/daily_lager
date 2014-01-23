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
end

