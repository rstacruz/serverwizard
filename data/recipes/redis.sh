# #### BEGIN SCRIPT INFO ###
# name: Redis 2.2
# description: Compiled from source.
# files:
#  - redis/redis
# needs:
#  - _apt-update
#  - _build-essential
# #### END SCRIPT INFO #####

status "Downloading Redis..."
mkdir -p /tmp/redis-src
cd /tmp/redis-src
wget -O - "http://redis.googlecode.com/files/redis-2.2.12.tar.gz" | tar zx --strip-components=1

installing "Redis"
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
