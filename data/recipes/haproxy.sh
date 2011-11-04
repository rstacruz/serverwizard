# #### BEGIN SCRIPT INFO ###
# name: Haproxy 1.4
# description: Compiled from source.
# files:
#  - haproxy/haproxy.cfg
#  - haproxy/haproxy
# notes: |
#  - Control the service using:  
#    `sudo service haproxy {start|stop|reload|restart}`.
# needs:
#  - _apt-update
#  - _build-essential
# #### END SCRIPT INFO #####

status "Downloading Haproxy..."
mkdir -p ~/.src/haproxy-src
cd ~/.src/haproxy-src
wget -O - "http://haproxy.1wt.eu/download/1.4/src/haproxy-1.4.16.tar.gz" | tar xz --strip-components=1

status "Buidling Haproxy..."
make TARGET=linux26

installing "Haproxy"
make install

status "Installing Haproxy config files..."
mkdir -p /etc/haproxy
cat_file haproxy/haproxy.cfg > /etc/haproxy/haproxy.cfg
chmod 644 /etc/haproxy/haproxy.cfg

cat_file haproxy/haproxy > /etc/init.d/haproxy
chmod 755 /etc/init.d/haproxy

status "Making Haproxy start on system startup"
update-rc.d haproxy defaults

cd $DIR
rm -rf ~/.src/haproxy-src

status  "Haproxy installed."
status_ "The config file can be found in /etc/haproxy/haproxy.cfg."
