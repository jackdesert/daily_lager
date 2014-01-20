require 'spec_helper'

describe Verb  do
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
