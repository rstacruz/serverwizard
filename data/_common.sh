# name: Common

# Bootstrapper script

status() {
    echo -e "\033[0;32m*** $*\033[0;m"
}

installing() {
    echo -e "\033[0;32m*** Installing: $*...\033[0;m"
}

# Ensure Linux-ness
if [ ! -f "/etc/lsb-release" ]; then
  echo "Error: This platform is not supported."
  echo "Please try this on an Ubuntu 10.04 server instead."
  exit 256
fi

# Ensure Ubuntu-ness
source /etc/lsb-release
if [ "$DISTRIB_ID" != "Ubuntu" ]; then
  echo "Error: This platform is not supported."
  echo "Please try this on an Ubuntu 10.04 server instead."
  exit 256
fi

# Ensure root-ness
if [ `whoami` != "root" ]; then
    echo "Run me as root!"
    exit
fi
