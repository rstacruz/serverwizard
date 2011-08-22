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
    field.name.should == "Root password"
    field.id.should   == "MYSQL_ROOT_PASSWORD"
  end

  test "bundle" do
    output = ScriptBundle.build(%w(mysql redis nginx_passenger), {}, 'serverwizard.dev')

    output.should.include "http://serverwizard.dev"
    output.should.include "cat_file"             # from common
    output.should.include "MYSQL_ROOT_PASSWORD"  # from mysql
    output.should.include "redis.conf"           # from redis
    output.should.include "Done!"
  end
end
