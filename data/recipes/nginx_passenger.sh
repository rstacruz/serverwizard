# name: Nginx with Passenger 3
# description: Compiles Nginx from source.
# implies:
#  - ruby19
# files:
#  - nginx/nginx
#  - nginx/nginx.conf
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
cat_file nginx/nginx.conf > /opt/nginx/conf/nginx.conf
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


