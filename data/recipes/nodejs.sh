# name: NodeJS with NPM

ensure_updated_apt

installing "NodeJS"
apt-get install -y python-software-properties curl
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

installing "Node Package Manager"
wget http://npmjs.org/install.sh -q -O - | sudo sh
