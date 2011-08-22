require_relative '../test_helper'
require 'tempfile'

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

  test "files" do
    s = ScriptBundle.new(%w(mysql nginx_passenger redis))
    s.files.should.include "redis/redis"
    s.files.should.include "nginx/nginx.conf"
  end

  test "tarball" do
    s = ScriptBundle.new(%w(mysql nginx_passenger redis))
    t = Tempfile.new ['', 'x.tar.gz']
    t.write s.tarball
    t.close

    path = "/tmp/tarball-test-#{Time.now.to_i}-#{rand(65535)}"
    prefix = "#{path}/bootstrap"

    FileUtils.mkdir_p path
    system "cd \"#{path}\" && tar -zxf #{t.path}; ls -la"

    File.file?("#{prefix}/remote.sh").should == true
    File.file?("#{prefix}/bootstrap.sh").should == true
    File.file?("#{prefix}/nginx/nginx").should == true
    File.file?("#{prefix}/nginx/nginx.conf").should == true
    File.file?("#{prefix}/nginx/conf.d/virtual.conf").should == true

    FileUtils.rm_rf path
  end
end
