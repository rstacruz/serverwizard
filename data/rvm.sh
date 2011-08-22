# name: Ruby Version Manager (system-wide)
# position: 30

ensure_updated_apt

status "Installing Ruby dependencies"
apt-get install -y build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake

status "Installing system-wide RVM"
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

status "Installing Ruby via RVM"
rvm install ruby-1.9.2-p180

if [ -n "$MY_USER" ]; then
  status "Giving $MY_USER RVM rights"
  sudo adduser $MY_USER rvm
fi

status "RVM is installed."
status "Note: You may need to log out first to use it."
