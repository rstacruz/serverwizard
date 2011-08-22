# name: Nginx with Passenger 3
# description: Compiles Nginx from source.
# implies:
#  - ruby19
# files:
#  - nginx/nginx
#  - nginx/conf.d/virtual.conf
#  - nginx/conf.d/ssl.conf
# notes: |
#    - Place each host as a config file in `/opt/nginx/conf/conf.d/`.  
#      See *virtual.conf* for an example.
#    - Control the service using:  
#      `sudo service nginx {start|stop|reload|restart}`.

ensure_updated_apt

HAS_PASSENGER=`gem list | grep passenger | grep 3.0. | wc -l`
if [ "$HAS_PASSENGER" == "0" ]; then
  installing "Passenger gem"
  gem install passenger -v "~> 3.0.8"
fi

installing "Nginx via Passenger"
apt-get install -y libcurl4-openssl-dev
passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx

installing "Nginx service script"
cat_file nginx/nginx > /etc/init.d/nginx
chown root:root /etc/init.d/nginx
chmod 755 /etc/init.d/nginx

installing "Nginx configuration files"
PASSENGER_ROOT="`gem which phusion_passenger`"
PASSENGER_ROOT="${PASSENGER_ROOT%/lib/*}"
(
  echo "#user nobody;"
  echo "worker_processes 1;"
  echo "pid /var/run/nginx.pid;"
  echo ""
  echo "events {"
  echo "    worker_connections 1024;"
  echo "}"
  echo ""
  echo "http {"
  echo "    passenger_root $PASSENGER_ROOT;"
  echo "    passenger_ruby $(which ruby);"
  echo "    passenger_max_pool_size 6;"
  echo "    passenger_max_instances_per_app 0;"
  echo "    "
  echo "    include mime.types;"
  echo "    default_type application/octet-stream;"
  echo "    sendfile on;"
  echo "    keepalive_timeout 65;"
  echo "    "
  echo "    include /opt/nginx/conf/conf.d/*.conf;"
  echo "}"
) > /opt/nginx/conf/nginx.conf
chown root:root /opt/nginx/conf/nginx.conf
chmod 644 /opt/nginx/conf/nginx.conf

mkdir -p /opt/nginx/conf/conf.d
chmod 755 /opt/nginx/conf/conf.d

cat_file nginx/conf.d/virtual.conf > /opt/nginx/conf/conf.d/virtual.conf
chown root:root /opt/nginx/conf/conf.d/virtual.conf
chmod 644 /opt/nginx/conf/conf.d/virtual.conf

cat_file nginx/conf.d/ssl.conf > /opt/nginx/conf/conf.d/ssl.conf
chown root:root /opt/nginx/conf/conf.d/ssl.conf
chmod 644 /opt/nginx/conf/conf.d/ssl.conf

# Start on bootup
status "Making Nginx start up on boot"
update-rc.d nginx defaults


