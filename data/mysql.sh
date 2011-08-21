# name: MySQL
# fields:
#   MYSQL_ROOT_PASSWORD: "Root password (text)"

installing "MySQL"
echo mysql-server-5.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD | debconf-set-selections
echo mysql-server-5.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | debconf-set-selections
sudo apt-get install -y mysql-server

status "Making MySQL start on boot"
sudo update-rc.d mysql defaults
