# #### BEGIN SCRIPT INFO ###
# name: Ruby 1.9
# position: 30
# description: Compiled from source.
# fields:
#   RUBY_VERSION:
#     name: Ruby version
#     inline: true
#     options:
#       - 1.9.2-p290
#       - 1.9.3-p0
#       - 1.9.3-p125
#     default: 1.9.3-p125
# needs:
# - _apt-update
# - _build-essential
# #### END SCRIPT INFO #####

installing "Ruby dependencies"
apt-get -y install libc6-dev libssl-dev libmysql++-dev libsqlite3-dev libssl-dev libreadline5-dev zlib1g-dev unzip wget libyaml-dev

status "Downloading Ruby..."
mkdir -p ~/.src/ruby-src
cd ~/.src/ruby-src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$RUBY_VERSION.tar.gz -q -O - | tar xz --strip-components=1

installing "Ruby"
./configure --prefix=/usr/local
make && make install

cd -
rm -rf ~/.src/ruby-src
