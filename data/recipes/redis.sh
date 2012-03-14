# #### BEGIN SCRIPT INFO ###
# name: Redis 2.x
# description: Compiled from source.
# fields:
#   REDIS_VERSION:
#     name: Redis version
#     inline: true
#     options:
#       - 2.2.12
#       - 2.4.8
#     default: 2.4.8
# files:
#  - redis/redis
# needs:
#  - _apt-update
#  - _build-essential
# #### END SCRIPT INFO #####

status "Downloading Redis..."
mkdir -p ~/.src/redis-src
cd ~/.src/redis-src
wget "http://redis.googlecode.com/files/redis-$REDIS_VERSION.tar.gz" -q -O - | tar xz --strip-components=1

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

cd -
rm -rf ~/.src/redis-src

status  "Redis installed."
status_ "The config file can be found in /etc/redis/redis.conf."
