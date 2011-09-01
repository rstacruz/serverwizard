# #### BEGIN SCRIPT INFO ###
# name: Common
# #### END SCRIPT INFO #####

DIR="`pwd`"

# Helpers
status()     { echo -e "\033[0;34m==>\033[0;32m $*\033[0;m"; }
status_()    { echo -e "\033[0;32m    $*\033[0;m"; }
err()        { echo -e "\033[0;31m==> \033[0;33mERROR: \033[0;31m$*\033[0;m"; }
err_()       { echo -e "\033[0;31m    $*\033[0;m"; }
installing() { status "Installing \033[0;33m$1\033[0;32m..."; }
die()        { err "$*"; exit 256; }

cat_file()    { [ -f "$DIR/$*" ] && cat "$DIR/$*" || wget "http://HTTP_HOST/$*" -q -O -; }
source_file() { cat_file $* | source /dev/stdin; }

# Ensure Linux-ness
if [ ! -f "/etc/lsb-release" ]; then
  err  "Only Linux platforms are supported."
  err_ "Please try this on an Ubuntu Server 10.04+ instance."
  exit 256
fi

# Ensure Ubuntu-ness
source /etc/lsb-release
if [ "$DISTRIB_ID" != "Ubuntu" ]; then
  err  "This Linux distribution is not supported."
  err_ "Please try this on an Ubuntu Server 10.04+ instance."
  exit 256
fi

if [ "$(echo "$DISTRIB_RELEASE < 10.04" | bc)" == "1" ]; then
  err  "Your Ubuntu version is too old."
  err_ "Please try this on an Ubuntu Server 10.04+ instance."
  exit 256
fi

# Ensure root-ness
if [ `whoami` != "root" ]; then
    die "Run me as root!"
fi
