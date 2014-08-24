# Note NonsenseVerb is not in this list because it should not be tested as an inverse
KLASSES = [ActionVerb, CreateVerb, CreateVerbWithDefault, DeleteVerb, ListVerb, RenameVerb, TodayVerb,UpdateDefaultVerb, YesterdayVerb]

def verify_appropriateness_of(array_of_arrays, klass, options={})

  human = options[:human] || Human.new
  shortcut_words = options[:shortcut_words] || []
  invert = options[:invert] || false
  raise ArgumentError, 'unexpected key in options' if (options.keys - [:human, :shortcut_words, :invert]).present?

  raise ArgumentError, 'expected an array' unless array_of_arrays.kind_of? Array
  raise ArgumentError, 'expected an array' unless shortcut_words.kind_of? Array
  raise ArgumentError, 'expected a Human' unless human.kind_of? Human
  truthiness = !invert
  context "when klass is #{klass}" do
    array_of_arrays.each do |array|
      context "and @words is #{array}" do
        it "is #{'not' unless truthiness} appropriate" do
          stub(human).thing_names { shortcut_words }
          klass.new(array, human).send(:appropriate?).should == truthiness
        end
      end
    end
  end
  if truthiness
    verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass, options)
  end
end

def verify_inappropriateness_of(array_of_arrays, klass, options={})
  raise ArgumentError, 'unexpected key in options' if (options.keys - [:human, :shortcut_words]).present?
  human = options[:human] || Human.new
  shortcut_words = options[:shortcut_words] || []

  raise ArgumentError, 'expected an array' unless array_of_arrays.kind_of? Array
  raise ArgumentError, 'expected an array' unless shortcut_words.kind_of? Array
  raise ArgumentError, 'expected a Human' unless human.kind_of? Human
  verify_appropriateness_of(array_of_arrays, klass, options.merge(invert: true))
end

def verify_inappropriateness_of_all_other_klasses(array_of_arrays, klass, options)
  other_klasses = KLASSES.clone
  other_klasses.delete(klass)
  other_klasses.each do |other_klass|
    verify_inappropriateness_of(array_of_arrays, other_klass, options)
  end
end

def has_error_on?(attribute)
  valid?
  errors.has_key? attribute
end

def create(model_name, params={})
  case model_name
  when :human
    # rand.to_s generates something like '0.12847366495349'
    default_params = { phone_number: '+1' + rand.to_s[2..11] }
    Human.create(default_params.merge(params))
  end
end
