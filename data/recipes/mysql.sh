# #### BEGIN SCRIPT INFO ###
# name: MySQL
# fields:
#   MYSQL_ROOT_PASSWORD:
#     name: Root password
#     default: root
# needs:
#   - _apt-update
# #### END SCRIPT INFO #####

installing "MySQL"
echo mysql-server-5.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD | debconf-set-selections
echo mysql-server-5.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | debconf-set-selections
apt-get install -y mysql-server

status "Making MySQL start on boot"
update-rc.d mysql defaults
