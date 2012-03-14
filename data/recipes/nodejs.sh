# #### BEGIN SCRIPT INFO ###
# name: NodeJS with NPM
# description: Compiled from source.
# notes: |
#  - You may need to type *"yes"* somewhere during the installation of NPM.
# needs:
#  - _apt-update
#  - _build-essential
# fields:
#   NODEJS_VERSION:
#     name: NodeJS version
#     inline: true
#     options:
#       - 0.5.10
#       - 0.6.12
#       - 0.7.6
#       - latest
#     default: latest
# #### END SCRIPT INFO #####

apt-get install -y libssl-dev

installing "NodeJS"
status "Downloading NodeJS..."
mkdir -p ~/.src/nodejs-src
cd ~/.src/nodejs-src
<% if vars["NODEJS_VERSION"] == 'latest' %>
wget http://nodejs.org/dist/latest/node.tar.gz -q -O - | tar xz --strip-components=1
<% else %>
wget http://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION.tar.gz -q -O - | tar xz --strip-components=1
<% end %>

status "Building NodeJS..."
./configure --prefix=/usr/local
make install

installing "Node Package Manager"
wget http://npmjs.org/install.sh -q -O - | sudo sh

cd -
rm -rf ~/.src/nodejs-src
