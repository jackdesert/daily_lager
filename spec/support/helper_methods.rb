def verify_appropriateness_of(array_of_arrays, klass, invert=false)
  truthiness = !invert
  context "when klass is #{klass}" do
    array_of_arrays.each do |array|
      context "and @words is #{array}" do
        it "is #{'not' unless truthiness} appropriate" do
          klass.new(array).send(:appropriate?).should == truthiness
        end
      end
    end
  end
end

def verify_inappropriateness_of(array_of_arrays, klass)
  verify_appropriateness_of(array_of_arrays, klass, true)
end
