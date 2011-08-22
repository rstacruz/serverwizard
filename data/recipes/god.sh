# name: God
# implies:
#  - ruby19

gem install god

mkdir /etc/god
mkdir /etc/god/conf.d

cat_file god/master.god > /etc/god/master.god
cat_file god/sample.god > /etc/god/conf.d/sample.god
