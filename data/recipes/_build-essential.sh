# name: Build tools
# position: 6

which make > /dev/null || apt-get install -y make
which gcc  > /dev/null || apt-get install -y build-essential
