# #### BEGIN SCRIPT INFO ###
# name: Rack app
# description: via Git + Nginx + Passenger.
# position: 70
# implies:
#   - nginx_passenger
#   - git
# files:
#   - nginx/conf.d/app.conf.sh
# fields:
#   APP_USER:
#    name: Username
#    default: myapp
#    description: This is the name of the user that will own the application files. It will be created if it doesn't exist.
#   APP_DOMAIN:
#    name: Domain name
#    default: myapp.com
#    description: The domain name that the application will be served under.
#   APP_GIT_REPO:
#    name: Git repository URL
#    default: http://github.com/rstacruz/serverwizard.git
# notes: |
#  * If you need an SSH key for Git, download (*.tar.gz*) the script and add the files `ssh/id_rsa.pub` and `ssh/id_rsa`.
#  * If you need to do setup (like `bundle install`) for your app, download (*.tar.gz*) the script and edit `bootstrap.sh`.
# #### END SCRIPT INFO #####

useradd_() {
  local HAS_USER=`cat /etc/passwd | egrep ^$1: | wc -l`
  if [ "$HAS_USER" == "0" ]; then
    status "Creating user $1..."
    useradd $*
  else
    status "User $1 already exists, skipping user creation."
  fi
}

NGINX_ROOT="/opt/nginx"
APP_PATH="/var/www/$APP_DOMAIN"
APP_REPO_PATH="$APP_PATH/current"
APP_LOGS_PATH="$APP_PATH/logs"
APP_NGINX_CONF="$NGINX_ROOT/conf/conf.d/$APP_DOMAIN.conf"

useradd_ $APP_USER --home "/home/$APP_USER" --create-home --shell /bin/bash

mkdir -p /home/$APP_USER/.ssh
chmod 700 /home/$APP_USER/.ssh

if [ -n "$SSH_PUBKEY" ]; then
  status "Adding your pubkey to $APP_USER's SSH authorized keys..."
  echo $SSH_PUBKEY > /home/$APP_USER/.ssh/authorized_keys
  chmod 400 /home/$APP_USER/.ssh/authorized_keys
fi

if [ -f "$DIR/ssh/id_rsa.pub" ]; then
  status "Adding public key to $APP_USER..."
  cat "$DIR/ssh/id_rsa.pub" > /home/$APP_USER/.ssh/id_rsa.pub
  chmod 644 /home/$APP_USER/.ssh/id_rsa.pub
fi

if [ -f "$DIR/ssh/id_rsa" ]; then
  status "Adding private key to $APP_USER..."
  cat "$DIR/ssh/id_rsa" > /home/$APP_USER/.ssh/id_rsa
  chmod 600 /home/$APP_USER/.ssh/id_rsa
fi

status "Cloning repository to $APP_REPO_PATH..."
mkdir -p "$APP_REPO_PATH"
chown -R $APP_USER:$APP_USER $APP_PATH
sudo -u $APP_USER git clone $APP_GIT_REPO "$APP_REPO_PATH"

status "Setting up logs ($APP_LOGS_PATH)..."
mkdir -p $APP_LOGS_PATH

status "Adding Nginx configuration ($APP_NGINX_CONF)..."
source_file nginx/conf.d/app.conf.sh > $APP_NGINX_CONF

cd "$APP_REPO_PATH"
status "Setting up application..."
#
# (If you need to do things like 'bundle install', do it here.)
#
# gem install bundler
# bundle install
# rake setup
#
cd $DIR

status "Reloading nginx configuration..."
"$NGINX_ROOT/sbin/nginx" -s reload
