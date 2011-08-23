require_relative '../test_helper'

class DepTest < UnitTest
  test "dependency" do
    Recipe['git'].dependencies.first.id.should == '_aptupdate'
  end

  test "dependency in bundle" do
    b = Bundle.new %w(git hostname)
    contents = b.build

    contents.should.include "Updating apt cache"
  end

  test "include" do
    b = Bundle.new %w(git hostname)
    b.recipes.should.include Recipe['_aptupdate']
  end

  test "uniq" do
    [Recipe['git'], Recipe['git']].uniq.size.should == 1
  end
end
