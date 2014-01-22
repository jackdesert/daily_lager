# Note NonsenseVerb is not in this list because it should not be tested as an inverse
KLASSES = [ActionVerb, CreateVerb, CreateVerbWithDefault, DeleteVerb, ListVerb, RenameVerb, TodayVerb,UpdateDefaultVerb, YesterdayVerb]

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
  if truthiness
    verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass)
  end
end

def verify_inappropriateness_of(array_of_arrays, klass)
  verify_appropriateness_of(array_of_arrays, klass, true)
end

def verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass)
  other_klasses = KLASSES.clone
  other_klasses.delete(klass)
  other_klasses.each do |other_klass|
    verify_inappropriateness_of(array_of_arrays, other_klass)
  end
end

def sms(text)
  raise 'text must be a String' unless text.kind_of? String
  Verb.new(text).receive
end
