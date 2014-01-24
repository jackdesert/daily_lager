# Note NonsenseVerb is not in this list because it should not be tested as an inverse
KLASSES = [ActionVerb, CreateVerb, CreateVerbWithDefault, DeleteVerb, ListVerb, RenameVerb, TodayVerb,UpdateDefaultVerb, YesterdayVerb]

def verify_appropriateness_of(array_of_arrays, klass, human=Human.new, invert=false)
  truthiness = !invert
  context "when klass is #{klass}" do
    array_of_arrays.each do |array|
      context "and @words is #{array}" do
        it "is #{'not' unless truthiness} appropriate" do
          klass.new(array, Object.new).send(:appropriate?).should == truthiness
        end
      end
    end
  end
  if truthiness
    verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass, human)
  end
end

def verify_inappropriateness_of(array_of_arrays, klass, human=Human.new)
  verify_appropriateness_of(array_of_arrays, klass, human, true)
end

def verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass, human)
  other_klasses = KLASSES.clone
  other_klasses.delete(klass)
  other_klasses.each do |other_klass|
    verify_inappropriateness_of(array_of_arrays, other_klass, human)
  end
end


