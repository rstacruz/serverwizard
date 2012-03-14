require_relative '../test_helper'
require 'tempfile'

class AppTest < UnitTest
  setup do
  end
  
  test "script" do
    Recipe['mysql'].meta.name.should == "MySQL"
  end

  test "contents" do
    Recipe['mysql'].contents.should.include "start on boot"
  end

  test "inlines" do
    contents = Recipe['ruby19'].contents({ 'RUBY_VERSION' => 'skitz' })
    contents.should.include "skitz.tar.gz"
  end

  test "inline in bundles" do
    output = Bundle.build(%w(ruby19), { 'RUBY_VERSION' => 'skitz' }, 'serverwizard.dev')
    output.should.include "skitz.tar.gz"
  end

  test "fields" do
    field = Recipe['mysql'].fields.first
    field.name.should == "Root password"
    field.id.should   == "MYSQL_ROOT_PASSWORD"
  end

  test "bundle" do
    output = Bundle.build(%w(mysql redis nginx_passenger), {}, 'serverwizard.dev')

    output.should.include "http://serverwizard.dev"
    output.should.include "cat_file"             # from common
    output.should.include "MYSQL_ROOT_PASSWORD"  # from mysql
    output.should.include "redis.conf"           # from redis
    output.should.include "Done!"
  end

  test "files" do
    s = Bundle.new(%w(mysql nginx_passenger redis))
    s.files.should.include "redis/redis"
    s.files.should.include "nginx/nginx.conf.sh"
  end

  test "tarball" do
    s = Bundle.new(%w(mysql nginx_passenger redis))
    t = Tempfile.new ['', 'x.tar.gz']
    t.write s.tarball
    t.close

    path = "/tmp/tarball-test-#{Time.now.to_i}-#{rand(65535)}"
    prefix = "#{path}/bootstrap"

    FileUtils.mkdir_p path
    system "cd \"#{path}\" && tar -zxf #{t.path}"

    File.file?("#{prefix}/remote.sh").should == true
    File.file?("#{prefix}/bootstrap.sh").should == true
    File.file?("#{prefix}/nginx/nginx").should == true
    File.file?("#{prefix}/nginx/nginx.conf.sh").should == true
    File.file?("#{prefix}/nginx/conf.d/virtual.conf").should == true
    File.stat( "#{prefix}/remote.sh").mode.should == 0100755
    File.stat( "#{prefix}/bootstrap.sh").mode.should == 0100755

    FileUtils.rm_rf path
  end
end
