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

def has_error_on?(attribute)
  validate
  errors.has_key? attribute
end

def create(model_name)
  case model_name
  when :human
    # rand.to_s generates something like '0.12847366495349'
    Human.create(phone_number: rand.to_s[2..11])
  end
end
