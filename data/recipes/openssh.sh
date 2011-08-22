# name: OpenSSH Server
# position: 15

ensure_updated_apt

installing "OpenSSH server"
apt-get install -y openssh-server
