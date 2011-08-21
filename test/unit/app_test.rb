require_relative '../test_helper'

class AppTest < UnitTest
  setup do
  end
  
  test "script" do
    Script['mysql'].meta.name.should == "MySQL"
  end

  test "contents" do
    Script['mysql'].contents.should.include "start on boot"
  end

  test "fields" do
    field = Script['mysql'].fields.first
    field.name.should == "MySQL root password"
    field.id.should   == "MYSQL_ROOT_PASSWORD"
  end
end
