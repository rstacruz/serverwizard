# name: NodeJS with NPM

ensure_updated_apt

installing "NodeJS"
apt-get install -y python-software-propreties
apt-get install -y curl
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

installing "Node Package Manager"
curl http://npmjs.org/install.sh | sudo sh
