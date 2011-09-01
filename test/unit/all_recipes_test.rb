require_relative '../test_helper'

class AllRecipesTest < UnitTest
  def self.each_recipe
    Dir["#{Recipe.home}/*.sh"].each { |fname| yield File.basename(fname, '.sh'), fname }
  end

  each_recipe do |name, fn|
    describe(name) {
      setup { @recipe = Recipe[name] }

      test "Parsing of YAML metadata" do
        @recipe.meta
      end
      
      test "Dependencies" do
        deps = @recipe.meta.dependencies

        if deps
          deps.map! { |str| Recipe[str] }
          deps.should.not.include nil
          @recipe.dependencies
        end
      end
    }
  end

  test "all" do
    Recipe.all
  end
end
