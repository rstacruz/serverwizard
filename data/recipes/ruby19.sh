# #### BEGIN SCRIPT INFO ###
# name: Ruby 1.9.3
# position: 30
# description: Compiled from source.
# needs:
# - _apt-update
# #### END SCRIPT INFO #####

installing "Ruby dependencies"
apt-get -y install libc6-dev libssl-dev libmysql++-dev libsqlite3-dev make build-essential libssl-dev libreadline5-dev zlib1g-dev unzip wget libyaml-dev

status "Downloading Ruby..."
mkdir -p ~/.src/ruby-src
cd ~/.src/ruby-src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz -q -O - | tar xz --strip-components=1

installing "Ruby"
./configure --prefix=/usr/local
make && make install

cd $DIR
rm -rf ~/.src/ruby-src
