# name: Redis 2.2
# description: Compiled from source.
# files:
#  - redis/redis
# needs:
#  - _aptupdate

apt-get install -y build-essential make

status "Downloading Redis..."
mkdir -p /tmp/redis-src
cd /tmp/redis-src
wget http://redis.googlecode.com/files/redis-2.2.12.tar.gz
tar -xzvf redis-2.2.12.tar.gz

installing "Redis"
cd redis-2.2.12
make
cp src/redis-{benchmark,check-aof,check-dump,cli,server} /usr/local/bin

status "Installing Redis config files..."
mkdir -p /etc/redis
cp redis.conf /etc/redis/redis.conf
chmod 644 /etc/redis/redis.conf

cat_file redis/redis > /etc/init.d/redis
chmod 755 /etc/init.d/redis

status "Making Redis start on system startup"
update-rc.d redis defaults

cd $DIR
rm -rf /tmp/redis-src

status  "Redis installed."
status_ "The config file can be found in /etc/redis/redis.conf."
