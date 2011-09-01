# #### BEGIN SCRIPT INFO ###
# name: Cassandra 0.8
# description: From Apache.org's deb sources.
# #### END SCRIPT INFO #####

status "Adding Apache.org's apt source for Cassandra..."
(
    echo "deb http://www.apache.org/dist/cassandra/debian 08x main"
    echo "deb-src http://www.apache.org/dist/cassandra/debian 08x main"
) > /etc/apt/sources.list.d/cassandra.list

gpg --keyserver pgp.mit.edu --recv-keys 4BD736A82B5C1B00
gpg --export --armor 4BD736A82B5C1B00 | apt-key add -

installing "Cassandra"
apt-get update
apt-get install -y cassandra
