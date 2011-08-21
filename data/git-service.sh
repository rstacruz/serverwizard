# name: Git user
# description: Creates a git user.

status "Creating the Git user..."
sudo useradd git --home /home/git --create-home --shell /usr/bin/git-shell

if [ "$SSH_PUBKEY" != "" ]; then
  status "Setting up SSH keys..."
  sudo mkdir /home/git/.ssh
  echo $SSH_PUBKEY > /home/$MY_USER/.ssh/authorized_keys
  sudo chmod 700 /home/git/.ssh
  sudo chmod 400 /home/git/.ssh/authorized_keys
  sudo chown -R git:git /home/git/.ssh
fi
