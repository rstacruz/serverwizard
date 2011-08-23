require_relative '../test_helper'

class AllScriptTest < UnitTest
  Dir["#{Script.home}/*.sh"].each { |fn|
    fn = File.basename(fn, '.sh')
    test(fn) { Script[fn].meta }
  }

  test "all" do
    Script.all
  end
end
