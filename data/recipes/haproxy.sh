# name: Haproxy 1.4
# description: Compiled from source.
# files:
#  - haproxy/haproxy.cfg
# needs:
#  - _apt-update
#  - _build-essential
# notes:
#  - Haproxy will not start on system startup. (TODO)

status "Downloading Haproxy..."
mkdir -p /tmp/haproxy-src
cd /tmp/haproxy-src
wget -O - "http://haproxy.1wt.eu/download/1.4/src/haproxy-1.4.16.tar.gz" | tar xz --strip-components=1

status "Buidling Haproxy..."
make TARGET=linux26

installing "Haproxy"
make install

status "Installing Haproxy config files..."
mkdir -p /etc/haproxy
cat_file haproxy/haproxy.cfg > /etc/haproxy/haproxy.cfg
chmod 644 /etc/haproxy/haproxy.cfg

cd $DIR
rm -rf /tmp/haproxy-src

status  "haproxy installed."
status_ "The config file can be found in /etc/haproxy/haproxy.cfg."
