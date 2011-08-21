# name: Nginx with Passenger 3
# description: Compiles Nginx from source.

# Install
installing "Passenger gem"
sudo gem install passenger -v 3.0.6

installing "Nginx via Passenger"
passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx

# Yeah
installing "Nginx service script"
curl -s http://HTTP_HOST/nginx/nginx > /etc/init.d/nginx
chown root:root /etc/init.d/nginx
chmod 755 /etc/init.d/nginx

# Start on bootup
status "Making Nginx start up on boot"
sudo update-rc.d nginx defaults


