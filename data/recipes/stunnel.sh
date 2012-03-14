# #### BEGIN SCRIPT INFO ###
# name: Stunnel 4.39 with X-Forwarded-For fix
# position: 30
# description: Compiled from source.
# needs:
# - _apt-update
# - _build-essential
# files:
#  - stunnel/default-stunnel4
#  - stunnel/init.d-stunnel4
#  - stunnel/ip-down.d-stunnel4
#  - stunnel/ip-up.d-stunnel4
#  - stunnel/logrotate.d-stunnel4
#  - stunnel/stunnel.conf
# notes: |
#    - This installs an older version of `stunnel` that includes a patch to
#      support X-Forwarded-For taken from [here](http://www.exceliance.fr/download/free/patches/stunnel/x-forwarded-for/).
# #### END SCRIPT INFO #####

status "Downloading stunnel..."
mkdir -p ~/.src/stunnel-src
cd ~/.src/stunnel-src
wget -O - "ftp://ftp.stunnel.org/stunnel/archive/4.x/stunnel-4.39.tar.gz" | tar xz --strip-components=1

status "Patching stunnel for X-Forwarded-For support..."
wget "http://www.exceliance.fr/download/free/patches/stunnel/x-forwarded-for/stunnel-4.39-xforwarded-for.diff"
patch -p 1 < stunnel-4.39-xforwarded-for.diff

status "Building stunnel..."
./configure --sysconfdir=/etc --localstatedir=/var
make
make install

status "Creating stunnel user/group..."
mkdir -p /var/run/stunnel4
mkdir -p /var/log/stunnel4
groupadd -r stunnel4
useradd stunnel4 -g stunnel4 --home /var/run/stunnel4 --shell /bin/false
chown -R stunnel4:stunnel4 /var/run/stunnel4

status "Installing stunnel /etc files..."
mkdir -p /etc/stunnel

cat_file stunnel/default-stunnel4 > /etc/default/stunnel4
chmod 644 /etc/default/stunnel4

cat_file stunnel/init.d-stunnel4 > /etc/init.d/stunnel4
chmod 755 /etc/default/stunnel4

cat_file stunnel/stunnel.conf > /etc/stunnel/stunnel.conf
chmod 644 /etc/stunnel/stunnel.conf

cat_file ip-up.d-0stunnel4 > /etc/ppp/ip-up.d/0stunnel4
chmod 755 /etc/ppp/ip-up.d/0stunnel4

cat_file ip-down.d-0stunnel4 > /etc/ppp/ip-down.d/0stunnel4
chmod 755 /etc/ppp/ip-down.d/0stunnel4

cat_file logrotate.d-stunnel4 > /ppp/logrotate.d/stunnel4
chmod 644 /etc/logrotate.d/stunnel4

cat_file ssl/ssl_test.key > /etc/stunnel/ssl_test.key
chmod 400 /etc/stunnel/ssl_test.key

cat_file ssl/ssl_test.crt > /etc/stunnel/ssl_test.crt
chmod 400 /etc/stunnel/ssl_test.crt

chown -R stunnel4:stunnel4 /etc/stunnel

status "Making Stunnel start on boot"
update-rc.d stunnel4 defaults
