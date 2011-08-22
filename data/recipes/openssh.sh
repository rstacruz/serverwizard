# name: OpenSSH Server
# position: 15
# description: Allows SSH access.

ensure_updated_apt

installing "OpenSSH server"
apt-get install -y openssh-server
