# name: Git user
# description: Creates a git user.

status "Creating the Git user..."
useradd git --home /home/git --create-home --shell /usr/bin/git-shell

if [ -n "$SSH_PUBKEY" ]; then
  status "Setting up SSH keys..."
  mkdir /home/git/.ssh
  echo $SSH_PUBKEY > /home/git/.ssh/authorized_keys
  chmod 700 /home/git/.ssh
  chmod 400 /home/git/.ssh/authorized_keys
  chown -R git:git /home/git/.ssh
fi

status "Git user created."
status "To create a repo:  command sudo -u git git init --bare /home/git/myrepo.git"
status "To use that repo:  git add git@SERVERNAME:myrepo.git"
