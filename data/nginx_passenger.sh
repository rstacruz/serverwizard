# name: Nginx with Passenger 3
# description: Compiles Nginx from source.

installing "Passenger gem"
gem install passenger -v 3.0.6

installing "Nginx via Passenger"
apt-get install -y libcurl4-openssl-dev
passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx

installing "Nginx service script"
cat_file nginx/nginx > /etc/init.d/nginx
chown root:root /etc/init.d/nginx
chmod 755 /etc/init.d/nginx

# Start on bootup
status "Making Nginx start up on boot"
update-rc.d nginx defaults


