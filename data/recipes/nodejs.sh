# #### BEGIN SCRIPT INFO ###
# name: NodeJS 0.4 with NPM
# description: Compiled from source.
# notes: |
#  - You may need to type *"yes"* somewhere during the installation of NPM.
# needs:
#  - _apt-update
#  - _build-essential
# #### END SCRIPT INFO #####

apt-get install -y libssl-dev

installing "NodeJS"
status "Downloading NodeJS..."
mkdir -p ~/.src/nodejs-src
cd ~/.src/nodejs-src
wget http://nodejs.org/dist/node-v0.4.11.tar.gz -q -O - | tar xz --strip-components=1

status "Building NodeJS..."
./configure --prefix=/usr/local
make install

installing "Node Package Manager"
wget http://npmjs.org/install.sh -q -O - | sudo sh

cd $DIR
rm -rf ~/.src/nodejs-src
