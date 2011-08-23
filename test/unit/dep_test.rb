require_relative '../test_helper'

class DepTest < UnitTest
  test "dependency" do
    Script['git'].dependencies.first.id.should == '_aptupdate'
  end

  test "dependency in bundle" do
    b = ScriptBundle.new %w(git hostname)
    contents = b.build

    contents.should.include "Updating apt cache"
  end

  test "include" do
    b = ScriptBundle.new %w(git hostname)
    b.recipes.should.include Script['_aptupdate']
  end

  test "uniq" do
    [Script['git'], Script['git']].uniq.size.should == 1
  end
end
