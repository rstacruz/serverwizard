require_relative '../test_helper'

class AllRecipesTest < UnitTest
  Dir["#{Recipe.home}/*.sh"].each { |fn|
    fn = File.basename(fn, '.sh')
    test(fn) { Recipe[fn].meta }
  }

  test "all" do
    Recipe.all
  end
end
