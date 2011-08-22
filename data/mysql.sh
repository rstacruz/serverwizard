# name: MySQL
# fields:
#   MYSQL_ROOT_PASSWORD: "Root password (text)"

ensure_updated_apt

installing "MySQL"
echo mysql-server-5.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD | debconf-set-selections
echo mysql-server-5.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | debconf-set-selections
apt-get install -y mysql-server

status "Making MySQL start on boot"
update-rc.d mysql defaults
