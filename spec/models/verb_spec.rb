require 'spec_helper'

describe Verb  do
  reusable_hash = {
      "  3       miles    \t" => ['3', 'miles'],
      "blather" => ['blather'], 
      "\t twenty minutes\tbefore  dawn\t  " => ['twenty', 'minutes', 'before', 'dawn'],
      ['1', '2', '3'] => ['1', '2', '3'],
    }


  describe '#convert_to_array' do
    let(:verb) { described_class.new('anything') }
    reusable_hash.each_pair do |string, expected_array|
      it "turns #{string} into #{expected_array}" do
        verb.send(:convert_to_array, string).should == expected_array
      end
    end
  end

  describe '#initialize' do
    reusable_hash.each_pair do |argument, expected_words|
      it "turns #{argument} into #{expected_words}" do
        verb = Verb.new(argument)
        verb.send(:words).should == expected_words
      end
    end
  end

  hash = { 
          '3 miles' => ActionVerb,
          'help' => HelpVerb,
#          'list' => ListVerb,
#          'today' => TodayVerb,
#          'yesterday' => YesterdayVerb,
#          'create miles' => CreateVerb,
#          'create miles default 30' => CreateVerbWithDefault,
#          'rename miles run' => RenameVerb,
#          'delete run' => DeleteVerb,
#          'update run default 30' => UpdateDefaultVerb,
#          'nonsense' => NonsenseVerb,
        }

  hash.each_pair do |words, returned_class|
    it "returns #{returned_class} when receives '#{words}'" do
      Verb.new(words).receive.should == returned_class
    end
  end
end
