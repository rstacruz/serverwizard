# name: Ruby 1.9.2
# position: 30
# description: Compiled from source.
# needs:
# - _aptupdate

installing "Ruby dependencies"
apt-get -y install libc6-dev libssl-dev libmysql++-dev libsqlite3-dev make build-essential libssl-dev libreadline5-dev zlib1g-dev unzip wget

status "Downloading Ruby..."
mkdir -p /tmp/ruby-src
cd /tmp/ruby-src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p180.tar.gz
tar -xzvf ruby-1.9.2-p180.tar.gz

installing "Ruby"
cd ruby-1.9.2-p180
./configure --prefix=/usr/local
make && make install

cd $DIR
rm -rf /tmp/ruby-src
