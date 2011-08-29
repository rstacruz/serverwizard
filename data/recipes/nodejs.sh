# name: NodeJS with NPM
# description: Latest, compiled from source.
# notes: |
#  - You may need to type *"yes"* somewhere during the installation of NPM.
# needs:
#   - _apt-update
#  - _build-essential

apt-get install -y libssl-dev

installing "NodeJS"
status "Downloading NodeJS..."
mkdir -p /tmp/nodejs-src
cd /tmp/nodejs-src
wget http://nodejs.org/dist/node-latest.tar.gz
tar zxf node-latest.tar.gz --strip-components=1

status "Building NodeJS..."
./configure --prefix=/usr/local
make install

installing "Node Package Manager"
wget http://npmjs.org/install.sh -q -O - | sudo sh
