# name: Ruby Version Manager (system-wide)
# position: 30

status "Installing Ruby dependencies"
sudo apt-get install -y libreadline5-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev

status "Installing system-wide RVM"
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

status "Installing Ruby via RVM"
rvm install ruby-1.9.2-p180
rvm use ruby-1.9.2-p180 --default

if [ -n "$MY_USER" ]; then
  status "Giving $MY_USER RVM rights"
  sudo adduser $MY_USER rvm
fi
