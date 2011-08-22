# name: Common

DIR="`pwd`"

status() {
    echo -e "\033[0;32m*** $*\033[0;m"
}

err() {
    echo -e "\033[0;31m* Error: $*\033[0;m"
}

die() {
  err "$*"
  exit 256
}

installing() {
    echo -e "\033[0;32m*** Installing: $*...\033[0;m"
}

cat_file() {
  if [ -f "$DIR/$*" ]; then
    cat "$DIR/$*"
  else
    wget "http://HTTP_HOST/$*" -q -O -
  fi
}

ensure_updated_apt() {
  if [ "$UPDATED_APT" != "1" ]; then
    status "Updating apt cache..."
    UPDATED_APT=1
    apt-get update || (die "Failed to update.")
  fi
}

# Ensure Linux-ness
if [ ! -f "/etc/lsb-release" ]; then
  err "This platform is not supported."
  die "Please try this on an Ubuntu 10.04 server instead."
fi

# Ensure Ubuntu-ness
source /etc/lsb-release
if [ "$DISTRIB_ID" != "Ubuntu" ]; then
  err "Error: This platform is not supported."
  die "Please try this on an Ubuntu 10.04 server instead."
fi

# Ensure root-ness
if [ `whoami` != "root" ]; then
    die "Run me as root!"
fi
